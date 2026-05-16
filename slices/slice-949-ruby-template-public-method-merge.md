## Slice 949: Ruby Template Public Method Merge

Insert a template-only method under a direct template `public` section without
transporting a redundant public marker into a destination class/module body that
has default public visibility.

### Why

- private and protected sections carry semantic visibility changes
- a leading `public` section in otherwise default-public class bodies is often
  incidental style
- inserting the method only preserves behavior while avoiding noisy marker
  duplication

### Rules

1. a template-only method under a direct template `public` section is public
2. if the matched destination declaration has no direct visibility section
   before the insertion point, insert the method body text without the `public`
   marker
3. destination-owned methods preserve their source text
4. inserted method text preserves template method indentation

### Notes

- Existing destination public-section merge remains a separate fixture.
