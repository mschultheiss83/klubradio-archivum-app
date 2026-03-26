---
description: Commit and push (cap). Usage `/cap` <commit message>
---

Commit and push with message: **$ARGUMENTS**

## Steps

1. **Pre-flight checks** (run in parallel):
   - `git status` — if there are NO changes, tell the user and stop.

2. **Stage files**:
   - Stage all modified and untracked files that are relevant to the changes.
   - Do NOT stage files that contain secrets (.env, credentials, etc.).
   - Prefer staging specific files over `git add -A`.

3. **Commit**:
   - Use the commit message above.
   - ALWAYS append ` -c` at the end (agent marker convention for this project).
   - Do NOT add "Co-Authored-By" or "Generated with Claude Code" signatures.
   - Use a HEREDOC for the commit message to preserve formatting.

4. **Push**:
   - Run `git push`.
   - If push fails, report the error and stop. Do NOT force push.

## On failure

- **Analyze fails**: Show issues, attempt fix, re-analyze. If still failing, stop and report.
- **Tests fail**: Stop immediately. Report which tests failed.
- **Commit fails** (pre-commit hook): Show output, attempt fix with NEW commit (never amend). If fix fails, stop.
- **Push fails**: Report error. No --force.
