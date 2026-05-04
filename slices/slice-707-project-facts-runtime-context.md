# Slice 707: Project Facts Runtime Context

## Goal

Define a provider-neutral runtime-context handoff for project facts supplied by
wrappers, so native content recipe policies can consume resolver and project
metadata without owning discovery.

## Shared Behavior

This slice covers external fact handoff for native policies:

1. wrappers may provide a `project_facts` object in `runtime_context`,
2. each fact has a stable `fact_id`, `subject_kind`, `subject`, `value`,
   `source`, and `confidence`,
3. native policies may consume supplied facts deterministically,
4. native policies fail closed with `configuration_error` when a required fact
   is missing,
5. fact discovery, resolver execution, and project metadata derivation remain
   wrapper responsibilities.

## Notes

- This slice does not require native tools to resolve dependency metadata from
  package registries.
- Ruby gemspec dependency floor comment alignment is native only after a
  wrapper supplies dependency floor facts.
- The fact envelope is intentionally provider-neutral; Ruby-specific subjects
  are examples of facts, not the schema boundary.
