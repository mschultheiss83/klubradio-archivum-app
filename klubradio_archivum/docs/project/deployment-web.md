# Web Deployment Guide

## Overview

This guide covers deploying a web version of the Klubrádió Archive Flutter app. The web version will be a **streaming-only** version without downloads and subscriptions, as these features rely on native file system access not available in web browsers.

**Web Version Features**:
- ✓ Browse podcasts and episodes
- ✓ Stream episodes directly (no download required)
- ✓ Search and discover content
- ✓ Playback controls (play, pause, seek, speed control)
- ✓ Responsive design (mobile and desktop)
- ✗ Downloads (not supported in browsers)
- ✗ Subscriptions (requires persistent local storage)
- ✗ Offline playback (web apps require internet)

## Prerequisites

- **Flutter Web Support**: Enabled by default in Flutter 3.x
- **Hosting Service**: Various options (Firebase, GitHub Pages, Netlify, Vercel, own server)
- **Domain** (optional): Custom domain for professional appearance
- **SSL Certificate**: HTTPS required for audio playback (provided by most hosts)

## Timeline

- **Development**: 2-5 days (adapt app for web, disable unsupported features)
- **Build**: 5-10 minutes
- **Deployment**: 10-30 minutes (depends on hosting service)
- **Total**: Can be done in 1 week

---

## Phase 1: Prepare Flutter Web Build

### 1.1 Check Web Support

Verify Flutter web is enabled:

```bash
flutter doctor -v

# Should show:
# [✓] Chrome - develop for the web
```

If not enabled:
```bash
flutter config --enable-web
```

### 1.2 Test Web Build Locally

```bash
cd klubradio_archivum

# Run in web browser
flutter run -d chrome

# Or specific browser:
flutter run -d edge
flutter run -d firefox
```

**Expected issues** (to be fixed):
- Download features won't work (need to disable)
- File system access won't work (use IndexedDB or remove)
- Some native plugins may not be web-compatible

---

## Phase 2: Adapt App for Web

### 2.1 Identify Incompatible Features

**Features to disable/modify for web**:

1. **Downloads**: Not supported (no file system access)
   - Remove download buttons
   - Hide download manager screen
   - Disable auto-download settings

2. **Subscriptions**: Limited support
   - Option 1: Remove completely (simpler)
   - Option 2: Use web storage (localStorage/IndexedDB) for basic favorites
     - Won't sync across devices
     - Cleared if user clears browser data

3. **Offline playback**: Not possible
   - Remove offline indicators
   - Always stream from URL

4. **Background playback**: Limited
   - Works only while browser tab active
   - Can't continue with phone locked (mobile web)

### 2.2 Platform Detection

Add platform checks throughout your code:

**lib/utils/platform_utils.dart**:
```dart
import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformUtils {
  static bool get isWeb => kIsWeb;

  static bool get supportsDownloads => !kIsWeb;

  static bool get supportsSubscriptions => !kIsWeb;

  static bool get supportsOfflinePlayback => !kIsWeb;

  static bool get supportsBackgroundAudio => !kIsWeb;
}
```

### 2.3 Conditional UI Rendering

**Example: Hide download button on web**:

```dart
// In episode tile or episode detail screen
if (PlatformUtils.supportsDownloads) {
  IconButton(
    icon: Icon(Icons.download),
    onPressed: () => _downloadEpisode(),
  ),
}

// Or show play-only button on web
if (PlatformUtils.isWeb) {
  IconButton(
    icon: Icon(Icons.play_arrow),
    onPressed: () => _streamEpisode(),
    tooltip: AppLocalizations.of(context)!.streamEpisode,
  ),
}
```

**Example: Hide download manager screen**:

```dart
// In AppShell bottom navigation
bottomNavigationBar: BottomNavigationBar(
  items: [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: AppLocalizations.of(context)!.home,
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.explore),
      label: AppLocalizations.of(context)!.discover,
    ),
    // Only show downloads tab on non-web platforms
    if (PlatformUtils.supportsDownloads)
      BottomNavigationBarItem(
        icon: Icon(Icons.download),
        label: AppLocalizations.of(context)!.downloads,
      ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: AppLocalizations.of(context)!.settings,
    ),
  ],
  // ...
),
```

