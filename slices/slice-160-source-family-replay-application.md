# Slice 160: Source-Family Replay Application

## Goal

Replay a bundled review decision against the dedicated source-family review
state.

## Shared Behavior

This slice defines one source-family replay-application contract:

1. the source-family review surface MAY accept a replay bundle,
2. the replay bundle MAY apply the same review decision as an inline review
   interaction,
3. the resulting reviewed state remains identical to the equivalent inline
   reviewed-default state.
