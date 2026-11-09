---
name: fix-bugs-root-cause
description: >-
  Fixes bugs by reproducing them with a failing test, tracing the root cause
  with file:line evidence, and applying the smallest fix at the owning
  boundary. Use when the user reports a bug, error, crash, regression, failing
  test, stack trace, or unexpected behavior, or asks to debug or fix something.
---

# Fix bugs at the root cause

## Workflow

Copy and track:

```
- [ ] 1. Reproduce with a failing test
- [ ] 2. Find the root cause
- [ ] 3. Apply the smallest fix
- [ ] 4. Verify
- [ ] 5. Search for the same pattern
```

**1. Reproduce.** Write a test that reproduces the bug, run it, and show it fails for the expected reason (an assertion, not a setup error). Do not change production code yet. Place the test with the existing tests for that code, following project naming. If a test is impractical (UI, infra, timing), write the smallest reproducible script or steps instead and say why.

**2. Root cause.** Trace from the input to the first incorrect state, citing file:line at each hop. List plausible hypotheses and the observation that confirms or rules out each. Separate evidence from guesses. State the cause in 2–3 sentences before editing.

**3. Fix.** Make the smallest change at the boundary that owns the bug, and explain why it doesn't break other callers. No unrelated refactoring, renaming, or formatting. No public API or schema changes without asking.

**4. Verify.** Show the reproducing test now passes, then run the full relevant suite.

**5. Same pattern elsewhere.** Search for other occurrences and list them. Do not fix them unless asked.

## Forbidden

- Deleting, skipping, or loosening assertions
- Catching and ignoring the exception
- Adding sleeps, retries, or longer timeouts to hide the problem
- Claiming a fix without running the test

## Stop and ask when

- The bug can't be reproduced or may be environmental: report what evidence is missing.
- The fix needs data repair, a migration, production access, or an off-limits change.
- The expected behavior itself seems wrong.

## Report

- Root cause (2–3 sentences, with file:line)
- Files changed, one-line reason each
- Test commands and results, before and after
- Other occurrences of the same pattern
