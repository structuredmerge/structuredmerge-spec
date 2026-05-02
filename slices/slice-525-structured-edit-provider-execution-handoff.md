# Slice 525: Structured Edit Provider Execution Handoff

## Goal

Standardize a provider-execution handoff that binds one resolved execution plan
to one concrete dispatch record ready for executor handoff.

## Shared Behavior

This slice defines one shared execution-handoff contract:

1. the handoff carries one provider execution plan,
2. the handoff carries one provider execution dispatch,
3. the plan and dispatch remain visible together without flattening either
   underlying shared contract,
4. metadata may remain visible without changing the plan or dispatch payloads.

## Notes

- This slice is the bridge between provider planning and actual executor
  handoff for a future `ast-crispr` runner.
- It standardizes handoff shape, not execution output.
