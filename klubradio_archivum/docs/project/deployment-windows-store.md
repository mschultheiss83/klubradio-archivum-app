# Microsoft Store (Windows Store) Deployment Guide

## Overview

This guide covers deploying the Klubrádió Archive Flutter app to the Microsoft Store for Windows desktop users. Estimated timeline: 1-3 weeks for initial setup and review.

## Prerequisites

- **Microsoft Account**: Personal or organization account
- **Registration Fee**: $19 USD for individual, $99 USD for company (one-time, valid for lifetime)
- **Windows 10/11**: For testing and building
- **Developer Mode**: Enabled on Windows development machine
- **App Requirements**: Completed Flutter Windows app, privacy policy, screenshots

## Timeline

- **Initial Registration**: Immediate (credit card) or 1-2 days (invoice)
- **Account Verification**: Same day to 2 days
- **App Review**: 1-3 days (typically 24-48 hours)
- **Target**: Aim to submit by early December for mid-December release

---

## Phase 1: Microsoft Partner Center Registration

### 1.1 Create Microsoft Partner Center Account

1. **Visit**: https://partner.microsoft.com/dashboard/registration/
2. **Select account type**:
   - **Individual**: $19 USD, faster approval, for personal projects
   - **Company**: $99 USD, requires business verification (EIN/VAT), for organizations

**Recommendation**: Start with **Individual** account unless you need:
- Organization branding
- Company purchase orders
- Multiple team members

3. **Sign in** with Microsoft account (or create new one)

### 1.2 Complete Registration

**For Individual Account**:
1. Provide personal information:
   - Full legal name
   - Country/region (Hungary)
   - Address
   - Phone number
   - Publisher display name: "Klubrádió" (visible to users, must be unique)
2. Accept App Developer Agreement
3. Pay $19 USD registration fee (credit card)
4. Wait for email confirmation (typically within hours)

**For Company Account**:
1. Provide business information:
   - Company name
   - Business address
   - Tax ID/VAT number
   - Business verification documents
   - Contact details
2. Wait for verification (1-5 business days)

### 1.3 Complete Partner Center Profile

After approval:
1. Go to **Partner Center Dashboard**: https://partner.microsoft.com/dashboard
2. Navigate to **Account settings** > **Publisher profile**
3. Complete:
   - Support contact info (visible to users)
   - Marketing contact info
   - Publisher website (optional): https://klubradio.hu
   - Company logo (if company account)

---

## Phase 2: Windows App Preparation

### 2.1 App Identity and Package Name

The Microsoft Store uses a **Package Identity** system. You'll need to reserve your app name first.

**Reserve App Name** (do this before building):
1. Go to **Partner Center** > **Apps and games** > **New product** > **MSIX or PWA app**
2. Enter app name: **"Klubrádió Archívum"**
   - Must be unique across entire Microsoft Store
   - If taken, try variations: "Klubradio Archive", "Klubrádió Archive App"
3. Click **Reserve product name**
4. Name reserved for 3 months (renewable)

**Important**: Note down:
- **Package/Identity/Name**: e.g., `12345PublisherName.KlubradióArchívum`
- **Publisher ID**: e.g., `CN=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX`
- **Package Family Name**: e.g., `12345PublisherName.KlubradióArchívum_xxxxxxxxxx`

You'll need these for packaging.

### 2.2 Create MSIX Package Configuration

Flutter Windows apps need to be packaged as MSIX (Microsoft Windows App Package) for Store submission.

#### Option 1: Use msix Flutter Package (Recommended)

1. **Add msix package to pubspec.yaml**:

