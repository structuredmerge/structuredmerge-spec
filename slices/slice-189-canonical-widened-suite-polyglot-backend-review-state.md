# Slice 189: Canonical Widened-Suite Polyglot Backend Review State

## Goal

Prove that canonical widened-suite review-state generation remains stable when
the `yaml` family is bound to the polyglot backend.

## Contract

1. review-state generation preserves the same entry ordering and decision
   surfaces
2. the `yaml` family review context advertises `backend:
   "kreuzberg-language-pack"`
3. the `yaml` family review context advertises `supports_dialects: false`
4. diagnostics and review requests remain otherwise unchanged from the
   widened-suite backend review-state baseline
