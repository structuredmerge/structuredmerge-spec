# Slice 04: JSON And JSONC Parse Contracts

## Goal

Connect `tree-haver` and `json-merge` through a real parse contract.

## Planned Scope

- strict JSON parse result
- JSONC comments acceptance
- trailing-comma rejection as a diagnostic outcome
- shared fixture corpus for parse acceptance and rejection

## Shared Behavior

This slice defines a small, portable parse contract:

1. `json` rejects comments
2. `jsonc` accepts line and block comments
3. both `json` and `jsonc` reject trailing commas
4. a rejected parse reports a `parse_error` diagnostic

The implementation may preprocess JSONC comments before handing off to a
host-language JSON parser, but it must not silently repair trailing commas.

## Shared Types

- `JsonDialect`
- `JsonAnalysis`
- `parse_json` or equivalent host-language function

## Intended Outputs

- parser-facing diagnostic mapping
- first real `tree-haver` integration points
- deterministic acceptance and rejection behavior from shared fixtures
