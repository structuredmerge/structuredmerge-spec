# Slice 937: Ruby Prism Parse Error Projection

## Status

Accepted for Ruby-first implementation.

## Context

Slices 935 and 936 establish Prism normalized parse projection for valid Ruby
source. Ruby tooling also needs a stable failure shape for invalid source so
CLI, git, HTTP, and template flows do not consume raw Prism error objects.

## Contract

When Prism cannot parse Ruby source, the normalized parse API returns:

- `ok: false`,
- no root id,
- no normalized nodes,
- provider capability metadata,
- parse-error tolerance metadata,
- `source_fragments_available: false`, and
- Prism error messages as diagnostics.

The provider may keep native Prism error objects internally, but downstream
callers consume the normalized report.

## Fixtures

The conformance fixture is
`fixtures/ruby/slice-937-prism-parse-error-projection/missing-end-normalized-error.json`.
