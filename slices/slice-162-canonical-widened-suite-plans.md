# Slice 162: Canonical Widened-Suite Plans

## Goal

Plan the canonical manifest after stable source-family suite promotion.

## Shared Behavior

This slice defines one canonical widened-suite planning contract:

1. the widened canonical manifest MAY be planned through explicit contexts for
   both stable config-family suites and stable source-family suites,
2. the resulting named-suite plans preserve the canonical suite ordering,
3. the widened canonical plan surface remains one manifest-level plan
   collection rather than separate config and source reports,
4. family-local nested Markdown or Ruby delegated suites remain outside that
   widened canonical plan surface until a later promotion slice adds them
   explicitly.
