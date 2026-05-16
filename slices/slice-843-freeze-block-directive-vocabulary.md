# Slice 843: Freeze Block Directive Vocabulary

## Goal

Define the portable freeze/directive vocabulary before porting old
`FreezeNodeBase`, `Freezable`, `BlockDirective`, or format-local freeze node
classes.

## Contract

Freeze behavior is represented as normalized node metadata, semantic sidecars,
or family/provider reports, not as a required old Ruby base class.

Portable directive model:

- `freeze` / `unfreeze` form a balanced block directive pair;
- `freeze` blocks preserve destination content and are opaque unless a family
  fixture explicitly permits structural edits inside the block;
- standalone node-level freeze directives may attach to the following
  structural node when the provider can prove ownership;
- `nocov` is a directive kind, but it follows coverage/annotation policy rather
  than destination-preserving freeze policy;
- nested directive blocks are allowed when they form a clean tree;
- offset-overlapping/crossing directive spans are invalid;
- unmatched close markers and unclosed open markers produce diagnostics;
- supported marker styles are hash comments, HTML comments, C/JavaScript line
  comments, and C/JavaScript block comments;
- `smorg` is the canonical token namespace for new fixtures, with legacy or
  custom tokens treated as provider/config input.

Families must fixture their comment syntax, token handling, preservation
policy, diagnostics, and render/reparse behavior before claiming freeze-block
support.
