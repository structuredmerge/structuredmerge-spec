# Slice 533: Structured Edit Provider Execution Invocation

## Goal

Standardize a provider-execution invocation that presents one provider
execution handoff as an explicit runnable executor call boundary.

## Shared Behavior

This slice defines one shared execution-invocation contract:

1. the invocation carries one provider execution handoff,
2. the handoff remains visible without flattening its underlying shared plan
   and dispatch contracts,
3. invocation metadata may remain visible without changing the handoff
   payload.

## Notes

- This slice is the first shared executor-call surface after provider handoff.
- It keeps the future `ast-crispr` runner boundary explicit without hardcoding
  a Ruby-only executor API.
