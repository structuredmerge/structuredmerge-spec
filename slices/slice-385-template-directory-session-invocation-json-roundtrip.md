# Slice 385: Template Directory Session Invocation JSON Roundtrip

## Goal

Prove that top-level template-directory session invocation inputs can be
serialized and deserialized without changing the execution contract.

## Scope

- round-trip one session invocation payload through JSON
- preserve operation, nested `payload` or `request`, and flat invocation fields
- keep the transport shape language-neutral

## Contract

This slice defines one JSON round-trip contract:

1. exported session invocation inputs may be serialized to JSON and read back
   again
2. the deserialized value is observably equivalent to the original invocation
3. the round-trip does not alter whether the invocation routes through the
   nested-command or flat-command-payload path

## Shared Fixture

- `template-directory-session-invocation-json-roundtrip.json`
