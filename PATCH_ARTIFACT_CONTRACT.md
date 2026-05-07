# Patch Artifact Contract

`structuredmerge.patch.v1` is the first portable apply artifact shape. It
records what would change without implying that any repository, filesystem, or
remote workspace has been mutated.

## Shape

```json
{
  "kind": "structuredmerge.patch.v1",
  "format": "json",
  "change_count": 2,
  "changes": []
}
```

Fields:

- `kind`: literal contract identifier.
- `format`: input family or syntax label used to produce the patch.
- `change_count`: number of entries in `changes`.
- `changes`: ordered change records.

## Change Records

The initial change vocabulary is JSON Pointer-like:

```json
{
  "operation": "replace",
  "path": "/name",
  "before": "old",
  "after": "new"
}
```

Allowed operations:

- `add`
- `remove`
- `replace`

Implementations may add family-specific metadata later, but the base fields
above must remain readable by generic clients.

## Apply Semantics

Producing this artifact does not mutate a repository. Any API or CLI response
that returns this artifact should make mutation state explicit, for example with
`repository_mutated: false`.

Repository-writing apply is a separate, policy-gated workflow and must not be
implied by this contract.
