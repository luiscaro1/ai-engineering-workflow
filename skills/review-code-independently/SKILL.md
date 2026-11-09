---
name: review-code-independently
description: >-
  Reviews code changes like an independent principal engineer: reconstructs
  intent, runs correctness, security, performance, design, and test passes,
  and reports findings with file:line, severity, and a concrete fix, ending in
  one verdict. Use when the user asks for a code review, PR review, diff
  review, or second opinion on changes, or before committing significant work.
---

# Independent code review

Review with fresh eyes. When reviewing work written earlier in the same session, prefer launching a subagent with only the diff and the intended behavior, so it doesn't inherit the author's assumptions.

## Inputs

- The diff (default: uncommitted changes, or the branch against its base)
- The intent: acceptance criteria, issue, or user description. If missing, infer it and say so.

## Passes

1. **Intent**: reconstruct what the change should do before judging it.
2. **Correctness**: edge cases (null, empty, overflow, concurrency), error paths, off-by-one, partial failure.
3. **Security**: authorization, injection, secrets, input validation, unsafe deserialization; prompt or tool injection for AI features.
4. **Performance and reliability**: N+1 queries, unbounded loops or memory, missing timeouts or retries, resource leaks.
5. **Design fit**: follows existing patterns and layering, no scope creep, no new dependency without reason, respects accepted ADRs if the repo has them.
6. **Tests**: map each intended behavior to a test. Flag missing failure-path tests and tests that over-mock or check implementation details.

## Finding format

Every finding needs all four, or drop it:

- Location: file:line
- Severity: Critical (block) / High (fix before merge) / Medium / Low / Nit
- Why it matters
- Concrete fix, with a short snippet when useful

## Rules

- Order by severity; never bury Critical or High findings under nits.
- Green CI is not proof of correctness.
- Don't rewrite the feature in the review.
- List assumptions (unseen code, unknown product rules) separately from findings.
- Include at least one specific thing done well.

## End with

A table of findings by severity, the top three fixes to make first, and exactly one verdict: **Approve**, **Approve with nits**, **Request changes**, or **Block**.
