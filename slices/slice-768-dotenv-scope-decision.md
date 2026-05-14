# Slice 768: Dotenv Scope Decision

## Goal

Decide whether old `dotenv-merge` behavior is covered by plain text/config
aggregate work, needs a dedicated family, or should be retired.

## Evidence

The old `reference/dotenv-merge` package contains real dotenv-specific merge
value:

- line model for assignment, export assignment, comment, blank, and invalid
  lines;
- key/value parsing with empty values, quoted values, escaped double-quoted
  values, and `#` handling inside quoted and unquoted values;
- inline comment stripping only when `#` is separated as a comment;
- assignment identity by environment key;
- destination/template preference for matched keys;
- template-only entry insertion;
- destination heading, footer, grouped, and inline comment preservation;
- duplicate key comment association;
- freeze marker and freeze block support;
- reproducible fixtures for variable add/remove/change, exports, comments,
  duplicate keys, and quoted hash values.

No active dotenv package exists today under `ruby/gems`, `go`, `rust/crates`,
or `typescript/packages`.

## Decision

Dotenv needs a future dedicated dotenv/config-env family. It is not retired, and
it should not be treated as already covered by generic plain text/config
aggregate work.

The old behavior is too semantic for a plain line merge: it depends on dotenv
key identity, export prefixes, quoted value parsing, inline comments, duplicate
keys, and grouped comment association. Generic config work may share transport,
reporting, and merge operation shapes, but it should not claim dotenv behavior
without dotenv fixtures.

Do not include `dotenv-merge` as a current generated README support claim until
an active dotenv package and fixture-backed contract exist.

## Future Fixture Order

Recommended future order:

1. Env line parsing for assignment, export assignment, comment, blank, and
   invalid lines.
2. Value parsing for empty, single-quoted, double-quoted, escaped, and
   hash-bearing values.
3. Assignment identity by key, including duplicate key policy.
4. Matched-key preference and template-only entry insertion.
5. Header, footer, grouped, and inline comment preservation.
6. Freeze markers and freeze blocks.
7. Generated README examples for dotenv-specific configuration files.

Until those fixtures exist, generated READMEs should mention dotenv only as a
future or unresolved package, not active supported behavior.