### 2.4 Check Plugin Compatibility

Verify all packages support web:

**Check pubspec.yaml dependencies**:
```bash
# Check each package's pub.dev page for web support
# Key packages to check:

# Audio playback
just_audio: ^0.9.x  # ✓ Supports web

# Database (SQLite)
drift: ^2.x  # ✗ SQLite not supported on web (use drift with web storage backend)
sqlite3_flutter_libs: ^0.5.x  # ✗ Native only

# Downloads
background_downloader: ^8.x  # ✗ Native only (expected)

# Shared preferences
shared_preferences: ^2.x  # ✓ Supports web (uses localStorage)

# Provider
provider: ^6.x  # ✓ Supports web
```

**Replace drift with web-compatible storage**:

Option 1: **Remove database completely** (simplest for web version)
- Don't persist downloads/subscriptions
- Use in-memory state management only

Option 2: **Use drift with web backend**:
```yaml
dependencies:
  drift: ^2.14.0
  # For web, use:
  # drift/web.dart uses IndexedDB
```

### 2.5 Update Web-Specific Configuration

**web/index.html** - Update metadata:

```html
<!DOCTYPE html>
<html>
<head>
  <base href="$FLUTTER_BASE_HREF">

  <meta charset="UTF-8">
  <meta content="IE=Edge" http-equiv="X-UA-Compatible">

  <!-- Primary Meta Tags -->
  <meta name="description" content="Hallgasd a Klubrádió archívumát online! 100+ műsor, podcast stílusban, böngészőből.">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">

  <!-- Open Graph / Facebook -->
  <meta property="og:type" content="website">
  <meta property="og:url" content="https://your-domain.com/">
  <meta property="og:title" content="Klubrádió Archívum - Podcast Online">
  <meta property="og:description" content="Hallgasd a Klubrádió archívumát online! 100+ műsor elérhető.">
  <meta property="og:image" content="https://your-domain.com/icons/Icon-512.png">

  <!-- Twitter -->
  <meta property="twitter:card" content="summary_large_image">
  <meta property="twitter:url" content="https://your-domain.com/">
  <meta property="twitter:title" content="Klubrádió Archívum">
  <meta property="twitter:description" content="Hallgasd a Klubrádió archívumát online!">
  <meta property="twitter:image" content="https://your-domain.com/icons/Icon-512.png">

  <!-- SEO -->
  <meta name="keywords" content="klubrádió, podcast, magyar, rádió, archívum, streaming, online">
  <meta name="author" content="Klubrádió Archívum">

  <!-- Theme Color -->
  <meta name="theme-color" content="#1976D2">

  <title>Klubrádió Archívum - Podcast Online</title>
  <link rel="manifest" href="manifest.json">

  <!-- Favicon -->
  <link rel="icon" type="image/png" href="favicon.png"/>
  <link rel="apple-touch-icon" href="icons/Icon-192.png">

  <!-- Splash screen styles -->
  <style>
    body {
      margin: 0;
      padding: 0;
      background: #1976D2;
      display: flex;
      align-items: center;
      justify-content: center;
      height: 100vh;
    }

    .loading {
      display: flex;
      flex-direction: column;
      align-items: center;
      color: white;
    }

    .spinner {
      border: 4px solid rgba(255,255,255,0.3);
      border-radius: 50%;
      border-top: 4px solid white;
      width: 40px;
      height: 40px;
      animation: spin 1s linear infinite;
    }

    @keyframes spin {
      0% { transform: rotate(0deg); }
      100% { transform: rotate(360deg); }
    }

    .loading-text {
      margin-top: 20px;
      font-family: sans-serif;
      font-size: 16px;
    }
  </style>
</head>
<body>
  <!-- Loading indicator -->
  <div class="loading">
    <div class="spinner"></div>
    <div class="loading-text">Betöltés...</div>
  </div>

  <script>
    // Service worker registration
    var serviceWorkerVersion = null;
    var scriptLoaded = false;

    function loadMainDartJs() {
      if (scriptLoaded) {
        return;
      }
      scriptLoaded = true;
      var scriptTag = document.createElement('script');
      scriptTag.src = 'main.dart.js';
      scriptTag.type = 'application/javascript';
      document.body.append(scriptTag);
    }

    if ('serviceWorker' in navigator) {
      // Service Workers are supported. Register one.
      window.addEventListener('load', function () {
        var serviceWorkerUrl = 'flutter_service_worker.js?v=' + serviceWorkerVersion;
        navigator.serviceWorker.register(serviceWorkerUrl)
          .then((reg) => {
            function waitForActivation(serviceWorker) {
              serviceWorker.addEventListener('statechange', () => {
                if (serviceWorker.state == 'activated') {
                  console.log('Service worker activated.');
                  loadMainDartJs();
                }
              });
            }
            if (!reg.active && (reg.installing || reg.waiting)) {
              waitForActivation(reg.installing || reg.waiting);
            } else if (!reg.active.scriptURL.endsWith(serviceWorkerVersion)) {
              reg.update();
            } else {
              loadMainDartJs();
            }
          });

        // If service worker doesn't activate in 4 seconds, load app anyway
        setTimeout(() => {
          if (!scriptLoaded) {
            console.warn('Service worker not ready, loading app anyway.');
            loadMainDartJs();
          }
        }, 4000);
      });
    } else {
      // Service workers not supported. Load immediately.
      loadMainDartJs();
    }
  </script>
</body>
</html>
```

