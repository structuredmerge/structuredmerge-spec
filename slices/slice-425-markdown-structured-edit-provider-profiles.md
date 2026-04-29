# Slice 425: Markdown Structured Edit Provider Profiles

## Goal

Project the shared structured-edit profile contracts onto the Markdown provider
surface.

## Shared Behavior

This slice defines one Markdown provider-profile contract:

1. the Markdown provider projects the shared structured-edit structure profile,
2. it may expose heading-owned section selection through shared selection and
   match profiles,
3. it keeps the shared Markdown family identity while surfacing provider-local
   metadata.

## Notes

- The expected first native provider is the Markly-backed Markdown surface.
- This slice preserves provider differences such as the lack of comment-region
  support without changing the shared contract shape.
