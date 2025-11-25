# Google Play Store Deployment Guide

## Overview

This guide covers the complete process of deploying the Klubrádió Archive app to the Google Play Store. Estimated timeline: 2-4 weeks for initial setup and review.

## Prerequisites

- **Google Account**: You need a Google account (personal or organization)
- **One-time Registration Fee**: $25 USD (lifetime)
- **Payment Method**: Credit/debit card for the registration fee
- **App Requirements**: Completed app, privacy policy, screenshots, store listing assets

## Timeline

- **Initial Registration**: 1-2 days
- **First-time Account Review**: 1-2 days (Google reviews new developer accounts)
- **App Review**: 1-7 days (typically 1-3 days for initial submission)
- **Target**: Aim to submit by early December for mid-December release

---

## Phase 1: Account Registration (Do This First)

### 1.1 Create Google Play Console Account

1. **Visit**: https://play.google.com/console/signup
2. **Sign in** with your Google account
3. **Pay $25 USD registration fee** (one-time, non-refundable)
4. **Accept** Play Console Developer Distribution Agreement
5. **Complete account details**:
   - Developer name (appears in store): "Klubrádió" or your organization name
   - Contact email (visible to users)
   - Website URL (optional but recommended)
   - Phone number (for verification)

### 1.2 Verify Your Identity

Google now requires identity verification for new accounts:
- You'll need to provide a government-issued ID
- This process can take 1-2 days
- You cannot publish apps until verification is complete

**Action**: Start this process immediately as it's the longest wait time.

### 1.3 Set Up Payment Profile (Optional)

If you plan to sell the app or in-app purchases:
- Go to **Settings > Payment profile**
- Complete tax information and banking details
- For free apps, you can skip this step

---

## Phase 2: App Preparation

### 2.1 Create App Signing Key

Google requires a signing key to verify your app's authenticity.

**Generate Upload Key** (one-time setup):

```bash
cd klubradio_archivum/android

# Create keystore directory (add to .gitignore!)
mkdir -p ~/.android-signing

# Generate key (replace values with your details)
keytool -genkey -v -keystore ~/.android-signing/klubradio-upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias klubradio-upload \
  -storepass "YOUR_STRONG_PASSWORD" \
  -keypass "YOUR_STRONG_PASSWORD" \
  -dname "CN=Klubradio Archivum, OU=Mobile, O=Klubradio, L=Budapest, ST=Budapest, C=HU"
```

**Windows equivalent**:
```cmd
cd klubradio_archivum\android
mkdir %USERPROFILE%\.android-signing
keytool -genkey -v -keystore %USERPROFILE%\.android-signing\klubradio-upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias klubradio-upload
```

**Important**: Save the keystore file and passwords securely! Store them:
- In a password manager
- In a secure backup location
- **Never** commit to git

### 2.2 Configure Signing in Flutter

Create `android/key.properties` (add to `.gitignore`!):

```properties
storePassword=YOUR_KEYSTORE_PASSWORD
keyPassword=YOUR_KEY_PASSWORD
keyAlias=klubradio-upload
storeFile=/Users/YOUR_USERNAME/.android-signing/klubradio-upload-keystore.jks
```

Windows path example:
```properties
storeFile=C:\\Users\\YOUR_USERNAME\\.android-signing\\klubradio-upload-keystore.jks
```

### 2.3 Update android/app/build.gradle.kts

The signing configuration should already be present in your `build.gradle.kts`. Verify these sections exist:

```kotlin
// After android { block
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    // ...

    signingConfigs {
        create("release") {
            keyAlias = keystoreProperties["keyAlias"] as String
            keyPassword = keystoreProperties["keyPassword"] as String
            storeFile = file(keystoreProperties["storeFile"] as String)
            storePassword = keystoreProperties["storePassword"] as String
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.getByName("release")
            // ...
        }
    }
}
```

### 2.4 Update App Metadata

Verify these settings in `android/app/build.gradle.kts`:

