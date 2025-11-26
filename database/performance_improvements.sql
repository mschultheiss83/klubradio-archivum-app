-- SQL for creating Materialized Views to improve read performance

-- Drop existing views/materialized views before recreating them
-- DROP VIEW IF EXISTS public.episodes;
DROP MATERIALIZED VIEW IF EXISTS public.episodes;
-- DROP VIEW IF EXISTS public.podcasts;
DROP MATERIALIZED VIEW IF EXISTS public.podcasts;
--- DROP VIEW IF EXISTS public.top_shows_this_year;
DROP MATERIALIZED VIEW IF EXISTS public.top_shows_this_year;


-- Create Materialized View for Episodes
CREATE MATERIALIZED VIEW public.episodes AS
SELECT
  id,
  CASE
    WHEN program_id IS NULL THEN id
    ELSE program_id
  END AS "podcastId",
  title,
  COALESCE(description[1], ''::text) AS description,
  mp3_url AS "audioUrl",
  created_at AS "publishedAt",
  show_date AS "showDate",
  COALESCE(duration * 60, 0) AS duration,
  program_image AS "imageUrl",
  COALESCE(hosts, '{}'::text[]) AS hosts
FROM
  shows s
ORDER BY
  id DESC;

-- Create Materialized View for Podcasts
CREATE MATERIALIZED VIEW public.podcasts AS
WITH
  base AS (
    SELECT
      COALESCE(shows.program_id::text, shows.id::text) AS podcast_id,
      shows.id AS episode_id,
      shows.created_at,
      shows.title AS episode_title,
      shows.show_date,
      shows.hosts,
      shows.description,
      shows.mp3_url,
      shows.duration,
      shows.program_image
    FROM
      shows
  )
SELECT
  p.podcast_id AS id,
  COALESCE(lat.episode_title, 'Ismeretlen műsor'::text) AS title,
  COALESCE(p.podcast_description, ''::text) AS description,
  lat.cover_image_url,
  p.episode_count,
  COALESCE(lat.hosts, array[]::text[]) AS hosts,
  jsonb_build_object(
    'id',
    lat.episode_id,
    'title',
    lat.episode_title,
    'show_date',
    lat.show_date,
    'mp3_url',
    lat.mp3_url,
    'duration',
    lat.duration,
    'hosts',
    COALESCE(lat.hosts, array[]::text[])
  ) AS latest_episode,
  p.last_updated
FROM
  (
    SELECT
      b.podcast_id,
      max(b.program_image) AS cover_image_url,
      count(*) AS episode_count,
      max(b.created_at) AS last_updated,
      (
        SELECT
          COALESCE(bb.description[1], ''::text) AS "coalesce"
        FROM
          base bb
        WHERE
          bb.podcast_id = b.podcast_id
          AND bb.description IS NOT NULL
        LIMIT
          1
      ) AS podcast_description
    FROM
      base b
    GROUP BY
      b.podcast_id
  ) p
  LEFT JOIN LATERAL (
    SELECT
      b.podcast_id,
      b.episode_id,
      b.episode_title,
      b.show_date,
      b.description,
      b.mp3_url,
      b.duration,
      b.hosts,
      b.created_at,
      b.program_image
    FROM
      base b
    WHERE
      b.podcast_id = p.podcast_id
    ORDER BY
      (
        CASE
          WHEN NULLIF(b.created_at, ''::text) IS NULL THEN 1
          ELSE 0
        END
      ),
      (NULLIF(b.created_at, ''::text)) DESC,
      b.created_at DESC
    LIMIT
      1
  ) lat ON TRUE;

-- Create Materialized View for Top Shows This Year
CREATE MATERIALIZED VIEW public.top_shows_this_year AS
SELECT
  program_id as id,
  title,
  count(program_id) as count
FROM
  shows
WHERE
  EXTRACT(
    year
    FROM
      (created_at AT TIME ZONE 'UTC'::text)
  ) = EXTRACT(
    year
    FROM
      (now() AT TIME ZONE 'UTC'::text)
  )
GROUP BY
  program_id,
  title
ORDER BY
  (count(program_id)) DESC
LIMIT
  8;

-- Create function to refresh all materialized views
CREATE OR REPLACE FUNCTION public.
RETURNS void
LANGUAGE plpgsql
SECURITY DEFINER
AS $$
BEGIN
    REFRESH MATERIALIZED VIEW public.episodes;
    REFRESH MATERIALIZED VIEW public.podcasts;
    REFRESH MATERIALIZED VIEW public.top_shows_this_year;
END;
$$;

-- Commands to refresh materialized views
-- These commands should be run periodically, for example, after the speed_upload_shows.js script completes,
-- or on a schedule (e.g., daily) to ensure the materialized views are up-to-date.
REFRESH MATERIALIZED VIEW public.episodes;
REFRESH MATERIALIZED VIEW public.podcasts;
REFRESH MATERIALIZED VIEW public.top_shows_this_year;