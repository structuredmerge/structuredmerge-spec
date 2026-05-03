# Slice 582: Structured Edit Provider Execution Receipt Replay Workflow Transport Envelope

## Goal

Standardize a versioned transport envelope for one provider execution receipt
replay workflow.

## Shared Behavior

This slice extends the shared replay-workflow contract:

1. exporting a replay workflow yields an envelope with a stable `kind`,
2. the envelope carries one shared replay-workflow record,
3. importing a supported envelope round-trips the replay-workflow record.

## Notes

- This slice standardizes replay-workflow transport, not replay execution.
