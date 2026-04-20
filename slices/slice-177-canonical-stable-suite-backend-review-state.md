# Slice 177: Canonical Stable-Suite Backend Review State

## Goal

Review the canonical stable suite set through alternate TOML and YAML backends
on each host.

## Shared Behavior

This slice defines one language-local canonical review-state contract:

1. alternate TOML and YAML backends preserve the same stable-suite review-state
   surface,
2. replay context and host hints remain unchanged,
3. backend-specific config-family contexts flow through the review state without
   introducing review requests when explicit contexts are already provided.
