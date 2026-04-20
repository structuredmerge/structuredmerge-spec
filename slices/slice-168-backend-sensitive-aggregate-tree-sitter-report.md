# Slice 168: Backend-Sensitive Aggregate Tree-Sitter Report

## Goal

Report the backend-sensitive aggregate manifest through tree-sitter-backed
source contexts.

## Shared Behavior

This slice defines one backend-sensitive aggregate reporting contract:

1. stable config-family suites continue to report normally,
2. unrestricted source-family roles continue to report normally,
3. native-only source-family parity roles become explicit skipped results when a
   tree-sitter-backed source context is active.
