# Slice 560: Structured Edit Provider Execution Receipt Replay Request Envelope Application

## Goal

Standardize applying one imported provider execution receipt replay-request
envelope back to the shared replay-request contract.

## Shared Behavior

This slice defines shared replay-request envelope application behavior:

1. importing a supported envelope yields one shared replay request,
2. the nested execution receipt remains unchanged,
3. existing wrong-kind and unsupported-version rejection behavior remains
   visible during replay-request envelope application.

## Notes

- This slice standardizes envelope application, not executor replay execution.
