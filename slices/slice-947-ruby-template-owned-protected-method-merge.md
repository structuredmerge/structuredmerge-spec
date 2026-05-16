## Slice 947: Ruby Template-Owned Protected Method Merge

Preserve a template-owned protected visibility section when inserting
template-only methods into a matched class/module body.

### Why

- slices 945 and 946 cover private visibility transport and existing-section
  merge
- protected methods have the same structural requirement and should be covered
  before moving on to broader refiners

### Rules

1. a template-only method under a direct template `protected` section is
   protected
2. if the matched destination declaration has no direct `protected` section,
   insert the template-owned protected section marker with the method
3. destination-owned methods preserve their source text
4. inserted protected-section text preserves the template source indentation and
   blank-line shape

### Notes

- Existing destination protected-section merge is covered by a separate slice.