**web/manifest.json** - PWA configuration:

```json
{
  "name": "Klubrádió Archívum",
  "short_name": "Klubrádió",
  "description": "Hallgasd a Klubrádió archívumát online",
  "start_url": ".",
  "display": "standalone",
  "background_color": "#FFFFFF",
  "theme_color": "#1976D2",
  "orientation": "portrait-primary",
  "categories": ["news", "music", "entertainment"],
  "icons": [
    {
      "src": "icons/Icon-192.png",
      "sizes": "192x192",
      "type": "image/png",
      "purpose": "maskable any"
    },
    {
      "src": "icons/Icon-512.png",
      "sizes": "512x512",
      "type": "image/png",
      "purpose": "maskable any"
    }
  ]
}
```

---

## Phase 3: Build for Production

### 3.1 Build Web Release

```bash
cd klubradio_archivum

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build for web (release mode)
flutter build web --release

# Or with custom base href (for subdirectories):
flutter build web --release --base-href /archivum/

# Output: build/web/
```

**Build output**:
- `build/web/index.html` - Main HTML file
- `build/web/main.dart.js` - Compiled Dart code (minified)
- `build/web/assets/` - Images, fonts, JSON files
- `build/web/icons/` - App icons
- `build/web/flutter_service_worker.js` - Service worker for PWA
- `build/web/manifest.json` - PWA manifest

**Typical size**: 2-5 MB (compressed)

### 3.2 Test Build Locally

```bash
# Install a simple HTTP server (if not already installed)
# Option 1: Python 3
cd build/web
python -m http.server 8000

# Option 2: Node.js http-server
npx http-server build/web -p 8000

# Option 3: Flutter's built-in server
flutter run -d web-server --web-port 8000
```

Open browser: http://localhost:8000

**Test checklist**:
- [ ] App loads without errors
- [ ] Podcast list appears
- [ ] Can play episodes (streaming)
- [ ] Search works
- [ ] Playback controls work (play, pause, seek, speed)
- [ ] Download/subscription features hidden
- [ ] Responsive on mobile and desktop
- [ ] No console errors

---

## Phase 4: Hosting Options

### Option 1: Firebase Hosting (Recommended)

**Pros**:
- Free tier (10 GB storage, 360 MB/day bandwidth)
- Automatic HTTPS
- Global CDN
- Custom domain support
- Easy rollback
- CI/CD friendly

**Cons**:
- Requires Google account
- Bandwidth limits (paid plans for high traffic)

**Setup**:

1. **Install Firebase CLI**:
```bash
npm install -g firebase-tools
```

2. **Login to Firebase**:
```bash
firebase login
```

3. **Initialize Firebase in your project**:
```bash
cd klubradio_archivum
firebase init hosting

# Select options:
# ? What do you want to use as your public directory? build/web
# ? Configure as a single-page app? Yes
# ? Set up automatic builds and deploys with GitHub? No (or Yes if using GitHub Actions)
# ? File build/web/index.html already exists. Overwrite? No
```

