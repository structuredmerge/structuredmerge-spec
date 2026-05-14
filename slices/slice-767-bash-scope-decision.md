# Slice 767: Bash Scope Decision

## Goal

Decide whether old `bash-merge` behavior belongs in the current source family,
a future shell family, or should be retired.

## Evidence

The old `reference/bash-merge` package contains real Bash-specific merge value:

- tree-sitter-bash parsing through TreeHaver backends;
- line-bound statement ownership;
- function, assignment, command, pipeline, conditional, and loop signatures;
- shebang-aware script handling;
- hash-comment attachment and preservation;
- conservative inline comment handling;
- template-only node insertion;
- duplicate template preamble corruption handling;
- freeze marker and freeze block support;
- multi-backend execution across MRI, FFI, Rust, and Java TreeHaver backends.

No active Bash or shell package exists today under `ruby/gems`, `go`,
`rust/crates`, or `typescript/packages`, and no active shell fixtures were found
under `fixtures` or `spec/slices`.

## Decision

Bash belongs to a future shell family, not the current source/Ruby family, and
is not retired.

Do not include `bash-merge` as a current generated README support claim until a
shell family package and fixture-backed contract exist. The old README and old
specs are migration source material for later shell work.

The current source family is not the right destination because the old Bash
behavior is shell-script-specific: statement identity, shebangs, commands,
pipelines, shell loops, hash comments, and shell freeze markers are not Ruby
source semantics.

## Future Fixture Order

Recommended future order:

1. Parse/profile metadata for shell scripts with tree-sitter-bash.
2. Statement identity for functions, assignments, and commands.
3. Shebang and document boundary handling.
4. Comment attachment and conservative inline comment preservation.
5. Template-only function, assignment, and command insertion.
6. Freeze markers and freeze blocks.
7. Pipelines, conditionals, and loop identity.
8. Duplicate template preamble corruption handling.
9. Backend/provider compatibility across available TreeHaver-style adapters.

Until those fixtures exist, generated READMEs should mention Bash only as a
future or unresolved shell package, not active supported behavior.
