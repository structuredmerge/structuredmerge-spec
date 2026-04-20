# Slice 169: Backend-Sensitive Aggregate Native Report

## Goal

Report the backend-sensitive aggregate manifest through native source-family
contexts.

## Shared Behavior

This slice defines one backend-sensitive aggregate native-report contract:

1. stable config-family suites continue to report normally,
2. unrestricted source-family roles continue to report normally,
3. native-only source-family parity roles report as ordinary passed cases when
   the matching native backend is active.
