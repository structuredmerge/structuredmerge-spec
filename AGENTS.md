# AGENTS.md - TreeHaver Development Guide
## 🎯 Project Overview
TreeHaver is a **cross-Ruby adapter for AST parsing libraries** - think Faraday for parsing. It provides a unified API across 10 different backends (tree-sitter, Prism, Psych, Citrus, Parslet, etc.) that works on MRI, JRuby, and TruffleRuby.
**Core Philosophy**: Write once, run anywhere. Learn once, write anywhere.

## ⚠️ AI Agent Terminal Limitations

### Terminal Output Is Not Visible

**CRITICAL**: AI agents using `run_in_terminal` almost never see the command output. The terminal tool sends commands to a persistent Copilot terminal, but output is frequently lost or invisible to the agent.

**Workaround**: Always redirect output to a file in the project's local `tmp/` directory, then read it back with `read_file`:

```bash
bundle exec rspec spec/some_spec.rb > tmp/test_output.txt 2>&1
```

**NEVER** use `/tmp` or other system directories — always use the project's own `tmp/` directory.

### direnv Requires Separate `cd` Command

**CRITICAL**: Never chain `cd` with other commands via `&&`. The `direnv` environment won't initialize until after all chained commands finish. Run `cd` alone first:

✅ **CORRECT**:
```bash
cd /home/pboling/src/kettle-rb/ast-merge/vendor/tree_haver
```
```bash
bundle exec rspec > tmp/test_output.txt 2>&1
```

❌ **WRONG**:
```bash
cd /home/pboling/src/kettle-rb/ast-merge/vendor/tree_haver && bundle exec rspec
```

### Prefer Internal Tools Over Terminal

Use `read_file`, `list_dir`, `grep_search`, `file_search` instead of terminal commands for gathering information. Only use terminal for running tests, installing dependencies, and git operations.

### grep_search Cannot Search Nested Git Projects

This project is a nested git project inside the `ast-merge` workspace. The `grep_search` tool **cannot** search inside it. Use `read_file` and `list_dir` instead.

### NEVER Pipe Test Commands Through head/tail

Always redirect to a file in `tmp/` instead of truncating output.

## 🏗️ Architecture: The Adapter Pattern
### Backend Selection Strategy
TreeHaver uses **automatic backend selection** with environment-based control:
1. **Priority Chain**: Explicit `backend:` param → `TreeHaver.backend` → `TREE_HAVER_BACKEND` env → Auto-detection
2. **Auto-detection Order** (MRI): `:mri` → `:rust` → `:ffi` → `:citrus` → `:parslet`
3. **Fallback Behavior**: If tree-sitter runtime missing, auto-falls back to Citrus/Parslet

**Engine Exclusivity**: Ruby engines (MRI, JRuby, TruffleRuby) never run simultaneously. Auto-detection order adapts to the running engine - JRuby prioritizes `:java` and `:ffi`, TruffleRuby uses pure Ruby backends only.

