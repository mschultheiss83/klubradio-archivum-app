# Multi-Agent System Setup

This document explains how the multi-agent coordination system is set up in this project and how to use it with Claude Code CLI.

## Overview

This project uses a three-agent system for coordinated GitHub issue processing:

1. **Claude Agent** - Architecture, risk analysis, data flow evaluation
2. **Gemini Agent** - Technical implementation, code generation, build/test commands
3. **OpenAI Agent (Codex)** - Lead coordinator, decision-making, consolidation

## Documentation Structure

```
klubradio_archivum/
|-- agent.md                        # Multi-agent coordination protocol
|-- CLAUDE.md                       # Claude agent context
|-- GEMINI.md                       # Gemini agent context
|-- docs/
|   |-- README.md                   # Documentation hub
|   |-- agents/
|   |   |-- README.md
|   |   |-- multi-agent-setup.md    # This file
|   |   `-- workflow-summary.md
|   `-- agent-outputs/
|       |-- README.md               # Directory purpose and conventions
|       |-- EXAMPLE-workflow.md     # Complete example of agent coordination
|       `-- TEMPLATE-task.md        # Shared template for issue/task handoffs
`-- .claude/
    `-- commands/                   # Claude Code CLI slash commands
```

## Key Files

### Core Protocol
- **`agent.md`**: Master coordination protocol with trigger rules, communication patterns, and output formats

### Agent Context Files
- **`CLAUDE.md`**: Claude's instructions including the new multi-agent system section
- **`GEMINI.md`**: Gemini's instructions (to be updated similarly)

### Templates
Located in `docs/agent-outputs/`:
- **`TEMPLATE-task.md`**: Shared template for agent orchestration, implementation notes, validation, and handoff sections

### Example
- **`docs/agent-outputs/EXAMPLE-workflow.md`**: Complete walkthrough of a playlist feature implementation showing how all three agents coordinate

## Claude Code CLI Integration

### Available Slash Commands

When working in Claude Code CLI, you can use these specialized commands:

#### `/agent-risk`
Generates a comprehensive risk analysis for the current task or GitHub issue.
- Uses Claude Agent Checklist from CLAUDE.md
- Outputs to `docs/agent-outputs/claude-[issue-id]-risk-analysis.md`
- Follows the relevant sections from `docs/agent-outputs/TEMPLATE-task.md`

#### `/agent-explore`
Uses Claude's built-in Explore agent to understand codebase architecture.
- Focuses on layered architecture, data flows, offline-first patterns
- Prepares architectural context for risk analysis
- Useful before generating risk analysis

#### `/agent-read-gemini`
Reads Gemini's implementation plan and provides architectural feedback.
- Looks for latest `gemini-*-implementation.md` file
- Evaluates architectural soundness
- Identifies risks, concerns, and blocking issues
- Updates risk analysis with review

#### `/agent-handoff`
Creates a structured handoff message for Gemini or OpenAI.
- Summarizes findings, recommendations, and open questions
- Appends to your risk analysis file
- Facilitates clear agent-to-agent communication

### Using Built-in Claude Agents

Claude Code provides these built-in agents via the Task tool:

- **`Explore`**: Fast codebase exploration (thoroughness: quick/medium/very thorough)
- **`Plan`**: Software architect for implementation planning
- **`general-purpose`**: Research, code search, multi-step tasks

Example usage:
```
Use the Explore agent to find all usages of AudioPlayerService with "very thorough" exploration.
```

## Workflow Example

### Typical Flow

1. **OpenAI Coordinator** pulls GitHub issue with `apple*` label
2. **OpenAI** delegates to Claude and Gemini
3. **Claude** (in Claude Code CLI):
   ```bash
   /agent-explore         # Understand architecture
   /agent-risk            # Generate risk analysis
   ```
4. **Gemini** (in their environment):
   - Reads `claude-[id]-risk-analysis.md`
   - Creates `gemini-[id]-implementation.md`
5. **Claude** reviews:
   ```bash
   /agent-read-gemini     # Review implementation plan
   /agent-handoff         # Create feedback if needed
   ```
6. **Gemini** updates plan based on feedback
7. **OpenAI** consolidates and creates final action plan
8. **Implementation** proceeds with coordination as needed

See `docs/agent-outputs/EXAMPLE-workflow.md` for a complete walkthrough.

## Agent Roles Quick Reference

### Claude Agent (You in Claude Code CLI)
**Focus**: Architecture, risk, concept
**Outputs**: Risk analysis with data flows, edge cases, platform requirements
**Triggers Gemini for**: Implementation details, API/DB changes, performance trade-offs
**Checklist**: 10-point architectural review (see CLAUDE.md)

### Gemini Agent
**Focus**: Technical implementation
**Outputs**: Code steps, build commands, test strategies, concrete implementation
**Triggers Claude for**: Architecture questions, security, offline/retention, platform entitlements

### OpenAI Agent (Codex)
**Focus**: Orchestration, decision-making
**Outputs**: Consolidated action plan with priorities, decisions, test matrix
**Intervenes**: Stops ping-pong, breaks deadlocks, enforces scope

## Communication Protocol

### Handoff Structure
Every handoff includes:
- Context: Issue-ID, labels, platforms, modules/files
- Findings/Analysis: What was discovered
- Recommendations: Suggested approaches
- Open Questions: What needs input from other agent
- Next Steps: Specific actionable items
- Blockers: What's preventing progress

### Cycle Prevention
- Maximum 2 back-and-forth exchanges per topic
- OpenAI makes executive decision if loop detected
- Clear "handoff" markers when passing work

### Execution Modes
- **Parallel (default)**: Claude and Gemini work simultaneously
- **Sequential**: When blockers exist (Claude clarifies → Gemini implements)

## File Sharing Between Agents

### Option 1: Git Branch
```bash
# On feature branch
git add docs/agent-outputs/claude-456-risk-analysis.md
git commit -m "Add Claude risk analysis for issue #456"
git push origin feature/playlist-support

