# Slice 697: Content Recipe Execution Envelope

## Goal

Define a provider-neutral envelope for executing one resolved template content
string against one destination content string through an ordered recipe step
pipeline.

## Shared Behavior

This slice defines one shared content recipe execution surface:

1. a request envelope identifies the recipe, target file, provider/parser family,
   template content, destination content, ordered steps, and runtime context,
2. a recipe step is declarative data, not arbitrary executable script text,
3. a report envelope records the original request, final content, changed status,
   diagnostics, and one report per step,
4. step reports record status, changed state, input content, output content,
   diagnostics, and optional structured-edit application/provenance metadata,
5. the surface is scoped to in-memory single-file execution and does not include
   token resolution, file discovery, or directory write orchestration.

## Notes

- This is the executable-contract bridge after the kettle-jem primitive gap
  report from slice 696.
- `smart_merge`, `partial_merge`, `structured_edit`, and `native_policy` are
  step kinds in the recipe pipeline. Concrete execution semantics land in later
  acceptance slices.
- `ruby_script` is intentionally absent from the shared step-kind vocabulary.
