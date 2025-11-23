// Dieses Modul verwaltet Netzwerk-Anfragen.
const axios = require("axios");
const path = require("path");
const logger = require("../loggingSetup");
const { RATE_LIMIT_MS } = require("../config");

let lastRequestTime = 0;

function _getUserAgent() {
  try {
    // Lese die package.json-Datei, um die Versionsnummer zu erhalten
    const packageJson = require(path.join(__dirname, "..", "package.json"));
    const ver = packageJson.version;
    return `KlubradioScraper/${ver} (+https://github.com/yourorg/klubradio-archivum-app)`;
  } catch (error) {
    logger.warn(
      `Fehler beim Lesen der package.json: ${error.message}. Verwende Fallback-User-Agent.`,
    );
    return "KlubradioScraper/0.0.0 (+https://github.com/yourorg/klubradio-archivum-app)";
  }
}

async function rateLimit() {
  const now = Date.now();
  const elapsed = now - lastRequestTime;
  if (elapsed < RATE_LIMIT_MS) {
    const sleepTime = RATE_LIMIT_MS - elapsed;
    logger.info(`Rate-Limit: Warte ${sleepTime}ms...`);
    await new Promise((resolve) => setTimeout(resolve, sleepTime));
  }
  lastRequestTime = now;
}

async function fetchPage(url) {
  await rateLimit();
  logger.info(`Seite abrufen: ${url}`);
  const userAgent = _getUserAgent();

  try {
    const response = await axios.get(url, {
      headers: { "User-Agent": userAgent },
      timeout: 10000,
    });
    if (response.status !== 200) {
      throw new Error(`Statuscode: ${response.status}`);
    }
    logger.info("Seite erfolgreich abgerufen.");
    return response.data;
  } catch (error) {
    logger.error(`Fehler beim Abrufen der Seite ${url}: ${error.message}`);
    return null;
  }
}

module.exports = {
  fetchPage,
};
