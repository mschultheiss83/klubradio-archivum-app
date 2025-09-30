-- 0) Private schema for caches/materialized stuff
create schema if not exists internal;

-- Make sure anon/auth users cannot see internal objects by default
revoke all on schema internal from public, anon, authenticated;
grant usage on schema internal to postgres;  -- owner/admin role

-- 1) (Re)create the MV inside the private schema
drop view if exists public.episodes;
drop materialized view if exists internal.episodes_mv;

create or replace materialized view internal.episodes_mv as
select
  s.id                                       as id,
  case when s.program_id is null then s.id else s.program_id end as "podcastId",
  s.title                                   as title,
  coalesce(s.description[1], '')            as description,
  s.mp3_url                                 as "audioUrl",
  s.created_at                              as "publishedAt",
  coalesce(s.duration, 0)                   as duration,      -- seconds
  s.program_image                           as "imageUrl",
  coalesce(s.hosts, '{}')                   as hosts
from public.shows s;

-- 2) Indexes for fast reads + concurrent refresh
create unique index if not exists episodes_mv_pk
  on internal.episodes_mv (id);

create index if not exists episodes_mv_podcastId_idx
  on internal.episodes_mv ("podcastId");

create index if not exists episodes_mv_publishedAt_desc_idx
  on internal.episodes_mv ("publishedAt" desc);

-- 3) Public, RLS-aware wrapper view (what your app should query)
create or replace view public.episodes
with (security_invoker = on) as
select
  id,
  "podcastId",
  title,
  description,
  "audioUrl",
  "publishedAt",
  duration,
  "imageUrl",
  hosts
from internal.episodes_mv;

-- Grant read ONLY on the public view
grant select on public.episodes to anon, authenticated;

-- Ensure base table has the RLS posture you want (optional)
alter table public.shows enable row level security;
drop policy if exists "shows_read_all" on public.shows;
create policy "shows_read_all" on public.shows
  for select
  to anon, authenticated
  using (true);

-- 4) Safe refresh function + (optional) cron schedule
create or replace function public.refresh_episodes_mv()
returns void
language plpgsql
security definer
set search_path = public, internal, extensions
as $$
declare
  got_lock boolean;
begin
  got_lock := pg_try_advisory_lock(hashtext('public.refresh_episodes_mv'));
  if not got_lock then
    return;
  end if;

  begin
    refresh materialized view concurrently internal.episodes_mv;
  exception
    when feature_not_supported then
      refresh materialized view internal.episodes_mv;
  end;

  perform pg_advisory_unlock(hashtext('public.refresh_episodes_mv'));
end;
$$;

-- First build/refresh (after indexes created)
select public.refresh_episodes_mv();

-- If you use pg_cron on Supabase (optional):
create extension if not exists pg_cron with schema extensions;
select cron.schedule(
   'refresh_episodes_mv_every_30min',
   '*/30 * * * *',
   $$select public.refresh_episodes_mv();$$
 );
