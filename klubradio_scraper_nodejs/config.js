// Dieses Modul lädt Umgebungsvariablen und definiert Konstanten für das Projekt.
const path = require("path");

// Umgebungs-Konfiguration
require("dotenv").config();

const SUPABASE_URL = process.env.SUPABASE_URL;
const SUPABASE_KEY = process.env.SUPABASE_KEY;
const SUPABASE_TABLE = "klubradio_shows";

// Scraper-Konstanten
const KLUBRADIO_ARCHIVE_URL = "https://www.klubradio.hu/archivum";
const HEADERS = {
  "User-Agent":
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36",
};
const RATE_LIMIT_MS = 2000; // Wartezeit zwischen den Anfragen in Millisekunden

// Pfade für den lokalen Cache und Logging
const BASE_DIR = path.resolve(__dirname, "..");
const CACHE_DIR = path.join(BASE_DIR, "cache");
const LOG_DIR = path.join(BASE_DIR, "logs");

// Stellen Sie sicher, dass die Verzeichnisse existieren
if (!require("fs").existsSync(CACHE_DIR)) {
  require("fs").mkdirSync(CACHE_DIR);
}
if (!require("fs").existsSync(LOG_DIR)) {
  require("fs").mkdirSync(LOG_DIR);
}

const CACHE_PATH = path.join(CACHE_DIR, "page_cache.json");
const LOG_FILE_PATH = path.join(LOG_DIR, "scraper.log");

function validateConfig() {
  if (!SUPABASE_URL || !SUPABASE_KEY) {
    throw new Error(
      "SUPABASE_URL und SUPABASE_KEY müssen in den Umgebungsvariablen gesetzt sein.",
    );
  }
  console.log("Konfiguration erfolgreich validiert.");
}

module.exports = {
  SUPABASE_URL,
  SUPABASE_KEY,
  SUPABASE_TABLE,
  KLUBRADIO_ARCHIVE_URL,
  HEADERS,
  RATE_LIMIT_MS,
  CACHE_PATH,
  LOG_FILE_PATH,
  validateConfig,
};
