# Slice 701: Ruby Gemspec Native Boundary Report

## Goal

Classify kettle-jem's gemspec merge behavior into provider-neutral native
recipe primitives and behavior that still requires a project wrapper.

## Shared Behavior

This slice defines the native boundary for Gem::Specification-like Ruby source:

1. declaration signatures for `Gem::Specification.new`, field assignments,
   operator writes, metadata assignments, and dependency calls are portable,
2. bounded single-file field replacement/insertion is portable when replacement
   values are already supplied,
3. placeholder-aware `summary` and `description` preservation is portable as a
   named native policy,
4. `spec.files = Dir[...]` literal-list union and duplicate field cleanup are
   portable as named native policies,
5. dependency section normalization is portable when it only depends on
   template/destination/merged content,
6. version-loader rewrite is portable when runtime inputs are supplied,
7. deriving runtime inputs, dependency floor comments, README emoji context,
   bootstrap fallbacks for malformed files, and project-specific package policy
   remain wrapper responsibilities.

## Notes

- The shared product API should not expose kettle-jem's Ruby scripts.
- A wrapper such as kettle-jem may still be necessary to gather project context,
  call external resolvers, and decide which native policy steps to run.
