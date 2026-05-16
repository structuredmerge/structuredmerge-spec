## Slice 948: Ruby Existing Protected Section Method Merge

Insert template-only protected methods into an existing destination protected
section without duplicating the section marker.

### Why

- slice 947 preserves template-owned protected sections when the destination has
  no matching section
- existing destination protected sections should receive template-only protected
  methods as method text only

### Rules

1. a template-only method under a direct template `protected` section is
   protected
2. if the matched destination declaration already has a direct `protected`
   section, insert the template-only protected method as method text only
3. destination-owned protected methods preserve their source text and order
4. inserted method text preserves the template method indentation

### Notes

- This mirrors slice 946 for `protected`.
