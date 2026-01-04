# Task: [Title] - Issue #[ID]

**Date**: [YYYY-MM-DD]
**Labels**: [issue labels]
**Platform(s)**: [Android/iOS/Windows/macOS/Linux/Web]
**Priority**: [High/Medium/Low]
**Status**: [In Progress/Completed/Blocked]

---

## Claude's Orchestration Plan

**Task Analysis:**
- **Complexity**: [Low/Medium/High]
- **Risk Level**: [Low/Medium/High]
- **Estimated Impact**: [Small/Medium/Large]

**Agent Assignments:**
- [ ] Gemini: [specific tasks]
- [ ] Codex: [if needed - specific tasks]
- [ ] Additional instances: [if needed]

**Execution Mode:**
- [ ] Parallel (Gemini + Codex simultaneously)
- [ ] Sequential (Phase 1 → Phase 2 → ...)

**Platform Considerations:**
- **Affected Platforms**: [list]
- **Platform-specific Requirements**:
  - Android: [requirements/concerns]
  - iOS: [requirements/concerns]
  - macOS: [entitlements/requirements]
  - Windows: [requirements/concerns]
  - Linux: [requirements/concerns]
  - Web: [CORS/storage/limitations]

**Architecture Assessment:**
- **Data Flow**: [affected flows: Download/Playback/Subscription]
- **Offline-First Impact**:
  - [ ] JSON metadata affected
  - [ ] JPG cover art affected
  - [ ] MP3 storage affected
- **Provider Chain**: [affected providers]
- **Database Impact**: [tables: Subscriptions/Episodes/Settings]
- **Retention Policy**: [Keep Latest N / Delete After Hours affected?]

**Risk Assessment:**
| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| [Risk 1] | [H/M/L] | [H/M/L] | [strategy] |
| [Risk 2] | [H/M/L] | [H/M/L] | [strategy] |

**Decision Points:**
- **Option A**: [description]
  - Pros: [list]
  - Cons: [list]
  - **Selected**: [Y/N]
- **Option B**: [description]
  - Pros: [list]
  - Cons: [list]
  - **Selected**: [Y/N]

**Test Strategy:**
- [ ] Unit tests for: [components]
- [ ] Integration tests for: [flows]
- [ ] Platform tests: [platforms]
- [ ] Manual test plan: [steps]

**Deployment Plan:**
- **Deployer**: Gemini (or User if fails)
- **Target**: [dev/staging/production]
- **Rollback Strategy**: [steps]

---

## Codex Analysis (if triggered by Claude)

**Concept/Design Decisions:**
- [High-level design considerations]
- [Strategic architecture decisions]

**Alternative Approaches Evaluated:**
1. **Approach A**: [description]
   - Evaluation: [analysis]
   - Recommendation: [accept/reject + reason]
2. **Approach B**: [description]
   - Evaluation: [analysis]
   - Recommendation: [accept/reject + reason]

**Architecture Recommendations:**
- [Recommendation 1 with detailed rationale]
- [Recommendation 2 with detailed rationale]

**Critical Review Findings:**
- **Security Concerns**: [if any]
- **Performance Considerations**: [if any]
- **Scalability Issues**: [if any]
- **Technical Debt**: [if any]

**Code Review (if Gemini implementation reviewed):**
```
File: [path]
Lines: [range]
Issue: [description]
Severity: [Critical/High/Medium/Low]
Recommendation: [fix recommendation]
```

**Approval Status:**
- [ ] Architecture approved
- [ ] Implementation approach approved
- [ ] Security cleared
- [ ] Performance acceptable
- [ ] Concerns: [list if any]

---

## Gemini Implementation

### Code Changes

**New Files:**
- `[file path]`: [purpose/description]
- `[file path]`: [purpose/description]

**Modified Files:**
- `[file path]`: Lines [range] - [what changed]
- `[file path]`: Lines [range] - [what changed]

**Deleted Files:**
- `[file path]`: [reason for deletion]

### Database Schema Changes (if applicable)

**Tables Modified/Added:**
```dart
// lib/db/database.dart or tables.dart
class TableName extends Table {
  // Schema definition
}
```

