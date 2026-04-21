# Slice 52: Planned Named Conformance Suite Runner

## Goal

Run aggregate suite-descriptor plans while preserving suite identity.

## Scope

- compose suite-descriptor plan entries with a shared execution callback
- preserve stable ordering from aggregate planning
- avoid rebuilding aggregate suite execution in each host language

## Contract

This slice defines one small aggregate suite-descriptor runner contract:

1. a planned suite-descriptor runner helper consumes ordered suite-descriptor
   plan entries
2. it executes each plan through the existing planned-suite runner helper
3. it returns ordered suite-descriptor results entries

## Shared Fixture

- `named-suite-runner-entries.json`
