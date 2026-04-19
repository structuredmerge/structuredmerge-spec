# Slice 40: Planned Conformance Suite Runner

## Goal

Define a normalized runner that executes an already-planned conformance suite.

## Scope

- execute only planned suite entries
- preserve the plan entry order
- keep planning distinct from execution

## Contract

This slice defines one small planned-suite runner contract:

1. a planned-suite runner consumes one `ConformanceSuitePlan`
2. the runner executes the plan's ordered `entries` and ignores
   `missing_roles`
3. each plan entry is executed through its enclosed `run`
4. the output is an ordered list of `ConformanceCaseResult`
5. planned-suite execution is equivalent to running the entry runs through the
   existing suite runner

## Shared Fixture

- `planned-suite-runner.json`

## Notes

- This slice is an execution layer above slice-39 planning.
- It deliberately reuses existing case-runner and suite-runner semantics rather
  than introducing a new outcome model.
