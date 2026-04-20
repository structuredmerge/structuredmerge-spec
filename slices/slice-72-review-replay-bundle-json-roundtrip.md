# Slice 72: Review Replay Bundle JSON Roundtrip

## Goal

Prove that replay bundles can be transported as JSON without changing replay
inputs.

## Scope

- round-trip one replay bundle through JSON
- preserve replay context and decisions
- keep the result equivalent to the original bundle

## Contract

This slice defines one replay-bundle JSON contract:

1. a replay bundle may be serialized to JSON and deserialized again
2. the deserialized bundle is observably equivalent to the original
3. bundle JSON transport does not change replay-compatibility meaning

## Shared Fixture

- `review-replay-bundle-json-roundtrip.json`
