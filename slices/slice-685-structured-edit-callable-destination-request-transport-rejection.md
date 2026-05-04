# Slice 685: Structured Edit Request Transport Rejection

## Goal

Standardize rejection for unsupported structured edit request envelopes.

## Shared Behavior

This slice defines one shared rejection surface:

1. import rejects envelopes with the wrong kind,
2. import rejects envelopes with an unsupported version,
3. the rejection reports the transport error without mutating the request.

## Notes

- This slice hardens the generic request transport layer introduced in slice
  684.
