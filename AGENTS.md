# AGENTS.md - TreeHaver Development Guide

## 🎯 Project Overview

TreeHaver is a **cross-Ruby adapter for AST parsing libraries** - think Faraday for parsing. It provides a unified API across 10 different backends (tree-sitter, Prism, Psych, Citrus, Parslet, etc.) that works on MRI, JRuby, and TruffleRuby.
**Core Philosophy**: Write once, run anywhere. Learn once, write anywhere.

## ⚠️ AI Agent Terminal Limitations

### Terminal Output Is Available, but Each Command Is Isolated

**Minimum Supported Ruby**: See the gemspec `required_ruby_version` constraint.
**Local Development Ruby**: See `.tool-versions` for the version used in local development (typically the latest stable Ruby).

### Use `mise` for Project Environment

**CRITICAL**: The canonical project environment lives in `mise.toml`, with local overrides in `.env.local` loaded via `dotenvy`.

⚠️ **Watch for trust prompts**: After editing `mise.toml` or `.env.local`, `mise` may require trust to be refreshed before commands can load the project environment. Until that trust step is handled, commands can appear hung or produce no output, which can look like terminal access is broken.

**Recovery rule**: If a `mise exec` command goes silent or appears hung, assume `mise trust` is the first thing to check. Recover by running:

```bash
mise trust -C /home/pboling/src/kettle-rb/tree_haver
mise exec -C /home/pboling/src/kettle-rb/tree_haver -- bundle exec rspec
```

Do this before spending time on unrelated debugging; in this workspace pattern, silent `mise` commands are usually a trust problem first.

```bash
mise trust -C /home/pboling/src/kettle-rb/tree_haver
```

✅ **CORRECT**:
```bash
mise exec -C /home/pboling/src/kettle-rb/tree_haver -- bundle exec rspec
```

✅ **CORRECT**:
```bash
eval "$(mise env -C /home/pboling/src/kettle-rb/tree_haver -s bash)" && bundle exec rspec
```

❌ **WRONG**:
```bash
cd /home/pboling/src/kettle-rb/tree_haver
bundle exec rspec
```

❌ **WRONG**:
```bash
cd /home/pboling/src/kettle-rb/tree_haver && bundle exec rspec
```

### Prefer Internal Tools Over Terminal

Use `read_file`, `list_dir`, `grep_search`, `file_search` instead of terminal commands for gathering information. Only use terminal for running tests, installing dependencies, and git operations.

### Workspace layout

❌ **WRONG** — A chained `cd` does not give directory-change hooks time to update the environment:

### NEVER Pipe Test Commands Through head/tail

When you do run tests, keep the full output visible so you can inspect failures completely.

## 🏗️ Architecture: The Adapter Pattern

### Backend Selection Strategy

✅ **CORRECT** — If you need shell syntax first, load the environment in the same command:

- Uses `kettle-test` for RSpec helpers (stubbed_env, block_is_expected, silent_stream, timecop)
- Uses `Dir.mktmpdir` for isolated filesystem tests
- Spec helper is loaded by `.rspec` — never add `require "spec_helper"` to spec files

**Engine Exclusivity**: Ruby engines (MRI, JRuby, TruffleRuby) never run simultaneously. Auto-detection order adapts to the running engine - JRuby prioritizes `:java` and `:ffi`, TruffleRuby uses pure Ruby backends only.

❌ **AVOID** when possible:

- `TREE_HAVER_BACKEND` - Force single backend (`:auto`, `:mri`, `:ffi`, `:citrus`, etc.)
- `TREE_HAVER_NATIVE_BACKEND` - Restrict native backends (comma-separated or `none`)
- `TREE_HAVER_RUBY_BACKEND` - Restrict Ruby backends (comma-separated or `none`)
```ruby
# Check what's allowed
TreeHaver.allowed_native_backends  # => [:mri, :ffi] or [:auto] or [:none]
TreeHaver.backend_allowed?(:ffi)   # => true/false
```

