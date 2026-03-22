---
description: Commit and push (cap). Usage: /cap <commit message>
---

You are performing a **commit and push** operation. The user's argument is the commit message.

## Steps

1. **Pre-flight checks** (run in parallel):
   - `git status` — check for uncommitted changes. If there are NO changes (nothing to commit), tell the user and stop.
   - `flutter analyze` — must pass with 0 issues. If issues found, fix them first, then re-analyze.
   - `flutter test` — all tests must pass. If tests fail, stop and report which tests failed.

2. **Stage files**:
   - Stage all modified and untracked files that are relevant to the changes.
   - Do NOT stage files that contain secrets (.env, credentials, etc.).
   - Prefer staging specific files over `git add -A`.

3. **Commit**:
   - Use the user's argument as commit message.
   - ALWAYS append ` -c` at the end (agent marker convention for this project).
   - Do NOT add "Co-Authored-By" or "Generated with Claude Code" signatures.
   - Use a HEREDOC for the commit message to preserve formatting.

4. **Push**:
   - Run `git push`.
   - If push fails (e.g. remote rejected, auth error, network), report the error and stop. Do NOT force push.

## On failure at any step

- **Analyze fails**: Show the issues, attempt to fix them, re-run analyze. If still failing after one fix attempt, stop and show the user the remaining issues.
- **Tests fail**: Stop immediately. Show which tests failed and the error output. Do NOT commit.
- **Commit fails** (e.g. pre-commit hook): Show the hook output. Attempt to fix the issue and create a NEW commit (never amend). If fix fails, stop and report.
- **Push fails**: Show the error. Do NOT retry with --force. Let the user decide next steps.

In all failure cases, clearly state what failed and why so the user can decide how to proceed.

## Example usage

```
/cap fix: resolve double-encoding bug in search API
```

Results in commit message: `fix: resolve double-encoding bug in search API -c`
