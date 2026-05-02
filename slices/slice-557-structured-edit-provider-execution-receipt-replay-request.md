# Slice 557: Structured Edit Provider Execution Receipt Replay Request

## Goal

Standardize a replay request built from one provider execution receipt.

## Shared Behavior

This slice defines one shared receipt replay-request contract:

1. the request carries one shared provider execution receipt,
2. the request declares an explicit replay mode,
3. request metadata may remain visible without changing the receipt payload.

## Notes

- This slice standardizes replay-request shape, not executor replay behavior.
