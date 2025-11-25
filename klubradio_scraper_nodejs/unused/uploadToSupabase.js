const { createClient } = require('@supabase/supabase-js');
const fs = require('fs');
const path = require('path');
require('dotenv').config(); // Läd Umgebungsvariablen aus der .env-Datei

// --- Konfiguration ---
// Supabase-Anmeldeinformationen aus Umgebungsvariablen laden
const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_ANON_KEY = process.env.SUPABASE_ANON_KEY;
const DIRECTORY = path.join(__dirname, 'downloads');

// Prüfen, ob die Umgebungsvariablen gesetzt sind
if (!SUPABASE_URL || !SUPABASE_ANON_KEY) {
  console.error('❌ Fehler: Supabase-URL oder Anon-Key nicht in der .env-Datei gefunden.');
  process.exit(1);
}

// --- Initialisieren des Supabase-Clients ---
const supabase = createClient(SUPABASE_URL, SUPABASE_ANON_KEY);

function parseDate(dateString) {
  if (!dateString) return null;
  return dateString.replace(/[\(\)]/g, '').trim();
}

// --- Hilfsfunktion zum Parsen der Dauer ---
function parseDuration(durationString) {
  if (!durationString) return null;
  const parts = durationString.split(':');
  let totalMinutes = 0;
  if (parts.length === 2) {
    // Format MM:SS
    totalMinutes = parseInt(parts[0], 10);
  } else if (parts.length === 3) {
    // Format HH:MM:SS (falls es jemals vorkommt)
    const hours = parseInt(parts[0], 10);
    const minutes = parseInt(parts[1], 10);
    totalMinutes = hours * 60 + minutes;
  }
  return totalMinutes;
}

const collator = new Intl.Collator(undefined, {
  numeric: true,
  sensitivity: 'base'
});

// --- Hauptfunktion zum Hochladen der Daten ---
async function main() {
  console.log('Starte Upload der JSON-Dateien zu Supabase...');
  const start = new Date()

  try {
    const files = Array.from(fs.readdirSync(DIRECTORY).filter(file => file.startsWith('resultDetails-') && file.endsWith('.json')))
      .sort((a, b) => collator.compare(a, b)).reverse()

    let index = 0
    if (files.length === 0) {
      console.log('Keine JSON-Dateien zum Hochladen gefunden.');
      return;
    }

    for (const file of files) {
      const filePath = path.join(DIRECTORY, file);
      const data = fs.readFileSync(filePath, 'utf-8');
      const record = JSON.parse(data);
      if (index % 1000 === 0) {
        console.log(`current index ${index}`, record.id, Math.round((new Date() - start)/1000), 'sec')
      }
      // Umwandlung der Dauer vor dem Hochladen
      const durationInMinutes = parseDuration(record.duration);
      const showDate = parseDate(record.date);

      // Supabase-Einfüge-Anfrage
      const { data: insertedData, error } = await supabase
        .from('shows')
        .upsert([
          {
            id: record.id,
            title: record.title,
            description: record.description,
            show_date: showDate,
            hosts: record.hostsTexts,
            rss_url: record.rss,
            mp3_url: record.mp3Link,
            duration: durationInMinutes // Verwende den umgewandelten Wert
          }
        ]);

      if (error) {
        console.error(`❌ Fehler beim Hochladen von ${file}:`, error.message);
      }

      if (insertedData) {
        console.log(`✅ ${file} erfolgreich hochgeladen.`);
        console.log(insertedData)
      }

      index++
    }

    console.log('✨ Alle Dateien wurden verarbeitet.');
  } catch (error) {
    console.error('Ein schwerwiegender Fehler ist aufgetreten:', error);
  }
}

(async () => {
  const start = new Date()
  console.log(start.toISOString())
  await main();
  const end = new Date()
  console.log(end.toISOString(), Math.round((end - start)/1000))
})()