```kotlin
android {
    namespace = "hu.klubradio.archivum"

    defaultConfig {
        applicationId = "hu.klubradio.archivum"
        minSdk = 21  // Android 5.0
        targetSdk = 34  // Update to latest (currently 34)
        versionCode = 1  // Increment for each release
        versionName = "1.0.0"  // Semantic version from pubspec.yaml
    }
}
```

**Important**:
- `versionCode` must increment with each release (1, 2, 3, ...)
- `versionName` should match your `pubspec.yaml` version
- `targetSdk` should be latest Android API level

---

## Phase 3: Required Legal Documents

### 3.1 Privacy Policy (REQUIRED)

Google requires a publicly accessible privacy policy URL for apps that:
- Access user data
- Use network connections
- Download/store content

**Create a privacy policy** that covers:
- What data you collect (listening history, subscriptions, downloads)
- How you use it
- Third-party services (Supabase backend)
- User rights (access, deletion)
- Contact information

**Where to host**:
- Your website (recommended): https://klubradio.hu/privacy-policy-archivum
- GitHub Pages: https://USERNAME.github.io/klubradio-privacy
- Free services: iubenda.com, privacypolicies.com

**Template sections**:
```markdown
# Privacy Policy for Klubrádió Archive App

## Data Collection
- Subscription preferences (stored locally)
- Downloaded episodes (stored locally)
- Listening history (stored locally)
- Optional: Usage analytics

## Third-Party Services
- Klubrádió API (content delivery)
- Supabase (backend services)

## Data Storage
- All personal data stored on user's device
- No data sold to third parties

## User Rights
- Users can delete all data by uninstalling the app
- Contact: support@klubradio.hu

Last Updated: December 2024
```

### 3.2 Content Rating (REQUIRED)

During app creation, you'll complete a content questionnaire:
- Violence: None
- Sexual content: None
- Language: Mild (news/talk radio)
- Controlled substances: None
- Target age: All ages

Expected rating: **Everyone** or **Everyone 10+**

---

## Phase 4: Create App in Play Console

### 4.1 Create New App

1. Go to **Play Console** > **All apps** > **Create app**
2. Fill in:
   - **App name**: "Klubrádió Archívum" (max 50 characters)
   - **Default language**: Hungarian (Magyar)
   - **App or game**: App
   - **Free or paid**: Free
   - **Declarations**: Check all required boxes
     - Accept Google Play Developer Program Policies
     - Export compliance (if applicable)
     - US export laws compliance

### 4.2 Set Up App Access

**Dashboard > App access**:
- Select: "All functionality is available without restrictions"
- Or if login required: Provide demo account credentials for reviewers

### 4.3 Ads Declaration

**Dashboard > Ads**:
- Select: "No, my app does not contain ads" (assuming you have no ads)

### 4.4 Content Rating

**Dashboard > Content rating**:
1. Start questionnaire
2. Select category: "Utility, Productivity, Communication, or Other"
3. Answer questions honestly (all "No" for violence, sexual content, etc.)
4. Generate rating certificate
5. Save and apply

### 4.5 Target Audience

**Dashboard > Target audience and content**:
- **Target age groups**: 13+ (or broader if appropriate)
- **Appeal to children**: No
- **Store presence**: Select all appropriate categories
  - News & Magazines
  - Music & Audio

### 4.6 News App Declaration

**Dashboard > News app**:
- If you want to appear in Google News: Yes
- Requires: Official news organization verification
- For podcast archive, you might select: No

### 4.7 Data Safety

**Dashboard > Data safety**:

This is critical! Declare all data collection:

**Data collected**:
- Location: No (unless you use location features)
- Personal info: No (no names, emails, etc. collected by app)
- Financial info: No
- Health and fitness: No
- Messages: No
- Photos and videos: No
- Audio files: Yes (downloaded podcasts - stored locally)
- Files and docs: No
- Calendar: No
- Contacts: No
- App activity: Yes
  - App interactions (listening history, subscriptions)
  - In-app search history
- Web browsing: No
- App info and performance: No (unless you use crash reporting)
- Device or other IDs: No (unless using analytics)

**Data usage**:
- All data is stored locally
- No data shared with third parties
- Optional: Analytics (if using Firebase Analytics, Google Analytics, etc.)

