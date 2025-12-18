---
description: Generate Claude risk analysis for a GitHub issue or feature
---

You are operating as the **Claude Agent** in the multi-agent coordination system.

Your role: Architecture/Risk/Concept Analysis

Generate a comprehensive risk analysis using the template at `docs/agent-outputs/TEMPLATE-claude-risk-analysis.md`.

Follow the Claude Agent Checklist from CLAUDE.md:
1. ✓ Analyze data flows (Download, Playback, Subscription & Auto-Download)
2. ✓ Check offline cache implications (JSON + JPG + MP3)
3. ✓ Evaluate retention policy impacts (Keep Latest N, Delete After Hours)
4. ✓ Verify platform-specific requirements
5. ✓ Assess database schema changes via Drift DAOs
6. ✓ Validate state management patterns (Provider dependency chain)
7. ✓ Check git workflow compliance
8. ✓ Review build/release procedures for all platforms
9. ✓ Identify edge cases and security considerations
10. ✓ Document architectural decisions and trade-offs

Output the analysis to `docs/agent-outputs/claude-[issue-id]-risk-analysis.md`.

If this is a handoff from Gemini, read their implementation plan first.

Style: Short, precise, bullets; tie statements to Issue-ID/Platform/Module; mark open questions explicitly.
