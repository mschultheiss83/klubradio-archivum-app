create table public.playback_events (
  id uuid not null default gen_random_uuid (),
  episodeid text not null,
  podcastid text not null,
  userid uuid null,
  client text null,
  ip inet null,
  playedat timestamp with time zone not null default now(),
  constraint playback_events_pkey primary key (id)
) TABLESPACE pg_default;
