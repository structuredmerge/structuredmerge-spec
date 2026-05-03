# Slice 685: Structured Edit Callable Destination Request Transport Rejection

## Goal

Standardize rejection for unsupported callable-destination request envelopes.

## Shared Behavior

This slice defines one shared rejection surface:

1. import rejects envelopes with the wrong kind,
2. import rejects envelopes with an unsupported version,
3. the rejection reports the transport error without mutating the request.

## Notes

- This slice hardens the transport layer introduced in slice 684.
