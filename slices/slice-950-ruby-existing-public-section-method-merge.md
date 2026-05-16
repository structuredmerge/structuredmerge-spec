## Slice 950: Ruby Existing Public Section Method Merge

Insert template-only public methods into an existing destination public section
without duplicating the section marker.

### Why

- slice 949 elides redundant template `public` markers for default-public class
  bodies
- destination code may intentionally reopen public visibility after private or
  protected methods
- template-only public methods should join that explicit destination section
  when it exists

### Rules

1. a template-only method under a direct template `public` section is public
2. if the matched destination declaration already has a direct `public` section,
   insert the template-only public method as method text only
3. destination-owned public methods preserve their source text and order
4. inserted method text preserves the template method indentation

### Notes

- This completes the initial private/protected/public visibility-section
  transport set.
