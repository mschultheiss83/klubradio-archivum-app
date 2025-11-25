// speed_upload_shows.js
const { createClient } = require('@supabase/supabase-js');
const fs = require('fs/promises');
const path = require('path');
require('dotenv').config();

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;
const DIRECTORY = path.join(__dirname, 'downloads');

// Tuning knobs
const FILE_READ_CONCURRENCY = Number(process.env.FILE_READ_CONCURRENCY || 16);
const UPSERT_CHUNK_SIZE = Number(process.env.UPSERT_CHUNK_SIZE || 500);
const ONLY_INSERT_NEW = String(process.env.ONLY_INSERT_NEW || '').toLowerCase() === 'true';

if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.error('❌ Fehler: SUPABASE_URL oder SUPABASE_ANON_KEY fehlen.');
  process.exit(1);
}

const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

function parseDate(dateString) {
  if (!dateString) return null;
  return dateString.replace(/[\(\)]/g, '').trim();
}

function parseDuration(durationString) {
  if (!durationString) return null;
  const parts = durationString.split(':');
  let totalMinutes = 0;
  if (parts.length === 2) {
    totalMinutes = parseInt(parts[0], 10); // MM:SS -> minutes
  } else if (parts.length === 3) {
    const hours = parseInt(parts[0], 10);
    const minutes = parseInt(parts[1], 10);
    totalMinutes = hours * 60 + minutes;
  }
  return totalMinutes;
}

const collator = new Intl.Collator(undefined, { numeric: true, sensitivity: 'base' });

function chunk(arr, size) {
  const out = [];
  for (let i = 0; i < arr.length; i += size) out.push(arr.slice(i, i + size));
  return out;
}

/** Simple concurrency limiter */
async function mapWithConcurrency(items, limit, worker) {
  const results = new Array(items.length);
  let next = 0;
  let running = 0;

  return new Promise((resolve, reject) => {
    const run = () => {
      if (next >= items.length && running === 0) return resolve(results);
      while (running < limit && next < items.length) {
        const i = next++;
        running++;
        Promise.resolve(worker(items[i], i))
          .then((res) => { results[i] = res; })
          .catch(reject)
          .finally(() => { running--; run(); });
      }
    };
    run();
  });
}

async function readAllRecords() {
  const files = (await fs.readdir(DIRECTORY))
    .filter(f => f.startsWith('resultDetails-') && f.endsWith('.json'))
    .sort((a, b) => collator.compare(a, b))
    .reverse();

  if (files.length === 0) {
    console.log('Keine JSON-Dateien gefunden.');
    return [];
  }

  console.log(`📁 Dateien gefunden: ${files.length}. Lese & parse mit ${FILE_READ_CONCURRENCY}× Parallelität...`);
  return await mapWithConcurrency(files, FILE_READ_CONCURRENCY, async (file) => {
    const filePath = path.join(DIRECTORY, file);
    const data = await fs.readFile(filePath, 'utf-8');
    const record = JSON.parse(data);

    return {
      id: record.id,
      title: record.title ?? null,
      description: record.description ?? null,
      show_date: parseDate(record.date),
      hosts: record.hostsTexts ?? [],
      rss_url: record.rss ?? null,
      program_id: record.programId ?? null,
      program_image: record.programImg ?? null,
      mp3_url: record.mp3Link ?? null,
      duration: parseDuration(record.duration),
    };
  });
}

async function upsertChunkMinimal(rows) {
  if (rows.length === 0) return { inserted: 0 };
  const { error } = await supabase
    .from('shows')
    .upsert(rows, { onConflict: 'id' })
    .select('*', { head: true, count: 'exact' }); // minimal response

  return { inserted: rows.length, error: error?.message || null };
}

async function existingIdsFor(chunkIds) {
  const { data, error } = await supabase
    .from('shows')
    .select('id')
    .in('id', chunkIds);

  if (error) {
    console.warn('⚠️ Konnte bestehende IDs nicht abfragen, fall-back auf Upsert:', error.message);
    return null;
  }
  return new Set((data || []).map(r => r.id));
}

async function main() {
  const t0 = Date.now();
  const allRows = await readAllRecords();
  console.log(`🧮 Aufbereitet: ${allRows.length} Datensätze.`);

  const chunks = chunk(allRows, UPSERT_CHUNK_SIZE);
  let processed = 0;
  let inserted = 0;

  for (let i = 0; i < chunks.length; i++) {
    const batch = chunks[i];
    let toSend = batch;

    if (ONLY_INSERT_NEW) {
      const ids = batch.map(r => r.id);
      const existing = await existingIdsFor(ids);
      if (existing) {
        toSend = batch.filter(r => !existing.has(r.id));
      }
    }

    const { error } = await upsertChunkMinimal(toSend);

    if (error) {
      console.error(`❌ Fehler in Chunk ${i + 1}/${chunks.length}:`, error);
    } else {
      inserted += toSend.length;
    }

    processed += batch.length;

    if ((i + 1) % Math.max(1, Math.floor(1000 / UPSERT_CHUNK_SIZE)) === 0 || i === chunks.length - 1) {
      const secs = Math.round((Date.now() - t0) / 1000);
      console.log(`✅ Fortschritt: ${processed}/${allRows.length} (eingespielt: ${inserted}) – ${secs}s`);
    }
  }

  const totalSecs = Math.round((Date.now() - t0) / 1000);
  console.log(`✨ Fertig. Datensätze: ${allRows.length}, upserts/inserts: ${inserted}, Zeit: ${totalSecs}s`);

  // --- ADDED LINES TO REFRESH MATERIALIZED VIEWS ---
  console.log('🔄 Refreshing materialized views...');
  // Call the Supabase RPC function
  const { error: refreshError } = await supabase.rpc('refresh_all_materialized_views');

  if (refreshError) {
    console.error('❌ Fehler beim Aktualisieren der Materialized Views:', refreshError);
  } else {
    console.log('✅ Materialized Views erfolgreich aktualisiert.');
  }
  // --- END OF ADDED LINES ---
}

(async () => {
  try {
    await main();
  } catch (e) {
    console.error('Ein schwerwiegender Fehler ist aufgetreten:', e);
    process.exit(1);
  }
})();
