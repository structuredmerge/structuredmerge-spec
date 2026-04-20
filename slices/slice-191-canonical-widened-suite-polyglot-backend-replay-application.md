# Slice 191: Canonical Widened-Suite Polyglot Backend Replay Application

## Goal

Prove that replay application remains stable when canonical widened-suite review
uses the polyglot `yaml` backend.

## Contract

1. replay application preserves the same final review state
2. the `yaml` family review context advertises `backend:
   "kreuzberg-language-pack"`
3. the `yaml` family review context advertises `supports_dialects: false`
4. replay diagnostics remain unchanged apart from the explicit `yaml` backend
   context
