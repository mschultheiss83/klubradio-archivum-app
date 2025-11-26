// Dieses Skript orchestriert den gesamten Scraping- und Datenspeicherungs-Workflow.
const logger = require("../loggingSetup");
const { validateConfig, KLUBRADIO_ARCHIVE_URL } = require("../config");
const { fetchPage } = require("./net");
const { parseArchivePage, parseDetailsPage } = require("./parsing");
const { getMp3Duration } = require("./mp3meta");
const { storeShowsInDb } = require("./supabase");
const { loadCache, saveCache } = require("./cache");

async function mainFlow() {
  logger.info("Starte den Haupt-Workflow.");

  try {
    // Schritt 1: Konfiguration validieren
    validateConfig();

    // Schritt 2: Cache laden
    const pageCache = loadCache();

    // Schritt 3: Archivseite abrufen und parsen
    const htmlContent = await fetchPage(KLUBRADIO_ARCHIVE_URL);
    if (!htmlContent) {
      logger.error("Archivseite konnte nicht abgerufen werden. Breche ab.");
      return;
    }

    const showsList = parseArchivePage(htmlContent);

    // Schritt 4: Zusätzliche Details für jede Show abrufen (wenn nicht im Cache)
    for (const show of showsList) {
      const audioUrl = show.audio_url;

      // Schritt 5: MP3-Dauer ermitteln
      if (audioUrl) {
        const duration = await getMp3Duration(audioUrl);
        show.duration = duration;
      }
    }

    // Schritt 6: Daten in Supabase speichern
    await storeShowsInDb(showsList);

    // Schritt 7: Cache speichern
    // Hier könnten wir die HTML-Inhalte in den Cache schreiben, um sie wiederzuverwenden.
    // pageCache[KLUBRADIO_ARCHIVE_URL] = htmlContent;
    // saveCache(pageCache);

    logger.info("Workflow abgeschlossen.");
  } catch (error) {
    logger.error(
      `Ein schwerwiegender Fehler ist im Haupt-Flow aufgetreten: ${error.message}`,
    );
  }
}

mainFlow();