**Security practices**:
- Data is encrypted in transit (HTTPS)
- Data is encrypted at rest (device storage encryption)
- Users can request data deletion (via app uninstall)

---

## Phase 5: Store Listing

### 5.1 Main Store Listing

**Dashboard > Main store listing**:

**App name**: Klubrádió Archívum

**Short description** (max 80 characters):
```
Hallgasd a Klubrádió archívumát podcast formában bárhol, bármikor!
```

**Full description** (max 4000 characters):
```
Klubrádió Archívum - Podcast alkalmazás

Fedezd fel a Klubrádió gazdag archívumát ebben az egyszerűen használható podcast alkalmazásban!

FŐBB FUNKCIÓK:

🎙️ PODCAST MŰSOROK
• 100+ műsor teljes archívuma
• Naponta frissülő tartalom
• Egyszerű navigáció kategóriák szerint

📥 LETÖLTÉS ÉS OFFLINE HALLGATÁS
• Töltsd le kedvenc epizódjaidat
• Hallgasd őket offline, internetkapcsolat nélkül
• Automatikus letöltés az feliratkozott műsorokhoz
• Intelligens tárhely kezelés

⭐ FELIRATKOZÁSOK
• Kövesd a kedvenc műsoraidat
• Értesítések új epizódokról
• Automatikus letöltés beállítása

🎵 OKOS LEJÁTSZÓ
• Háttér lejátszás
• Lejátszási sebesség állítása
• 15 másodperces előre/vissza ugrás
• Folytatás ahol abbahagytad

💾 TÁRHELY KEZELÉS
• Automatikus törlés meghallgatott epizódok után
• "Legutóbbi N megtartása" szabály
• WiFi-n történő letöltés opció

🌍 NYELVEK
• Magyar
• Német
• Angol

MIÉRT VÁLASZD A KLUBRÁDIÓ ARCHÍVUM APPOT?

✓ Ingyenes és reklám mentes
✓ Modern, egyszerű felhasználói felület
✓ Gyors és megbízható
✓ Automatikus szinkronizálás
✓ Keresztplatformos (Android, iOS, Windows, macOS, Linux)

TÁMOGATOTT MŰSOROK

Politika, kultúra, tudomány, sport, zene - több mint 100 műsor közül válogathatsz:
• 168 Óra
• Megbeszéljük
• Heti Progresszió
• Jazzation
• ... és még sok más!

KAPCSOLAT

Kérdésed van? Írj nekünk: support@klubradio.hu
Weboldal: https://www.klubradio.hu

A Klubrádió Archívum nem hivatalos alkalmazás, de a Klubrádió nyilvános archívumát használja.
```

### 5.2 Graphic Assets

**Required assets** (create high-quality versions):

1. **App Icon** (already have via flutter_launcher_icons)
   - 512x512 PNG
   - 32-bit PNG with alpha
   - No rounded corners (system will apply)

2. **Feature Graphic** (REQUIRED)
   - Size: 1024x500 px
   - PNG or JPEG
   - No transparency
   - Appears at top of store listing
   - Should showcase app branding/key features

3. **Phone Screenshots** (REQUIRED, min 2, max 8)
   - Resolution:
     - Min: 320px - 3840px (16:9 to 9:16 ratio)
     - Recommended: 1080x1920 or 1440x2560
   - PNG or JPEG
   - Show key features:
     1. Home screen with podcast list
     2. Podcast detail page
     3. Now playing screen
     4. Download manager
     5. Settings screen

4. **Tablet Screenshots** (Optional but recommended, min 2, max 8)
   - 7-inch: 1200x1920
   - 10-inch: 1600x2560

5. **Promotional Video** (Optional)
   - YouTube URL
   - 30 seconds to 2 minutes
   - Showcase app features

**Tool recommendations for screenshots**:
- Use Android Emulator in Android Studio
- Flutter run with device frames: `flutter screenshot`
- Design tool mockups: figma.com/templates/android-mockup/

### 5.3 Categorization

**App category**:
- Primary: News & Magazines
- Or: Music & Audio

**Tags** (optional, improves discoverability):
- podcast
- rádió
- Klubrádió
- hírek
- archívum

