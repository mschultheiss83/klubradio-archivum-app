// Dies ist der zentrale Einstiegspunkt (Runner) für das Projekt.
// Es steuert den gesamten Prozess basierend auf den Befehlszeilen-Parametern.

import { flow } from "./flow.js";
import { rssBuild } from "./rssBuild.js";
import { supabase } from "./supabase.js";
import logging from "../loggingSetup.js";

const logger = logging.getLogger("main");

/**
 * Startet den Haupt-Workflow.
 * @param {string} mode - Der auszuführende Modus ('all', 'scrape', 'rss').
 */
async function run(mode) {
  try {
    if (mode === "all" || mode === "scrape") {
      logger.info("Starte den Scraper-Workflow...");
      await flow();
    }

    if (mode === "all" || mode === "rss") {
      logger.info("Starte den RSS-Workflow...");
      const client = await supabase.getClient();
      const { data, error } = await client
        .from("shows")
        .select("*")
        .order("published_date", { ascending: false });

      if (error) {
        logger.error(
          `Fehler beim Abrufen der Daten aus Supabase: ${error.message}`,
        );
        return;
      }

      const rssContent = rssBuild.build(data);
      // TODO: Füge hier die Logik zum Hochladen des RSS-Feeds in Supabase Storage hinzu.
      logger.info("RSS-Feed wurde erfolgreich erstellt.");
      console.log(rssContent); // Zum Debuggen
    }

    if (mode === undefined) {
      logger.error(
        'Kein Modus angegeben. Bitte verwenden Sie "npm start scrape", "npm start rss" oder "npm start all".',
      );
    }

    if (mode !== "all" && mode !== "scrape" && mode !== "rss") {
      logger.error(
        `Ungültiger Modus: "${mode}". Gültige Modi sind "all", "scrape" oder "rss".`,
      );
    }
  } catch (err) {
    logger.error(`Ein unerwarteter Fehler ist aufgetreten: ${err.message}`);
    console.error(err);
  }
}

// Führt die Funktion basierend auf den Befehlszeilen-Argumenten aus.
const args = process.argv.slice(2);
run(args[0]);
