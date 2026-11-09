---
name: record-architecture-decisions
description: >-
  Drafts architecture decision records (ADRs) that coding agents can implement
  from, and checks code changes against accepted ADRs for architectural drift.
  Use when choosing between technologies or designs, introducing a new
  dependency, pattern, service, or data store, changing module boundaries, or
  when the user mentions ADRs, architecture decisions, or architectural drift.
---

# Architecture decision records

## Find the existing setup

Look for an ADR folder (`docs/adr/`, `docs/adrs/`, `doc/architecture/decisions/`, `adr/`) and follow its numbering, format, and status conventions. If none exists, propose `docs/adr/` in MADR format and ask before creating it.

## Draft an ADR

Before writing, get answers from the conversation or by asking:

1. What is being decided? Use a verb-phrase title ("Adopt X", "Replace Y with Z").
2. Why now? What breaks or stays blocked if nothing changes?
3. Constraints: stack, existing code, team, budget, compliance.
4. Measurable success criteria (latency, cost, maintenance burden).
5. At least two options and their core trade-offs.
6. Non-goals.

Template:

```markdown
# NNNN. <Title>

Status: proposed
Date: YYYY-MM-DD

## Context

## Decision
<Specific and actionable: "PostgreSQL 16 with pgvector", not "a database".>

## Options considered
### <Option>: pros / cons

## Consequences
<Positive, negative, and follow-up work.>

## Non-goals

## Implementation plan
- Affected paths:
- Patterns to follow (link example files):
- Things to avoid:
- Tests to add:

## Verification
- [ ] <Checkable criterion, ideally by a command or lint rule>
```

Rules:

- Always create with **Status: proposed**. Only the user changes it to accepted.
- No placeholder text; remove optional sections rather than leave them empty.
- Where a constraint can be enforced mechanically (import boundaries, banned dependencies), suggest the linter rule or architecture test that enforces it.

## Check a change for drift

1. List ADRs with their statuses and read the ones relevant to the diff. Only **accepted** ADRs are binding; mention conflicts with proposed ones as notes.
2. Compare the diff against each relevant ADR's Decision and Consequences sections.
3. Report each violation: ADR id, the quoted rule, file:line, and a suggested fix.
4. Say whether the change introduces a decision that needs a new ADR (new dependency, data store, service, cross-module pattern, or boundary change).
