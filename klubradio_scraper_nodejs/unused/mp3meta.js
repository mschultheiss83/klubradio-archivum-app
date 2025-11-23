// Dieses Modul bestimmt die Länge einer MP3-Datei durch das Parsen des Headers.
const axios = require("axios");
const logger = require("../loggingSetup");

// Bitraten-Lookup-Tabelle (MPEG 1, Layer III)
const BITRATES = {
  1: [0, 32, 40, 48, 56, 64, 80, 96, 112, 128, 160, 192, 224, 256, 320, 0],
};
// Abtastfrequenz-Lookup-Tabelle (MPEG 1)
const SAMPLING_RATES = {
  1: [44100, 48000, 32000],
};

async function getMp3Duration(url) {
  logger.info(`Versuche, die Dauer von ${url} zu ermitteln...`);
  try {
    const response = await axios({
      method: "get",
      url: url,
      responseType: "stream",
      timeout: 10000,
    });

    // Wir lesen nur einen kleinen Puffer, der den Header enthalten sollte.
    const buffer = await new Promise((resolve, reject) => {
      const chunks = [];
      response.data.on("data", (chunk) => {
        chunks.push(chunk);
        if (chunks.reduce((acc, val) => acc + val.length, 0) >= 4096) {
          response.data.destroy(); // Stoppe das Herunterladen
          resolve(Buffer.concat(chunks));
        }
      });
      response.data.on("end", () => resolve(Buffer.concat(chunks)));
      response.data.on("error", reject);
    });

    const file_size = parseInt(response.headers["content-length"], 10);
    if (!file_size) {
      throw new Error(
        "Content-Length Header fehlt. Dauer kann nicht berechnet werden.",
      );
    }

    // Suche den ersten MP3-Frame-Header im Puffer
    let frameStartIndex = -1;
    for (let i = 0; i < buffer.length - 4; i++) {
      // Ein gültiger Frame-Header beginnt mit 11 Bits, die alle auf 1 gesetzt sind
      if (buffer[i] === 0xff && (buffer[i + 1] & 0xf0) === 0xf0) {
        frameStartIndex = i;
        break;
      }
    }

    if (frameStartIndex === -1) {
      throw new Error("Kein gültiger MP3-Frame-Header gefunden.");
    }

    const header = buffer.readUInt32BE(frameStartIndex);

    // Extrahiere Metadaten aus dem Header
    const versionId = (header >> 19) & 0x3;
    const layer = (header >> 17) & 0x3;
    const bitrateIndex = (header >> 12) & 0xf;
    const samplingRateIndex = (header >> 10) & 0x3;

    // Prüfe auf MPEG 1, Layer III (üblich für MP3-Dateien)
    if (versionId !== 3 || layer !== 1) {
      throw new Error("Unbekanntes MP3-Format (nicht MPEG 1, Layer III).");
    }

    const bitrate = BITRATES[versionId][bitrateIndex];
    const sampleRate = SAMPLING_RATES[versionId][samplingRateIndex];

    if (bitrate === 0 || sampleRate === 0) {
      throw new Error("Ungültige Bitrate oder Abtastfrequenz.");
    }

    const durationSeconds = Math.floor(file_size / ((bitrate * 1000) / 8));
    logger.info(
      `Dauer ermittelt: ${durationSeconds} Sekunden (Bitrate: ${bitrate} kbps).`,
    );
    return durationSeconds;
  } catch (error) {
    logger.error(
      `Fehler beim Abrufen oder Parsen der MP3-Metadaten von ${url}: ${error.message}`,
    );
    return 0;
  }
}

module.exports = {
  getMp3Duration,
};
