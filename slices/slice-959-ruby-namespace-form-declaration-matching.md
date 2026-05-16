## Slice 959: Ruby Namespace Form Declaration Matching

Match a nested namespace declaration in the template with an equivalent qualified
destination declaration while preserving the destination declaration form.

### Why

- Ruby code commonly alternates between `module Admin; class User` and
  `class Admin::User`
- declaration matching by raw local path misses this semantic equivalence
- namespace matching should preserve destination layout and only project
  template-owned body members into the matched destination declaration

### Rules

1. nested template declarations expose a qualified declaration merge identity
2. qualified destination declarations can match that identity
3. destination declaration spelling and source text shape are preserved
4. a template namespace wrapper that only contained matched nested declarations
   is not appended as an unmatched declaration
