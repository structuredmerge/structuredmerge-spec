# Slice 182: Canonical Widened-Suite Backend Replay Application

## Goal

Replay reviewed decisions into the canonical widened suite set while alternate
TOML and YAML backends are active.

## Shared Behavior

This slice defines one language-local widened replay contract:

1. replay application preserves the explicit alternate TOML and YAML backend
   choices,
2. replay compatibility continues to depend on the widened manifest replay
   context,
3. backend-sensitive source-family replay outcomes remain unchanged in the same
   widened surface.
