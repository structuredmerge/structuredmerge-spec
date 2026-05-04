# Slice 704: Ruby Gemspec Dependency Section Policy Acceptance

## Goal

Define provider-neutral native policy behavior for gemspec dependency-section
normalization.

## Shared Behavior

This slice covers single-file dependency-section harmonization:

1. dependency declarations are identified by method and gem name,
2. runtime dependencies shadow development dependencies for the same gem,
3. shadowed development dependency blocks are deleted,
4. runtime dependency blocks that appear after the development-dependency note
   block are relocated before that note block,
5. destination-only development dependencies that are not shadowed are preserved,
6. attached dependency comments move with their dependency declaration.

## Notes

- Resolver-backed `# ruby >= ...` comment alignment remains wrapper work.
- This slice does not require package-index or Bundler resolution.
