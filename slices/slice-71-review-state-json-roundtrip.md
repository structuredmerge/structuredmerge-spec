# Slice 71: Review State JSON Roundtrip

## Goal

Prove that review state can be serialized and deserialized without losing the
observable contract.

## Scope

- round-trip one emitted review state through JSON
- preserve diagnostics, requests, applied decisions, host hints, and replay
  context
- keep the transport shape language-neutral

## Contract

This slice defines one JSON round-trip contract:

1. exported review state may be serialized to JSON and read back again
2. the deserialized value is observably equivalent to the original review state
3. the round-trip does not alter replay-safety semantics

## Shared Fixture

- `review-state-json-roundtrip.json`
