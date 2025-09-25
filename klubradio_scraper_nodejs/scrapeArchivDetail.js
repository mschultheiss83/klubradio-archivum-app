const puppeteer = require('puppeteer');
const fs = require('fs');
const path = require('path');
const os = require('os'); // Importiert das OS-Modul für die CPU-Anzahl

// --- Konfiguration ---
const CONFIG = {
  resultsFile: './downloads/result.json', // Pfad zur Datei mit den URLs
  resultsDetailsFile: (id) => `./downloads/resultDetails-${id}.json`, // Pfad zur Datei mit den URLs
  headless: process.env.HEADLESS !== 'false',
  cookieFile: 'cookies.json', // Dateipfad für Cookies
  userAgent: 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
  // Die Anzahl der parallelen Prozesse wird von der CPU-Anzahl bestimmt
  filterKeywords: ["Spotify", "Apple podcast"],
  maxConcurrent: os.cpus().length,
  delay: 1000 // Kurze Pause zwischen den Anfragen
};

// --- Hilfsfunktionen ---
function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}

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

/**
 * Speichert Cookies von der Seite in eine Datei.
 * @param {object} page Die Puppeteer-Page-Instanz.
 * @param {string} filePath Der Pfad, unter dem die Cookies gespeichert werden sollen.
 */
async function saveCookies(page, filePath) {
  const cookies = await page.cookies();
  fs.writeFileSync(filePath, JSON.stringify(cookies, null, 2));
  // console.log(`🍪 Cookies erfolgreich in ${filePath} gespeichert.`);
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
      // console.log(`🍪 Cookies erfolgreich aus ${filePath} geladen.`);
    } catch (error) {
      console.error('❌ Fehler beim Laden der Cookies:', error.message);
    }
  } else {
    console.log(`ℹ️ Cookie-Datei nicht gefunden, beginne mit einer neuen Sitzung.`);
  }
}

/**
 * Verarbeitet eine einzelne URL. Hier kommt Ihre Logik zum Parsen der Detailseite rein.
 * @param {object} browser Die übergeordnete Puppeteer Browser-Instanz.
 * @param {string} url Die URL der Detailseite, die gescraped werden soll.
 */
async function processUrl(browser, url) {
  if (!url) {
    return
  }

  const id = url.split('-').pop();
  const filePath = CONFIG.resultsDetailsFile(id);

  // --- 1. Prüfen, ob die Datei existiert und nicht leer ist ---
  try {
    if (fs.existsSync(filePath) && fs.statSync(filePath).size > 20) {
      // console.log(`✅ Datei für ID ${id} existiert und ist nicht leer. Überspringe.`);
      return
    }
  } catch (error) {
    console.error(`❌ Fehler beim Prüfen der Datei für ID ${id}:`, error.message);
  }

  let page;
  try {
    // console.log(`Starte Verarbeitung für: ${url}`);
    page = await browser.newPage();
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

    await page.goto(url, { waitUntil: 'networkidle2', timeout: 5000 })
      .catch(async ()=> {
        await page.goto(url, { waitUntil: 'networkidle2', timeout: 15000 })
      });

    // --- Extrahieren der Daten ---
    const duration = await page.$eval('.adas-holder .duration', el => el.innerText.trim()) || -1;
    const titleElement = await page.$('.article-wrapper h3');
    let title = titleElement
      ? await page.evaluate(el => el.innerText.trim(), titleElement)
      : null;
    let date = ''
    if (title) {
      date = '(' + title.split(' (').pop().trim()
      title = title.split(' (').shift().trim()
    }

    const hostsTexts = (await page.$$eval('.article-wrapper h5', hosts =>
      hosts
        .map(el => el.innerText.trim())
        .filter(text => text !== 'Tovább a műsor adásaihoz')
    ));

    const description = (await page.evaluate(() => {
      return [...document.querySelectorAll('.musor-description p')]
        .map(e => e.innerText.trim());
    })).filter(text => {
      const isKeyword = CONFIG.filterKeywords.some(keyword => text.includes(keyword));
      const isNotEmpty = !!text;
      return isNotEmpty && !isKeyword;
    });
    const rssElement = await page.$('.musor-description a');
    const rss = rssElement
      ? await page.evaluate(el => el.href, rssElement)
      : null;
    const mp3Link = await page.$eval('.musoradatlap .adas-holder div.audio-player-middle source', element => element.src);

    // --- Speichern der Daten ---
    const resultDetails = {
      id,
      date,
      title,
      duration,
      description,
      hostsTexts,
      rss,
      mp3Link
    };

    // --- 2. Speichern nur, wenn der mp3Link verfügbar ist ---
    if (mp3Link && typeof mp3Link === 'string') {
      fs.writeFileSync(filePath, JSON.stringify(resultDetails, null, 2), { encoding: 'utf-8' });
      console.log(`✅ Daten für ID ${id} erfolgreich extrahiert und gespeichert.`);
    } else {
      console.warn(`⚠️ Kein MP3-Link für ID ${id} gefunden. Datei wird nicht gespeichert.`);
    }
  } catch (error) {
    console.error(`❌ Fehler beim Verarbeiten von ${url}:`, error.message);
  } finally {
    if (page) {
      await saveCookies(page, CONFIG.cookieFile);
      await page.close(); // Seite nach der Verarbeitung immer schließen
    }
  }
}

