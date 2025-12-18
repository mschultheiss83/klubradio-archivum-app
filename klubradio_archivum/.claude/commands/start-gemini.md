---
description: Generate a structured task message to start Gemini agent
---

You are the **Claude Agent** (Orchestrator) preparing a task for **Gemini Agent** (Primary Worker).

Generate a complete, structured task message that the user can copy-paste to start Gemini:

---

**TASK FOR GEMINI**

**Issue/Task**: [Brief title]

**Context**: [1-2 sentence summary of what needs to be done]

**Your Role**: Gemini (Primary Worker)
- Implement the solution
- Create/update tests
- Validate with `flutter analyze` and `flutter test`
- Build for relevant platforms
- Commit with `-g` marker
- Report results

**Claude's Analysis** (orchestration plan available in `docs/agent-outputs/[filename].md`):
- [Key finding 1]
- [Key finding 2]
- [Key finding 3]

**Implementation Steps**:
1. [Specific step with file references]
2. [Specific step with commands]
3. [Specific step for testing]
4. [Specific step for commit]

**Files to Modify**:
- `[file path]`: [what to change]
- `[file path]`: [what to change]

**Platform Target(s)**: [Android / iOS / Web / Desktop / All]

**Validation Checklist** (MUST complete before commit):
```bash
flutter analyze                    # Must be clean
flutter test                       # All tests green
flutter build [platform] --debug   # Relevant platforms
```

**l10n Required**: [Yes/No] - [If yes, update all 4 languages: hu, de, en, ro]

**Drift Schema Changes**: [Yes/No] - [If yes, run: dart run build_runner build --delete-conflicting-outputs]

**Critical Considerations**:
- [Architecture consideration]
- [Platform-specific requirement]
- [Performance/security note]

**Expected Output**:
Update `docs/agent-outputs/[filename].md` with your implementation section:
- Code changes (files, lines)
- Test results
- Build verification
- Any issues encountered

**Git Workflow**:
```bash
git checkout dev
git pull origin dev
git checkout -b feature/[feature-name]
# ... implement ...
git commit -m "feat: [description] -g"
```

**Commit Marker**: `-g` (MANDATORY)

**Questions/Blockers**: If you encounter architectural uncertainty, platform entitlements issues, or need Claude review, document in the output file and escalate.

---

**Instructions for User**:
Copy the task message above and paste it into Gemini's chat to start the implementation.
