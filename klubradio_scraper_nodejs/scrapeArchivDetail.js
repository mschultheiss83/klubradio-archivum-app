const puppeteer = require('puppeteer');
const fs = require('fs/promises');
const path = require('path');
const os = require('os');
require('dotenv').config();

// --- Config (env-tunable) ---
const CONFIG = {
  resultsFile: './downloads/result.json',
  resultsDetailsFile: (id) => `./downloads/resultDetails-${id}.json`,
  headless: process.env.HEADLESS !== 'false',
  cookieFile: 'cookies.json',
  userAgent: null,
  filterKeywords: ['Spotify', 'Apple podcast'],
  downloadsPath: path.join(__dirname, 'downloads'),

  // Performance knobs:
  workers: Number(process.env.WORKERS || os.cpus().length),
  waitUntil: process.env.WAIT_UNTIL || 'domcontentloaded', // 'domcontentloaded' is faster than 'networkidle2'
  navTimeoutMs: Number(process.env.NAV_TIMEOUT_MS || 15000),
  retryNavTimeoutMs: Number(process.env.RETRY_NAV_TIMEOUT_MS || 30000),
  cleanDownloadsFirst: String(process.env.CLEAN_DOWNLOADS || '').toLowerCase() === 'true',
  preloadStatConcurrency: Number(process.env.PRELOAD_STAT_CONCURRENCY || 64),
};

// --- Simple progress bar ---
function makeProgress(total) {
  const width = Number(process.env.PG_WIDTH || 30);
  const start = Date.now();
  let last = 0;

  function render(done) {
    const now = Date.now();
    if (now - last < 100 && done < total) return; // throttle
    last = now;

    const pct = total ? done / total : 1;
    const filled = Math.round(pct * width);
    const bar = '█'.repeat(filled) + '░'.repeat(width - filled);
    const percent = Math.floor(pct * 100);
    const elapsed = (now - start) / 1000;
    const rate = done / Math.max(elapsed, 0.001);
    const remaining = Math.max(total - done, 0);
    const eta = rate > 0 ? Math.round(remaining / rate) : 0;
    const line = `\r[${bar}] ${percent}%  ${done}/${total}  ${rate.toFixed(1)}/s  ETA ${eta}s`;
    process.stdout.write(line);
  }

  return {
    update: (done) => render(done),
    done: () => { render(total); process.stdout.write('\n'); }
  };
}

function _getUserAgent() {
  try {
    const pkg = require(path.join(__dirname, 'package.json'));
    return `KlubradioScraper/${pkg.version} (+https://github.com/mschultheiss83/klubradio-archivum-app)`;
  } catch (error) {
    console.warn(`User-Agent fallback (package.json not readable): ${error.message}`);
    return 'KlubradioScraper/0.0.0 (+https://github.com/yourorg/klubradio-archivum-app)';
  }
}

async function saveCookiesFrom(page, filePath) {
  try {
    const cookies = await page.cookies();
    await fs.writeFile(filePath, JSON.stringify(cookies, null, 2), 'utf-8');
  } catch (e) {
    console.warn('Could not save cookies:', e.message);
  }
}

async function loadCookiesTo(page, filePath) {
  try {
    const cookiesString = await fs.readFile(filePath, 'utf-8');
    const cookies = JSON.parse(cookiesString);
    if (Array.isArray(cookies) && cookies.length) {
      await page.setCookie(...cookies);
    }
  } catch (error) {
    if (error && error.code === 'ENOENT') {
      console.log('ℹ️ Cookie-Datei nicht gefunden, starte frisch.');
    } else {
      console.warn('Warnung beim Laden der Cookies:', error.message);
    }
  }
}

async function preloadExistingIds(dir, concurrency) {
  const collator = new Intl.Collator(undefined, { numeric: true, sensitivity: 'base' });
  const files = (await fs.readdir(dir))
    .filter(f => f.startsWith('resultDetails-') && f.endsWith('.json'))
    .sort((a, b) => collator.compare(a, b));

  const idFromName = (name) => {
    const m = name.match(/resultDetails-(.+)\.json$/);
    return m ? m[1] : null;
  };

  const queue = [...files];
  const good = new Set();

  const workers = Array.from({ length: Math.max(1, concurrency) }, async () => {
    for (;;) {
      const f = queue.pop();
      if (!f) break;
      const id = idFromName(f);
      if (!id) continue;
      try {
        const st = await fs.stat(path.join(dir, f));
        if (st.size > 20) good.add(id);
      } catch {}
    }
  });

  await Promise.all(workers);
  return good;
}

async function extractDetailsFromPage(page) {
  let duration = -1;
  try {
    duration = await page.$eval('.adas-holder .duration', el => el.innerText.trim());
  } catch {}

  let title = null;
  let date = '';
  try {
    const el = await page.$('.article-wrapper h3');
    if (el) title = await page.evaluate(e => e.innerText.trim(), el);
    if (title) {
      date = '(' + title.split(' (').pop().trim();
      title = title.split(' (').shift().trim();
    }
  } catch {}

  let hostsTexts = [];
  try {
    hostsTexts = await page.$$eval('.article-wrapper h5', hosts =>
      hosts
        .map(el => el.innerText.trim())
        .filter(text => text !== 'Tovább a műsor adásaihoz')
    );
  } catch {}

  let description = [];
  try {
    description = (await page.evaluate(() => {
      return [...document.querySelectorAll('.musor-description p')]
        .map(e => e.innerText.trim());
    })).filter(text => !!text);
  } catch {}

  if (description.length) {
    description = description.filter(text => !CONFIG.filterKeywords.some(k => text.includes(k)));
  }

  let rss = null;
  try {
    const a = await page.$('.musor-description a');
    if (a) rss = await page.evaluate(el => el.href, a);
  } catch {}

  let mp3Link = null;
  try {
    mp3Link = await page.$eval('.musoradatlap .adas-holder div.audio-player-middle source', el => el.src);
  } catch {}

  let programId = null;
  let programImg = null;
  try {
    const a = await page.$('article h5.duplo a');
    if (a) programId = ('' + await page.evaluate(el => el.href, a)).split('-').pop() || null;
  } catch {}
  try {
    const img = await page.$('article > a > img');
    if (img) programImg = '' + await page.evaluate(el => el.src, img);
  } catch {}

  return { duration, title, date, hostsTexts, description, rss, mp3Link, programId, programImg };
}