4. **Configure firebase.json**:
```json
{
  "hosting": {
    "public": "build/web",
    "ignore": [
      "firebase.json",
      "**/.*",
      "**/node_modules/**"
    ],
    "rewrites": [
      {
        "source": "**",
        "destination": "/index.html"
      }
    ],
    "headers": [
      {
        "source": "**/*.@(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)",
        "headers": [
          {
            "key": "Cache-Control",
            "value": "max-age=31536000"
          }
        ]
      },
      {
        "source": "**",
        "headers": [
          {
            "key": "Cross-Origin-Embedder-Policy",
            "value": "require-corp"
          },
          {
            "key": "Cross-Origin-Opener-Policy",
            "value": "same-origin"
          }
        ]
      }
    ]
  }
}
```

5. **Deploy**:
```bash
# Build first
flutter build web --release

# Deploy to Firebase
firebase deploy --only hosting

# Output:
# ✓ Deploy complete!
# Hosting URL: https://your-project.web.app
```

6. **Custom domain** (optional):
   - Go to Firebase Console > Hosting
   - Click "Add custom domain"
   - Follow instructions (add DNS records)
   - Example: `archivum.klubradio.hu`

**Cost**: Free for most use cases
- Free tier: 10 GB storage, 360 MB/day bandwidth
- If exceeded: ~$0.026/GB for bandwidth

---

### Option 2: GitHub Pages (Free)

**Pros**:
- Completely free
- No bandwidth limits
- Custom domain support
- Automatic HTTPS
- Easy CI/CD with GitHub Actions

**Cons**:
- Public repositories only (or paid GitHub account)
- Max 1 GB recommended size
- Not ideal for high-traffic production apps

**Setup**:

1. **Create GitHub repository** (if not exists):
```bash
cd klubradio_archivum
git init
git remote add origin https://github.com/YOUR_USERNAME/klubradio-archivum-web.git
```

2. **Build and deploy**:

**Option A: Manual deployment**:
```bash
# Build web
flutter build web --release --base-href /klubradio-archivum-web/

# Install gh-pages (Node.js package)
npm install -g gh-pages

# Deploy to gh-pages branch
gh-pages -d build/web

# Or manually:
git checkout -b gh-pages
cp -r build/web/* .
git add .
git commit -m "Deploy web app"
git push origin gh-pages
```

**Option B: GitHub Actions (automated)**:

Create `.github/workflows/deploy-web.yml`:

```yaml
name: Deploy Web to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: '3.24.0'
          channel: 'stable'

      - name: Install dependencies
        run: flutter pub get
        working-directory: ./klubradio_archivum

      - name: Build web
        run: flutter build web --release --base-href /klubradio-archivum-web/
        working-directory: ./klubradio_archivum

      - name: Deploy to GitHub Pages
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./klubradio_archivum/build/web
          cname: archivum.klubradio.hu  # Optional: custom domain
```

3. **Enable GitHub Pages**:
   - Go to repository Settings > Pages
   - Source: Deploy from branch "gh-pages"
   - Save

4. **Access your app**:
   - URL: `https://YOUR_USERNAME.github.io/klubradio-archivum-web/`

5. **Custom domain** (optional):
   - Settings > Pages > Custom domain
   - Enter: `archivum.klubradio.hu`
   - Add CNAME record in your DNS:
     ```
     archivum.klubradio.hu -> YOUR_USERNAME.github.io
     ```

**Cost**: Free

---

### Option 3: Netlify (Free/Paid)

**Pros**:
- Generous free tier (100 GB bandwidth/month)
- Automatic HTTPS
- Custom domain support
- Instant rollback
- Edge functions
- Form handling

**Cons**:
- Paid plans for more bandwidth

**Setup**:

1. **Sign up**: https://www.netlify.com/

2. **Deploy via drag-and-drop**:
   - Build locally: `flutter build web --release`
   - Go to Netlify dashboard
   - Drag `build/web` folder to deployment zone
   - Done!