**Migration:**
- Version: [old] → [new]
- Migration script: [describe or link]
- Data preservation: [how existing data handled]

**Build Runner Executed:**
```bash
dart run build_runner build --delete-conflicting-outputs
# Output: [success/errors]
```

### Internationalization (if applicable)

**l10n Updates:**
- Languages updated: [ ] hu [ ] de [ ] en [ ] ro
- New keys added: [count]
- Modified keys: [count]

**ARB Files Modified:**
```json
// lib/l10n/app_en.arb
{
  "newKey": "English text",
  "@newKey": {
    "description": "Description for translators"
  }
}
```

**Generated:**
```bash
flutter gen-l10n
# Output: [success/errors]
```

### Build/Test Commands Executed

**Analysis:**
```bash
flutter analyze
# Result: [✓ No issues found / ✗ X issues found]
# Issues: [list if any]
```

**Tests:**
```bash
flutter test
# Result: [✓ All X tests passed / ✗ X of Y tests failed]
# Failed tests: [list if any]
# New tests added: [count]
# Test coverage: [percentage]
```

**Platform Builds:**
```bash
# Android
flutter build apk --debug
# Result: [✓ Success / ✗ Failed]
# Notes: [any]

# iOS
flutter build ios --debug --no-codesign
# Result: [✓ Success / ✗ Failed]
# Notes: [any]

# macOS
flutter build macos --debug
# Result: [✓ Success / ✗ Failed]
# Notes: [entitlements verified, etc.]

# Windows
flutter build windows --debug
# Result: [✓ Success / ✗ Failed]

# Web
flutter build web --debug
# Result: [✓ Success / ✗ Failed]
# Notes: [CORS/storage considerations]
```

### Test Results Details

**New Tests Created:**
- `test/[path]`: [X tests] - [what they test]
- `test/[path]`: [X tests] - [what they test]

**Modified Tests:**
- `test/[path]`: [what changed]

**Test Coverage:**
- Before: [X%]
- After: [Y%]
- Delta: [+/- Z%]

### Platform-Specific Implementation

**Android (if relevant):**
- Files modified: [list]
- Permissions added: [list]
- Min SDK: [unchanged / changed to X]
- Notes: [any]

**iOS (if relevant):**
- Files modified: [list]
- Info.plist changes: [list]
- Permissions added: [list]
- Notes: [any]

**macOS (if relevant):**
- Files modified: [list]
- Entitlements updated:
  - [ ] com.apple.security.network.client
  - [ ] com.apple.security.files.user-selected.read-write
  - [ ] com.apple.security.files.downloads.read-write
  - [ ] com.apple.security.assets.music.read-write
- Notes: [any]

**Windows (if relevant):**
- Files modified: [list]
- Notes: [any]

**Web (if relevant):**
- Files modified: [list]
- Storage strategy: [LocalStorage/IndexedDB]
- CORS handling: [describe]
- Notes: [limitations/workarounds]

### Commit Information

**Commits Made:**
```bash
[commit hash] Fix download resume logic -g
[commit hash] Add playlist feature implementation -g
[commit hash] Update tests for playlist integration -g
```

**Branch:**
- Created from: `dev`
- Branch name: `feature/[name]`
- Status: [ready for PR / pushed / merged]

---

## Test & Validation Results

### Automated Testing

**flutter analyze:**
- Status: [✓ Clean / ✗ Issues found]
- Issues: [list if any with file:line]
- Resolution: [how issues were resolved]

**flutter test:**
- Status: [✓ All passed / ✗ Some failed]
- Total tests: [count]
- Passed: [count]
- Failed: [count with details]
- Skipped: [count with reason]
- Duration: [time]

### Platform Build Verification

| Platform | Build Status | Notes |
|----------|--------------|-------|
| Android  | [✓/✗] | [notes] |
| iOS      | [✓/✗] | [notes] |
| macOS    | [✓/✗] | [notes] |
| Windows  | [✓/✗] | [notes] |
| Linux    | [✓/✗] | [notes] |
| Web      | [✓/✗] | [notes] |

### Integration Tests (if applicable)

**API Live Tests:**
```bash
flutter test --dart-define API_SERVICE_LIVE_TESTS=true test/services/api_service_live_test.dart
# Result: [✓/✗]
# Notes: [any]
```

