---
name: write-meaningful-tests
description: >-
  Writes tests that catch real bugs: agrees on a behavior list first, tests
  through public APIs, mocks only external boundaries, and proves each test can
  fail. Supports test-driven development and diff-targeted tests. Use when
  writing or generating tests, increasing test coverage, doing TDD, or adding
  tests for a change.
---

# Write meaningful tests

The goal is tests that fail when behavior breaks, not a coverage number.

## Pick the mode

- **New code (TDD)**: behavior list, failing tests, implement, refactor.
- **Existing code**: behavior list, tests, prove they can fail.
- **A specific change**: diff-targeted tests (see below).
- **Legacy code nobody can specify**: characterization tests that pin current behavior. Flag suspicious behavior instead of "fixing" it.

## 1. Behavior list (no code yet)

For each public function, endpoint, or component under test, list behaviors grouped as:

- Happy path
- Boundaries (empty, zero, max, unicode)
- Invalid input
- Dependency failures (errors, timeouts, retries)
- State, where relevant (idempotency, caching, concurrency)

Each line: input → expected result. Mark any line where current behavior looks wrong as `BUG`. For non-trivial work, show the list to the user and wait for approval.

## 2. Write the tests

- One test per approved line; the test name restates the behavior.
- Go through the public API. Mock only external boundaries (database, network, clock, filesystem), never internal helpers or the unit itself.
- Assert outcomes, not implementation details.
- Follow the project's existing test location, naming, fixtures, and helpers.
- If a test fails, fix the test, not production code, unless its line is marked `BUG`.
- For TDD: run the tests and confirm they fail on assertions before implementing, then implement without modifying the tests.

## 3. Prove each test can fail

For each new test, break the behavior it checks (flip a condition, return early, drop a branch), run it, confirm it fails, then revert. Rewrite or delete any test that stays green.

If a mutation tool is available (Stryker, mutmut, PIT, cargo-mutants), run it on the changed file and add tests for surviving mutants.

## Diff-targeted tests

Read the diff and write tests that would fail on the old implementation and pass on the new one. Target new branches, new error cases, and changed return types. Name the branch each test covers.

## Report

- Behavior list, with the test name for each line
- Commands run and results
- Which tests failed when their behavior was deliberately broken
- Gaps intentionally left untested, and why
