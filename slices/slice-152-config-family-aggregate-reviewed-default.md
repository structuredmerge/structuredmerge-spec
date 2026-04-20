# Slice 152: Config-Family Aggregate Reviewed Default

## Goal

Apply an explicit review decision to the aggregate config-family review state.

## Shared Behavior

This slice defines one aggregate reviewed-default contract:

1. a host MAY accept a synthesized default family context during review,
2. the accepted decision becomes an applied decision in the review state,
3. the aggregate report then includes the newly activated suite results.
