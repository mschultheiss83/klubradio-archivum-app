# Apple App Store Deployment - Action Plan

**Created**: 2025-12-12
**Status**: Ready to start
**Target Go-Live**: Late December 2025 / Early January 2026

## Quick Links

- **GitHub Milestone**: [Apple App Store Deployment](https://github.com/mschultheiss83/klubradio-archivum-app/milestone/1)
- **Full Guide**: [deployment-apple-store.md](./deployment-apple-store.md)

## Current Status

### ✅ Ready
- Mac with macOS 26.1 available
- Xcode 26.1.1 installed
- Flutter 3.38.4 working
- iOS and macOS builds functioning
- Version: 1.0.4

### ⚠️ Needs Work
- iOS Info.plist missing privacy descriptions
- iOS background modes not configured
- App icons need verification
- Bundle ID decision needed

### 📋 Not Started
- Apple Developer Program enrollment
- App Store Connect setup
- Marketing materials preparation

## GitHub Issues (Ordered by Priority)

### Phase 0: Technical Configuration [PRIORITY]
**Issue**: [#53](https://github.com/mschultheiss83/klubradio-archivum-app/issues/53)
**Timeline**: Today - Tomorrow (Dec 12-13)
**Status**: 🔴 Not started

**Key Tasks**:
- Fix iOS Info.plist privacy descriptions
- Create iOS entitlements file for background audio
- Verify app icons with `dart run flutter_launcher_icons`
- Decide on bundle ID (`net.mschultheiss.*` or `hu.klubradio.*`)
- Test iOS and macOS builds

**Start Immediately**: This blocks everything else!

---

### Phase 1: Apple Developer Program
**Issue**: [#54](https://github.com/mschultheiss83/klubradio-archivum-app/issues/54)
**Timeline**: Dec 13-15 (includes 1-2 day approval wait)
**Cost**: $99 USD/year
**Status**: 🔴 Not started

**Key Tasks**:
- Decide: Individual vs Organization account
- Enroll at https://developer.apple.com/programs/enroll/
- Complete payment ($99/year)
- Wait for approval email
- Complete App Store Connect profile

**Can Start**: During Phase 0 (parallel)

---

### Phase 2-3: App Store Connect Setup
**Issue**: [#55](https://github.com/mschultheiss83/klubradio-archivum-app/issues/55)
**Timeline**: Dec 15-18 (2-3 days)
**Status**: 🔴 Not started

**Key Tasks**:
- Configure code signing in Xcode (both iOS and macOS)
- Create iOS app in App Store Connect
- Create macOS app in App Store Connect
- Prepare screenshots (4-6 per platform)
- Write app descriptions (Hungarian, English, German)
- Create/host privacy policy URL
- Complete App Privacy questionnaire

**Depends On**: Phase 1 (Developer Program approved)

---

### Phase 4: Build & Submit
**Issue**: [#56](https://github.com/mschultheiss83/klubradio-archivum-app/issues/56)
**Timeline**: Dec 18-20 (1-2 days)
**Status**: 🔴 Not started

**Key Tasks**:
- Create iOS archive in Xcode
- Validate iOS archive
- Upload iOS to App Store Connect
- Create macOS archive
- Upload macOS to App Store Connect
- Complete App Store listings
- Submit both apps for review
- Monitor review process (1-7 days)

**Depends On**: Phases 0, 1, 2-3 completed

---

### Post-Launch: Monitoring
**Issue**: [#57](https://github.com/mschultheiss83/klubradio-archivum-app/issues/57)
**Timeline**: After go-live (ongoing)
**Status**: 🔴 Not started

**Key Tasks**:
- Monitor crash rates and ratings
- Respond to user reviews
- Track download numbers
- Plan future updates

**Depends On**: Phase 4 (apps approved and live)

---

## Timeline Overview

```
Dec 12-13: Phase 0 (Technical Config) ← START HERE
Dec 13-15: Phase 1 (Developer Program) ← Can start during Phase 0
Dec 15-18: Phase 2-3 (App Store Setup)
Dec 18-20: Phase 4 (Build & Submit)
Dec 20-27: Apple Review (1-7 days)
~Dec 27:   Go Live! 🎉
```

**Note**: Holiday season (Dec 24-Jan 2) may slow Apple review times.

---

## Decision Points

### 1. Bundle ID Choice
**Current**:
- iOS: `net.mschultheiss.klubradioarchivum`
- macOS: `net.mschultheiss.klubradioArchivum` (note capitalization!)

**Options**:
- **Keep current**: Recommended for personal/solo project
- **Change to** `hu.klubradio.archivum`: For official Klubrádió branding

**Impact**: Must be decided before code signing setup (Phase 2)

### 2. Apple Developer Account Type
**Options**:
- **Individual**: Fast approval, personal name in store, $99/year
- **Organization**: Company name in store, requires D-U-N-S number, 1-2 day approval, $99/year

**Impact**: Affects App Store listing appearance and enrollment time

### 3. Privacy Policy URL
**Needed**: Before submission
**Suggestions**:
- `https://klubradio.hu/privacy-policy-archivum`
- GitHub Pages
- Alternative hosting

---

## Critical Files & Locations

### iOS Configuration
- Info.plist: `ios/Runner/Info.plist`
- Entitlements: `ios/Runner/Runner.entitlements` (to be created)
- Xcode project: `ios/Runner.xcworkspace` (use .xcworkspace!)
- Bundle ID: Set in Xcode → Runner target → General

### macOS Configuration
- Info.plist: `macos/Runner/Info.plist`
- Entitlements: `macos/Runner/DebugProfile.entitlements`, `macos/Runner/Release.entitlements`
- Xcode project: `macos/Runner.xcworkspace`

### Marketing Materials
- App icons: `assets/app_icon/`
- Screenshots: To be created (use simulator or physical device)
- Privacy policy: To be created/hosted

---

## Quick Commands Reference

```bash
# Verify environment
flutter doctor -v

# Generate app icons
cd klubradio_archivum
dart run flutter_launcher_icons

# Test iOS build
flutter build ios --release
flutter run -d "iPhone 15 Pro" --release

# Test macOS build
flutter build macos --release
open build/macos/Build/Products/Release/klubradio_archivum.app

# Open Xcode projects
open ios/Runner.xcworkspace    # iOS
open macos/Runner.xcworkspace  # macOS

# Update iOS dependencies
cd ios && pod install --repo-update && cd ..

# Clean build
flutter clean && flutter pub get
```

---

## Getting Help

### Documentation
- Main guide: `docs/project/deployment-apple-store.md`
- CLAUDE.md: Project overview and conventions

### External Resources
- Apple Developer Portal: https://developer.apple.com/account
- App Store Connect: https://appstoreconnect.apple.com
- App Store Review Guidelines: https://developer.apple.com/app-store/review/guidelines/
- Flutter iOS Deployment: https://docs.flutter.dev/deployment/ios

### Issues
- GitHub Issues: All tasks tracked with `app-store-deployment` label
- Milestone: [Apple App Store Deployment](https://github.com/mschultheiss83/klubradio-archivum-app/milestone/1)

---

## Success Criteria

- [ ] iOS app approved and live in App Store
- [ ] macOS app approved and live in Mac App Store
- [ ] All features working on both platforms
- [ ] Crash rate < 1%
- [ ] Average rating > 4.0 stars (after initial reviews)
- [ ] Privacy policy accessible
- [ ] Support email monitored
- [ ] Update process documented

---

**Last Updated**: 2025-12-12
**Next Review**: After Phase 0 completion