### Wrapping/Unwrapping Architecture

**Critical Design Principle**: `TreeHaver::Parser` handles ALL wrapping/unwrapping. Backends work with raw objects only.
**Key files**:
- `WRAPPING-ARCHITECTURE.md` - Complete unwrapping contract
- `lib/tree_haver/parser.rb` - The only place that wraps/unwraps objects
**Language Object Flow**:

- `grep_search` instead of `grep` command
- `file_search` instead of `find` command
- `read_file` instead of `cat` command
- `list_dir` instead of `ls` command
- `replace_string_in_file` or `create_file` instead of `sed` / manual editing

### Position API Unification

✅ **CORRECT** — Run self-contained commands with `mise exec`:

- `start_line`, `end_line` (1-based, human-readable)
- `source_position` (hash with 1-based lines, 0-based columns)
- Inheritance: `TreeHaver::Base::Node` provides defaults, backends override as needed

## 🔧 Development Workflows

### Running Tests

```bash
# Full suite (required for coverage thresholds)
mise exec -C /home/pboling/src/kettle-rb/tree_haver -- bundle exec rspec
# Single file (disable coverage threshold)
mise exec -C /home/pboling/src/kettle-rb/tree_haver -- env K_SOUP_COV_MIN_HARD=false bundle exec rspec spec/tree_haver/parser_spec.rb
# FFI backend isolation (run BEFORE other tests to avoid backend pollution)
mise exec -C /home/pboling/src/kettle-rb/tree_haver -- bundle exec rake ffi_specs
```

**CRITICAL**: All constructors and public API methods that accept keyword arguments MUST include `**options` as the final parameter for forward compatibility.

### Coverage Reports

Use `mise exec -C /home/pboling/src/kettle-rb/tree_haver -- bin/rake coverage` - pre-configured ENV variables for coverage reporting
Use `mise exec -C /home/pboling/src/kettle-rb/tree_haver -- bin/rspec` - Allows customization of ENV variables for coverage reporting with specific settings
**Key env vars** (set in `mise.toml`, with local overrides in `.env.local`):
- `K_SOUP_COV_DO=true` - Enable coverage
- `K_SOUP_COV_MIN_LINE=83` - Line coverage threshold
- `K_SOUP_COV_MIN_BRANCH=72` - Branch coverage threshold
- `K_SOUP_COV_MIN_HARD=false` - Fail if thresholds not met
- `K_SOUP_COV_FORMATTERS="html,xml,rcov,lcov,json,tty"` - Output formats
- `K_SOUP_COV_COMMAND_NAME` - Unique name for SimpleCov merging
**Never** review HTML reports - use JSON (preferred), XML, LCOV, or RCOV.
Use `kettle-soup-cover -d` - Reads SimpleCov output generated by prior command; prints human & AI digestable report.

### Grammar Discovery

Only use terminal for:

```ruby
finder = TreeHaver::GrammarFinder.new(:toml)
if finder.available?
  finder.register!  # Now: TreeHaver::Language.toml
end
```
**Search order**: ENV var (`TREE_SITTER_TOML_PATH`) → extra_paths → base dirs (`/usr/lib`, `/usr/local/lib`, etc.)
**Security**: Path validation rejects `../`, validates extensions (`.so`, `.dylib`, `.dll`)

### Working Examples

❌ **WRONG** — Do not rely on a previous command changing directories:

- Running tests (`bundle exec rspec`)
- Installing dependencies (`bundle install`)
- Git operations that require interaction
- Commands that actually need to execute (not just gather info)

Template updates preserve custom code wrapped in freeze blocks:

## 📝 Project Conventions

### Backend Registry Pattern

Single file (disable coverage threshold):

```ruby
# In external gem (e.g., commonmarker-merge)
TreeHaver::BackendRegistry.register_tag(
  :commonmarker_backend,
  category: :backend,
  require_path: "commonmarker/merge",
) { Commonmarker::Merge::Backend.available? }
```

