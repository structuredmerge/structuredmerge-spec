# Slice 706: Ruby Gemspec Version Loader Policy Acceptance

## Goal

Define provider-neutral native policy behavior for gemspec version-loader
rewrites when runtime context is supplied by a wrapper.

## Shared Behavior

This slice covers single-file version-loader policy:

1. runtime context supplies `min_ruby`, `entrypoint_require`, and `namespace`,
2. Ruby floors at or above the modern threshold inline the anonymous-module
   `Kernel.load` expression directly into `spec.version`,
3. older Ruby floors keep or insert a `gem_version` preamble and set
   `spec.version = gem_version`,
4. project identity and runtime context derivation remain wrapper
   responsibilities.

## Notes

- This slice does not require the native tool to infer namespace or require
  paths from project files.
- The policy is deterministic once runtime context is supplied.
