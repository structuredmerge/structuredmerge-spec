## Slice 955: Ruby Class and Instance Method Signature Merge

Distinguish class methods from instance methods when matching direct methods
inside a matched Ruby class/module declaration.

### Why

- method matching by bare method name collapses `def call` and `def self.call`
- template-only class methods must not be dropped just because the destination
  already has an instance method with the same name
- this is the first method matching refinement before broader fuzzy matching

### Rules

1. direct methods are matched by receiver-aware signature
2. `def self.name` and `def name` are different method signatures
3. destination-owned methods preserve their source text
4. template-only class methods are inserted using the same declaration-body
   placement rules as template-only instance methods