---

## Phase 6: Build and Upload

### 6.1 Build App Bundle

```bash
cd klubradio_archivum

# Clean previous builds
flutter clean

# Get dependencies
flutter pub get

# Build app bundle for Play Store
flutter build appbundle --release

# Output: build/app/outputs/bundle/release/app-release.aab
```

**Verify build**:
- Check file size (should be 20-50 MB typically)
- File location: `build/app/outputs/bundle/release/app-release.aab`

### 6.2 Test the Bundle (Optional but Recommended)

```bash
# Install bundletool
# Download from: https://github.com/google/bundletool/releases

# Generate APKs from bundle
bundletool build-apks --bundle=build/app/outputs/bundle/release/app-release.aab \
  --output=test.apks \
  --mode=universal

# Install on connected device
bundletool install-apks --apks=test.apks
```

### 6.3 Upload to Play Console

**Internal Testing Track** (recommended first):

1. Go to **Play Console** > **Your app** > **Release** > **Testing** > **Internal testing**
2. Click **Create new release**
3. Under **App bundles**, click **Upload**
4. Select `build/app/outputs/bundle/release/app-release.aab`
5. Wait for upload and processing (2-10 minutes)
6. Review release notes (optional):
   ```
   Első verzió - alapvető funkciók:
   • 100+ műsor böngészése
   • Epizódok letöltése és offline hallgatás
   • Feliratkozások és értesítések
   • Automatikus letöltés
   • Intelligens tárhely kezelés
   ```
7. Click **Review release**
8. Click **Start rollout to Internal testing**

**Add testers**:
1. **Testing** > **Internal testing** > **Testers** tab
2. Create email list or use Google Groups
3. Add tester emails
4. Testers will receive link to download app

### 6.4 Test Internal Release

- Install on test devices via Play Console link
- Test all major features
- Check for crashes
- Verify downloads work
- Test on different Android versions

---

## Phase 7: Production Release

### 7.1 Resolve All Pre-launch Issues

Before production release, ensure:
- ✓ All store listing sections completed (green checkmarks)
- ✓ Privacy policy URL added
- ✓ Content rating completed
- ✓ Data safety form completed
- ✓ Screenshots uploaded (min 2 phone screenshots)
- ✓ Feature graphic uploaded
- ✓ App tested on internal track
- ✓ No crashes or major bugs

### 7.2 Submit for Production

1. Go to **Release** > **Production**
2. Click **Create new release**
3. **Copy from internal testing** or upload new bundle
4. Add release notes in all supported languages:

**Hungarian**:
```
Üdvözöljük a Klubrádió Archívum első verziójában!

Új funkciók:
• 100+ műsor böngészése és felfedezése
• Epizódok letöltése offline hallgatáshoz
• Feliratkozás kedvenc műsorokhoz
• Automatikus letöltés új epizódokhoz
• Intelligens tárhely kezelés
• Lejátszási sebesség állítása
• Háttérben történő lejátszás
```

5. Click **Review release**
6. Verify all details
7. Click **Start rollout to Production**
8. Choose rollout percentage:
   - Start with 20% (gradual rollout)
   - Monitor for issues
   - Increase to 50%, then 100% if stable

### 7.3 Review Process

**What happens next**:
1. **Automated review**: 1-2 hours (checks for malware, policy violations)
2. **Manual review**: 1-7 days (typically 1-3 days)
3. **Status updates**: Check **Release dashboard** > **Production** > **Release status**

**Possible outcomes**:
- ✓ **Approved**: App goes live automatically
- ⚠️ **Rejected**: Review rejection reasons, fix issues, resubmit

**Common rejection reasons** (and how to avoid):
- Missing privacy policy → Add URL in app content section
- Misleading screenshots → Show actual app UI
- Permissions not explained → Update data safety form
- Content rating mismatch → Retake content rating questionnaire
- Broken functionality → Test thoroughly before submission

---

## Phase 8: Post-Launch

### 8.1 Monitor App Performance

