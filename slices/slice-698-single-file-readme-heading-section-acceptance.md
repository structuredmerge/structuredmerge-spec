# Slice 698: Single-File README Heading-Section Acceptance

## Goal

Define a provider-neutral, single-file README templating acceptance fixture using
generic heading-section AST semantics.

## Shared Behavior

This slice defines one shared README recipe acceptance surface:

1. the template provides the structural skeleton,
2. destination bodies for selected heading sections are preserved under refreshed
   template headings,
3. non-preserved sections keep template content,
4. the template H1 wins when the destination H1 differs only by decorative
   leading adornment,
5. ambiguous heading-section matches fail closed without changing content.

## Notes

- The fixture uses `generic_ast` / `generic_heading_sections` labels rather than
  Markly, CommonMarker, Prism, or any other backend-specific API.
- This remains a content-recipe acceptance fixture. Native step execution
  details continue in follow-up slices.
- `ruby_script` is not part of the shared recipe surface.
