# Slice 18: Policy Reporting

## Goal

Allow result contracts to expose active policy references.

## Planned Scope

- add optional policy reporting to parse and merge result contracts
- expose active policies on JSON merge results
- keep policy reporting structured and separate from diagnostics

## Shared Behavior

This slice defines a narrow reporting contract:

1. parse and merge results may expose zero or more active policy references
2. policy reporting is optional at the shared result-contract level
3. JSON merge results expose the baseline array policy
4. JSON merge results additionally expose the fallback policy when that recovery
   path is applied
5. diagnostics remain distinct from policy reporting

## Shared Types

- `ParseResult` with optional `policies`
- `MergeResult` with optional `policies`

## Notes

- This slice is about result reporting, not policy negotiation.
- Parse results are allowed to omit policies when no active policy surface is
  being reported yet.
