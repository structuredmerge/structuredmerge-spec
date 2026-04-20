# Slice 183: YAML Polyglot Backend Feature Profiles

## Goal

Expose a polyglot `tree-haver` YAML backend alongside the existing family-local
YAML parsers.

## Shared Behavior

This slice defines one YAML backend-plurality extension contract:

1. `yaml-merge` MAY expose `kreuzberg-language-pack` as a YAML backend,
2. that backend remains a family-level YAML backend even though its parser
   infrastructure comes from `tree-haver`,
3. the feature profile for `kreuzberg-language-pack` reports
   `supports_dialects = false`.