```yaml
# pubspec.yaml
dependencies:
  # ... existing dependencies

dev_dependencies:
  msix: ^3.16.7  # Check for latest version
  # ... existing dev dependencies

msix_config:
  display_name: Klubrádió Archívum
  publisher_display_name: Klubrádió  # Or your organization name
  identity_name: YOUR_PACKAGE_IDENTITY_NAME  # From Partner Center (e.g., 12345PublisherName.KlubradióArchívum)
  publisher: YOUR_PUBLISHER_ID  # From Partner Center (e.g., CN=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX)
  msix_version: 1.0.0.0  # Must be x.x.x.x format
  logo_path: assets/icon/icon.png
  capabilities: internetClient, musicLibrary, picturesLibrary, videosLibrary, removableStorage
  languages: hu, en, de
  protocol_activation: klubradio
  file_extension: .mp3
  execution_alias: klubradio
  app_installer:
    publish_folder_path: C:\tmp\Klubradio\msix_output  # Output folder
  install_certificate: false  # Store submission doesn't need certificate
```

2. **Run package builder**:

```bash
cd klubradio_archivum
flutter pub get
flutter pub run msix:create --store
```

This will:
- Build Windows release
- Package as MSIX
- Output to `build/windows/x64/runner/Release/klubradio_archivum.msix`

#### Option 2: Manual MSIX Packaging (Advanced)

If you prefer manual control:

1. **Build Flutter Windows app**:
```bash
flutter build windows --release
```

2. **Install Windows SDK** (includes MakeAppx and SignTool)
   - Download: https://developer.microsoft.com/windows/downloads/windows-sdk/
   - Or use Visual Studio Installer to add "Windows SDK"

3. **Create AppxManifest.xml** (see detailed template in Phase 2.3)

4. **Package with MakeAppx**:
```cmd
"C:\Program Files (x86)\Windows Kits\10\bin\10.0.22621.0\x64\makeappx.exe" pack /d build\windows\x64\runner\Release /p klubradio_archivum.msix
```

### 2.3 Configure AppxManifest.xml

The MSIX package requires an `AppxManifest.xml` file. If using `msix` package, it generates this automatically. For manual control:

**Create** `windows/packaging/AppxManifest.xml`:

```xml
<?xml version="1.0" encoding="utf-8"?>
<Package
  xmlns="http://schemas.microsoft.com/appx/manifest/foundation/windows10"
  xmlns:uap="http://schemas.microsoft.com/appx/manifest/uap/windows10"
  xmlns:rescap="http://schemas.microsoft.com/appx/manifest/foundation/windows10/restrictedcapabilities"
  xmlns:desktop="http://schemas.microsoft.com/appx/manifest/desktop/windows10"
  xmlns:uap3="http://schemas.microsoft.com/appx/manifest/uap/windows10/3"
  IgnorableNamespaces="uap rescap desktop uap3">

  <Identity
    Name="YOUR_PACKAGE_IDENTITY_NAME"
    Publisher="YOUR_PUBLISHER_ID"
    Version="1.0.0.0" />

  <Properties>
    <DisplayName>Klubrádió Archívum</DisplayName>
    <PublisherDisplayName>Klubrádió</PublisherDisplayName>
    <Logo>Assets\StoreLogo.png</Logo>
    <Description>Hallgasd a Klubrádió archívumát podcast formában</Description>
  </Properties>

  <Dependencies>
    <TargetDeviceFamily Name="Windows.Desktop" MinVersion="10.0.17763.0" MaxVersionTested="10.0.22621.0" />
  </Dependencies>

  <Resources>
    <Resource Language="hu-HU" />
    <Resource Language="en-US" />
    <Resource Language="de-DE" />
  </Resources>

  <Applications>
    <Application Id="KlubradioArchivum" Executable="klubradio_archivum.exe" EntryPoint="Windows.FullTrustApplication">
      <uap:VisualElements
        DisplayName="Klubrádió Archívum"
        Description="Klubrádió Archívum - Podcast alkalmazás"
        BackgroundColor="transparent"
        Square150x150Logo="Assets\Square150x150Logo.png"
        Square44x44Logo="Assets\Square44x44Logo.png">
        <uap:DefaultTile
          Wide310x150Logo="Assets\Wide310x150Logo.png"
          Square310x310Logo="Assets\Square310x310Logo.png"
          Square71x71Logo="Assets\Square71x71Logo.png"
          ShortName="Klubrádió">
          <uap:ShowNameOnTiles>
            <uap:ShowOn Tile="square150x150Logo" />
            <uap:ShowOn Tile="wide310x150Logo" />
            <uap:ShowOn Tile="square310x310Logo" />
          </uap:ShowNameOnTiles>
        </uap:DefaultTile>
      </uap:VisualElements>

      <Extensions>
        <!-- File type associations for MP3 downloads -->
        <uap3:Extension Category="windows.fileTypeAssociation">
          <uap3:FileTypeAssociation Name="mp3">
            <uap:SupportedFileTypes>
              <uap:FileType>.mp3</uap:FileType>
            </uap:SupportedFileTypes>
          </uap3:FileTypeAssociation>
        </uap3:Extension>

        <!-- Protocol activation for deep links -->
        <uap:Extension Category="windows.protocol">
          <uap:Protocol Name="klubradio">
            <uap:DisplayName>Klubrádió Archívum Protocol</uap:DisplayName>
          </uap:Protocol>
        </uap:Extension>
      </Extensions>
    </Application>
  </Applications>

  <Capabilities>
    <Capability Name="internetClient" />
    <rescap:Capability Name="runFullTrust" />
    <uap:Capability Name="musicLibrary" />
    <uap:Capability Name="picturesLibrary" />
    <uap:Capability Name="videosLibrary" />
    <uap:Capability Name="removableStorage" />
  </Capabilities>
</Package>
```

