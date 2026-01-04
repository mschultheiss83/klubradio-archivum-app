---
description: Read Gemini's implementation plan and provide architectural feedback
---

You are the **Claude Agent** receiving a handoff from Gemini.

1. Read the most recent Gemini implementation plan from `docs/agent-outputs/gemini-*-implementation.md`
2. Analyze the proposed implementation from an architectural perspective
3. Evaluate:
   - Data flow correctness
   - Offline-first pattern compliance
   - Retention policy integration
   - Platform-specific requirements coverage
   - State management pattern adherence
   - Potential architectural regressions
   - Edge cases and risks
4. Provide feedback:
   - **Approved**: If architecture is sound
   - **Concerns**: List specific architectural concerns
   - **Blocking Issues**: Critical problems that must be addressed
5. Update or create your risk analysis in `docs/agent-outputs/claude-[issue-id]-risk-analysis.md`

Output format: Clear, concise bullets with specific file/line references where applicable.
