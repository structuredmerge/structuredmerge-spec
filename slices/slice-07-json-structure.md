# Slice 07: JSON Structural Analysis

## Goal

Move from parse acceptance to merge-relevant JSON structure.

## Planned Scope

- object and array owner selection
- structural node wrappers
- stable match-key candidates for JSON object members
- fixture cases for object and array analysis

## Shared Behavior

This slice defines a small structural-analysis contract over successfully parsed
JSON or JSONC documents:

1. the analysis exposes a `root_kind`
2. every object member is a merge-relevant owner
3. every array element is a merge-relevant owner
4. owners expose a stable path using JSON Pointer-style notation
5. object members expose a `match_key` equal to the member key
6. array elements expose no match key

## Shared Types

- `JsonRootKind`
- `JsonOwnerKind`
- `JsonOwner`
- `analyze_json_structure` or equivalent host-language function

## Why This Slice Exists

Parse acceptance alone is not enough to support merge semantics. This slice is
intended to connect the parse contract from slice 04 to future JSON merge
behavior without collapsing immediately into full merge logic.