**Key ENV variables** (set in `mise.toml`, with local overrides in `.env.local`):

### Kettle-Dev Tooling

This gem is part of the **kettle-rb** ecosystem. Key development tools:

- **Templating**: Lines between `kettle-dev:freeze` / `kettle-dev:unfreeze` comments are preserved during template updates (see `tree_haver.gemspec` lines 3-5)
- **CI Workflows**: GitHub Actions and GitLab CI configurations are managed by kettle-dev templates
- **Releases**: Use `kettle-release` command for automated release process (versioning, changelog, gem publishing)

### Version Requirements

- Ruby >= 3.2.0 (gemspec line 19)
- `ruby_tree_sitter` v2.0+ required (exception hierarchy changed: all inherit from `Exception`, not `StandardError`)
- Tree-sitter runtime compatibility: Backend-specific (see README "Backend Requirements")

## 🧪 Testing Patterns

### Dependency Tag System

✅ **PREFERRED** — Use internal tools:

```ruby
RSpec.describe("feature", :toml_parsing, :commonmarker_backend) do
  # Auto-skipped if toml-rb or commonmarker unavailable
end
```
Tags resolved by `lib/tree_haver/rspec/dependency_tags.rb` via `BackendRegistry`.

### Backend Conflict Protection

Gemfiles are split into modular components under `gemfiles/modular/`. Each component handles a specific concern (coverage, style, debug, etc.). The main `Gemfile` loads these modular components via `eval_gemfile`.

### Matrix Testing

Use dependency tags to conditionally skip tests when optional dependencies are not available:

## 🔍 Critical Files

- `lib/tree_haver/parser.rb` - Main facade, handles all wrapping/unwrapping (439 lines)
- `lib/tree_haver/backend_registry.rb` - Dynamic backend registration system (458 lines)
- `lib/tree_haver/grammar_finder.rb` - Platform-aware grammar discovery (375 lines)
- `WRAPPING-ARCHITECTURE.md` - Unwrapping contracts and design principles (277 lines)
- `POSITION-API-SUMMARY.md` - Position API unification across backends (136 lines)
- `lib/tree_haver.rb` - Module-level backend configuration and language registry

## 🚀 Common Tasks

```bash
# Run all specs with coverage
bundle exec rake spec
# Generate coverage report and open in browser
bundle exec rake coverage
# Check code quality
bundle exec rake reek
bundle exec rake rubocop_gradual
# Run benchmarks (skipped on CI)
bundle exec rake bench
# Prepare changelog for release, build and release
kettle-changelog && kettle-release
```

## 🌊 Integration Points

- `K_SOUP_COV_DO=true` – Enable coverage
- `K_SOUP_COV_MIN_LINE` – Line coverage threshold
- `K_SOUP_COV_MIN_BRANCH` – Branch coverage threshold
- `K_SOUP_COV_MIN_HARD=true` – Fail if thresholds not met

## 💡 Key Insights

1. **Backend pollution**: MRI backend loads native tree-sitter, preventing FFI backend from working. Always run FFI specs first.
2. **Language caching**: `LanguageRegistry` caches loaded languages. Clear with `LanguageRegistry.clear_cache!` in tests.
3. **Backend compatibility**: Check `TreeHaver.capabilities` for backend-specific features (incremental parsing, queries, etc.).
4. **Grammar registration**: Use `GrammarFinder` for tree-sitter, `CitrusGrammarFinder` for Citrus, `ParsletGrammarFinder` for Parslet.
5. **Exception mapping**: TreeHaver catches backend exceptions and converts to `TreeHaver::NotAvailable` for consistent error handling.

# AGENTS.md - Development Guide