3. **Or connect Git repository** (automated):
   - Click "New site from Git"
   - Connect GitHub/GitLab
   - Build settings:
     - Base directory: `klubradio_archivum`
     - Build command: `flutter build web --release`
     - Publish directory: `klubradio_archivum/build/web`
   - Deploy

4. **Custom domain**:
   - Site settings > Domain management > Add custom domain
   - Add DNS records

**Cost**:
- Free tier: 100 GB bandwidth/month
- Pro: $19/month for 1 TB bandwidth

---

### Option 4: Vercel (Free/Paid)

**Pros**:
- Free tier (100 GB bandwidth)
- Excellent performance
- Automatic HTTPS
- Edge functions
- CI/CD with Git

**Cons**:
- Commercial usage requires paid plan

**Setup**:

1. **Sign up**: https://vercel.com/

2. **Install Vercel CLI**:
```bash
npm install -g vercel
```

3. **Deploy**:
```bash
cd klubradio_archivum
flutter build web --release
cd build/web
vercel --prod
```

4. **Or connect Git repository**:
   - Import GitHub repository
   - Framework preset: "Other"
   - Build command: `cd klubradio_archivum && flutter build web --release`
   - Output directory: `klubradio_archivum/build/web`

**Cost**:
- Free (Hobby): 100 GB bandwidth
- Pro: $20/month for 1 TB bandwidth

---

### Option 5: Own Server (Apache/Nginx)

**Pros**:
- Full control
- No bandwidth limits (depends on hosting)
- Custom configuration

