# Flutter App Release Process

This document outlines the steps to release the Klubrádió Archivum Flutter app to the Google Play Store and the Apple App Store, based on the official Flutter documentation.

## Prerequisites

-   **Google Play Store**:
    -   A Google Play Developer account.
    -   The app created in the Google Play Console with the application ID `hu.klubradio.archivum`.
-   **Apple App Store**:
    -   An Apple Developer Program membership.
    -   A Mac with Xcode.
    -   The app created in App Store Connect with the bundle ID `hu.klubradio.archivum`.

## General Steps (for both platforms)

### 1. Update Version Number

-   Update the version number in `pubspec.yaml`. The version number is in the format `major.minor.patch+build`. For example, `1.0.0+1`.

### 2. Add/Update App Icon

-   **Android**: Place your icon files in the `[project]/android/app/src/main/res/` directory, in folders named using configuration qualifiers (e.g., `mipmap-hdpi`, `mipmap-xxhdpi`, etc.). Update the `android:icon` attribute in `AndroidManifest.xml`.
-   **iOS**: In the Xcode project navigator, select `Assets.xcassets` in the `Runner` folder and update the placeholder icons with your own app icons.

---

## Android Release (Google Play Store)

### 1. Review App Manifest and Build Configuration

-   **`AndroidManifest.xml`**: Review `[project]/android/app/src/main/AndroidManifest.xml` to ensure it has the correct permissions (e.g., `android.permission.INTERNET`).
-   **`build.gradle`**: Review `[project]/android/app/build.gradle.kts` to ensure the `compileSdk`, `minSdk`, and `targetSdk` versions are appropriate.

### 2. Create a Keystore for Signing

-   If you don't have a keystore, create one using the `keytool` command:
    ```bash
    keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
    ```
-   Store the keystore file in a safe place.

### 3. Configure Gradle for Signing

-   Create a file named `[project]/android/key.properties` with the following content:
    ```properties
    storePassword=<password>
    keyPassword=<password>
    keyAlias=upload
    storeFile=<path-to-your-keystore-file>
    ```
-   In `[project]/android/app/build.gradle.kts`, add the signing configuration.

### 4. Build the App Bundle

-   Run the following command to build the app bundle:
    ```bash
    flutter build appbundle
    ```
-   The release bundle will be created at `[project]/build/app/outputs/bundle/release/app.aab`.

### 5. Upload to Google Play Console

-   Go to the Google Play Console.
-   Select the app and go to the "Production" track.
-   Upload the app bundle.
-   Fill in the release details and submit the release.

---

## iOS Release (Apple App Store)

### 1. Register a Bundle ID

-   In your Apple Developer account, go to "Certificates, IDs & Profiles" and register a new Bundle ID for your app.

### 2. Create an Application Record on App Store Connect

-   In App Store Connect, create a new app and fill in the required details.

### 3. Review Xcode Project Settings

-   Open the Xcode workspace (`ios/Runner.xcworkspace`).
-   Select the `Runner` target and review the settings in the "General" and "Signing & Capabilities" tabs. Ensure the "Display Name", "Bundle Identifier", and "Team" are correct.

### 4. Add a Launch Image

-   In the Xcode project navigator, select `Assets.xcassets` in the `Runner` folder and update the placeholder launch image.

### 5. Create a Build Archive

-   Run the following command to build the IPA:
    ```bash
    flutter build ipa
    ```
-   This will create an Xcode build archive (`.xcarchive`) and an App Store app bundle (`.ipa`).

### 6. Upload to App Store Connect

-   You can upload the `.ipa` file using the Transporter app or from the command line:
    ```bash
    xcrun altool --upload-app --type ios -f build/ios/ipa/*.ipa --apiKey your_api_key --apiIssuer your_issuer_id
    ```
-   Alternatively, open the `.xcarchive` file in Xcode and use the "Distribute App" feature.

### 7. Submit for Review

-   In App Store Connect, go to your app's page.
-   Fill in all the required metadata (screenshots, description, etc.).
-   Submit the app for review.

---

## Testing

-   **Google Play**: Use the internal, alpha, or beta testing tracks in the Google Play Console to test your app before releasing it to production.
-   **Apple App Store**: Use TestFlight to distribute your app to internal and external testers before releasing it on the App Store.