**Environment Variables**:
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
1. User passes: `TreeHaver::Backends::*::Language` wrapper
2. Parser unwraps via `#unwrap_language` (checks backend compatibility)
3. Backend receives appropriate raw object (MRI: `::TreeSitter::Language`, Rust: String, FFI: wrapper, etc.)
**Tree Object Flow**:
1. Backend returns raw tree → Parser wraps as `TreeHaver::Tree`
2. Incremental parsing: Parser unwraps `old_tree.inner_tree` before passing to backend
### Position API Unification
See `POSITION-API-SUMMARY.md` for details. All backends expose:
- `start_line`, `end_line` (1-based, human-readable)
- `source_position` (hash with 1-based lines, 0-based columns)
- Inheritance: `TreeHaver::Base::Node` provides defaults, backends override as needed
## 🔧 Development Workflows
### Running Tests
```bash
# Full suite (required for coverage thresholds)
bundle exec rspec
# Single file (disable coverage threshold)
K_SOUP_COV_MIN_HARD=false bundle exec rspec spec/tree_haver/parser_spec.rb
# FFI backend isolation (run BEFORE other tests to avoid backend pollution)
bundle exec rake ffi_specs
```
Note: Always run commands after a standalone `cd` so `direnv` can load ENV. Do NOT chain `cd` with `&&`. See [AI Agent Terminal Limitations](#️-ai-agent-terminal-limitations) above.

For AI agents, redirect output to a file:
```bash
cd /home/pboling/src/kettle-rb/ast-merge/vendor/tree_haver
```
```bash
bundle exec rspec spec/tree_haver/parser_spec.rb > tmp/test_output.txt 2>&1
```
**Critical**: FFI specs run FIRST in a clean environment (`:ffi_backend` tag triggers isolated mode). See `Rakefile` lines 66-95 for SimpleCov merging strategy.
### Coverage Reports
Use `bin/rake coverage` - pre-configured ENV variables for coverage reporting
Use `bin/rspec` - Allows customization of ENV variables for coverage reporting with specific settings
**Key env vars**:
- `K_SOUP_COV_DO=true` - Enable coverage (default in `.envrc`)
- `K_SOUP_COV_MIN_LINE=83` - Line coverage threshold
- `K_SOUP_COV_MIN_BRANCH=72` - Branch coverage threshold
- `K_SOUP_COV_MIN_HARD=true` - Fail if thresholds not met
- `K_SOUP_COV_FORMATTERS="json,xml,lcov,tty"` - Output formats
- `K_SOUP_COV_COMMAND_NAME` - Unique name for SimpleCov merging
**Never** review HTML reports - use JSON (preferred), XML, LCOV, or RCOV.
Use `kettle-soup-cover -d` - Reads SimpleCov output generated by prior command; prints human & AI digestable report.
### Grammar Discovery
`GrammarFinder` auto-discovers tree-sitter libraries across platforms:
```ruby
finder = TreeHaver::GrammarFinder.new(:toml)
if finder.available?
  finder.register!  # Now: TreeHaver::Language.toml
end
```
**Search order**: ENV var (`TREE_SITTER_TOML_PATH`) → extra_paths → base dirs (`/usr/lib`, `/usr/local/lib`, etc.)
**Security**: Path validation rejects `../`, validates extensions (`.so`, `.dylib`, `.dll`)

### Working Examples

The `examples/` directory contains fully functional scripts demonstrating TreeHaver patterns:

- `auto_json.rb` - Backend auto-selection with JSON parsing
- `backend_selection.rb` - Testing environment variable effects on backend availability
- `parser_for_citrus.rb` - Citrus backend usage patterns
- Real-world usage patterns for grammar registration, language loading, and tree traversal

These are excellent references for understanding how components work together in practice.

## 📝 Project Conventions
### Backend Registry Pattern
External gems register their availability via `BackendRegistry`:
```ruby
# In external gem (e.g., commonmarker-merge)
TreeHaver::BackendRegistry.register_tag(
  :commonmarker_backend,
  category: :backend,
  require_path: "commonmarker/merge",
) { Commonmarker::Merge::Backend.available? }
```
This enables dynamic RSpec tag filtering without hardcoding backend knowledge.

### Kettle-Dev Tooling

This project uses `kettle-dev` (sister project in kettle-rb org) for gem maintenance automation:

- **Templating**: Lines between `kettle-dev:freeze` / `kettle-dev:unfreeze` comments are preserved during template updates (see `tree_haver.gemspec` lines 3-5)
- **CI Workflows**: GitHub Actions and GitLab CI configurations are managed by kettle-dev templates
- **Releases**: Use `kettle-release` command for automated release process (versioning, changelog, gem publishing)

### Version Requirements
- Ruby >= 3.2.0 (gemspec line 19)
- `ruby_tree_sitter` v2.0+ required (exception hierarchy changed: all inherit from `Exception`, not `StandardError`)
- Tree-sitter runtime compatibility: Backend-specific (see README "Backend Requirements")
## 🧪 Testing Patterns
### Dependency Tag System
RSpec tests use dynamic tags based on backend availability:
```ruby
RSpec.describe("feature", :toml_parsing, :commonmarker_backend) do
  # Auto-skipped if toml-rb or commonmarker unavailable
end
```
Tags resolved by `lib/tree_haver/rspec/dependency_tags.rb` via `BackendRegistry`.
### Backend Conflict Protection
`TreeHaver.backend_protect` (default: true) prevents incompatible backend combinations (e.g., FFI after MRI). Tests may disable this with `TreeHaver.backend_protect = false`.
### Matrix Testing
`spec_matrix/` contains backend compatibility matrix tests with minimal helper to avoid pre-loading dependencies.
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
- **Backends**: 10 backends in `lib/tree_haver/backends/` (mri, rust, ffi, java, prism, psych, citrus, parslet, commonmarker, markly)
- **External Gems**: Uses `*-merge` family (toml-merge, commonmarker-merge, etc.) via backend registry
- **RSpec**: Deep integration via `tree_haver/rspec.rb` for dependency tagging
- **SimpleCov**: Custom merging strategy for multi-task coverage (FFI specs + main specs)
## 💡 Key Insights
1. **Backend pollution**: MRI backend loads native tree-sitter, preventing FFI backend from working. Always run FFI specs first.
2. **Language caching**: `LanguageRegistry` caches loaded languages. Clear with `LanguageRegistry.clear_cache!` in tests.
3. **Backend compatibility**: Check `TreeHaver.capabilities` for backend-specific features (incremental parsing, queries, etc.).
4. **Grammar registration**: Use `GrammarFinder` for tree-sitter, `CitrusGrammarFinder` for Citrus, `ParsletGrammarFinder` for Parslet.
5. **Exception mapping**: TreeHaver catches backend exceptions and converts to `TreeHaver::NotAvailable` for consistent error handling.