function shuffle(array) {
  let currentIndex = array.length;

  // While there remain elements to shuffle...
  while (currentIndex !== 0) {

    // Pick a remaining element...
    let randomIndex = Math.floor(Math.random() * currentIndex);
    currentIndex--;

    // And swap it with the current element.
    [array[currentIndex], array[randomIndex]] = [
      array[randomIndex], array[currentIndex]];
  }
}

const detailPageFound = (url) => {
  const id = url.split('-').pop();
  const filePath = CONFIG.resultsDetailsFile(id);

  // --- 1. Prüfen, ob die Datei existiert und nicht leer ist ---
  try {
    if (fs.existsSync(filePath) && fs.statSync(filePath).size > 20) {
      // console.log(`✅ Datei für ID ${id} existiert und ist nicht leer. Überspringe.`);
      return true;
    }
  } catch (error) {
    console.error(`❌ Fehler beim Prüfen der Datei für ID ${id}:`, error.message);
  }
  return false;
}

// --- Hauptfunktion zum Starten des parallelen Scrapings ---
async function main() {
  console.log('Starte kontinuierliches paralleles Scraping...');

  if (!fs.existsSync(CONFIG.resultsFile)) {
    console.error('❌ Fehler: Die Datei "result.json" wurde nicht gefunden.');
    return;
  }

  const fileContent = fs.readFileSync(CONFIG.resultsFile, 'utf-8');
  const { results: urls } = JSON.parse(fileContent);

  if (urls.length === 0) {
    console.log('Keine URLs zum Verarbeiten gefunden. Beende das Skript.');
    return;
  }
  shuffle(urls)
  console.log(`Gefundene URLs: ${urls.length}. ${CONFIG.maxConcurrent} Prozesse werden gleichzeitig laufen.`);

  const browser = await puppeteer.launch({
    headless: CONFIG.headless,
    args: ['--no-sandbox', '--disable-setuid-sandbox'],
    // slowMo: 200,
    defaultViewport: null,
  });

  const activePromises = new Set();
  let urlIndex = 0;

  try {
    console.log(`maxConcurrent: ${CONFIG.maxConcurrent}`)

    // Fülle den Pool mit den ersten maxConcurrent URLs
    for (let i = 0; i < CONFIG.maxConcurrent && urlIndex < urls.length; i++) {
      const url = urls[urlIndex++];
      if (url && !detailPageFound(url)) {
        // console.log(`try open url ${url}`)
        const promise = processUrl(browser, url).finally(() => activePromises.delete(promise));
        activePromises.add(promise);
      }
    }

    // Kontinuierliche Verarbeitung: Starte eine neue Aufgabe, sobald eine alte fertig ist
    while (urlIndex < urls.length || activePromises.size > 0) {
      // Warte auf die erste Aufgabe, die im Pool fertig wird
      if (activePromises.size + 1 > CONFIG.maxConcurrent) {
        await Promise.race(activePromises);
      }

      // Wenn noch URLs übrig sind, füge eine neue Aufgabe zum Pool hinzu
      if (urlIndex < urls.length) {
        const url = urls[urlIndex++];
        if (url && !detailPageFound(url)) {
          const promise = processUrl(browser, url).finally(() => activePromises.delete(promise));
          activePromises.add(promise);
        }
      }
      if (activePromises.size > 0) {
        await Promise.race(activePromises);
      }
    }
  } catch (error) {
    console.error('Ein schwerwiegender Fehler ist aufgetreten:', error);
  } finally {
    const page = (await browser.pages()).pop()
    await saveCookies(page, CONFIG.cookieFile);
    await browser.close();
    console.log('Alle URLs verarbeitet. Browser geschlossen.');
  }
}

(async () => {
  const start = new Date()
  console.log(start.toISOString())
  await main();
  const end = new Date()
  console.log(end.toISOString(), Math.round((end - start)/1000))
})()
