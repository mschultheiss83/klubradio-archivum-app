
const puppeteer = require('puppeteer');
const https = require('https');
const fs = require('fs');
const path = require('path');
const logger = require("./loggingSetup");

// --- Konfiguration ---
const CONFIG = {
  archivumUrl: 'https://www.klubradio.hu/archivum/',
  cookieFile: 'cookies.json', // Dateipfad für Cookies
  userAgent: _getUserAgent(),
  headless:  false, // true || false, // Verwende den neuen Headless-Modus
  outputDir: './downloads', // Verzeichnis für heruntergeladene Dateien
  resultsFile: './result.json', // Dateipfad für die Ergebnisse
  delay: 2000, // Verzögerung zwischen Aktionen (in ms)
  nextPageSelector: 'div.pager div.current a.page-link[rel="next"]' // Dies ist der vermutete Selektor. Falls es nicht funktioniert, müssen Sie diesen manuell im Browser-Inspektor finden.
};

function _getUserAgent() {
  try {
    // Lese die package.json-Datei, um die Versionsnummer zu erhalten
    const packageJson = require(path.join(__dirname, "package.json"));
    const ver = packageJson.version;
    return `KlubradioScraper/${ver} (+https://github.com/yourorg/klubradio-archivum-app)`;
  } catch (error) {
    logger.warn(
      `Fehler beim Lesen der package.json: ${error.message}. Verwende Fallback-User-Agent.`,
    );
    return "KlubradioScraper/0.0.0 (+https://github.com/yourorg/klubradio-archivum-app)";
  }
}

// --- Hilfsfunktionen ---
/**
 * Verzögert die Ausführung um eine bestimmte Zeit.
 * @param {number} ms Die Verzögerungszeit in Millisekunden.
 */
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}
/**
 * Lädt Cookies aus einer Datei und fügt sie der Seite hinzu.
 * @param {object} page Die Puppeteer-Page-Instanz.
 * @param {string} filePath Der Pfad zur Cookie-Datei.
 */
async function loadCookies(page, filePath) {
  if (fs.existsSync(filePath)) {
    try {
      const cookiesString = fs.readFileSync(filePath);
      const cookies = JSON.parse(cookiesString);
      await page.setCookie(...cookies);
      console.log(`🍪 Cookies erfolgreich aus ${filePath} geladen.`);
    } catch (error) {
      console.error('❌ Fehler beim Laden der Cookies:', error.message);
    }
  } else {
    console.log(`ℹ️ Cookie-Datei nicht gefunden, beginne mit einer neuen Sitzung.`);
  }
}

/**
 * Speichert Cookies von der Seite in eine Datei.
 * @param {object} page Die Puppeteer-Page-Instanz.
 * @param {string} filePath Der Pfad, unter dem die Cookies gespeichert werden sollen.
 */
async function saveCookies(page, filePath) {
  const cookies = await page.cookies();
  fs.writeFileSync(filePath, JSON.stringify(cookies, null, 2));
  console.log(`🍪 Cookies erfolgreich in ${filePath} gespeichert.`);
}

/**
 * Lädt eine Datei von einer URL herunter und speichert sie.
 * @param {string} url Die URL der herunterzuladenden Datei.
 * @param {string} filename Der Name der Datei, unter dem sie gespeichert werden soll.
 */
async function downloadFile(url, filename) {
  if (!fs.existsSync(CONFIG.outputDir)) {
    fs.mkdirSync(CONFIG.outputDir, { recursive: true });
  }

  const filePath = path.join(CONFIG.outputDir, filename);
  const file = fs.createWriteStream(filePath);

  return new Promise((resolve, reject) => {
    https.get(url, (response) => {
      if (response.statusCode !== 200) {
        return reject(new Error(`Download fehlgeschlagen, Statuscode: ${response.statusCode}`));
      }
      response.pipe(file);
      file.on('finish', () => {
        file.close();
        console.log(`✅ Datei heruntergeladen und gespeichert: ${filePath}`);
        resolve();
      });
    }).on('error', (err) => {
      fs.unlink(filePath, () => {}); // Löscht die Datei bei einem Fehler
      reject(err);
    });
  });
}

/**
 * Navigiert zur nächsten Seite, indem sie den entsprechenden Pager-Link findet und klickt.
 * @param {object} page Die Puppeteer-Page-Instanz.
 * @returns {Promise<boolean>} Gibt true zurück, wenn eine nächste Seite gefunden und geklickt wurde, ansonsten false.
 */
async function goToNextPage(page) {
  try {
    // Ruft die aktuelle Seitenzahl ab (im Browser-Kontext)
    const currentPageNumber = await page.$eval('.cur-page', el => parseInt(el.innerText.trim(), 10));
    console.log(`Aktuelle Seite: ${currentPageNumber}. Versuche zu Seite ${currentPageNumber + 1} zu navigieren...`);

    const nextPageNumber = currentPageNumber + 1;
    // Wählt das Element für die nächste Seite im Node.js-Kontext aus
    // Der Selektor sucht nach einem Link, dessen href die nächste Seitenzahl enthält
    const nextPageSelector = `a[href*="&page=${nextPageNumber}"]`;
    const nextPageLink = await page.$(nextPageSelector);

    if (nextPageLink) {
      const href = await page.evaluate(el => el.href, nextPageLink);
      await page.goto(href, { waitUntil: 'networkidle2' });
      console.log(`✅ Erfolgreich zu Seite ${nextPageNumber} navigiert.`);
      return true;
    } else {
      console.log('ℹ️ Keine nächste Seite mehr gefunden.');
      return false;
    }
  } catch (error) {
    console.error('❌ Fehler beim Navigieren zur nächsten Seite:', error.message);
    return false;
  }
}

