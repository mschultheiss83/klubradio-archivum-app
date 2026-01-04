---
description: Create a handoff message for Gemini or OpenAI agents
---

You are the **Claude Agent** preparing a handoff.

Generate a structured handoff message for coordination:

**Handoff to**: [Gemini / OpenAI]

**Context**: [Brief summary of the issue/task and current state]

**Analysis Complete**:
- Data flow analysis: [summary]
- Risk assessment: [summary]
- Platform requirements: [summary]

**Key Findings**:
1. [Finding 1]
2. [Finding 2]
3. [Finding 3]

**Architectural Recommendations**:
1. [Recommendation 1 with rationale]
2. [Recommendation 2 with rationale]

**Open Questions** (need Gemini input):
- [Question 1]
- [Question 2]

**Critical Risks**:
- [Risk 1]: [mitigation strategy]
- [Risk 2]: [mitigation strategy]

**Files to Review**:
- `[file path]`: [lines] - [reason]
- `[file path]`: [lines] - [reason]

**Recommended Next Steps**:
1. [Step 1]
2. [Step 2]
3. [Step 3]

**Blockers**: [None / List blockers]

Append this handoff to your risk analysis file: `docs/agent-outputs/claude-[issue-id]-risk-analysis.md`