**Download Integration Tests:**
```bash
flutter test --dart-define DOWNLOAD_LIVE_TESTS=true test/integration_test/download_manager_live_test.dart
# Result: [✓/✗]
# Notes: [any]
```

### Claude's Review Checkpoint

**Architecture Compliance:**
- [ ] Data flow patterns maintained
- [ ] Offline-first patterns followed
- [ ] Provider dependency chain correct
- [ ] Retention policies respected
- [ ] Platform requirements met

**Code Quality:**
- [ ] Minimal, focused changes
- [ ] No unnecessary refactoring
- [ ] Debug-friendly code
- [ ] Proper error handling
- [ ] Resource disposal correct

**Test Coverage:**
- [ ] New features have tests
- [ ] Edge cases covered
- [ ] Platform-specific tests included

**Approval:**
- [✓] Approved for commit
- [✗] Needs revision: [specific issues]

---

## Deployment

**Deployment Executed By:** [Gemini / User (if Gemini failed)]

**Pre-Deployment:**
- Git status: [clean / uncommitted changes]
- Branch: [name]
- All tests passing: [✓/✗]
- Builds successful: [✓/✗]

**Deployment Steps:**
```bash
# Build release
flutter build [platform] --release
# Result: [✓/✗]

# Deploy command (project-specific)
[deployment commands]
# Result: [✓/✗]

# Smoke tests
[basic functionality checks]
# Result: [✓/✗]
```

**Deployment Details:**
- Target environment: [dev/staging/production]
- Build number: [version+build]
- Deployment time: [timestamp]
- Status: [✓ Success / ✗ Failed]

**If Deployment Failed:**
- Error: [description]
- Logs: [relevant log output]
- Escalation: User deployed manually
- User deployment status: [✓/✗]

**Post-Deployment Verification:**
- [ ] App launches successfully
- [ ] Critical flows work (list: [flows])
- [ ] No crashes in smoke tests
- [ ] Monitoring setup: [what's being monitored]

---

## User Final Test

**Tested By:** [User name]
**Test Date:** [date]

**Platforms Tested:**
- [ ] Android (device: [model], OS: [version])
- [ ] iOS (device: [model], OS: [version])
- [ ] macOS (OS: [version])
- [ ] Windows (OS: [version])
- [ ] Linux (OS: [version])
- [ ] Web (browser: [name+version])

**Functional Tests:**
- [ ] Feature works as specified
- [ ] No regressions in existing functionality
- [ ] Offline functionality maintained (if applicable)
- [ ] Performance acceptable
- [ ] UI/UX as expected

**Test Results:**
| Test Case | Status | Notes |
|-----------|--------|-------|
| [Test 1]  | [✓/✗]  | [notes] |
| [Test 2]  | [✓/✗]  | [notes] |
| [Test 3]  | [✓/✗]  | [notes] |

**Issues Found:**
1. **[Issue Title]**
   - Severity: [Critical/High/Medium/Low]
   - Description: [details]
   - Resolution: [what was done]

**Overall Status:**
- [✓] Approved - Ready for production
- [✗] Rejected - Needs fixes: [list issues]
- [~] Approved with minor issues: [list issues to fix later]

**User Notes/Feedback:**
[Any additional notes or feedback from user testing]

---

## Summary & Next Steps

**What Was Accomplished:**
- [Bullet point summary]
- [Bullet point summary]

**Commits:**
- Total commits: [count]
- All with `-g`/`-c`/`-a` markers: [✓/✗]

**Quality Metrics:**
- Tests: [X passed / Y total]
- Coverage: [X%]
- Platforms verified: [X of Y]
- Deployment: [✓/✗]
- User acceptance: [✓/✗]

**Known Issues/Limitations:**
- [Issue 1]
- [Issue 2]

**Future Work:**
- [ ] [Enhancement 1]
- [ ] [Enhancement 2]

**Documentation Updated:**
- [ ] CLAUDE.md (if architecture changed)
- [ ] GEMINI.md (if workflow changed)
- [ ] README.md (if needed)
- [ ] Other: [specify]

**Task Complete:** [✓/✗]
