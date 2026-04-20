# Slice 190: Canonical Widened-Suite Polyglot Backend Reviewed Default

## Goal

Prove that reviewed-default replay remains stable when canonical widened-suite
review uses the polyglot `yaml` backend.

## Contract

1. reviewed-default replay preserves the same state transitions
2. the `yaml` family review context advertises `backend:
   "kreuzberg-language-pack"`
3. the `yaml` family review context advertises `supports_dialects: false`
4. reviewed-default diagnostics remain unchanged apart from the explicit `yaml`
   backend context
