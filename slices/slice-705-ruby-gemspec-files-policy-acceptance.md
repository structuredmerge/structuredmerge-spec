# Slice 705: Ruby Gemspec Files Policy Acceptance

## Goal

Define provider-neutral native policy behavior for gemspec `spec.files`
harmonization.

## Shared Behavior

This slice covers single-file `spec.files` policies:

1. literal `spec.files = Dir[...]` assignments can be unioned across template,
   destination, and merged content,
2. literal entries keep attached comments while moving into the union,
3. duplicate `spec.files` assignments are cleaned up after selecting the best
   surviving assignment,
4. nonliteral destination file enumeration is a wrapper-selected path: the
   wrapper may choose to preserve destination structure and run only compatible
   native policies.

## Notes

- This is still deterministic single-file content recipe behavior.
- Deciding whether a destination nonliteral files assignment should bypass the
  normal smart-merge path remains wrapper policy.
