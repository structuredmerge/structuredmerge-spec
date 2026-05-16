## Slice 945: Ruby Template-Owned Private Method Merge

Preserve a template-owned private visibility section when inserting
template-only methods into a matched class/module body.

### Why

- slice 942 prevents public template methods from being inserted under
  destination private/protected sections
- template-owned private methods need the inverse protection: they must not
  become public when inserted into a destination class without a private section

### Rules

1. a template-only method under a direct template `private` section carries that
   section marker when inserted
2. inserted private-section text preserves the template source indentation and
   blank-line shape
3. destination-owned methods preserve their source text
4. this slice covers `private`; `protected`, `public`, and existing destination
   visibility-section merging remain future fixtures

### Notes

- This slice models the first visibility-section transport contract, not a full
  Ruby visibility normalizer.
