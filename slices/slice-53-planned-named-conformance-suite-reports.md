# Slice 53: Planned Named Conformance Suite Reports

## Goal

Report aggregate named-suite plans while preserving suite identity.

## Scope

- compose named-suite plan entries with the existing planned-suite report helper
- preserve stable ordering from aggregate planning
- avoid rebuilding aggregate suite reporting in each host language

## Contract

This slice defines one small aggregate named-suite report contract:

1. a planned named-suite report helper consumes ordered named-suite plan entries
2. it reports each plan through the existing planned-suite report helper
3. it returns ordered named-suite report entries

## Shared Fixture

- `named-suite-report-entries.json`
