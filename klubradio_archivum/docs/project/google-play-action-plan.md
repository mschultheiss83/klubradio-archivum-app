# Google Play Deployment - Action Plan

**Created**: 2025-12-12
**Status**: Ready to start
**Target Go-Live**: Late December 2025 / Early January 2026

## Quick Links

- **GitHub Milestone**: [Google Play Deployment](https://github.com/mschultheiss83/klubradio-archivum-app/milestone/2)
- **Full Guide**: [deployment-google-play.md](./deployment-google-play.md)

## Current Status

### ✅ Ready
- Android builds working
- Flutter 3.38.4 installed
- Version: 1.0.4
- Permissions configured
- **4 Sprachen verfügbar**: Ungarisch, Deutsch, Englisch, Rumänisch

### ⚠️ Needs Work (CRITICAL!)
- **NO release signing configured** - still using debug keys!
- Need to create signing keystore (cannot be recovered if lost!)
- Need to create key.properties file
- Need to add key.properties to .gitignore
- App label shows `klubradio_archivum` instead of "Klubrádió Archívum"

### 📋 Not Started
- Google Play Console account registration ($25)
- Identity verification
- Privacy policy creation
- Marketing materials (screenshots, feature graphic)

## GitHub Issues (Ordered by Priority)

### Phase 0: Android Release Configuration [CRITICAL!]
**Issue**: [#58](https://github.com/mschultheiss83/klubradio-archivum-app/issues/58)
**Timeline**: Today (Dec 12)
**Status**: 🔴 Not started
**Priority**: ⚠️ **CRITICAL** - Must complete first!

**Key Tasks**:
- Create signing keystore (CANNOT BE RECOVERED IF LOST!)
- Create key.properties file with keystore details
- Add key.properties to .gitignore
- Configure release signing in build.gradle.kts
- Fix app label to "Klubrádió Archívum"
- Decide on Application ID
- Test release build

**⚠️ WARNING**: The signing keystore you create will be required for ALL future app updates. If you lose it, you cannot update your app in the Play Store. Back it up securely!

**Start Immediately**: This blocks everything else!

---

### Phase 1: Play Console Account
**Issue**: [#59](https://github.com/mschultheiss83/klubradio-archivum-app/issues/59)
**Timeline**: Dec 12-14 (includes 1-2 day verification wait)
**Cost**: $25 USD (one-time, lifetime)
**Status**: 🔴 Not started

**Key Tasks**:
- Register at https://play.google.com/console/signup
- Pay $25 registration fee
- Submit identity verification (government ID required)
- Wait for approval (1-2 days)

**Can Start**: During Phase 0 (parallel)

---

### Phase 2-3: Store Listing & Marketing
**Issue**: [#60](https://github.com/mschultheiss83/klubradio-archivum-app/issues/60)
**Timeline**: Dec 14-17 (2-3 days)
**Status**: 🔴 Not started

**Key Tasks**:
- Create/host privacy policy (REQUIRED)
- Prepare screenshots (min 2 phone, recommend 4-6)
- Create feature graphic (1024x500 px)
- Write app descriptions (Hungarian, English, German)
- Complete content rating questionnaire
- Fill data safety form
- Create app in Play Console

**Depends On**: Phase 1 (account verified)

---

### Phase 4: Internal Testing
**Issue**: [#61](https://github.com/mschultheiss83/klubradio-archivum-app/issues/61)
**Timeline**: Dec 17-19 (2-3 days)
**Status**: 🔴 Not started

**Key Tasks**:
- Build release bundle: `flutter build appbundle --release`
- Upload to internal testing track
- Add testers
- Test on multiple devices/Android versions
- Fix any critical bugs
- Verify all features work

**Depends On**: Phases 0, 1, 2-3

---

### Phase 5: Production & Post-Launch
**Issue**: [#62](https://github.com/mschultheiss83/klubradio-archivum-app/issues/62)
**Timeline**: Dec 19-26 (1-7 days review)
**Status**: 🔴 Not started

**Key Tasks**:
- Submit for production review
- Monitor review process (1-7 days)
- Gradual rollout (20% → 50% → 100%)
- Monitor crash rates and reviews
- Respond to user feedback
- Plan future updates

**Depends On**: Phases 0, 1, 2-3, 4

---

## Timeline Overview

```
TODAY (Dec 12):    Phase 0 - Release signing (CRITICAL!)
Dec 12-14:         Phase 1 - Account registration & verification
Dec 14-17:         Phase 2-3 - Store listing & marketing
Dec 17-19:         Phase 4 - Internal testing
Dec 19-26:         Phase 5 - Production review (1-7 days)
~Dec 26:           Go Live! 🎉
```

**Note**: Can run in parallel with Apple App Store deployment!

---

## Decision Points

### 1. Application ID Choice
**Current**: `net.mschultheiss.klubradioarchivum`

**Options**:
- **Keep current**: For personal project
- **Change to** `hu.klubradio.archivum`: For official Klubrádió branding

**Impact**: Must be decided before first release. Cannot change later without creating new app.

### 2. Privacy Policy Hosting
**Needed**: Before submission
**Options**:
- `https://klubradio.hu/privacy-policy-archivum` (recommended)
- GitHub Pages
- Free service (iubenda.com, privacypolicies.com)

**Requirement**: Must be publicly accessible without login

### 3. Rollout Strategy
**Options**:
- **Immediate 100%**: All users get app at once
- **Gradual** (recommended): 20% → 50% → 100% over 1 week

**Recommendation**: Gradual rollout to catch issues early

---

## Critical Files & Locations

### Android Configuration
- Signing keystore: `~/.android-signing/klubradio-upload-keystore.jks`
- Signing config: `android/key.properties` (create this, add to .gitignore!)
- Build config: `android/app/build.gradle.kts`
- Manifest: `android/app/src/main/AndroidManifest.xml`
- Application ID: Set in build.gradle.kts and AndroidManifest.xml

### Build Outputs
- Release bundle: `build/app/outputs/bundle/release/app-release.aab`
- Release APK (testing): `build/app/outputs/apk/release/app-release.apk`

### Marketing Materials
- Screenshots: To be created (use emulator or physical device)
- Feature graphic: To be created (1024x500 px)
- Privacy policy: To be created/hosted

---

## Quick Commands Reference

```bash
# Create signing keystore (PHASE 0 - DO FIRST!)
mkdir -p ~/.android-signing
keytool -genkey -v -keystore ~/.android-signing/klubradio-upload-keystore.jks \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias klubradio-upload

# Build release bundle
cd /Volumes/2TB/code/klubradio-archivum-app/klubradio_archivum
flutter clean
flutter pub get
flutter build appbundle --release

# Build release APK (for testing)
flutter build apk --release

# Verify bundle created
ls -lh build/app/outputs/bundle/release/app-release.aab

# Test signing configuration
cd android && ./gradlew signingReport && cd ..
```

---

## Security Checklist (CRITICAL!)

Before ANY submission:

- [ ] Keystore file created and backed up to 2+ secure locations
- [ ] Keystore password saved in password manager
- [ ] `key.properties` added to `.gitignore`
- [ ] Verified key.properties NOT in git: `git status`
- [ ] Verified no .jks files in git: `git log --all --full-history -- "*.jks"`
- [ ] HTTPS used for all network requests
- [ ] No API keys hardcoded in app
- [ ] Supabase credentials secured

---

## Getting Help

### Documentation
- Main guide: `docs/project/deployment-google-play.md`
- CLAUDE.md: Project overview and conventions

### External Resources
- Play Console: https://play.google.com/console
- Developer Docs: https://developer.android.com/distribute/console
- Flutter Deployment: https://docs.flutter.dev/deployment/android
- Content Policy: https://support.google.com/googleplay/android-developer/answer/9859751

### Issues
- GitHub Issues: All tasks tracked with `google-play-deployment` label
- Milestone: [Google Play Deployment](https://github.com/mschultheiss83/klubradio-archivum-app/milestone/2)

---

## Success Criteria

- [ ] App approved and live in Google Play Store
- [ ] All features working on Android
- [ ] Crash rate < 1%
- [ ] ANR rate < 0.5%
- [ ] Average rating > 4.0 stars (after initial reviews)
- [ ] Privacy policy accessible
- [ ] Support email monitored
- [ ] Update process tested and documented
- [ ] **Keystore backed up to multiple secure locations**

---

## Common Pitfalls to Avoid

1. **Losing the keystore** ⚠️
   - Backup IMMEDIATELY after creating
   - Store in password manager + cloud + external drive
   - If lost, cannot update app (must create new app listing)

2. **Committing secrets to git**
   - Add key.properties to .gitignore BEFORE creating it
   - Never commit .jks files
   - Check git status before every commit

3. **Incomplete store listing**
   - Privacy policy is REQUIRED
   - Data safety form is REQUIRED
   - Content rating is REQUIRED
   - At least 2 screenshots REQUIRED

4. **Not testing before production**
   - Always use internal testing first
   - Test on real devices, not just emulator
   - Check different Android versions

5. **Ignoring gradual rollout**
   - Start with 20% to catch issues early
   - Monitor crash reports closely
   - Don't rush to 100%

---

**Last Updated**: 2025-12-12
**Next Review**: After Phase 0 completion

**REMEMBER**: Phase 0 (Release Signing) is CRITICAL and must be done first! The keystore cannot be recovered if lost.