This project is a **RubyGem** managed with the [kettle-rb](https://github.com/kettle-rb) toolchain.

```bash
mise trust -C /path/to/project
mise exec -C /path/to/project -- bundle exec rspec
```

```bash
mise exec -C /path/to/project -- bundle exec rspec
```

```bash
eval "$(mise env -C /path/to/project -s bash)" && bundle exec rspec
```

```bash
cd /path/to/project
bundle exec rspec
```

```bash
cd /path/to/project && bundle exec rspec
```

- `run_in_terminal` for information gathering

## 🏗️ Architecture

### Toolchain Dependencies

| Tool | Purpose |
|------|---------|
| `kettle-dev` | Development dependency: Rake tasks, release tooling, CI helpers |
| `kettle-test` | Test infrastructure: RSpec helpers, stubbed_env, timecop |
| `kettle-jem` | Template management and gem scaffolding |

### Executables (from kettle-dev)

| Executable | Purpose |
|-----------|---------|
| `kettle-release` | Full gem release workflow |
| `kettle-pre-release` | Pre-release validation |
| `kettle-changelog` | Changelog generation |
| `kettle-dvcs` | DVCS (git) workflow automation |
| `kettle-commit-msg` | Commit message validation |
| `kettle-check-eof` | EOF newline validation |

## 📁 Project Structure

```
lib/
├── <gem_namespace>/           # Main library code
│   └── version.rb             # Version constant (managed by kettle-release)
spec/
├── fixtures/                  # Test fixture files (NOT auto-loaded)
├── support/
│   ├── classes/               # Helper classes for specs
│   └── shared_contexts/       # Shared RSpec contexts
├── spec_helper.rb             # RSpec configuration (loaded by .rspec)
gemfiles/
├── modular/                   # Modular Gemfile components
│   ├── coverage.gemfile       # SimpleCov dependencies
│   ├── debug.gemfile          # Debugging tools
│   ├── documentation.gemfile  # YARD/documentation
│   ├── optional.gemfile       # Optional dependencies
│   ├── rspec.gemfile          # RSpec testing
│   ├── style.gemfile          # RuboCop/linting
│   └── x_std_libs.gemfile     # Extracted stdlib gems
├── ruby_*.gemfile             # Per-Ruby-version Appraisal Gemfiles
└── Appraisal.root.gemfile     # Root Gemfile for Appraisal builds
.git-hooks/
├── commit-msg                 # Commit message validation hook
├── prepare-commit-msg         # Commit message preparation
├── commit-subjects-goalie.txt # Commit subject prefix filters
└── footer-template.erb.txt    # Commit footer ERB template
```

```bash
mise exec -C /path/to/project -- bundle exec rspec
```

```bash
mise exec -C /path/to/project -- env K_SOUP_COV_MIN_HARD=false bundle exec rspec spec/path/to/spec.rb
```

```bash
mise exec -C /path/to/project -- bin/rake coverage
mise exec -C /path/to/project -- bin/kettle-soup-cover -d
```

### Code Quality

```bash
mise exec -C /path/to/project -- bundle exec rake reek
mise exec -C /path/to/project -- bundle exec rubocop-gradual
```

### Releasing

```bash
bin/kettle-pre-release    # Validate everything before release
bin/kettle-release        # Full release workflow
```

### Freeze Block Preservation

```ruby
# kettle-jem:freeze
# ... custom code preserved across template runs ...
# kettle-jem:unfreeze
```

### Modular Gemfile Architecture

### Forward Compatibility with `**options`

### Test Infrastructure

### Environment Variable Helpers

```ruby
before do
  stub_env("MY_ENV_VAR" => "value")
end

before do
  hide_env("HOME", "USER")
end
```

### Dependency Tags

```ruby
RSpec.describe SomeClass, :prism_merge do
  # Skipped if prism-merge is not available
end
```

## 🚫 Common Pitfalls

1. **NEVER add backward compatibility** — No shims, aliases, or deprecation layers. Bump major version instead.
2. **NEVER expect `cd` to persist** — Every terminal command is isolated; use a self-contained `mise exec -C ... -- ...` invocation.
3. **NEVER pipe test output through `head`/`tail`** — Run tests without truncation so you can inspect the full output.
4. **Terminal commands do not share shell state** — Previous `cd`, `export`, aliases, and functions are not available to the next command.
