# Slice 55: Named Conformance Suite Report Envelope

## Goal

Define the manifest-wide report envelope for ordered suite-descriptor report
entries.

## Scope

- preserve ordered suite-descriptor report entries
- attach one aggregate manifest-wide summary
- avoid inventing a second summary vocabulary

## Contract

This slice defines one small aggregate report envelope contract:

1. a suite-descriptor report envelope contains `entries` and `summary`
2. `entries` is an ordered list of suite-descriptor report entries
3. `summary` is produced by the aggregate named-suite summary helper

## Shared Fixture

- `named-suite-report-envelope.json`
