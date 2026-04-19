# Slice 56: Named Conformance Suite Report Manifest

## Goal

Report all eligible named suites for a manifest through one helper.

## Scope

- compose aggregate planning with aggregate named-suite reporting
- preserve stable suite ordering
- return the aggregate report envelope

## Contract

This slice defines one small manifest-wide reporting contract:

1. a manifest-wide report helper consumes a manifest, family plan contexts, and one execution callback
2. it plans eligible named suites through the aggregate planning helper
3. it reports them through the aggregate named-suite reporting helper
4. it returns the aggregate report envelope

## Shared Fixture

- `named-suite-report-manifest.json`
