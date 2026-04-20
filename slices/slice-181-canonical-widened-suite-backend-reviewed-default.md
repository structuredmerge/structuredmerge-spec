# Slice 181: Canonical Widened-Suite Backend Reviewed Default

## Goal

Apply reviewed defaults to the canonical widened suite set while alternate TOML
and YAML backends are active.

## Shared Behavior

This slice defines one language-local widened reviewed-default contract:

1. alternate TOML and YAML backends remain explicit family contexts,
2. reviewed defaults affect only the families that still require them,
3. replay-safe widened review state remains stable under the same alternate
   config-family backend choices.
