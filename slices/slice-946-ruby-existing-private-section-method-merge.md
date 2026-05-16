## Slice 946: Ruby Existing Private Section Method Merge

Insert template-only private methods into an existing destination private
section without duplicating the section marker.

### Why

- slice 945 preserves template-owned private sections when the destination has
  no matching section
- when the destination already has a direct `private` section, duplicating the
  marker is noisy and weakens formatting preservation

### Rules

1. a template-only method under a direct template `private` section is private
2. if the matched destination declaration already has a direct `private` section,
   insert the template-only private method as method text only
3. destination-owned private methods preserve their source text and order
4. inserted method text preserves the template method indentation

### Notes

- This slice does not yet decide ordering within multiple visibility sections.
