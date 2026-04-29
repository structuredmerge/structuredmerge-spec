# Slice 424: Ruby Structured Edit Provider Profiles

## Goal

Project the shared structured-edit profile contracts onto the Ruby provider
surface.

## Shared Behavior

This slice defines one Ruby provider-profile contract:

1. the Ruby provider projects the shared structured-edit structure profile,
2. it may expose comment-region-aware selection through shared selection and
   match profiles,
3. it keeps the shared Ruby family identity while surfacing provider-local
   metadata.

## Notes

- The expected first native provider is the Prism-backed Ruby surface.
- This slice standardizes provider projection, not edit execution.
