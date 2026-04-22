`ruby-merge` MUST reconstruct Ruby source from accepted delegated child
outputs.

Given:

- the original Ruby source,
- delegated child operations for YARD example surfaces,
- a delegated child apply plan,
- and applied child outputs keyed by child operation id,

the family package MUST rewrite only the targeted child surface content and
MUST preserve:

- surrounding Ruby source,
- the original documentation prefix style,
- and untouched delegated child surfaces.

For YARD example blocks using comment-prefix reconstruction, each rewritten line
MUST retain the original comment/body prefix.