function makeRequestBlocker() {
  const blockedTypes = new Set(['image', 'stylesheet', 'font', 'media']);
  const blockedPrefixes = ['https://pagead2.googlesyndication.com/pagead/ads'];
  return (request) => {
    const url = request.url();
    const type = request.resourceType();
    if (blockedTypes.has(type) || blockedPrefixes.some(p => url.startsWith(p))) {
      request.abort();
    } else {
      request.continue();
    }
  };
}

async function processUrlOnPage(page, url) {
  if (!url) return;

  const id = url.split('-').pop();
  const filePath = CONFIG.resultsDetailsFile(id);

  try {
    await page.goto(url, { waitUntil: CONFIG.waitUntil, timeout: CONFIG.navTimeoutMs });
  } catch {
    await page.goto(url, { waitUntil: CONFIG.waitUntil, timeout: CONFIG.retryNavTimeoutMs });
  }

  const details = await extractDetailsFromPage(page);

  if (details.mp3Link && typeof details.mp3Link === 'string') {
    const resultDetails = {
      id,
      date: details.date,
      title: details.title,
      duration: details.duration,
      description: details.description,
      hostsTexts: details.hostsTexts,
      programId: details.programId,
      programImg: details.programImg,
      rss: details.rss,
      mp3Link: details.mp3Link,
    };
    await fs.writeFile(filePath, JSON.stringify(resultDetails, null, 2), 'utf-8');
  }
}

function makeIndexer(n) {
  let i = 0;
  return () => (i < n ? i++ : -1);
}

async function main() {
  console.log('🚀 Start parallel scraping…');

  let fileContent;
  try {
    fileContent = await fs.readFile(CONFIG.resultsFile, 'utf-8');
  } catch {
    console.error('❌ results.json not found. Abort.');
    return;
  }
  const { results: urls } = JSON.parse(fileContent);
  if (!urls || !urls.length) {
    console.log('Keine URLs zum Verarbeiten gefunden.');
    return;
  }

  if (CONFIG.cleanDownloadsFirst) {
    const names = await fs.readdir(CONFIG.downloadsPath);
    await Promise.all(
      names
        .filter(f => f.startsWith('resultDetails-') && f.endsWith('.json'))
        .map(f => fs.rm(path.join(CONFIG.downloadsPath, f), { force: true }))
    );
  }

  const existing = await preloadExistingIds(CONFIG.downloadsPath, CONFIG.preloadStatConcurrency);

  const args = [
    '--no-sandbox',
    '--disable-setuid-sandbox',
    '--disable-dev-shm-usage',
    '--disable-gpu',
    '--blink-settings=imagesEnabled=false',
  ];

  const browser = await puppeteer.launch({
    headless: CONFIG.headless,
    args,
    defaultViewport: { width: 1200, height: 800, deviceScaleFactor: 1 },
  });

  try {
    const bootstrap = await browser.newPage();
    await bootstrap.setCacheEnabled(true);
    await bootstrap.setUserAgent({userAgent: _getUserAgent()});
    await loadCookiesTo(bootstrap, CONFIG.cookieFile);
    await bootstrap.close();

    const todo = urls.filter(u => {
      const id = u?.split('-').pop();
      return id && !existing.has(id);
    });

    console.log(`🧮 URLs total: ${urls.length}, skipping existing: ${urls.length - todo.length}, scraping: ${todo.length}`);
    if (!todo.length) return;

    const nextIndex = makeIndexer(todo.length);
    const requestBlocker = makeRequestBlocker();
    const workers = Math.max(1, CONFIG.workers);

    // progress
    const progress = makeProgress(todo.length);
    progress.update(0);
    let completed = 0;

    async function worker(workerId) {
      const page = await browser.newPage();
      await page.setCacheEnabled(true);
      await page.setUserAgent({userAgent: _getUserAgent()});
      await page.setRequestInterception(true);
      page.on('request', requestBlocker);

      for (;;) {
        const i = nextIndex();
        if (i === -1) break;
        const url = todo[i];
        try {
          await processUrlOnPage(page, url);
        } catch (e) {
          console.warn(`[w${workerId}] Error on ${url}: ${e?.message || e}`);
        } finally {
          completed += 1;
          progress.update(completed);
        }
      }

      await page.close();
    }

    console.log(`⚙️  Spawning ${workers} workers (headless=${CONFIG.headless})…`);
    const t0 = Date.now();
    await Promise.all(Array.from({ length: workers }, (_, k) => worker(k + 1)));
    const secs = Math.round((Date.now() - t0) / 1000);
    progress.done();
    console.log(`✅ Done in ${secs}s`);
  } finally {
    const pages = await browser.pages();
    const last = pages[pages.length - 1];
    if (last) await saveCookiesFrom(last, CONFIG.cookieFile);
    await browser.close();
  }
}

(async () => {
  const start = new Date();
  console.log(start.toISOString());
  await main();
  const end = new Date();
  console.log(end.toISOString(), Math.round((end - start) / 1000));
})();
