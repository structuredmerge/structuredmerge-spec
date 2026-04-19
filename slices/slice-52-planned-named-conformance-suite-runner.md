# Slice 52: Planned Named Conformance Suite Runner

## Goal

Run aggregate named-suite plans while preserving suite identity.

## Scope

- compose named-suite plan entries with a shared execution callback
- preserve stable ordering from aggregate planning
- avoid rebuilding aggregate suite execution in each host language

## Contract

This slice defines one small aggregate named-suite runner contract:

1. a planned named-suite runner helper consumes ordered named-suite plan entries
2. it executes each plan through the existing planned-suite runner helper
3. it returns ordered named-suite results entries

## Shared Fixture

- `named-suite-runner-entries.json`
