# Slice 56: Named Conformance Suite Report Manifest

## Goal

Report all eligible suite descriptors for a manifest through one helper.

## Scope

- compose aggregate planning with aggregate suite-descriptor reporting
- preserve stable suite ordering
- return the aggregate report envelope

## Contract

This slice defines one small manifest-wide reporting contract:

1. a manifest-wide report helper consumes a manifest, family plan contexts, and one execution callback
2. it plans eligible suite descriptors through the aggregate planning helper
3. it reports them through the aggregate suite-descriptor reporting helper
4. it returns the aggregate report envelope

## Shared Fixture

- `named-suite-report-manifest.json`
