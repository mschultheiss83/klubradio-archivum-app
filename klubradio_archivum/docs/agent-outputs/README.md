# Agent Outputs Directory

This directory is used for coordination between the three AI agents (Claude, Gemini, OpenAI/Codex) when processing GitHub issues.

## Purpose

Agents write their analysis outputs to this directory in markdown format for coordination and review by other agents and developers.

## File Naming Convention

**One file per issue/task** with sections for each agent:
- `[issue-id].md` - For GitHub issues (e.g., `456.md`)
- `[task-name].md` - For tasks without GitHub issue (e.g., `playlist-feature.md`)

**File Structure:**
Each file contains these sections:
1. **Claude's Orchestration Plan** - Task analysis, agent assignments, risk assessment
2. **Codex Analysis** (if triggered) - Concept/design, code review, recommendations
3. **Gemini Implementation** - Code changes, tests, builds, platform-specific work
4. **Test & Validation Results** - All test outputs, Claude's review checkpoint
5. **Deployment** - Deployment execution and results
6. **User Final Test** - User testing and approval

**Template:** Use `TEMPLATE-task.md` as starting point

## Workflow

1. **User** reviews issue/task
2. **User** starts **Claude** with task description
3. **Claude** creates orchestration plan in `[issue-id].md`
4. **Claude** triggers agents (Gemini primary, Codex if needed)
5. **Agents** write to their sections in same file:
   - **Codex** (if used): Analysis section
   - **Gemini**: Implementation section
6. **Agents** run tests and validate
7. **Claude** reviews results in Test & Validation section
8. **Agents** commit with markers (-g/-c/-a)
9. **Gemini** deploys, writes Deployment section
10. **User** tests, writes User Final Test section

## Example File Structure

For Issue #456 (Add playlist feature):

```markdown
# Task: Add Playlist Feature - Issue #456

## Claude's Orchestration Plan
- Complexity: Medium
- Agents: Gemini (primary), Codex (for architecture review)
- Execution: Sequential (Gemini implements → Codex reviews → Gemini adjusts)
- Platforms: All (Android, iOS, macOS, Windows, Linux, Web)
- Risk: Medium (new DB table, provider chain update)

## Codex Analysis
- Reviewed Gemini's proposed schema
- Recommended: Use separate PlaylistDao
- Security: No concerns
- Performance: Acceptable
- Approval: ✓ Approved

## Gemini Implementation
- Created: lib/services/playlist_service.dart
- Created: lib/providers/playlist_provider.dart
- Modified: lib/db/database.dart (added Playlists table)
- Tests: 12 new tests, all passing
- Builds: ✓ All platforms successful
- Commits: 3 commits with -g marker

## Test & Validation Results
- flutter analyze: ✓ Clean
- flutter test: ✓ 127/127 passed
- Builds: ✓ All 6 platforms
- Claude Review: ✓ Approved

## Deployment
- By: Gemini
- Target: dev
- Status: ✓ Success

## User Final Test
- Tested: Android, iOS, macOS
- Status: ✓ Approved
```

## Git Ignore

This directory's content is not committed to version control (see `.gitignore`). Outputs are ephemeral coordination artifacts.
