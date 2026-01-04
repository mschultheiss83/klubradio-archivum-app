---
description: Generate a structured consultation request to start Codex agent
---

You are the **Claude Agent** (Orchestrator) preparing a consultation request for **Codex Agent** (Expert Consultant).

**IMPORTANT**: Codex is cost-limited. Only use for:
- Complex architectural decisions
- Security/performance deep-dives
- Critical code reviews
- Alternative approach evaluation

Generate a focused consultation message:

---

**CONSULTATION REQUEST FOR CODEX**

**Issue/Task**: [Brief title]

**Consultation Type**: [Concept Design / Code Review / Architecture Evaluation / Security Analysis / Performance Analysis]

**Context**: [What's been done so far, why expert input is needed]

**Your Role**: Codex (Expert Consultant)
- Provide strategic guidance
- Evaluate alternatives
- Identify risks and trade-offs
- Recommend best approach
- NO implementation (Gemini handles that)

**Specific Questions**:
1. [Focused question 1]
2. [Focused question 2]
3. [Focused question 3]

**Current State**:
- Implementation status: [Not started / In progress / Review needed]
- Files involved: [key files]
- Existing solutions considered: [list]

**Claude's Initial Analysis** (in `docs/agent-outputs/[filename].md`):
- [Finding 1]
- [Finding 2]
- [Uncertainty that requires expert input]

**Architectural Context**:
- Affected layers: [UI / Provider / Service / Repository / DB]
- Data flows: [which flows are impacted]
- Platform scope: [Android / iOS / Web / Desktop / All]
- Offline-first implications: [describe]

**Evaluation Criteria**:
- Performance impact
- Security implications
- Maintainability
- Cross-platform compatibility
- Alignment with existing patterns

**Files for Review** (if code review):
- `[file path]`: [lines] - [what to evaluate]
- `[file path]`: [lines] - [what to evaluate]

**Expected Output**:
Add your analysis to `docs/agent-outputs/[filename].md`:

```markdown
## Codex Analysis

### Strategic Recommendation
[Clear recommendation with rationale]

### Alternative Approaches Evaluated
1. **Approach A**: [pros/cons]
2. **Approach B**: [pros/cons]
3. **Recommended**: [which and why]

### Critical Risks Identified
- [Risk 1]: [severity] - [mitigation]
- [Risk 2]: [severity] - [mitigation]

### Architecture Considerations
- [Consideration 1]
- [Consideration 2]

### Security/Performance Notes
[Detailed analysis if applicable]

### Implementation Guidance for Gemini
[Specific technical recommendations]
```

**Commit Marker**: `-a` (if creating commits)

**Handoff**: Your analysis will be used by Claude to orchestrate Gemini's implementation.

---

**Instructions for User**:
Copy the consultation request above and paste it into Codex/OpenAI chat to request expert analysis.

**Budget Note**: Codex usage is tracked. Use strategically for high-value consultation.
