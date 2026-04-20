# Slice 187: Canonical Widened-Suite Polyglot Backend Plans

## Goal

Prove that canonical widened-suite planning remains stable when the `yaml`
family is explicitly bound to the shared polyglot backend.

## Contract

1. canonical widened-suite planning still returns the same ordered suite entries
2. the `yaml` family plan context advertises `backend:
   "kreuzberg-language-pack"`
3. the `yaml` family plan context advertises `supports_dialects: false`
4. all other family contexts remain unchanged from the canonical widened-suite
   backend plan baseline
