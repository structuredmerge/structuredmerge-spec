`markdown-merge` MUST reconstruct Markdown source from accepted delegated child
outputs.

Given:

- the original Markdown source,
- delegated child operations for fenced-code surfaces,
- a delegated child apply plan,
- and applied child outputs keyed by child operation id,

the family package MUST rewrite only the targeted fenced-code bodies and MUST
preserve:

- the original fence markers,
- the declared fence language/info string,
- untouched fenced-code blocks,
- and surrounding Markdown structure.
