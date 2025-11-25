# Apple App Store Deployment Guide

## Overview

This guide covers deploying the Klubrádió Archive Flutter app to the Apple App Store for iOS devices. Estimated timeline: 2-4 weeks for initial setup and review.

**IMPORTANT**: This process requires:
- Mac computer (macOS 11.0 or later)
- Xcode 13.0 or later
- Physical iOS device or iOS Simulator for testing
- Apple Developer Account

---

## Prerequisites

- **Mac Computer**: Required for building iOS apps (cannot build on Windows/Linux)
- **Xcode**: Free download from Mac App Store
- **Apple ID**: Personal or organization Apple ID
- **Apple Developer Program**: $99 USD/year (required for App Store submission)
- **iOS Device**: iPhone or iPad for testing (recommended but optional with simulator)
- **Payment Method**: Credit card for Developer Program enrollment

## Timeline

- **Developer Program Enrollment**: 1-2 days (can take up to 48 hours for approval)
- **Account Verification**: Immediate to 2 days (organization accounts take longer)
- **App Review**: 1-7 days (average 24-48 hours)
- **Target**: Aim to submit by early December for mid-December release

**Note**: Plan to start this process once you have access to a Mac (in ~3 weeks).

---

## Phase 1: Apple Developer Program Enrollment

### 1.1 Choose Account Type

**Individual Account** ($99/year):
- Personal developer name appears in store
- Fast approval (usually same day)
- Suitable for solo developers and small projects
- Can't transfer apps to organization later

**Organization Account** ($99/year):
- Company name appears in store
- Requires D-U-N-S Number (free but takes 1-2 weeks to obtain)
- Requires business verification documents
- Can add team members
- Can transfer apps

**Recommendation**: If Klubrádió is a registered organization, use **Organization Account**. Otherwise, start with **Individual Account**.

### 1.2 Enroll in Apple Developer Program

1. **Visit**: https://developer.apple.com/programs/enroll/
2. **Sign in** with your Apple ID
3. **Select account type**:
   - Individual (personal)
   - Organization (company)
4. **Review and accept** Apple Developer Program License Agreement
5. **Complete enrollment**:
   - Enter personal/organization details
   - Provide contact information
   - Add payment method ($99 USD/year)
6. **Submit enrollment**
7. **Wait for approval** (email confirmation):
   - Individual: Usually within hours
   - Organization: 1-2 days (may require verification call)

### 1.3 Organization Account Additional Steps

If enrolling as organization:

1. **Obtain D-U-N-S Number** (if you don't have one):
   - Visit: https://developer.apple.com/enroll/duns-lookup/
   - Free service by Dun & Bradstreet
   - Takes 1-2 weeks to receive
   - Required for organization verification

2. **Prepare documents**:
   - Business registration documents
   - Tax ID / VAT number
   - Proof of authority to sign on behalf of organization
   - Official company website

3. **Verification call**: Apple may call to verify organization details

### 1.4 Complete Developer Account Setup

After approval:

1. Go to **App Store Connect**: https://appstoreconnect.apple.com
2. **Sign in** with your Apple ID
3. **Complete profile**:
   - Contact information
   - Banking information (for paid apps or IAP - optional for free apps)
   - Tax forms (W-8BEN for non-US, W-9 for US)

---

## Phase 2: iOS Development Setup

### 2.1 Install Xcode

1. **Open Mac App Store**
2. **Search** for "Xcode"
3. **Install** (12+ GB download, takes 30-60 minutes)
4. **Open Xcode** and accept license agreement
5. **Install additional components** when prompted

**Verify installation**:
```bash
xcode-select --install
xcode-select -p
# Should output: /Applications/Xcode.app/Contents/Developer
```

### 2.2 Configure Xcode Command Line Tools

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -runFirstLaunch
```

### 2.3 Install CocoaPods

CocoaPods manages iOS dependencies (required by Flutter iOS projects):

```bash
# Install CocoaPods
sudo gem install cocoapods

# Verify installation
pod --version
```

### 2.4 Verify Flutter iOS Setup

```bash
# Check Flutter iOS toolchain
flutter doctor -v

# Expected output should show:
# [✓] Xcode - develop for iOS and macOS
#     • Xcode at /Applications/Xcode.app/Contents/Developer
#     • CocoaPods version 1.xx.x
```

**Fix any issues** reported by `flutter doctor` before proceeding.

---

## Phase 3: iOS App Configuration

### 3.1 Open iOS Project in Xcode

```bash
cd klubradio_archivum
open ios/Runner.xcworkspace  # Note: .xcworkspace, NOT .xcodeproj!
```

**Important**: Always open `.xcworkspace`, not `.xcodeproj`, when using CocoaPods.

### 3.2 Configure App Identity

In Xcode:

1. **Select "Runner" target** (top left, next to stop button)
2. **Go to "Signing & Capabilities" tab**
3. **Bundle Identifier**: `hu.klubradio.archivum`
   - Must be unique across entire App Store
   - Format: reverse domain notation
   - If `hu.klubradio.archivum` is taken, try:
     - `hu.klubradio.archivum.app`
     - `com.klubradio.archivum`
4. **Display Name**: "Klubrádió Archívum"
   - User-visible app name (appears under icon)
5. **Version**: `1.0.0` (matches `pubspec.yaml`)
6. **Build**: `1` (increment for each submission)

### 3.3 Configure Signing

**Automatic Signing** (recommended for beginners):

1. In **Signing & Capabilities** tab:
2. Check **"Automatically manage signing"**
3. Select **Team**: Your Apple Developer account name
4. Xcode will automatically:
   - Create App ID
   - Generate provisioning profiles
   - Create certificates

**Manual Signing** (advanced):

If you need manual control:
1. Uncheck **"Automatically manage signing"**
2. Create **App ID** in Developer Portal
3. Create **Provisioning Profiles**:
   - Development profile (for testing)
   - Distribution profile (for App Store)
4. Download and install profiles
5. Select profiles in Xcode

**Recommendation**: Use automatic signing for first-time submission.

### 3.4 Add Required Capabilities

Your app needs specific capabilities for downloads and audio playback:

1. In Xcode, **Signing & Capabilities** tab
2. Click **"+ Capability"** button
3. Add:
   - **Background Modes**:
     - ☑ Audio, AirPlay, and Picture in Picture (for background audio playback)
     - ☑ Background fetch (for auto-downloads)
     - ☑ Remote notifications (if you add push notifications later)
   - **App Transport Security**: (optional, usually auto-configured)

### 3.5 Configure Info.plist

Add required privacy descriptions (iOS requires explanations for permission requests):

**File**: `ios/Runner/Info.plist`

Add these keys (if not already present):

```xml
<dict>
    <!-- Existing keys... -->

    <!-- Media Library (for downloads) -->
    <key>NSAppleMusicUsageDescription</key>
    <string>Letöltött epizódok tárolása a média könyvtárban.</string>

    <!-- Microphone (if using audio recording - probably not needed) -->
    <!-- <key>NSMicrophoneUsageDescription</key>
    <string>Nem használt a jelenlegi verzióban.</string> -->

    <!-- Photos Library (for saving cover art - optional) -->
    <!-- <key>NSPhotoLibraryUsageDescription</key>
    <string>Podcast borítók mentése.</string> -->

    <!-- Background audio -->
    <key>UIBackgroundModes</key>
    <array>
        <string>audio</string>
        <string>fetch</string>
    </array>

    <!-- App Transport Security (allows HTTP if needed, but use HTTPS!) -->
    <key>NSAppTransportSecurity</key>
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <false/>  <!-- Set to false for security, only allow HTTPS -->
    </dict>

    <!-- Supported interface orientations -->
    <key>UISupportedInterfaceOrientations</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
        <string>UIInterfaceOrientationLandscapeLeft</string>
        <string>UIInterfaceOrientationLandscapeRight</string>
    </array>

    <!-- iPad orientations -->
    <key>UISupportedInterfaceOrientations~ipad</key>
    <array>
        <string>UIInterfaceOrientationPortrait</string>
        <string>UIInterfaceOrientationPortraitUpsideDown</string>
        <string>UIInterfaceOrientationLandscapeLeft</string>
        <string>UIInterfaceOrientationLandscapeRight</string>
    </array>
</dict>
```

**Important**: Provide descriptions in Hungarian (or your primary language) as this is what users will see.

### 3.6 Configure App Icons

Your app icon should already be configured via `flutter_launcher_icons`. Verify:

**File**: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`

**Required sizes**:
- 20x20 (2x, 3x)
- 29x29 (2x, 3x)
- 40x40 (2x, 3x)
- 60x60 (2x, 3x)
- 76x76 (1x, 2x) - iPad
- 83.5x83.5 (2x) - iPad Pro
- 1024x1024 (1x) - App Store

**Verify in Xcode**:
1. Open `ios/Runner/Assets.xcassets`
2. Click **AppIcon**
3. Ensure all sizes are populated
4. No transparency allowed (use solid background color)

If icons missing, regenerate with:
```bash
cd klubradio_archivum
dart run flutter_launcher_icons
```

### 3.7 Update Deployment Target

Set minimum iOS version:

1. In Xcode, **Runner target** > **General** tab
2. **Minimum Deployments**: iOS 12.0 (or higher)
   - Flutter 3.x supports iOS 12+
   - Recommendation: iOS 12.0 for widest compatibility
   - Or iOS 13.0 for newer features

Also update in `ios/Podfile`:

```ruby
# Uncomment and set to match Xcode deployment target
platform :ios, '12.0'
```

Then update pods:
```bash
cd ios
pod install --repo-update
cd ..
```

---

## Phase 4: Required Legal Documents

### 4.1 Privacy Policy (REQUIRED)

Same requirements as other stores. You need a publicly accessible privacy policy URL.

**Reuse from Google Play deployment** or create one covering:
- Data collection (subscriptions, downloads, listening history)
- Local storage (all data on device)
- Third-party services (Supabase backend, audio streaming)
- User rights (data deletion via app uninstall)
- IDFA usage (if using analytics - probably not)
- Contact information

**Where to host**:
- https://klubradio.hu/privacy-policy-archivum (recommended)
- Or GitHub Pages, WordPress, etc.

### 4.2 Content Rights

Apple requires you to confirm:
- You have rights to all content in the app
- Content does not infringe on copyrights/trademarks
- Content complies with App Store guidelines

**For Klubrádió Archive**:
- Confirm you have permission to use Klubrádió content
- Or that content is publicly available and licensed appropriately
- Add attribution in app (e.g., "Content provided by Klubrádió")

---

## Phase 5: Create App in App Store Connect

### 5.1 Create New App

1. Go to **App Store Connect**: https://appstoreconnect.apple.com
2. Click **"My Apps"**
3. Click **"+"** button > **"New App"**
4. Fill in:
   - **Platform**: iOS
   - **Name**: "Klubrádió Archívum" (must be unique, max 30 characters)
     - If taken, try: "Klubrádió Archive", "Klubradio Archivum"
   - **Primary Language**: Hungarian
   - **Bundle ID**: Select `hu.klubradio.archivum` (or your configured bundle ID)
   - **SKU**: Unique identifier for your records (e.g., `klubradio-archivum-ios`)
     - Not visible to users
     - Can use: `KLUBRADIO_ARCHIVUM_001`
   - **User Access**: Full Access (or Limited if restricting team access)
5. Click **"Create"**

### 5.2 App Information

**Tab: App Information**

1. **Name**: Klubrádió Archívum (displayed in App Store)

2. **Subtitle** (optional, max 30 characters):
   ```
   Podcast alkalmazás
   ```

3. **Category**:
   - **Primary**: Music
   - **Secondary** (optional): News

4. **Content Rights**: Do you own or have licensed all content?
   - Select appropriate option based on your agreement with Klubrádió

5. **Privacy Policy URL**: (REQUIRED)
   ```
   https://klubradio.hu/privacy-policy-archivum
   ```

6. **License Agreement**: (optional)
   - Leave blank to use Apple's standard EULA
   - Or provide custom terms of service URL

### 5.3 Pricing and Availability

**Tab: Pricing and Availability**

1. **Price**: Select **Free**

2. **Availability**:
   - Start date: Immediate upon approval
   - Or: Schedule for specific date (e.g., December 15, 2024)

3. **Countries and Regions**:
   - Select: **All countries and regions** (175+ countries)
   - Or: Specific countries (Hungary, EU, etc.)
   - Recommendation: All countries for maximum reach

4. **Pre-order**: (optional)
   - Allow users to pre-order before release
   - Useful for marketing campaign
   - Requires build uploaded 2-180 days before release

---

## Phase 6: Prepare App Store Listing

### 6.1 App Store Information

**Tab: [Version] > App Store Localization (Hungarian)**

**Screenshots** (REQUIRED):

You need screenshots for at least one device size, but providing all sizes is recommended:

**iPhone 6.7" Display** (iPhone 15 Pro Max, 14 Pro Max, etc.):
- Size: 1290 x 2796 px
- Required: 1-10 screenshots
- Show: Home, Podcast Detail, Now Playing, Downloads, Settings

**iPhone 6.5" Display** (iPhone 11 Pro Max, XS Max):
- Size: 1242 x 2688 px

**iPhone 5.5" Display** (iPhone 8 Plus, 7 Plus):
- Size: 1242 x 2208 px

**iPad Pro (6th gen) 12.9" Display**:
- Size: 2048 x 2732 px
- Required if iPad support enabled

**Tip**: Use iPhone simulator in Xcode to capture screenshots at exact sizes:
```bash
# Launch iOS simulator
flutter run

# Take screenshot in simulator:
# Device > Screenshot (Cmd+S)
# Or: Hardware > Device > Screenshot
```

**Create 4-6 screenshots showing**:
1. Home screen with podcast list
2. Podcast detail page with episodes
3. Now playing screen with controls
4. Download manager showing downloads
5. Settings screen
6. (Optional) Discovery/Browse screen

**App Preview Videos** (optional, recommended):
- Duration: 15-30 seconds
- Size: Same as screenshot dimensions
- Show app in action
- Must be actual device footage (not mockups)
- Can add text overlays, transitions

**Promotional Text** (optional, max 170 characters):
```
Fedezd fel a Klubrádió teljes archívumát! 100+ műsor, offline hallgatás, automatikus letöltés. 🎙️
```

This text can be updated anytime without new app review.

**Description** (max 4,000 characters):

```
Klubrádió Archívum - A teljes archívum mindig veled

Hallgasd a Klubrádió gazdag műsorarchívumát ebben a modern, felhasználóbarát podcast alkalmazásban!

🎙️ 100+ MŰSOR ARCHÍVUMA
• Politika, kultúra, tudomány, sport, zene
• Naponta frissülő tartalom
• Könnyű navigáció és keresés

📥 LETÖLTÉS ÉS OFFLINE HALLGATÁS
• Töltsd le kedvenc epizódjaidat
• Hallgasd őket bárhol, internetkapcsolat nélkül
• Automatikus letöltés feliratkozott műsorokhoz
• WiFi-n történő letöltés opció

⭐ FELIRATKOZÁSOK
• Kövesd a kedvenc műsoraidat
• Értesítések új epizódokról
• Testreszabható beállítások

🎵 PROFESSZIONÁLIS LEJÁTSZÓ
• Háttérben futó lejátszás
• Lejátszási sebesség állítása (0.5x - 2.0x)
• 15 másodperces előre/vissza ugrás
• Folytatás ahol abbahagytad
• Alvás időzítő
• CarPlay támogatás (későbbi verzióban)

💾 INTELLIGENS TÁRHELY KEZELÉS
• Automatikus törlés meghallgatott epizódok után
• "Legutóbbi N megtartása" szabály műsoronként
• WiFi korlátozás mobiladatok megóvására

🌍 TÖBBNYELVŰ FELÜLET
• Magyar
• Angol
• Német

NÉPSZERŰ MŰSOROK

• 168 Óra - politikai heti
• Megbeszéljük - aktuális témák elemzése
• Heti Progresszió - zene és kultúra
• Jazzation - jazz műsor
• Sztárlánc - érdekes interjúk
• Kultúrház - kulturális magazin
• Irodalmi Újság - könyvek és irodalom
• ... és még 100+ műsor

MIÉRT VÁLASZD AZ APPOT?

✓ 100% ingyenes
✓ Reklám mentes
✓ Gyors és megbízható
✓ Egyszerű, modern dizájn
✓ Teljes offline funkció
✓ Automatikus szinkronizálás
✓ Rendszeres frissítések

TÁMOGATOTT ESZKÖZÖK

• iPhone (iOS 12.0 vagy újabb)
• iPad (iOS 12.0 vagy újabb)
• iPod touch (iOS 12.0 vagy újabb)

RENDSZERKÖVETELMÉNYEK

• iOS 12.0 vagy újabb
• Internet kapcsolat (letöltéshez és streaming-hez)
• Javasolt: 1GB szabad tárhely a letöltésekhez

KAPCSOLAT

Van kérdésed vagy visszajelzésed?
Email: support@klubradio.hu
Web: https://www.klubradio.hu

JOGI INFORMÁCIÓK

Ez az alkalmazás nem hivatalos Klubrádió app, de a nyilvánosan elérhető Klubrádió archívumot használja. A tartalomért a Klubrádió felelős.

Tartalomszolgáltató: Klubrádió Zrt.
Web: https://www.klubradio.hu

© 2024 Klubrádió Archívum App
```

**Keywords** (max 100 characters, comma-separated):

```
podcast,rádió,klubrádió,hírek,zene,kultúra,archívum,hallgatás,magyar
```

**Support URL** (REQUIRED):
```
https://klubradio.hu
```

**Marketing URL** (optional):
```
https://klubradio.hu/archivum
```

### 6.2 Additional Localizations

Add English and German listings:

**Click "+ Localization"** and select:
- **English (U.S.)** - `en-US`
- **German** - `de-DE`

Provide translated screenshots (optional but recommended) and descriptions.

**English Description** (abbreviated):
```
Klubrádió Archive - Your Podcast Companion

Explore the complete Klubrádió archive in this modern podcast app!

🎙️ 100+ SHOWS
• Politics, culture, science, sports, music
• Daily updated content
• Easy navigation and search

📥 DOWNLOAD & OFFLINE LISTENING
• Download favorite episodes
• Listen anywhere without internet
• Auto-download for subscriptions

[... continue with key features]
```

**German Description** (abbreviated):
```
Klubrádió Archiv - Ihre Podcast-App

Entdecken Sie das komplette Klubrádió-Archiv!

🎙️ 100+ SENDUNGEN
• Politik, Kultur, Wissenschaft, Sport, Musik
• Täglich aktualisierte Inhalte
• Einfache Navigation und Suche

[... continue with key features]
```

---

## Phase 7: Build and Submit App

### 7.1 Build iOS Release

**Clean build**:
```bash
cd klubradio_archivum
flutter clean
flutter pub get

# Update iOS pods
cd ios
pod install --repo-update
cd ..
```

**Build for release** (archive):
```bash
flutter build ios --release

# Or build directly in Xcode (recommended for first-time submission)
```

### 7.2 Create Archive in Xcode

1. **Open Xcode**:
   ```bash
   open ios/Runner.xcworkspace
   ```

2. **Select target device**:
   - Top bar: Select **"Any iOS Device (arm64)"** (not simulator!)

3. **Product Menu** > **Archive**
   - Wait for build to complete (3-10 minutes)
   - Xcode will open **Organizer** window when done

4. **Organizer window** appears with your archive:
   - Verify: Version 1.0.0, Build 1
   - Archive size: typically 30-80 MB

### 7.3 Validate Archive

Before uploading, validate for issues:

1. In **Organizer**, select your archive
2. Click **"Validate App"**
3. Select **distribution options**:
   - **App Store Connect**: Yes
   - **Include bitcode**: No (deprecated by Apple)
   - **Rebuild from Bitcode**: No
   - **Strip Swift symbols**: Yes (reduces size)
   - **Upload your app's symbols**: Yes (enables crash reports)
4. Click **"Next"**
5. Select **automatic signing** (or manual if configured)
6. Click **"Validate"**
7. Wait for validation (1-5 minutes)

**Possible issues**:
- Missing icon sizes → Regenerate with `flutter_launcher_icons`
- Invalid signature → Check signing configuration
- Missing permissions → Add to Info.plist
- Bundle ID mismatch → Verify in Xcode and App Store Connect

8. If validation succeeds: **"No issues found"** ✓

### 7.4 Upload to App Store Connect

1. In **Organizer**, select your archive
2. Click **"Distribute App"**
3. Select **"App Store Connect"**
4. Click **"Next"**
5. Select **distribution options** (same as validation):
   - **Upload**: Yes
   - **Include bitcode**: No
   - **Strip Swift symbols**: Yes
   - **Upload symbols**: Yes
6. Click **"Next"**
7. Select **automatic signing**
8. Click **"Upload"**
9. Wait for upload (5-20 minutes depending on size and connection)
10. **"Upload Successful"** notification

### 7.5 Wait for Processing

After upload:
1. Go to **App Store Connect** > **My Apps** > **Klubrádió Archívum**
2. Go to **TestFlight** tab or **App Store** tab > **Build**
3. Status: **"Processing"** 🔄
   - Wait 5-30 minutes (sometimes up to 1 hour)
4. You'll receive email: **"Your build has completed processing"**
5. Status changes to: **"Ready to Submit"** ✓

**If processing fails**:
- Check email for specific error (e.g., missing Info.plist keys)
- Common issues:
  - Missing privacy descriptions
  - Invalid provisioning profile
  - Bitcode issues (disable bitcode)
- Fix issue and re-upload

---

## Phase 8: TestFlight (Optional but Recommended)

Before submitting to App Store, test with real users via TestFlight.

### 8.1 Internal Testing

1. Go to **App Store Connect** > **TestFlight** tab
2. **Build** is automatically available for internal testing
3. **Add internal testers**:
   - App Store Connect users with Admin or App Manager role
   - Up to 100 internal testers
4. Testers install **TestFlight app** from App Store
5. Testers receive invitation email
6. Click link → Opens TestFlight → Install app
7. Test thoroughly for 3-7 days

### 8.2 External Testing (Optional)

For broader testing with public beta testers:

1. **App Store Connect** > **TestFlight** > **External Testing**
2. **Create new group**: "Public Beta" or "Klubrádió Testers"
3. **Add testers** via:
   - Email addresses (up to 10,000 testers)
   - Public link (anyone can join)
4. **Submit for Beta App Review** (required for external testing)
   - Review takes 1-2 days
   - Same guidelines as App Store review
5. After approval, testers can install via TestFlight

---

## Phase 9: Submit for App Review

### 9.1 Complete App Store Information

Ensure all sections completed:
- ✓ App Information (name, category, privacy policy)
- ✓ Pricing and Availability
- ✓ App Store listing (screenshots, description)
- ✓ Build selected
- ✓ Version release (manual or automatic)

### 9.2 Version Information

**Tab: [Version] > General Information**

1. **What's New in This Version** (release notes, max 4,000 characters):

**Hungarian (primary language)**:
```
Üdvözöljük a Klubrádió Archívum első verziójában! 🎉

✨ ÚJ FUNKCIÓK:
• 100+ műsor teljes archívuma elérhető
• Epizódok böngészése és keresése
• Letöltés offline hallgatáshoz
• Feliratkozás kedvenc műsorokhoz
• Automatikus letöltés új epizódokhoz
• Intelligens tárhely kezelés
• Lejátszási sebesség állítása
• Háttérben futó lejátszás
• Sleep timer
• Többnyelvű támogatás (HU, EN, DE)

📱 TÁMOGATOTT ESZKÖZÖK:
• iPhone (iOS 12.0+)
• iPad (iOS 12.0+)

🐛 JAVÍTÁSOK:
• Nincs (első verzió)

💬 VISSZAJELZÉS:
Észrevételedet várom: support@klubradio.hu

Köszönöm, hogy használod az appot! ❤️
```

2. **Copyright**:
   ```
   © 2024 Klubrádió Archívum
   ```

3. **Routing App Coverage File**: Not applicable (not a navigation app)

4. **Sign-in information**:
   - Is sign-in required? **No**
   - If yes, provide demo account (not needed for this app)

5. **Contact Information** (for App Review team):
   - First name: Your first name
   - Last name: Your last name
   - Phone number: +36 xxx xxx xxxx (with country code)
   - Email: support@klubradio.hu
   - **Important**: This contact is for reviewers, not public

6. **Notes** (for App Review team):

```
Thank you for reviewing Klubrádió Archívum!

KEY FEATURES TO TEST:
1. Browse podcasts (no login required)
2. Play an episode (streaming works immediately)
3. Download an episode (requires internet)
4. Play downloaded episode offline (works without internet)
5. Subscribe to a podcast
6. Configure auto-download settings

TESTING NOTES:
• No account/login required - app works immediately
• First launch requires internet to fetch podcast list
• All content is in Hungarian (UI is multi-language)
• Downloads may take 1-5 minutes depending on episode length
• All content provided by Klubrádió (public archive)

CONTENT RIGHTS:
• This app uses publicly available content from Klubrádió's public archive
• Content URL: https://www.klubradio.hu/archivum
• We have appropriate rights to use this content

CONTACT FOR QUESTIONS:
support@klubradio.hu
+36 xxx xxx xxxx

Thank you!
```

### 9.3 App Review Information

**Section: App Review Information**

1. **Attach file** (optional):
   - Screenshots showing key features
   - Testing instructions
   - Not usually necessary

### 9.4 Version Release

**Select release option**:

1. **Manually release this version** (recommended for first release):
   - After approval, you manually click "Release" button
   - Gives you control over exact release time

2. **Automatically release this version**:
   - App goes live immediately after approval
   - No manual action needed

3. **Automatically release this version after App Review, no earlier than [date]**:
   - Schedule release for specific date
   - E.g., December 15, 2024, 10:00 AM

**Recommendation**: Select **"Manually release"** for first version to ensure everything is ready.

### 9.5 Submit for Review

1. Click **"Add for Review"** (top right)
2. **Review submission checklist**:
   - All required fields completed
   - Build selected
   - Screenshots uploaded
   - Privacy policy accessible
   - Contact info provided
3. Click **"Submit to App Review"**
4. **Confirmation**: "Waiting for Review"

---

## Phase 10: App Review Process

### 10.1 Review Stages

**Your app goes through**:

1. **Waiting for Review** (1-3 days, sometimes longer):
   - App queued for review
   - Average wait: 24-48 hours
   - Peak times (holidays) can be longer

2. **In Review** (1-2 hours):
   - Apple reviewer is actively testing your app
   - You'll receive email notification

3. **Pending Developer Release** (if manual release selected):
   - App approved, waiting for you to release
   - Or: **Ready for Sale** (if automatic release)

**Check status**: App Store Connect > My Apps > Your app > Status

### 10.2 Possible Outcomes

✓ **Approved**:
- Email: "Your app is Ready for Sale" (automatic release)
- Or: "Pending Developer Release" (manual release)
- App appears in App Store within 1-2 hours
- Status: **Ready for Sale**

⚠️ **Rejected** (don't worry, very common for first submissions):
- Email: "We found issues with your app"
- Detailed rejection reasons in Resolution Center
- Fix issues and resubmit

**Common rejection reasons**:

1. **Guideline 2.1 - App Completeness**:
   - App crashes on launch
   - Features don't work as described
   - **Fix**: Test thoroughly on real device, fix bugs

2. **Guideline 2.3 - Accurate Metadata**:
   - Screenshots don't match app
   - Description misleading
   - **Fix**: Use actual app screenshots, accurate description

3. **Guideline 4.0 - Design**:
   - Poor UI/UX
   - Looks like web view (Flutter apps rarely have this issue)
   - **Fix**: Improve design, follow iOS HIG

4. **Guideline 5.1.1 - Privacy**:
   - Privacy policy missing or inaccessible
   - Missing data collection disclosures
   - **Fix**: Ensure privacy policy URL works, update App Privacy details

5. **Guideline 5.1.2 - Data Use**:
   - Unclear why data is collected
   - Excessive permissions requested
   - **Fix**: Only request necessary permissions, explain in Info.plist

**How to resubmit**:
1. Fix issues mentioned in rejection
2. Increment build number (1 → 2)
3. Create new archive in Xcode
4. Upload to App Store Connect
5. Wait for processing
6. Go to App Store Connect > Version > **Submit for Review** again
7. No need to change version number (1.0.0), just build number

### 10.3 Release App

If **manual release** selected and app approved:

1. Go to **App Store Connect** > **My Apps** > **Klubrádió Archívum**
2. Status: **Pending Developer Release**
3. Click **"Release This Version"** button
4. App goes live within 1-2 hours
5. Status changes to: **Ready for Sale** ✓

---

## Phase 11: Post-Launch

### 11.1 Monitor App Performance

**App Store Connect Analytics**:
- **App Units**: Downloads, updates, redownloads
- **In-App Purchases**: (not applicable for free app)
- **Sales and Trends**: Downloads by country, device
- **Usage**: Sessions, active devices, crashes
- **Ratings and Reviews**: User feedback

**Check regularly**:
- Crash rate (aim for <1%)
- Average rating (aim for >4.0 stars)
- User reviews (respond within 24-48 hours)

### 11.2 Respond to Reviews

**In App Store Connect**:
1. Go to **Ratings and Reviews**
2. Filter by rating (prioritize 1-3 stars)
3. Click **"Respond"** on individual reviews

**Response guidelines**:
- Be professional and courteous
- Acknowledge issues
- Explain fixes or workarounds
- Invite to contact support for further help

**Example response** (Hungarian):
```
Köszönöm a visszajelzést! Sajnálom, hogy [probléma] történt.
Az 1.0.1-es verzióban javítottuk ezt a hibát. Kérlek, frissítsd az appot és jelezd, ha továbbra is problémád van.
Írj nekünk: support@klubradio.hu

Üdvözlettel,
Klubrádió Archívum csapat
```

### 11.3 Update Release Process

For subsequent updates:

1. **Update version** in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2  # Version+BuildNumber
   ```

2. **Update in Xcode**:
   - Runner target > General > Version: `1.0.1`
   - Runner target > General > Build: `2`

3. **Create new archive**:
   ```bash
   flutter clean
   flutter pub get
   cd ios && pod install && cd ..
   # Open Xcode and create archive
   open ios/Runner.xcworkspace
   ```

4. **Upload to App Store Connect**:
   - Validate → Distribute → Upload

5. **Create new version**:
   - App Store Connect > "+" button next to "iOS App"
   - Version: 1.0.1
   - Select new build
   - Update "What's New" release notes

6. **Submit for review**:
   - Updates typically review faster than initial submission

---

## Phase 12: App Privacy Details (Important!)

Apple requires detailed privacy disclosures. Complete this section carefully.

**App Store Connect** > **App Privacy**

### 12.1 Data Collection

For each data type, indicate:
- **Collected**: Yes/No
- **Linked to user**: Yes/No (identifies user)
- **Used for tracking**: Yes/No (tracking across apps/websites)

**For Klubrádió Archívum**:

**Contact Info**: No

**Health & Fitness**: No

**Financial Info**: No

**Location**: No

**Sensitive Info**: No

**Contacts**: No

**User Content**: No

**Browsing History**: No

**Search History**:
- **Collected**: Yes (episode searches)
- **Linked to user**: No (stored locally, not sent to server)
- **Used for tracking**: No
- **Purpose**: App functionality

**Identifiers**:
- If using analytics (Firebase, etc.): Yes
- **Collected**: Device ID (if using analytics)
- **Linked to user**: No
- **Used for tracking**: No
- **Purpose**: Analytics

**Purchases**: No (free app, no IAP)

**Usage Data**:
- **Collected**: Yes (listening history, subscriptions)
- **Linked to user**: No (stored locally on device)
- **Used for tracking**: No
- **Purpose**: App functionality

**Diagnostics**:
- If using crash reporting: Yes
- **Collected**: Crash data
- **Linked to user**: No
- **Used for tracking**: No
- **Purpose**: App functionality, bug fixes

**Other Data**: No

### 12.2 Tracking

**Does this app collect data to track users?**
- **No** (assuming no cross-app/website tracking)
- If using Facebook Analytics, Google Analytics with tracking: **Yes**

---

## Troubleshooting

### Build Issues

**Problem**: "Code signing error"
```bash
# Open Xcode, go to Signing & Capabilities
# Enable "Automatically manage signing"
# Select your team
```

**Problem**: "Module 'some_package' not found"
```bash
cd ios
pod install --repo-update
cd ..
flutter clean
flutter pub get
```

**Problem**: "Xcode version too old"
- Update Xcode from Mac App Store
- Must be latest stable version

### Archive Issues

**Problem**: "Archive not showing in Organizer"
- Ensure "Any iOS Device (arm64)" selected (not simulator!)
- Product > Clean Build Folder (Shift+Cmd+K)
- Product > Archive again

**Problem**: "Invalid bundle"
- Check bundle ID matches App Store Connect
- Verify all icon sizes present
- Check Info.plist has required keys

### Validation Issues

**Problem**: "Missing compliance"
- Add export compliance in Info.plist if using encryption (HTTPS counts as encryption)
- Answer questionnaire in App Store Connect

**Problem**: "Invalid provisioning profile"
- Refresh profiles in Xcode: Preferences > Accounts > Download Manual Profiles
- Enable automatic signing

---

## Security Checklist

Before submission:

- [ ] API keys not hardcoded (use backend or environment variables)
- [ ] HTTPS used for all network requests
- [ ] SSL certificate validation enabled
- [ ] Supabase credentials secured
- [ ] Keychain used for sensitive data (if any)
- [ ] Privacy policy URL publicly accessible
- [ ] App Privacy details accurately filled
- [ ] Info.plist privacy descriptions added

---

## Cost Summary

- **Apple Developer Program**: $99 USD/year (REQUIRED)
  - Individual or Organization
  - Renews annually
  - Covers iOS, macOS, watchOS, tvOS development

- **Per-app fees**: $0
- **Update fees**: $0 (unlimited updates)
- **Transaction fees**: 0% (for free apps)

**Total first year**: **$99 USD**
**Total subsequent years**: **$99 USD/year**

---

## Key Dates for December Release

| Task | Duration | Target Date |
|------|----------|-------------|
| Get Mac access | - | ~3 weeks |
| Enroll in Developer Program | 1-2 days | Dec 1 |
| Setup Xcode and Flutter | 1 day | Dec 2 |
| Configure iOS project | 1 day | Dec 3 |
| Create App Store Connect listing | 2 days | Dec 5 |
| Build and test | 2 days | Dec 7 |
| TestFlight testing (optional) | 3-5 days | Dec 12 |
| Submit for review | - | Dec 13 |
| App review | 1-7 days | Dec 14-20 |
| **Go Live** | - | **Dec 15-21** |

**Note**: Wait until you have Mac access (3 weeks from now) before starting. Then aim for early December submission.

---

## Resources

- **App Store Connect**: https://appstoreconnect.apple.com
- **Developer Portal**: https://developer.apple.com/account
- **App Store Review Guidelines**: https://developer.apple.com/app-store/review/guidelines/
- **Human Interface Guidelines**: https://developer.apple.com/design/human-interface-guidelines/
- **Flutter iOS Deployment**: https://docs.flutter.dev/deployment/ios
- **TestFlight**: https://developer.apple.com/testflight/

---

## Quick Reference Commands

```bash
# Check Flutter iOS setup
flutter doctor -v

# Open iOS project in Xcode (use .xcworkspace!)
open ios/Runner.xcworkspace

# Update iOS dependencies
cd ios && pod install --repo-update && cd ..

# Build iOS release
flutter build ios --release

# Clean build
flutter clean && flutter pub get

# Generate app icons
dart run flutter_launcher_icons
```

---

## Next Steps (When You Have Mac Access)

1. **Enroll in Apple Developer Program**: https://developer.apple.com/programs/enroll/
2. **Install Xcode** from Mac App Store
3. **Configure iOS project** in Xcode (bundle ID, signing)
4. **Create app in App Store Connect**
5. **Add privacy descriptions** to Info.plist
6. **Build and test** on iOS Simulator or device
7. **Create archive** in Xcode
8. **Upload to App Store Connect**
9. **Complete App Store listing** (screenshots, description)
10. **Submit for review**

**Important**: Start Developer Program enrollment now (even without Mac) as it takes 1-2 days for approval. This way you'll be ready when you get Mac access in 3 weeks.
