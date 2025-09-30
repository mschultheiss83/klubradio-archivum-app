create or replace view public.podcasts as
with base as (
  select
    coalesce(program_id::text, id::text) as podcast_id,
    id as episode_id,
    created_at,
    title as episode_title,
    show_date,
    hosts,
    description,
    mp3_url,
    duration,
    program_image
  from public.shows
)
select
  a.podcast_id as id,
  coalesce(lat.episode_title, 'Ismeretlen műsor') as title,
  coalesce(lat.description[1], '') as description,
  a.cover_image_url as "coverImageUrl",
  a.episode_count as "episodeCount",
  a.hosts_json as hosts,
  jsonb_build_object(
    'id',       lat.episode_id,
    'title',    lat.episode_title,
    'show_date',lat.show_date,
    'mp3_url',  lat.mp3_url,
    'duration', lat.duration
  ) as "latestEpisode",
  a.last_updated as "lastUpdated"
from (
  select
    podcast_id,
    -- aggregate hosts once per podcast: distinct unnest -> jsonb array
    coalesce((
      select jsonb_agg(jsonb_build_object('name', h))
      from (
        select distinct unnest(b.hosts) as h
        from base b
        where b.podcast_id = p.podcast_id
      ) s
    ), '[]'::jsonb) as hosts_json,
    max(program_image) as cover_image_url,
    count(*) as episode_count,
    max(created_at) as last_updated
  from base p
  group by podcast_id
) a
left join lateral (
  -- pick single latest episode per podcast_id by show_date (non-empty preferred) then created_at
  select
    podcast_id,
    episode_id,
    episode_title,
    show_date,
    description,
    mp3_url,
    duration,
    created_at
  from base b
  where b.podcast_id = a.podcast_id
  order by
    (case when nullif(b.show_date, '') is null then 1 else 0 end), -- prefer non-null/empty show_date
    nullif(b.show_date, '') desc,
    b.created_at desc
  limit 1
) lat on true;