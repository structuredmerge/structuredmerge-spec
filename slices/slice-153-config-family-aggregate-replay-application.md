# Slice 153: Config-Family Aggregate Replay Application

## Goal

Replay a bundled review decision against the aggregate config-family review
state.

## Shared Behavior

This slice defines one aggregate replay-application contract:

1. the aggregate config-family review surface MAY accept a replay bundle,
2. the replay bundle MAY apply the same review decision as an inline review
   interaction,
3. the resulting reviewed state remains identical to the equivalent inline
   reviewed-default state.
