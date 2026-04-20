# Slice 180: Canonical Widened-Suite Backend Review State

## Goal

Review the canonical widened suite set through alternate TOML and YAML
backends.

## Shared Behavior

This slice defines one language-local widened review-state contract:

1. alternate TOML and YAML backends preserve the widened review-state surface,
2. backend-sensitive source-family review behavior remains unchanged,
3. explicit config-family contexts suppress review requests for those families.