// --- Haupt-Scraping-Funktion ---
async function scrapeKlubradio() {
  console.log('Starte Scraping-Prozess...');

  // Starte den Browser mit der konfigurierten Option
  const browser = await puppeteer.launch({
    headless: CONFIG.headless,
    // slowMo: 200,
    defaultViewport: null,
  });
  const pages = await browser.pages();
  const page = pages[0];

  await page.setRequestInterception(true);
  page.on('request', request => {
    const url = request.url();
    const type = request.resourceType()
    // Liste der zu blockierenden Ressourcentypen
    const blockedResources = ['image', 'stylesheet', 'font', 'media'];
    // Liste der zu blockierenden URL-Hostnamen oder -Muster
    const blockedUrls = [
      'https://pagead2.googlesyndication.com/pagead/ads'
      // Fügen Sie hier weitere URLs hinzu, die Sie blockieren möchten
    ];

    if (blockedResources.includes(type) || blockedUrls.some(urlToBlock => url.startsWith(urlToBlock))) {
      request.abort();
    } else {
      request.continue();
    }
  });

  // Lade Cookies, bevor die Seite aufgerufen wird
  await loadCookies(page, CONFIG.cookieFile);

  // Setzt einen realistischen User-Agent, um Bot-Erkennung zu umgehen
  await page.setUserAgent({
    userAgent: _getUserAgent(),
  });

  try {
    let results = [];
    let hasNextPage = true
    let pageCount = 1

    const resultFilePath = path.join(CONFIG.outputDir, CONFIG.resultsFile);
    if (fs.existsSync(resultFilePath)) {
      try {
        const data = fs.readFileSync(resultFilePath);
        const savedState = JSON.parse(data);
        pageCount = savedState.pageCount;
        results = savedState.results
        console.log(`✅ Gefundenen Status geladen. Starte ab Seite ${pageCount}.`);
      } catch (error) {
        console.error('❌ Fehler beim Laden des Status, starte von vorne:', error.message);
      }
    }
    // Navigiert zur Archivseite und wartet auf das vollständige Laden
    if (pageCount > 1) {
      console.log(`Navigiere direkt zu Seite ${pageCount}...`);
      await page.goto(`${CONFIG.archivumUrl}?page=${pageCount}`, { waitUntil: 'networkidle2' });
    } else {
      console.log('Navigiere zur Startseite...');
      await page.goto(CONFIG.archivumUrl, { waitUntil: 'networkidle2' });
    }

    // Schleife, die die Seiten durchläuft, bis es keine nächste mehr gibt
    do {
      const articles = await page.$$('article', { isolate: false });
      console.log('Seite erfolgreich geladen. Starte Datenerfassung...');

      if (articles.length === 0) {
        await saveCookies(page, CONFIG.cookieFile);
        await browser.close();
      }

      console.log(`Scrape Seite ${pageCount}...`);
      console.log(`Gefundene Episoden auf Seite ${pageCount}: ${articles.length}`);
      for (const article of articles) {
        const detailLinks = await article.$$eval('h3 a',
            links => links.map(link => link.href)) || [];
        if (detailLinks.length) {
          results.push(... detailLinks);
        }

      }

      await saveCookies(page, CONFIG.cookieFile);
      // Versuche, zur nächsten Seite zu navigieren
      hasNextPage = await goToNextPage(page);

      // wir haben alle check jetzt nur noch die ersten 5 Seiten
      if (pageCount > 4) {
        hasNextPage = false;
      }

      if (hasNextPage) {
        pageCount++;
      } else {
        pageCount = 1
      }
      const uniqueResults = [...new Set(results)];
      console.log(`Duplikate entfernt. Gesamtzahl einzigartiger Ergebnisse: ${uniqueResults.length}`);
      fs.writeFileSync(resultFilePath, JSON.stringify({
        pageCount: pageCount,
        results: uniqueResults
      }, null ,2), {encoding: "utf-8"})
    } while (hasNextPage);


  } catch (error) {
    console.error('Ein Fehler ist aufgetreten:', error);
  } finally {
    await saveCookies(page, CONFIG.cookieFile);
    // Schließt den Browser immer, unabhängig vom Ergebnis
    await browser.close();
    console.log('Browser geschlossen. Scraping-Prozess beendet.');
  }
}

(async () => {
  if (!fs.existsSync(CONFIG.outputDir)) {
    fs.mkdirSync(CONFIG.outputDir, { recursive: true });
  }
  await scrapeKlubradio();
})()