**Cons**:
- Requires server management
- Manual SSL setup (use Let's Encrypt)
- No automatic scaling

**Setup with Apache**:

1. **Build app**:
```bash
flutter build web --release
```

2. **Upload to server**:
```bash
scp -r build/web/* user@your-server.com:/var/www/html/archivum/
```

3. **Configure Apache** (`/etc/apache2/sites-available/archivum.conf`):
```apache
<VirtualHost *:80>
    ServerName archivum.klubradio.hu
    DocumentRoot /var/www/html/archivum

    <Directory /var/www/html/archivum>
        Options -Indexes +FollowSymLinks
        AllowOverride All
        Require all granted

        # SPA routing
        RewriteEngine On
        RewriteBase /
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteCond %{REQUEST_FILENAME} !-d
        RewriteRule ^ index.html [L]
    </Directory>

    # Enable compression
    <IfModule mod_deflate.c>
        AddOutputFilterByType DEFLATE text/html text/css application/javascript
    </IfModule>

    # Cache static assets
    <IfModule mod_expires.c>
        ExpiresActive On
        ExpiresByType image/png "access plus 1 year"
        ExpiresByType application/javascript "access plus 1 year"
        ExpiresByType text/css "access plus 1 year"
    </IfModule>
</VirtualHost>
```

4. **Enable site and SSL**:
```bash
sudo a2ensite archivum
sudo a2enmod rewrite expires deflate

# Install Let's Encrypt SSL
sudo certbot --apache -d archivum.klubradio.hu

sudo systemctl reload apache2
```

**Setup with Nginx**:

Configure `/etc/nginx/sites-available/archivum`:
```nginx
server {
    listen 80;
    server_name archivum.klubradio.hu;

    root /var/www/html/archivum;
    index index.html;

    # SPA routing
    location / {
        try_files $uri $uri/ /index.html;
    }

    # Cache static assets
    location ~* \.(js|css|png|jpg|jpeg|gif|ico|svg|woff|woff2|ttf|eot)$ {
        expires 1y;
        add_header Cache-Control "public, immutable";
    }

    # Gzip compression
    gzip on;
    gzip_types text/css application/javascript image/svg+xml;
    gzip_min_length 1000;
}
```

Enable and reload:
```bash
sudo ln -s /etc/nginx/sites-available/archivum /etc/nginx/sites-enabled/
sudo certbot --nginx -d archivum.klubradio.hu
sudo systemctl reload nginx
```

**Cost**: Depends on hosting provider ($5-50/month)

---

## Phase 5: SEO and PWA Optimization

### 5.1 Search Engine Optimization

**web/index.html** - Add structured data:

```html
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@type": "WebApplication",
  "name": "Klubrádió Archívum",
  "description": "Hallgasd a Klubrádió archívumát online",
  "url": "https://archivum.klubradio.hu",
  "applicationCategory": "MultimediaApplication",
  "operatingSystem": "Any (Web Browser)",
  "offers": {
    "@type": "Offer",
    "price": "0",
    "priceCurrency": "HUF"
  },
  "aggregateRating": {
    "@type": "AggregateRating",
    "ratingValue": "4.5",
    "ratingCount": "100"
  }
}
</script>
```

**Create sitemap.xml** in `build/web/`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
  <url>
    <loc>https://archivum.klubradio.hu/</loc>
    <lastmod>2024-12-01</lastmod>
    <changefreq>daily</changefreq>
    <priority>1.0</priority>
  </url>
  <!-- Add more URLs if you have distinct pages -->
</urlset>
```

**Create robots.txt** in `build/web/`:
```
User-agent: *
Allow: /
Sitemap: https://archivum.klubradio.hu/sitemap.xml
```

### 5.2 PWA Features

Ensure your web app is installable as a Progressive Web App:

1. **Service Worker**: Already generated by Flutter
2. **Manifest**: Already configured in `manifest.json`
3. **HTTPS**: Required (provided by hosting services)
4. **Icons**: 192x192 and 512x512 PNG icons

**Test PWA**:
1. Open app in Chrome
2. F12 > Application tab > Manifest
3. Verify: "Add to Home Screen" available
4. Check Service Worker registered
5. Run Lighthouse audit (Performance, Accessibility, PWA)

### 5.3 Performance Optimization

**Enable code splitting** (Flutter does this by default):
```bash
# Already done with --release flag
flutter build web --release --split-debug-info=build/web/debug_info
```

**Web-specific optimizations**:

Add to `web/index.html`:
```html
<!-- Preload critical resources -->
<link rel="preload" href="main.dart.js" as="script">
<link rel="preload" href="assets/AssetManifest.json" as="fetch" crossorigin>

<!-- Resource hints -->
<link rel="dns-prefetch" href="https://YOUR_SUPABASE_URL.supabase.co">
<link rel="preconnect" href="https://YOUR_SUPABASE_URL.supabase.co">
```

**Compress assets**:
Most hosting services (Firebase, Netlify, Vercel) automatically compress files with gzip/brotli.

For own server, enable compression in Apache/Nginx (see Phase 4, Option 5).

---

## Phase 6: Analytics and Monitoring

### 6.1 Google Analytics (Optional)

Add Google Analytics to track usage:

**Install package**:
```yaml
# pubspec.yaml
dependencies:
  firebase_analytics: ^10.8.0  # If using Firebase
  # Or
  google_analytics: ^6.0.0  # Direct GA4 integration
```

**Configure in web/index.html**:
```html
<!-- Google tag (gtag.js) -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-XXXXXXXXXX"></script>
<script>
  window.dataLayer = window.dataLayer || [];
  function gtag(){dataLayer.push(arguments);}
  gtag('js', new Date());
  gtag('config', 'G-XXXXXXXXXX');
</script>
```

### 6.2 Error Tracking

**Sentry integration**:
```yaml
# pubspec.yaml
dependencies:
  sentry_flutter: ^7.14.0
```

**Initialize in main.dart**:
```dart
import 'package:sentry_flutter/sentry_flutter.dart';

Future<void> main() async {
  await SentryFlutter.init(
    (options) {
      options.dsn = 'YOUR_SENTRY_DSN';
      options.environment = kReleaseMode ? 'production' : 'development';
    },
    appRunner: () => runApp(MyApp()),
  );
}
```

---

## Phase 7: Maintenance and Updates

### 7.1 Update Process

For subsequent updates:

1. **Make changes** to code
2. **Test locally**: `flutter run -d chrome`
3. **Build**: `flutter build web --release`
4. **Deploy**:
   - Firebase: `firebase deploy`
   - GitHub Pages: Push to main branch (if using Actions)
   - Netlify/Vercel: Push to Git or drag-and-drop

### 7.2 Cache Busting

Flutter automatically generates unique file hashes for cache busting. Service worker handles updates.

**Force refresh**: Users see new version on next app load (or after closing tab).

**Notify users of updates**:
```dart
// Check for service worker updates
if (kIsWeb) {
  html.window.navigator.serviceWorker?.addEventListener('controllerchange', (event) {
    // Show snackbar: "New version available! Refresh to update."
  });
}
```

---

## Comparison: Native App vs Web

| Feature | Native Apps | Web App |
|---------|-------------|---------|
| Downloads | ✓ Full support | ✗ Not supported |
| Offline playback | ✓ Full support | ✗ Requires internet |
| Subscriptions | ✓ Persistent | △ Limited (localStorage) |
| Background audio | ✓ Full support | △ Tab must be active |
| Push notifications | ✓ Full support | △ Limited (requires service worker) |
| File size | 50-150 MB | 2-5 MB initial load |
| Installation | App Store | Instant (or PWA install) |
| Updates | App Store review | Instant |
| Reach | iOS/Android users | Anyone with browser |
| Cost | $118/year | Free - $20/month (hosting) |

**Recommendation**: Web app is best as a **companion** to native apps, not a replacement.

---

## Cost Summary

### Hosting Costs (Annual)

| Service | Free Tier | Paid Tier | Best For |
|---------|-----------|-----------|----------|
| Firebase Hosting | 10 GB + 360 MB/day | ~$25/month | Most use cases |
| GitHub Pages | Unlimited | Free | Low traffic, open source |
| Netlify | 100 GB/month | $19/month | Medium traffic |
| Vercel | 100 GB/month | $20/month | Medium traffic |
| Own Server (VPS) | - | $5-50/month | Full control |

**Recommendation**: Start with **Firebase Hosting** (free tier). Upgrade if you exceed bandwidth limits.

---

## Key Dates for December Release

| Task | Duration | Target Date |
|------|----------|-------------|
| Adapt app for web (disable downloads/subs) | 2-3 days | Dec 3-5 |
| Test web build locally | 1 day | Dec 6 |
| Choose hosting service | 1 day | Dec 7 |
| Build and deploy | 1 day | Dec 8 |
| Test deployed app | 1 day | Dec 9 |
| Configure custom domain (optional) | 1 day | Dec 10 |
| SEO/PWA optimization | 1 day | Dec 11 |
| **Go Live** | - | **Dec 12** |

**Note**: Web deployment is fastest (no app store review). Can go live in 1 week!

---

## Resources

- **Flutter Web Documentation**: https://docs.flutter.dev/platform-integration/web
- **Firebase Hosting**: https://firebase.google.com/docs/hosting
- **GitHub Pages**: https://pages.github.com/
- **Netlify Docs**: https://docs.netlify.com/
- **PWA Guidelines**: https://web.dev/progressive-web-apps/
- **Lighthouse**: https://developers.google.com/web/tools/lighthouse

---

## Quick Reference Commands

```bash
# Enable web support
flutter config --enable-web

# Run web app locally
flutter run -d chrome

# Build for production
flutter build web --release

# Build with custom base href (for subdirectories)
flutter build web --release --base-href /archivum/

# Test build locally
cd build/web && python -m http.server 8000

# Deploy to Firebase
firebase deploy --only hosting

# Check web compatibility
flutter doctor -v
```

---

## Next Steps

1. **Decide on web app scope**:
   - Option A: Streaming-only (no downloads/subscriptions) - Simpler
   - Option B: Limited subscriptions (localStorage) - More features but complex

2. **Adapt codebase**:
   - Add platform detection (`PlatformUtils.isWeb`)
   - Hide/disable download features on web
   - Test thoroughly in browser

3. **Choose hosting service**:
   - Recommendation: **Firebase Hosting** (free tier)
   - Alternative: **GitHub Pages** (if open source)

4. **Build and deploy**:
   ```bash
   flutter build web --release
   firebase deploy
   ```

5. **Test deployed app**:
   - Functional testing (browse, search, stream)
   - Performance testing (Lighthouse)
   - Mobile responsive testing

6. **Optional: Custom domain**:
   - Configure DNS: `archivum.klubradio.hu`
   - Update hosting service settings

7. **Promote web app**:
   - Add link to Klubrádió website
   - Social media announcement
   - "Try without installing" button in native app stores

**Advantage**: Web deployment is fastest and cheapest. No app store approval needed. Great for reaching users who don't want to install apps!
