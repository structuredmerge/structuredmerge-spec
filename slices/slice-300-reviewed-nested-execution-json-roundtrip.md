# Slice 300: Reviewed Nested Execution JSON Roundtrip

## Goal

Prove that reviewed nested execution inputs can be serialized and deserialized
without changing the execution contract.

## Scope

- round-trip one reviewed nested execution payload through JSON
- preserve family, delegated-child review state, and applied child outputs
- keep the transport shape language-neutral

## Contract

This slice defines one JSON round-trip contract:

1. exported reviewed nested execution inputs may be serialized to JSON and read
   back again
2. the deserialized value is observably equivalent to the original input
3. the round-trip does not alter nested execution semantics

## Shared Fixture

- `reviewed-nested-execution-json-roundtrip.json`
