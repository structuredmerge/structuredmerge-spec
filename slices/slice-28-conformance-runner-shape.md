# Slice 28: Conformance Runner Shape

## Goal

Define a normalized runner shape for cross-language conformance execution.

## Scope

- define a minimal runner vocabulary
- describe how fixtures, roles, and outcomes are reported
- keep the runner shape separate from any one test framework

## Contract

This slice defines one minimal reporting contract:

1. a conformance runner reports each executed case through a stable case
   reference
2. the case reference identifies the family, role, and fixture case name
3. each reported case has a normalized outcome
4. each reported case may carry zero or more diagnostic messages intended for
   human-readable failure context
5. the runner shape is descriptive and transportable; it does not prescribe a
   specific assertion library or test runner

## Shared Types

- `ConformanceCaseRef`
- `ConformanceOutcome`
- `ConformanceCaseResult`

## Notes

- This slice is intentionally smaller than a full reusable runner
  implementation.
- It gives the current fixture-driven test suites one normalized reporting
  target without forcing any repo to adopt a shared executable harness yet.