**Replace**:
- `YOUR_PACKAGE_IDENTITY_NAME` → Value from Partner Center
- `YOUR_PUBLISHER_ID` → Value from Partner Center

### 2.4 Create Required Image Assets

Microsoft Store requires specific tile images in various sizes. Create these assets:

**Required assets** (in `windows/runner/resources/` or `assets/windows/`):

1. **Square44x44Logo.png** (44x44 px) - App list icon
2. **Square71x71Logo.png** (71x71 px) - Small tile
3. **Square150x150Logo.png** (150x150 px) - Medium tile
4. **Square310x310Logo.png** (310x310 px) - Large tile
5. **Wide310x150Logo.png** (310x150 px) - Wide tile
6. **StoreLogo.png** (50x50 px) - Store listing

**Design tips**:
- Use transparent background or brand color
- Keep design simple and recognizable
- Ensure icon is centered with padding
- Use vector source (SVG) and export to PNG at exact sizes

**Quick generation**:
You can use online tools or scripts to generate all sizes from a single 512x512 source icon:
- https://www.microsoft.com/store/apps/9nblggh5pxs8 (Asset Generator)
- Or manually in Photoshop/GIMP/Figma

### 2.5 Update Version Number

Ensure version consistency:

**pubspec.yaml**:
```yaml
version: 1.0.0+1
```

**If using msix package** (pubspec.yaml):
```yaml
msix_config:
  msix_version: 1.0.0.0  # Must be 4 parts (major.minor.build.revision)
```

**For subsequent releases**, increment version:
- `1.0.0.0` → `1.0.1.0` (minor update)
- `1.0.1.0` → `1.1.0.0` (feature release)
- `1.1.0.0` → `2.0.0.0` (major release)

**Important**: Microsoft Store requires version to always increase.

---

## Phase 3: Required Legal Documents

### 3.1 Privacy Policy (REQUIRED)

Same requirements as Google Play Store. You need a publicly accessible privacy policy URL.

**Reuse from Google Play deployment** if already created, or create one covering:
- Data collection (subscriptions, downloads, listening history)
- Local storage (all data on device)
- Third-party services (Supabase backend)
- User rights (data deletion via uninstall)
- Contact information

**Where to host**:
- https://klubradio.hu/privacy-policy-archivum (recommended)
- Or GitHub Pages, WordPress, etc.

### 3.2 Age Rating

Microsoft uses the **International Age Rating Coalition (IARC)** system.

During submission, you'll complete a questionnaire:
- Violence: None
- Sexual content: None
- Language: Mild
- Controlled substances: None
- User interaction: None (no user-generated content, no social features)
- In-app purchases: None
- Location sharing: No

Expected rating: **PEGI 3** (Europe), **ESRB Everyone** (US)

---

## Phase 4: Create App Submission in Partner Center

### 4.1 Start New Submission

