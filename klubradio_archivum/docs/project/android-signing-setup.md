# Android Release Signing — Team Setup Guide

## Overview

The app uses a **release keystore** for signing Play Store builds. These files are **NOT in Git** (`.gitignore` excludes them). They must be distributed to team members securely (e.g., encrypted cloud share, password manager, direct handoff).

## Required Files

Team members need **2 files** to build release APKs/AABs:

### 1. `android/key.properties`

```properties
storePassword=klubradio2026
keyPassword=klubradio2026
keyAlias=klubradio
storeFile=app/klubradio-release.jks
```

### 2. `android/app/klubradio-release.jks`

Binary keystore file (RSA 2048-bit, validity 10,000 days = ~27 years).

**Certificate details:**
- CN: Klubradio Archivum
- OU: Mobile
- O: Multilevel Studios
- L/ST: Budapest
- C: HU

## Setup Steps (for new team members)

1. Obtain both files from the team lead (NOT from Git).
2. Place `key.properties` in `android/` directory.
3. Place `klubradio-release.jks` in `android/app/` directory.
4. Verify with: `flutter build appbundle --release`

## Security Rules

- **NEVER** commit `key.properties` or `*.jks` to Git.
- **NEVER** share via unencrypted email or public channels.
- **Store a backup** of the keystore in a secure location. If lost, you cannot update the app on Play Store.
- Recommended: Use a password manager (1Password, Bitwarden) to store the keystore + passwords.

## How Signing Works

`android/app/build.gradle.kts` loads `key.properties` at build time:
- If `key.properties` exists → release builds are signed with the keystore.
- If missing → release builds will fail (no fallback to debug signing).

## Regenerating the Keystore (emergency only)

If the keystore is lost, a new one must be generated. **This means the app cannot be updated on Play Store** — a new listing must be created.

```bash
keytool -genkey -v \
  -keystore android/app/klubradio-release.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias klubradio \
  -dname "CN=Klubradio Archivum, OU=Mobile, O=Multilevel Studios, L=Budapest, ST=Budapest, C=HU" \
  -storepass <NEW_PASSWORD> \
  -keypass <NEW_PASSWORD>
```

Then update `key.properties` with the new password.

## Google Play App Signing

Google Play uses **Play App Signing** by default. When you upload the first AAB, Google extracts the upload key and manages the final signing key. This means:
- You still need the keystore to **upload** builds.
- Google re-signs with their own key for distribution.
- If you lose the upload key, you can request a reset via Play Console (with identity verification).
