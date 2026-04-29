# Slice 437: Structured Edit Envelope Application

## Goal

Expose structured-edit application payloads through the supported transport
envelope.

## Shared Behavior

This slice defines one narrow application contract:

1. a supported structured-edit transport envelope may be imported,
2. the imported payload yields the same structured-edit application shape as
   the direct shared object,
3. rejected envelopes preserve the hard edge defined by slice 436.

## Notes

- This slice standardizes envelope application shape, not shared runtime
  execution.
