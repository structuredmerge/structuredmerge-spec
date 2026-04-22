## Slice 330: Template Target Classification

`ast-merge` MUST provide a shared helper that classifies a logical
destination-relative path for template application.

Given a normalized destination path, the classifier MUST return a stable record
containing:

1. the destination path
2. a file-type identifier
3. a merge family identifier
4. a dialect identifier

The classifier MUST recognize the shared template-routing cases needed by the
reference product layer, including:

- Ruby entrypoints and suffixes
- YAML files
- Markdown files
- Bash and shell-script files
- dotenv files
- JSON and JSONC files
- TOML files
- RBS files
- text fallback

This slice only classifies paths. It does not choose strategies, perform
destination remapping, or guarantee that the returned family is currently
implemented in every language stack.
