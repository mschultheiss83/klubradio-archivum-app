// Dieses Modul ist für das Parsen von HTML-Inhalten zuständig.
const cheerio = require("cheerio");
const logger = require("../loggingSetup");

function parseArchivePage(htmlContent) {
  logger.info("Starte das Parsen der Archivseite...");
  const $ = cheerio.load(htmlContent);
  const shows = [];

  // TODO: Passen Sie diese Selektoren an die tatsächliche HTML-Struktur an.
  // Dies sind nur Beispiele.
  $("div.archive-item").each((i, element) => {
    try {
      const title = $(element).find("h3.program-title").text().trim();
      const date = $(element).find("span.program-date").text().trim();
      const audioLink = $(element).find("a.audio-link").attr("href");

      if (title && audioLink) {
        shows.push({
          title,
          date,
          audio_url: audioLink,
          source_page: "https://www.klubradio.hu/archivum",
        });
      }
    } catch (error) {
      logger.warn(`Fehler beim Parsen eines Archiv-Items: ${error.message}`);
    }
  });

  logger.info(`Parsing abgeschlossen. ${shows.length} Shows gefunden.`);
  return shows;
}

function parseDetailsPage(htmlContent) {
  logger.info("Starte das Parsen der Detailseite...");
  const $ = cheerio.load(htmlContent);
  const details = {};

  // TODO: Passen Sie diese Selektoren an die Struktur der Detailseite an
  const description = $("div.show-description p").text().trim();
  if (description) {
    details.description = description;
  }

  logger.info("Parsing der Detailseite abgeschlossen.");
  return details;
}

module.exports = {
  parseArchivePage,
  parseDetailsPage,
};
