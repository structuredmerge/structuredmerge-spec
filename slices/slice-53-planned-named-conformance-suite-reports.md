# Slice 53: Planned Named Conformance Suite Reports

## Goal

Report aggregate suite-descriptor plans while preserving suite identity.

## Scope

- compose suite-descriptor plan entries with the existing planned-suite report
  helper
- preserve stable ordering from aggregate planning
- avoid rebuilding aggregate suite reporting in each host language

## Contract

This slice defines one small aggregate suite-descriptor report contract:

1. a planned suite-descriptor report helper consumes ordered suite-descriptor
   plan entries
2. it reports each plan through the existing planned-suite report helper
3. it returns ordered suite-descriptor report entries

## Shared Fixture

- `named-suite-report-entries.json`