1. Go to **Partner Center** > **Apps and games**
2. Click on your reserved app name: **Klubrádió Archívum**
3. Click **Start your submission**

You'll see the submission checklist with sections to complete.

### 4.2 Pricing and Availability

**Section: Pricing and availability**

1. **Markets**: Select where app will be available
   - Recommended: **All markets** (240+ countries)
   - Or specific markets: Hungary, EU countries, etc.

2. **Pricing**:
   - Base price: **Free**
   - Trial: Not applicable (free app)

3. **Schedule**:
   - Release option: **As soon as possible after certification**
   - Or: **At a specific date/time** (e.g., December 15, 2024)

4. **Visibility**:
   - **Public store listing**: Anyone can find and download
   - Or: **Private audience** (requires promo code or direct link)
   - Recommended: **Public store listing**

5. **Organizational licensing**:
   - Allow volume acquisition: **Yes** (allows businesses to buy in bulk)
   - For free apps, this just enables business downloads

### 4.3 Properties

**Section: Properties**

1. **Category**: Select primary category
   - **Music** > Podcasts
   - Or: **News & weather** > News

2. **Subcategory**: (optional)
   - If available, select relevant subcategory

3. **Additional categories**: (optional)
   - Add up to 2 more categories for better discoverability

4. **Privacy policy URL**: (REQUIRED)
   ```
   https://klubradio.hu/privacy-policy-archivum
   ```

5. **Website**: (optional but recommended)
   ```
   https://klubradio.hu
   ```

6. **Support contact info**: (REQUIRED)
   ```
   support@klubradio.hu
   ```

7. **System requirements**: (auto-filled from manifest)
   - Minimum Windows version: 10.0.17763.0 (Windows 10 October 2018 Update)
   - Recommended: 10.0.22000.0 (Windows 11)

8. **Game settings**: Not applicable (this is not a game)

### 4.4 Age Ratings

**Section: Age ratings**

1. Click **Get age rating** (IARC questionnaire)
2. Complete questionnaire honestly:
   - Does your app depict or enable...
     - Realistic violence? **No**
     - Unrealistic violence? **No**
     - Sexual content? **No**
     - Nudity? **No**
     - Bad language? **No** (or **Mild** if news content has profanity)
     - Drug use? **No**
     - Gambling? **No**
     - Fear? **No**
   - Does your app allow users to interact with each other? **No**
   - Does your app share user location? **No**
   - Does your app allow purchases? **No**
