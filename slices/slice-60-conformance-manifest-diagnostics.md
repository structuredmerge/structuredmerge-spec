# Slice 60: Conformance Manifest Diagnostics

## Goal

Expose manifest-level diagnostics alongside aggregate named-suite reporting.

## Scope

- preserve the existing aggregate named-suite report envelope
- add one outer manifest-report layer with diagnostics
- surface assumed defaults and configuration errors explicitly

## Contract

This slice defines one small manifest-report contract:

1. a manifest report contains `report` and `diagnostics`
2. `report` is the existing named-suite report envelope
3. `diagnostics` records assumed defaults and configuration errors discovered
   during aggregate planning

## Shared Fixture

- `conformance-manifest-report.json`
