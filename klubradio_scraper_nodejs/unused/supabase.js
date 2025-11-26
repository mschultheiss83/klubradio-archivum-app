// Dieses Modul verwaltet die Verbindung zu Supabase.
const { createClient } = require("@supabase/supabase-js");
const logger = require("../loggingSetup");
const { SUPABASE_URL, SUPABASE_KEY, SUPABASE_TABLE } = require("../config");

let supabase;

function getSupabaseClient() {
  if (!supabase) {
    try {
      supabase = createClient(SUPABASE_URL, SUPABASE_KEY);
      logger.info("Supabase-Client erfolgreich initialisiert.");
    } catch (error) {
      logger.error(
        `Fehler beim Initialisieren des Supabase-Clients: ${error.message}`,
      );
      return null;
    }
  }
  return supabase;
}

async function storeShowsInDb(showsData) {
  const client = getSupabaseClient();
  if (!client) {
    logger.error(
      "Supabase-Client ist nicht verfügbar. Daten können nicht gespeichert werden.",
    );
    return;
  }

  logger.info(`Speichere ${showsData.length} Shows in der Datenbank.`);

  // In Supabase V2 wird `insert` für die Speicherung verwendet.
  // Für Upserts kann `.upsert()` verwendet werden.
  try {
    const { data, error } = await client.from(SUPABASE_TABLE).insert(showsData);

    if (error) {
      throw error;
    }

    logger.info(
      `${data.length} Shows erfolgreich in der Datenbank gespeichert.`,
    );
  } catch (error) {
    logger.error(
      `Fehler beim Speichern der Shows in Supabase: ${error.message}`,
    );
  }
}

module.exports = {
  getSupabaseClient,
  storeShowsInDb,
};
