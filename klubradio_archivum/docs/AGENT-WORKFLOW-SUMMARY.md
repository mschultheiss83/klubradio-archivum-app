# Multi-Agent Workflow - Quick Reference

## Agent Roles

| Agent | Role | Cost | When to Use | Commit Marker |
|-------|------|------|-------------|---------------|
| **Claude** | Orchestrator | Free | Always (started by user) | `-c` |
| **Gemini** | Primary Worker | Free | Default for code/build/test/deploy | `-g` |
| **Codex** | Expert Consultant | Paid | Concept, review, critical thinking | `-a` |
| **User** | Tester & Coordinator | - | Final test, manual deploy if needed | - |

## Workflow Steps

```
1. User → Reviews issue/task
2. User → Starts Claude with task description
3. Claude → Analyzes & decides agents (Gemini default, Codex sparingly)
4. Claude → Starts agent instances (parallel/sequential)
5. Agents → Work (code, tests)
6. Agents → Validate: flutter analyze + flutter test + builds
7. Claude → Reviews test results, approves or requests fixes
8. Agents → Commit with marker: git commit -m "Message -g/-c/-a"
9. Gemini → Deploys (dev/staging)
10. If deploy fails → User deploys manually
11. User → Final tests & approval
```

## Commit Convention

**ALWAYS use agent markers:**
```bash
git commit -m "Add playlist feature -g"           # Gemini
git commit -m "Orchestrate multi-platform -c"     # Claude
git commit -m "Review security concerns -a"       # Codex
```

## Test Requirements

**Before EVERY commit:**
- ✓ `flutter analyze` must be clean
- ✓ `flutter test` must pass (all green)
- ✓ Relevant platform builds must succeed

## Output Files

**One file per issue/task:**
```
docs/agent-outputs/[issue-id or task-name].md
```

**Structure:**
- Claude's Orchestration Plan
- Codex Analysis (if used)
- Gemini Implementation
- Test & Validation Results
- Deployment Status
- User Final Test

## API Cost Management

- **Gemini**: Free → Use frequently, default worker
- **Codex**: Paid → Use strategically for concept/review/critical thinking
- **Claude**: Can start multiple instances of all agents
- **Escalation**: Claude escalates to User when API limits reached

## Error Handling

- Test fails → Agent fixes (max 2 iterations) → Escalate to User
- Build fails → Gemini fixes, Claude reviews → Codex if complex → User if stuck
- Deploy fails → User deploys manually
- API limit → Claude switches agents or escalates to User

## Quick Commands

```bash
# Check issues
gh issue list --label 'apple*'

# Start work
git checkout -b feature/task-name

# Test before commit
flutter analyze
flutter test

# Commit with marker
git commit -m "Your message -g"

# Push
git push origin feature/task-name
```

## Files to Reference

- **agent.md** - Full protocol details
- **CLAUDE.md** - Claude's context
- **GEMINI.md** - Gemini's context (if exists)
- **docs/agent-outputs/** - Coordination workspace
