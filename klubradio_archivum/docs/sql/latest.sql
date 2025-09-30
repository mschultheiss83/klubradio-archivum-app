-- =====================================================
-- Pre-check: list objects that depend on public.episodes
-- Review output before proceeding.
-- =====================================================
SELECT
  dep.classid::regclass::text AS dependent_object_catalog,
  n.nspname AS dependent_schema,
  c.relname AS dependent_name,
  CASE c.relkind
    WHEN 'v' THEN 'view'
    WHEN 'm' THEN 'materialized view'
    WHEN 'r' THEN 'table'
    WHEN 'f' THEN 'foreign table'
    WHEN 'S' THEN 'sequence'
    ELSE c.relkind
  END AS dependent_kind
FROM pg_depend dep
JOIN pg_class c ON c.oid = dep.objid
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE dep.refobjid = 'public.episodes'::regclass;

-- Also check dependent functions that reference the relation (if any)
SELECT
  n.nspname AS schema,
  p.proname AS function_name,
  'function' AS object_type
FROM pg_proc p
JOIN pg_depend d ON d.objid = p.oid
JOIN pg_namespace n ON n.oid = p.pronamespace
WHERE d.refobjid = 'public.episodes'::regclass
UNION
SELECT
  n.nspname AS schema,
  c.relname AS view_name,
  CASE c.relkind WHEN 'v' THEN 'view' WHEN 'm' THEN 'materialized view' ELSE c.relkind END
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
JOIN pg_depend d ON d.objid = c.oid
WHERE d.refobjid = 'public.episodes'::regclass;

-- =====================================================
-- Destructive step: drop public.episodes and dependents
-- Run this only after you've reviewed the pre-check results and taken a backup.
-- =====================================================
DROP VIEW IF EXISTS public.episodes CASCADE;

-- =====================================================
-- Recreate improved pattern:
--  - internal.episodes_mv (materialized view)
--  - indexes on the MV
--  - public.episodes (wrapper view)
--  - refresh function (SECURITY DEFINER)
--  - status function (as provided)
--  - initial concurrent refresh
-- =====================================================

-- 1) Ensure internal schema exists and tighten default privileges
CREATE SCHEMA IF NOT EXISTS internal;

-- Tighten schema privileges (adjust as needed for your environment)
REVOKE ALL ON SCHEMA internal FROM PUBLIC;
REVOKE ALL ON SCHEMA internal FROM anon;
REVOKE ALL ON SCHEMA internal FROM authenticated;

-- 2) Create materialized view in internal schema
-- NOTE: Replace the SELECT below with your actual source query (e.g., joins from public.shows, public.seasons, etc.)
CREATE MATERIALIZED VIEW IF NOT EXISTS internal.episodes_mv AS
SELECT
  e.id,
  e.show_id,
  e.title,
  e.summary,
  e.published_at,
  e.duration,
  now() AS mv_created_at
FROM public.episodes_source e;  -- <<-- REPLACE this with your actual source table or query

-- 3) Create required indexes (unique index needed for CONCURRENTLY refresh)
CREATE UNIQUE INDEX IF NOT EXISTS internal_episodes_mv_pkey ON internal.episodes_mv (id);
CREATE INDEX IF NOT EXISTS internal_episodes_mv_show_id_idx ON internal.episodes_mv (show_id);
CREATE INDEX IF NOT EXISTS internal_episodes_mv_published_at_idx ON internal.episodes_mv (published_at);

-- 4) Create public wrapper view selecting from the internal materialized view
CREATE OR REPLACE VIEW public.episodes
WITH (security_invoker = ON) AS
SELECT
  id,
  show_id,
  title,
  summary,
  published_at,
  duration
FROM internal.episodes_mv;

-- 5) Grants on the public view (adjust roles as needed)
GRANT SELECT ON public.episodes TO authenticated;
GRANT SELECT ON public.episodes TO anon; -- remove this line if anonymous access should not be allowed

-- 6) Refresh function for the materialized view
-- This function runs as a SECURITY DEFINER so it can be executed via a scheduled job by non-privileged roles.
CREATE OR REPLACE FUNCTION internal.refresh_episodes_mv()
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
  -- Use CONCURRENTLY to avoid exclusive lock when possible.
  REFRESH MATERIALIZED VIEW CONCURRENTLY internal.episodes_mv;
END;
$$;

-- Restrict execution of the refresh function from public roles
REVOKE EXECUTE ON FUNCTION internal.refresh_episodes_mv() FROM PUBLIC;
REVOKE EXECUTE ON FUNCTION internal.refresh_episodes_mv() FROM anon;
REVOKE EXECUTE ON FUNCTION internal.refresh_episodes_mv() FROM authenticated;

-- 7) Your provided status function (placed into public as you requested)
create or replace function public.episodes_mv_status()
returns jsonb
language sql
security invoker
set search_path = public, internal, extensions
as $$
  select jsonb_build_object(
    'size_bytes', pg_total_relation_size('internal.episodes_mv')
  );
$$;

grant execute on function public.episodes_mv_status() to anon, authenticated;

-- 8) Initial populate / refresh of the materialized view
-- Note: Requires the unique index created above for CONCURRENTLY.
REFRESH MATERIALIZED VIEW CONCURRENTLY internal.episodes_mv;

-- =====================================================
-- Post-checks: verify objects were created
-- =====================================================
-- Verify the materialized view and public view exist
SELECT n.nspname, c.relname, c.relkind
FROM pg_class c
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE (n.nspname = 'internal' AND c.relname = 'episodes_mv')
   OR (n.nspname = 'public' AND c.relname = 'episodes');

-- Check indexes on the materialized view
SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'internal' AND tablename = 'episodes_mv';

-- =====================================================
-- Notes and reminders:
-- =====================================================
-- Replace public.episodes_source with the actual table or SELECT query that should populate the materialized view.
-- REFRESH MATERIALIZED VIEW CONCURRENTLY requires a unique index on the materialized view — we've created one on id.
-- The DROP VIEW ... CASCADE step is destructive. Ensure you have a recent backup (pg_dump) before executing.
-- After running, schedule internal.refresh_episodes_mv() via your job scheduler (cron / pg_cron / Supabase scheduled function) as needed.
--
