### Implementing Step 1: Package Integration

To integrate the `background_downloader` package into your Flutter project at https://github.com/mschultheiss83/klubradio-archivum-app/tree/dev/klubradio_archivum, follow these steps. This assumes the project is a standard Flutter app (based on the structure and context). I'll provide exact code snippets and commands. After this, you can mark the status as completed in your project plan.

#### 1. Add the Package to `pubspec.yaml`
Open the `pubspec.yaml` file in the root of your Flutter app directory (likely `klubradio_archivum/pubspec.yaml`).

Add the following line under the `dependencies` section (if the section doesn't exist, create it after `dev_dependencies` or at the appropriate place):

```
dependencies:
  background_downloader: ^9.2.6
```

- This is the latest version as of the current date (September 29, 2025). If you want to pin to a specific version or use the latest, you can check pub.dev for updates, but this should work.
- Save the file.

Run the following command in your terminal from the project root to install the package:

```
flutter pub get
```

This will download and add the package to your `pubspec.lock`.

#### 2. Handle Platform Configurations
The `background_downloader` package requires some platform-specific setup for background operations, notifications, and storage access. These are typically done once per project.

##### Android Configuration
- **Update Kotlin Version (if needed):** The package requires Kotlin 1.9.20 or higher. Open `android/build.gradle` and ensure the `ext.kotlin_version` is set appropriately:
  ```
  buildscript {
      ext.kotlin_version = '1.9.20' // Or higher if your project uses a newer version
      repositories {
          google()
          mavenCentral()
      }
      dependencies {
          classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
      }
  }
  ```
    - If your project uses Gradle plugin syntax (common in newer Flutter projects), check `android/settings.gradle` and add/update:
      ```
      plugins {
          id "org.jetbrains.kotlin.android" version "1.9.20" apply false
      }
      ```

- **Add Permissions to `AndroidManifest.xml`:** Open `android/app/src/main/AndroidManifest.xml`. Add the following inside the `<manifest>` tag (before `<application>`):
  ```
  <uses-permission android:name="android.permission.POST_NOTIFICATIONS" />
  ```
    - This is required for notifications on Android 13+ (API 33+).
    - If your app targets external storage (as mentioned in the plan for downloads), also add (for compatibility with older APIs):
      ```
      <uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
      <uses-permission android:name="android.permission.READ_EXTERNAL_STORAGE" />
      ```
        - Note: For Android 10+ (API 29+), storage is scoped, so runtime permission requests will be handled in code (Step 2 of the plan). These manifest entries are for legacy support if needed.

- **Optional: Notification Localization and Icons**
    - If you want custom notification text, create `android/app/src/main/res/values/strings.xml` (or edit if exists) and add:
      ```
      <?xml version="1.0" encoding="utf-8"?>
      <resources>
          <string name="bg_downloader_cancel">Cancel</string>
          <string name="bg_downloader_pause">Pause</string>
          <string name="bg_downloader_resume">Resume</string>
          <string name="bg_downloader_notification_channel_name">Downloads</string>
          <string name="bg_downloader_notification_channel_description">Notifications for background downloads</string>
      </resources>
      ```
    - For custom icons, place XML drawables in `android/app/src/main/res/drawable/` matching names like `outline_download_done_24.xml` (copy from the package if needed).

After changes, rebuild the Android app with `flutter build apk` or run `flutter run` to verify.

##### iOS Configuration
- **Enable Background Modes in Xcode:**
    - Open the iOS project in Xcode: `open ios/Runner.xcworkspace`.
    - Select the "Runner" target in the Project Navigator.
    - Go to the "Signing & Capabilities" tab.
    - Click the "+" button to add a capability.
    - Search for and add "Background Modes".
    - Check the box for "Background fetch".

- **Update `Info.plist` for Storage and Sharing (Recommended for Downloads):**
    - Open `ios/Runner/Info.plist` in a text editor or Xcode.
    - Add the following keys inside the `<dict>` tag (if not already present). These make downloaded files visible in the Files app:
      ```
      <key>LSSupportsOpeningDocumentsInPlace</key>
      <true/>
      <key>UIFileSharingEnabled</key>
      <true/>
      ```
    - If your app needs to add files to the Photos library (unlikely for audio archives, but if media includes images/videos):
      ```
      <key>NSPhotoLibraryAddUsageDescription</key>
      <string>Allow adding downloaded media to your Photos library.</string>
      <key>NSPhotoLibraryUsageDescription</key>
      <string>Access to Photos library for downloaded media.</string>
      ```

- **Set Notification Delegate in `AppDelegate` (for Notifications):**
    - If using Swift (check `ios/Runner/AppDelegate.swift`):
        - Add to the `didFinishLaunchingWithOptions` method:
          ```
          UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
          ```
    - If using Objective-C (`ios/Runner/AppDelegate.m`):
      ```
      [UNUserNotificationCenter currentNotificationCenter].delegate = (id<UNUserNotificationCenterDelegate>) self;
      ```

- **Other iOS Notes:**
    - The package defaults to HTTPS URLs; HTTP may require App Transport Security exceptions in `Info.plist` if needed:
      ```
      <key>NSAppTransportSecurity</key>
      <dict>
          <key>NSAllowsArbitraryLoads</key>
          <true/>
      </dict>
      ```
    - To bypass certain permissions at compile time (optional, if you encounter build issues), edit `ios/Podfile` post-install section as noted in the package docs.

After changes, rebuild the iOS app with `flutter build ios` or run `flutter run` to verify.

#### 3. Verification
- Import the package in a Dart file (e.g., `lib/main.dart`) to test: `import 'package:background_downloader/background_downloader.dart';`
- Run `flutter doctor` to ensure no issues.
- If you encounter errors, check the console output from `flutter pub get` or the build process.

This completes Step 1. You can now proceed to Step 2 (Permissions Handling) in code, where you'll request runtime permissions (e.g., using `permission_handler` package if not already added). If background_downloader was already in your pubspec.yaml, just update the version and configs as needed.

If you share the current `pubspec.yaml`, `AndroidManifest.xml`, or `Info.plist` contents, I can provide diff-style exact changes.

