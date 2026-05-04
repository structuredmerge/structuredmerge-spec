# Slice 696: Kettle-Jem Templating Primitive Gap Report

## Goal

Capture the real-world `kettle-jem` single-file templating use case as a
provider-neutral primitive inventory before introducing executable recipe
contracts.

## Shared Behavior

This slice defines one shared gap-report surface:

1. the report identifies `reference/kettle-jem` as prior art, not as a shared
   Ruby API to port,
2. the report scopes the target to deterministic single-file content merging,
3. the report records which current structured-edit substrate capabilities are
   already available,
4. the report classifies required templating primitives as portable native
   primitives, named native policies, or unsupported shared API candidates,
5. the report states that Ruby-only `ruby_script` recipe steps must not become
   the shared product surface,
6. the report lists the next contract slices needed to reach executable
   templating parity across Go, Rust, TypeScript, and Ruby.

## Notes

- This slice is intentionally diagnostic/reporting only.
- The next implementation step is a provider-neutral content recipe step
  envelope, not a Prism/Markly projection API.
- `remove` remains conversational only; the canonical structured-edit operation
  kind remains `delete`.