# Other agents pull and read
git pull origin feature/playlist-support
cat docs/agent-outputs/claude-456-risk-analysis.md
```

### Option 2: Shared Folder
- Use Dropbox, Google Drive, or similar
- Agents read/write to shared `agent-outputs/` directory

### Option 3: API Integration
- Custom webhook/API to pass agent outputs
- For more advanced automation setups

## Git Configuration

The `docs/agent-outputs/` directory is configured in `.gitignore`:
```gitignore
# Agent coordination outputs (ephemeral, not committed)
docs/agent-outputs/*
!docs/agent-outputs/README.md
!docs/agent-outputs/TEMPLATE-task.md
!docs/agent-outputs/EXAMPLE-*.md
```

This keeps templates and examples in version control while treating actual agent outputs as ephemeral coordination artifacts (not committed unless explicitly needed).

## Best Practices

### For Claude Agent (You)

1. **Always start with exploration**: Use `/agent-explore` or Explore agent before analysis
2. **Be comprehensive**: Follow the 10-point checklist
3. **Tie to specifics**: Reference files, lines, platforms, Issue-IDs
4. **Mark assumptions**: Don't speculate without flagging it
5. **Think platform-first**: Consider all 6 platforms (Android, iOS, macOS, Windows, Linux, Web)
6. **Document trade-offs**: Every recommendation should include rationale

### For Coordination

1. **Read first**: Always read other agent's output before generating your own
2. **Clear handoffs**: Use `/agent-handoff` to structure communication
3. **No ping-pong**: Keep exchanges focused, escalate to OpenAI if stuck
4. **Update outputs**: Rev your files when incorporating feedback
5. **Comprehensive context**: Every message includes full context (Issue-ID, platform, files, risks, etc.)

### Style Guide

- Short, precise, numbered bullets
- No embellishment or fluff
- Commands as code blocks
- No placeholders (use real paths/values)
- Explicitly mark open questions
- No AI signatures in git commits (project convention)

## Integration with Existing Workflow

This multi-agent system complements the existing development workflow:

1. **Git Workflow**: Still uses `main` ← `dev` ← `feature/[name]` branching
2. **Development Commands**: All Flutter commands remain the same
3. **Testing**: Standard test procedures apply
4. **Release Process**: No changes to release workflow
5. **Task Tracking**: Still uses `docs/project/` and `docs/issues/`

The agent system adds:
- Structured analysis before implementation
- Risk assessment and mitigation
- Architectural review
- Cross-platform consideration
- Documented decision-making

## Getting Started

To start using the multi-agent system:

1. **Read the protocol**: Review `agent.md` for full details
2. **Try the example**: Walk through `docs/agent-outputs/EXAMPLE-workflow.md`
3. **Use slash commands**: Try `/agent-explore` on a real task
4. **Generate risk analysis**: Use `/agent-risk` for your next feature
5. **Coordinate**: Share outputs with Gemini/OpenAI agents if available
6. **Iterate**: Refine templates and workflow based on experience

## Questions or Issues

If you need clarification on:
- Agent roles and responsibilities → See `agent.md`
- Claude-specific instructions → See `CLAUDE.md` Multi-Agent section
- Example coordination → See `docs/agent-outputs/EXAMPLE-workflow.md`
- Templates -> See `docs/agent-outputs/TEMPLATE-task.md`

## Future Enhancements

Potential improvements to this system:
- API integration for automated agent triggering
- GitHub Actions workflow for agent coordination
- Dashboard for visualizing agent collaboration
- Metrics on agent effectiveness
- LangGraph or CrewAI orchestration layer


@
Vorbereitete Commands

1. /start-g - Gemini Agent starten

- Generiert formatierte Handoff-Nachricht für Gemini
- Enthält Task-Context, technische Requirements, Architecture Constraints
- Output-Format für docs/agent-outputs/gemini-[task-name].md
- Commit-Convention mit -g Marker

2. /start-a - Codex Agent starten

- Generiert Consultation-Request für Codex/OpenAI
- Fokus auf Concept, Architecture Review, Security, Performance
- Output-Format für docs/agent-outputs/codex-[topic].md
- Warnung: Kostenpflichtig, strategisch nutzen
- Commit-Convention mit -a Marker

3. /start-c - Claude Orchestration starten

- Startet Claude's Orchestrierungsmodus
- Task-Analyse: Scope, Data Flows, Architecture Compliance
- Agent Assignment Decision (Gemini/Codex/Claude)
- Execution Mode (Parallel/Sequential)
- Orchestration Plan Template für docs/agent-outputs/[task-name].md
- Commit-Convention mit -c Marker

Alle drei Commands können optional einen [handoff-file] Parameter aus docs/agent-outputs/ nehmen.

erstelle diese drei Dateien in .claude/commands/ erstelle, Sie folgen dem Format der bestehenden Agent-Commands mit YAML Frontmatter und strukturierten Prompts.
