---
description: Commit and push (cap). Usage: /cap <commit message>
---

Launch a **background agent** to commit and push. Use the Agent tool with `run_in_background: true` and the following prompt:

---

You are performing a **commit and push** operation in: `C:/tmp/Klubradio/klubradio-archivum-app/klubradio_archivum`

Commit message: **$ARGUMENTS**

## Steps

1. **Pre-flight checks** (run in parallel):
   - `git status` — if there are NO changes, return "Nothing to commit." and stop.
   - `flutter analyze` — must pass with 0 issues. If issues found, attempt to fix them once. If still failing, return the issues and stop.
   - `flutter test` — all tests must pass. If tests fail, return which tests failed and stop.

2. **Stage files**:
   - Stage all modified and untracked files relevant to the changes.
   - Do NOT stage files that contain secrets (.env, credentials, etc.).
   - Prefer staging specific files over `git add -A`.

3. **Commit**:
   - Use the commit message above.
   - ALWAYS append ` -c` at the end (agent marker convention for this project).
   - Do NOT add "Co-Authored-By" or "Generated with Claude Code" signatures.
   - Use a HEREDOC for the commit message.

4. **Push**:
   - Run `git push`.
   - If push fails, return the error. Do NOT force push.

## On failure

- **Analyze fails**: Show issues, attempt fix, re-analyze. If still failing, stop and report.
- **Tests fail**: Stop immediately. Report which tests failed.
- **Commit fails** (pre-commit hook): Show output, attempt fix with NEW commit. If fix fails, stop.
- **Push fails**: Report error. No --force.

## Return format

Return a short summary: what was committed, commit hash, push result, or what failed and why.