**Play Console Dashboard**:
- **Statistics**: Installs, uninstalls, rating
- **Crashes & ANRs**: Fix critical issues immediately
- **Reviews**: Respond to user feedback

### 8.2 Update Release Process

For subsequent updates:

1. Update version in `pubspec.yaml`:
   ```yaml
   version: 1.0.1+2  # version+buildNumber
   ```

2. Update `versionCode` in `android/app/build.gradle.kts`:
   ```kotlin
   versionCode = 2  // Increment by 1
   versionName = "1.0.1"
   ```

3. Build new bundle:
   ```bash
   flutter build appbundle --release
   ```

4. Upload to **Production** > **Create new release**

5. Add release notes explaining what's new

### 8.3 Set Up Release Management

**Recommended tracks**:
- **Internal testing**: Dev team (fast iteration)
- **Closed testing**: Beta testers (10-100 users)
- **Open testing**: Public beta (optional)
- **Production**: All users (gradual rollout)

**Staged rollout strategy**:
1. Release to 20% of users
2. Monitor for 1-2 days
3. Increase to 50% if stable
4. Roll out to 100% after 3-5 days

---

## Troubleshooting

### Build Issues

**Problem**: "Keystore file not found"
```bash
# Check file path in key.properties
# Ensure forward slashes even on Windows, or escape backslashes
```

**Problem**: "SDK version too low"
```bash
# Update android/app/build.gradle.kts
targetSdk = 34  # Use latest
```

### Upload Issues

**Problem**: "Bundle uses code that is too old"
```bash
# Update compileSdk in android/app/build.gradle.kts
compileSdk = 34
```

**Problem**: "Permissions not declared"
```bash
# Check AndroidManifest.xml has all required permissions
# Review uses-permission entries
```

### Review Issues

**Problem**: App rejected for "misleading information"
- Ensure app name matches functionality
- Screenshots show actual app (no mockups)
- Description is accurate

**Problem**: "Privacy policy required"
- Add publicly accessible privacy policy URL
- Must be reachable without login

---

## Security Checklist

Before submission:

- [ ] Keystore file backed up securely (NOT in git)
- [ ] key.properties added to .gitignore
- [ ] Passwords stored in password manager
- [ ] SSL/HTTPS used for all network requests
- [ ] API keys not hardcoded in app (use environment variables or backend)
- [ ] Supabase credentials secured
- [ ] ProGuard/R8 enabled for code obfuscation (default in release build)

---

## Cost Summary

- **Registration fee**: $25 USD (one-time)
- **Annual fees**: $0 (no annual fee for Play Console)
- **Per-app fees**: $0
- **Transaction fees**: 0% (for free apps)

---

## Key Dates for December Release

| Task | Duration | Target Date |
|------|----------|-------------|
| Register developer account | 1-2 days | Dec 1 |
| Identity verification | 1-2 days | Dec 3 |
| Create store listing | 2-3 days | Dec 6 |
| Internal testing | 3-5 days | Dec 11 |
| Submit for production | - | Dec 12 |
| Review process | 1-7 days | Dec 13-19 |
| **Go Live** | - | **Dec 15-20** |

**Recommendation**: Start registration process by December 1st to ensure mid-December launch.

---

## Resources

- **Play Console**: https://play.google.com/console
- **Developer Documentation**: https://developer.android.com/distribute/console
- **Flutter Deployment Guide**: https://docs.flutter.dev/deployment/android
- **Android App Bundle**: https://developer.android.com/guide/app-bundle
- **Content Policy**: https://support.google.com/googleplay/android-developer/answer/9859751

---

## Quick Reference Commands

```bash
# Build release bundle
flutter build appbundle --release

# Build APK (for testing)
flutter build apk --release

# Check app size
bundletool build-apks --bundle=app-release.aab --output=test.apks --mode=universal

# Test signing configuration
./gradlew signingReport

# Analyze bundle size
bundletool dump manifest --bundle=app-release.aab
```

---

**Next Steps**:
1. Create developer account at https://play.google.com/console/signup
2. Generate signing key (see Phase 2.1)
3. Create privacy policy (see Phase 3.1)
4. Prepare screenshots and feature graphic (see Phase 5.2)
