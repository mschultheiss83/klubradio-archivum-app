// Dieses Modul verwaltet den lokalen Cache.
const fs = require("fs");
const { CACHE_PATH } = require("../config");
const logger = require("../loggingSetup");

function loadCache() {
  if (fs.existsSync(CACHE_PATH)) {
    try {
      const data = fs.readFileSync(CACHE_PATH, "utf8");
      logger.info(`Cache erfolgreich von ${CACHE_PATH} geladen.`);
      return JSON.parse(data);
    } catch (error) {
      logger.error(`Fehler beim Laden des Caches: ${error.message}`);
      return {};
    }
  }
  logger.info("Cache-Datei nicht gefunden. Starte mit einem leeren Cache.");
  return {};
}

function saveCache(data) {
  try {
    fs.writeFileSync(CACHE_PATH, JSON.stringify(data, null, 4), "utf8");
    logger.info(`Cache erfolgreich in ${CACHE_PATH} gespeichert.`);
  } catch (error) {
    logger.error(`Fehler beim Speichern des Caches: ${error.message}`);
  }
}

module.exports = {
  loadCache,
  saveCache,
};