3. Generate rating certificate
4. Save certificate (you'll need this for other stores too)

Expected rating: **IARC 3+** / **PEGI 3** / **ESRB Everyone**

### 4.5 Store Listings

**Section: Store listings**

You'll create listings for each language. Start with Hungarian (primary).

#### Hungarian Store Listing

**Language**: Hungarian (Hungary) - `hu-HU`

**Store listing fields**:

1. **App name**: Klubrádió Archívum (or your reserved name)

2. **Description** (max 10,000 characters):

```
Klubrádió Archívum - A teljes archívum a zsebedben

Fedezd fel a Klubrádió gazdag műsorarchívumát ebben a modern, letisztult podcast alkalmazásban!

🎙️ 100+ MŰSOR
• Politika, kultúra, tudomány, sport, zene
• Naponta frissülő tartalom
• Keress műsorok és epizódok között

📥 LETÖLTÉS ÉS OFFLINE HALLGATÁS
• Töltsd le a kedvenc epizódjaidat
• Hallgasd őket bárhol, internet nélkül
• Automatikus letöltés az feliratkozott műsorokhoz
• WiFi-n történő letöltés opció

⭐ FELIRATKOZÁSOK
• Kövesd a kedvenc műsoraidat
• Ne maradj le új epizódokról
• Testreszabható értesítések

🎵 FEJLETT LEJÁTSZÓ
• Háttér lejátszás
• Lejátszási sebesség állítása (0.5x - 2.0x)
• 15 másodperces előre/vissza ugrás
• Folytatás ahol abbahagytad
• Sleep timer

💾 OKOS TÁRHELY KEZELÉS
• Automatikus törlés meghallgatott epizódok után
• "Legutóbbi N megtartása" szabály műsoronként
• WiFi-n történő letöltés korlátozás

🌍 TÖBBNYELVŰ
• Magyar
• Angol
• Német

NÉPSZERŰ MŰSOROK

• 168 Óra - politikai heti
• Megbeszéljük - aktuális témák
• Heti Progresszió - zene és kultúra
• Jazzation - jazz műsor
• Sztárlánc - interjúk
• ... és még 100+ műsor

MIÉRT VÁLASZD AZ APPOT?

✓ 100% ingyenes
✓ Reklám mentes
✓ Gyors és megbízható
✓ Modern, egyszerű felhasználói felület
✓ Windows 10 és 11 támogatás
✓ Teljes offline mód

RENDSZERKÖVETELMÉNYEK

• Windows 10 (1809) vagy újabb
• Internet kapcsolat (letöltéshez és streaming-hez)
• Javasolt: 2GB RAM, 1GB szabad tárhely

KAPCSOLAT

Kérdésed van? Írj nekünk: support@klubradio.hu
Weboldal: https://www.klubradio.hu
GitHub: https://github.com/your-repo (ha publikus)

JOGI INFORMÁCIÓK

Ez az alkalmazás nem hivatalos Klubrádió app, de a nyilvánosan elérhető Klubrádió archívumot használja.
Tartalomért a Klubrádió felelős: https://www.klubradio.hu

© 2024 Klubrádió Archívum App
```

3. **Release notes** (optional, for first release):
```
Első kiadás! 🎉

✨ Funkciók:
• 100+ műsor böngészése
• Epizódok letöltése
• Offline hallgatás
• Feliratkozások
• Automatikus letöltés
• Intelligens tárhely kezelés
```

4. **Screenshots** (REQUIRED, min 1, max 10):
   - Size: 1366x768, 1920x1080, or 3840x2160
   - PNG format (no transparency)
   - Show actual app UI
   - Recommended: 4-6 screenshots covering:
     1. Home screen with podcast list
     2. Podcast detail page with episodes
     3. Now playing screen
     4. Download manager
     5. Settings screen

   **Tip**: Use Windows Snipping Tool or Snip & Sketch to capture screenshots at native resolution.

5. **App tile icon** (optional but recommended):
   - Size: 1:1 ratio (e.g., 300x300, 400x400)
   - Featured icon for store search results
   - Use your 512x512 app icon

6. **Promotional images** (optional):
   - **Hero image**: 1920x1080 (featured on store homepage if selected)
   - **Promotional art**: 2400x1200 (for special promotions)

7. **Trailers** (optional):
   - Video URL (YouTube, Vimeo, etc.)
   - 30 seconds to 2 minutes
   - Show app features in action

8. **Keywords** (max 7):
   - podcast
   - rádió
   - klubrádió
   - hírek
   - zene
   - archívum
   - magyar

9. **Copyright and trademark info**: (optional)
   ```
   © 2024 Klubrádió Archívum. Klubrádió® is a registered trademark of Klubrádió Zrt.
   ```

10. **Additional license terms**: (optional)
    - Link to your terms of service if you have one

11. **Search terms**: (automatically uses keywords above)

#### Add English and German Listings (Optional but Recommended)

Repeat the store listing for:
- **English (United States)** - `en-US`
- **German (Germany)** - `de-DE`

**English description** (abbreviated):
```
Klubrádió Archive - Your Podcast Companion

Access the complete Klubrádió archive in this modern, user-friendly podcast app!

🎙️ 100+ SHOWS
• Politics, culture, science, sports, music
• Daily updated content
• Easy search and discovery

📥 DOWNLOAD & OFFLINE LISTENING
• Download your favorite episodes
• Listen anywhere, without internet
• Automatic downloads for subscriptions

[... continue with key features in English]
```

**German description** (abbreviated):
```
Klubrádió Archiv - Ihre Podcast-App

Entdecken Sie das komplette Klubrádió-Archiv in dieser modernen Podcast-App!

🎙️ 100+ SENDUNGEN
• Politik, Kultur, Wissenschaft, Sport, Musik
• Täglich aktualisierte Inhalte
• Einfache Suche und Entdeckung

[... continue with key features in German]
```

---

## Phase 5: Build and Upload Package

### 5.1 Build MSIX Package

Using **msix package** (recommended):

```bash
cd klubradio_archivum

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build and package for Store (no certificate needed)
flutter pub run msix:create --store

# Output: build/windows/x64/runner/Release/klubradio_archivum.msix
```

**Verify package**:
- File size: typically 50-150 MB for Flutter apps
- Location: `build/windows/x64/runner/Release/klubradio_archivum.msix`

### 5.2 Test MSIX Locally (Optional but Recommended)

Before uploading, test the MSIX package:

1. **Enable Developer Mode** on Windows:
   - Settings > Privacy & Security > For developers > Developer Mode: **On**

2. **Install MSIX locally**:
   ```powershell
   # Right-click klubradio_archivum.msix > Install
   # Or use PowerShell:
   Add-AppxPackage -Path "build\windows\x64\runner\Release\klubradio_archivum.msix"
   ```

3. **Test app**:
   - Launch from Start Menu
   - Test all major features
   - Check for crashes
   - Verify offline functionality

4. **Uninstall after testing**:
   ```powershell
   Get-AppxPackage *klubradio* | Remove-AppxPackage
   ```

### 5.3 Upload to Partner Center

**Section: Packages**

1. Go to **Submission** > **Packages**
2. Click **Upload MSIX/MSIXBUNDLE**
3. Select `klubradio_archivum.msix`
4. Wait for upload and validation (2-10 minutes)
5. **Validation checks**:
   - ✓ Package signature valid
   - ✓ Manifest correct
   - ✓ Required capabilities declared
   - ✓ Images present and correct size
   - ✓ No policy violations

**If validation fails**:
- Read error message carefully
- Common issues:
  - Wrong publisher ID in manifest
  - Missing or incorrect image assets
  - Version number already exists (must increment)
  - Capabilities not matching manifest

6. After validation succeeds, package info will be displayed:
   - Version: 1.0.0.0
   - Supported architectures: x64
   - Supported languages: hu, en, de
   - File size: ~XX MB
   - Minimum Windows version: 10.0.17763.0

---

## Phase 6: Complete Submission

### 6.1 Verify All Sections

Ensure all submission sections have green checkmarks:
- ✓ Pricing and availability
- ✓ Properties
- ✓ Age ratings
- ✓ Packages
- ✓ Store listings (at least 1 language)

### 6.2 Notes to Certification Testers (Optional)

**Section: Notes for certification**

Add any special instructions for Microsoft testers:

```
Test account: Not required (app works without login)

Key features to test:
1. Browse podcasts and episodes
2. Download an episode (requires internet)
3. Play downloaded episode offline
4. Subscribe to a podcast
5. Configure download settings

Known limitations:
- First launch requires internet to fetch podcast list
- Downloads require internet connection
- All content in Hungarian (some UI in English/German)

Contact for issues: support@klubradio.hu
```

### 6.3 Submit for Certification

1. Click **Review and publish** (bottom right)
2. Review all submission details on summary page
3. Verify:
   - App name correct
   - Package uploaded
   - All required fields completed
   - Privacy policy URL correct
4. Click **Submit to the Store**
5. Confirmation screen appears: **Submission in progress**

---

## Phase 7: Certification Process

### 7.1 Certification Stages

**Your app will go through**:

1. **Pre-processing** (1-2 hours)
   - Automated malware scan
   - Package integrity check
   - Policy compliance scan

2. **Manual review** (1-3 days)
   - Functionality testing on real devices
   - UI/UX review
   - Privacy policy verification
   - Content policy compliance

3. **Release** (immediate after approval)
   - App published to Store
   - Available for download

**Check status**: Partner Center > Your app > Submission status

### 7.2 Possible Outcomes

✓ **Passed certification**:
- App goes live immediately
- Email notification sent
- Takes 1-2 hours to appear in search results

⚠️ **Failed certification**:
- Detailed failure report provided
- Common reasons (and fixes):

**Issue**: "App crashes on launch"
- **Fix**: Test MSIX package locally first, ensure all dependencies included

**Issue**: "Privacy policy missing or inaccessible"
- **Fix**: Verify privacy policy URL is publicly accessible, no login required

**Issue**: "App description misleading"
- **Fix**: Ensure screenshots show actual app, description matches functionality

**Issue**: "Capabilities not justified"
- **Fix**: Remove unused capabilities from manifest (e.g., webcam if not used)

**Issue**: "Age rating doesn't match content"
- **Fix**: Retake IARC questionnaire with accurate answers

**How to resubmit**:
1. Fix the issue(s) mentioned in report
2. Increment version number (e.g., 1.0.0.0 → 1.0.1.0)
3. Rebuild MSIX package
4. Create new submission with updated package

---

## Phase 8: Post-Launch

### 8.1 Monitor App Performance

**Partner Center Analytics**:
- **Acquisitions**: Downloads, page views, conversion rate
- **Usage**: Daily active users, session duration
- **Health**: Crashes, hangs, error logs
- **Reviews**: User ratings and feedback
- **Revenue**: (if paid app or IAP) - Not applicable

**Important metrics**:
- Crash-free rate (aim for >99%)
- Average rating (aim for >4.0)
- Review response (respond within 24-48 hours)

### 8.2 Update Release Process

For subsequent updates:

1. **Update version** in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2  # Semantic versioning
   ```

2. **Update MSIX version** in `pubspec.yaml`:
   ```yaml
   msix_config:
     msix_version: 1.0.1.0  # Increment (must be higher than previous)
   ```

3. **Build new package**:
   ```bash
   flutter clean
   flutter pub get
   flutter pub run msix:create --store
   ```

4. **Create new submission** in Partner Center:
   - Go to your app > **Start new submission**
   - Most fields are pre-filled from previous submission
   - Upload new package
   - Update release notes
   - Submit

5. **Faster reviews**: Updates typically review faster than initial submission (often within 24 hours)

### 8.3 Respond to Reviews

1. Go to **Partner Center** > **Your app** > **Reviews**
2. Filter by:
   - Rating (prioritize 1-3 star reviews)
   - Date (respond to recent first)
   - Language
3. **Respond professionally**:
   ```
   Thank you for your feedback! We're sorry you experienced [issue].
   We've fixed this in version 1.0.1. Please update and let us know if the issue persists.
   You can reach us at support@klubradio.hu for further assistance.
   ```

4. **Use insights**: Common issues → prioritize in roadmap

---

## Phase 9: Optional Enhancements

### 9.1 Microsoft Store Badges

Add "Get it from Microsoft" badge to your website:

**HTML**:
```html
<a href="https://www.microsoft.com/store/apps/YOUR_APP_ID">
  <img src="https://get.microsoft.com/images/en-us%20dark.svg" alt="Get it from Microsoft"/>
</a>
```

Replace `YOUR_APP_ID` with your app's Store ID (found in Partner Center).

### 9.2 Deep Linking

Enable deep links to open app from web:

**Protocol**: `klubradio://` (already configured in AppxManifest.xml)

**Example links**:
- `klubradio://podcast/123` - Open specific podcast
- `klubradio://episode/456` - Open specific episode

**Website integration**:
```html
<a href="klubradio://podcast/123">Open in app</a>
```

### 9.3 Live Tiles (Optional)

Create dynamic Start Menu tiles that show recent episodes:

**Requires**: Windows 10/11 notification API integration
**Benefit**: Increased user engagement, shows recent content

**Implementation** (future enhancement):
- Use `flutter_local_notifications` package
- Send tile updates with episode info
- Show cover art and episode title

---

## Troubleshooting

### Build Issues

**Problem**: "MSIX package creation failed"
```bash
# Check Flutter Windows build first
flutter build windows --release
# Ensure no errors

# Check msix package installation
flutter pub get
flutter pub run msix:create --help
```

**Problem**: "Publisher ID not found"
- Verify you've reserved app name in Partner Center first
- Copy exact Publisher ID from Partner Center > App identity
- Format: `CN=XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX`

**Problem**: "Image assets not found"
- Ensure all required tile images exist in correct paths
- Check file names match exactly (case-sensitive)
- Verify PNG format (not JPEG)

### Validation Issues

**Problem**: "Package signature invalid"
- For Store submission, DON'T sign the package (use `--store` flag)
- Microsoft will sign it with their certificate

**Problem**: "Version number already exists"
- Increment version in `msix_config.msix_version`
- Must be higher than previous submission

**Problem**: "Capabilities not declared"
- Ensure `internetClient` capability in manifest
- Add other needed capabilities: `musicLibrary`, `picturesLibrary`, etc.

### Certification Issues

**Problem**: App rejected for "crashing on launch"
- Test MSIX package locally before submission
- Check Windows Event Viewer for crash logs
- Ensure all DLL dependencies included
- Test on clean Windows installation (VM recommended)

**Problem**: "Privacy policy not accessible"
- Verify URL is HTTPS
- Ensure no login/paywall
- Test in private browser window

---

## Security Checklist

Before submission:

- [ ] Privacy policy URL publicly accessible
- [ ] No API keys hardcoded in binary (use environment variables or backend)
- [ ] Supabase credentials secured
- [ ] HTTPS used for all network requests
- [ ] Local data encrypted (SQLite encryption if storing sensitive data)
- [ ] No debug/test code in release build
- [ ] Crash reporting configured (e.g., Sentry, Firebase Crashlytics)

---

## Cost Summary

- **Individual registration**: $19 USD (one-time, lifetime)
- **Company registration**: $99 USD (one-time, lifetime)
- **Annual fees**: $0 (no annual renewal)
- **Per-app fees**: $0
- **Transaction fees**: 0% (for free apps)
- **Update fees**: $0 (unlimited updates)

**Total for free app**: **$19 USD one-time**

---

## Key Dates for December Release

| Task | Duration | Target Date |
|------|----------|-------------|
| Register Partner Center account | 1 day | Dec 1 |
| Reserve app name | Same day | Dec 1 |
| Configure MSIX packaging | 1 day | Dec 2 |
| Create store listing | 1-2 days | Dec 4 |
| Build and test package | 1 day | Dec 5 |
| Submit for certification | - | Dec 6 |
| Certification review | 1-3 days | Dec 7-9 |
| **Go Live** | - | **Dec 7-10** |

**Recommendation**: Windows Store has fastest approval time. Start here if targeting December release.

---

## Resources

- **Partner Center**: https://partner.microsoft.com/dashboard
- **MSIX Documentation**: https://docs.microsoft.com/windows/msix/
- **Flutter MSIX Package**: https://pub.dev/packages/msix
- **Flutter Windows Deployment**: https://docs.flutter.dev/deployment/windows
- **Store Policies**: https://docs.microsoft.com/windows/uwp/publish/store-policies
- **IARC Rating**: https://www.globalratings.com/

---

## Quick Reference Commands

```bash
# Build Windows release
flutter build windows --release

# Create MSIX package for Store
flutter pub run msix:create --store

# Install MSIX locally for testing
Add-AppxPackage -Path "build\windows\x64\runner\Release\klubradio_archivum.msix"

# Uninstall local package
Get-AppxPackage *klubradio* | Remove-AppxPackage

# Check Flutter doctor for Windows
flutter doctor -v
```

---

## Next Steps

1. **Register Partner Center account**: https://partner.microsoft.com/dashboard/registration/
2. **Reserve app name**: "Klubrádió Archívum"
3. **Add msix package** to `pubspec.yaml`
4. **Configure msix_config** with Partner Center identity
5. **Create Windows tile images** (44x44, 71x71, 150x150, 310x310, 310x150)
6. **Build MSIX package**: `flutter pub run msix:create --store`
7. **Test locally** before submission
8. **Create store listing** with screenshots and description
9. **Submit for certification**

**Advantage**: Windows Store has the fastest review process (1-3 days vs 1-7 days for other stores). Consider submitting here first!
