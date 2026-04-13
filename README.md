[![Galtzo FLOSS Logo by Aboling0, CC BY-SA 4.0][🖼️galtzo-i]][🖼️galtzo-discord] [![ruby-lang Logo, Yukihiro Matsumoto, Ruby Visual Identity Team, CC BY-SA 2.5][🖼️ruby-lang-i]][🖼️ruby-lang] [![kettle-rb Logo by Aboling0, CC BY-SA 4.0][🖼️kettle-rb-i]][🖼️kettle-rb]

[🖼️galtzo-i]: https://logos.galtzo.com/assets/images/galtzo-floss/avatar-192px.svg
[🖼️galtzo-discord]: https://discord.gg/3qme4XHNKN
[🖼️ruby-lang-i]: https://logos.galtzo.com/assets/images/ruby-lang/avatar-192px.svg
[🖼️ruby-lang]: https://www.ruby-lang.org/
[🖼️kettle-rb-i]: https://logos.galtzo.com/assets/images/kettle-rb/avatar-192px.svg
[🖼️kettle-rb]: https://github.com/kettle-rb

# 🌴 TreeHaver

[![Version][👽versioni]][👽version] [![GitHub tag (latest SemVer)][⛳️tag-img]][⛳️tag] [![License: AGPL-3.0-only][📄license-img]][📄license-ref] [![Downloads Rank][👽dl-ranki]][👽dl-rank] [![Open Source Helpers][👽oss-helpi]][👽oss-help] [![CodeCov Test Coverage][🏀codecovi]][🏀codecov] [![Coveralls Test Coverage][🏀coveralls-img]][🏀coveralls] [![QLTY Test Coverage][🏀qlty-covi]][🏀qlty-cov] [![QLTY Maintainability][🏀qlty-mnti]][🏀qlty-mnt] [![CI Heads][🚎3-hd-wfi]][🚎3-hd-wf] [![CI Runtime Dependencies @ HEAD][🚎12-crh-wfi]][🚎12-crh-wf] [![CI Current][🚎11-c-wfi]][🚎11-c-wf] [![CI Truffle Ruby][🚎9-t-wfi]][🚎9-t-wf] [![CI JRuby][🚎10-j-wfi]][🚎10-j-wf] [![Deps Locked][🚎13-🔒️-wfi]][🚎13-🔒️-wf] [![Deps Unlocked][🚎14-🔓️-wfi]][🚎14-🔓️-wf] [![CI Test Coverage][🚎2-cov-wfi]][🚎2-cov-wf] [![CI Style][🚎5-st-wfi]][🚎5-st-wf] [![CodeQL][🖐codeQL-img]][🖐codeQL] [![Apache SkyWalking Eyes License Compatibility Check][🚎15-🪪-wfi]][🚎15-🪪-wf]

`if ci_badges.map(&:color).detect { it != "green"}` ☝️ [let me know][🖼️galtzo-discord], as I may have missed the [discord notification][🖼️galtzo-discord].

---

`if ci_badges.map(&:color).all? { it == "green"}` 👇️ send money so I can do more of this. FLOSS maintenance is now my full-time job.

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate at ko-fi.com][🖇kofi-img]][🖇kofi]

<details>
    <summary>👣 How will this project approach the September 2025 hostile takeover of RubyGems? 🚑️</summary>

I've summarized my thoughts in [this blog post](https://dev.to/galtzo/hostile-takeover-of-rubygems-my-thoughts-5hlo).

</details>

## 🌻 Synopsis

TreeHaver is a cross-Ruby adapter for the [tree-sitter](https://tree-sitter.github.io/tree-sitter/), [Citrus][citrus], and [Parslet][parslet] parsing libraries and other dedicated parsing tools that works seamlessly across MRI Ruby, JRuby, and TruffleRuby. It provides a unified API for parsing source code using grammars, regardless of your Ruby implementation.

### The Adapter Pattern: Like Faraday, but for Parsing

If you've used [Faraday](https://github.com/lostisland/faraday), [multi\_json](https://github.com/intridea/multi_json), or [multi\_xml](https://github.com/sferik/multi_xml), you'll feel right at home with TreeHaver. These gems share a common philosophy:

| Gem             | Unified API for | Backend Examples                                                          |
|-----------------|-----------------|---------------------------------------------------------------------------|
| **Faraday**     | HTTP requests   | Net::HTTP, Typhoeus, Patron, Excon                                        |
| **multi\_json** | JSON parsing    | Oj, Yajl, JSON gem                                                        |
| **multi\_xml**  | XML parsing     | Nokogiri, LibXML, Ox                                                      |
| **TreeHaver**   | Code parsing    | MRI, Rust, FFI, Java, Prism, Psych, Commonmarker, Markly, Citrus, Parslet |

**Learn once, write anywhere.**

**Write once, run anywhere.**

Just as Faraday lets you swap HTTP adapters without changing your code, TreeHaver lets you swap tree-sitter backends. Your parsing code remains the same whether you're running on MRI with native C extensions, JRuby with FFI, or TruffleRuby.

```ruby
# Your code stays the same regardless of backend
parser = TreeHaver::Parser.new
parser.language = TreeHaver::Language.from_library("/path/to/grammar.so")
tree = parser.parse(source_code)

# TreeHaver automatically picks the best available backend:
# - MRI: ruby_tree_sitter, tree_stump, ffi, prism, psych, commonmarker, markly, citrus, parslet
# - JRuby: ffi, java-tree-sitter (not a gem, but the jtreesitter maven package), prism, psych, commonmarker, markly, citrus, parslet
# - TruffleRuby: prism, psych, commonmarker, markly, citrus, parslet
#   (tree-sitter backends don't work on Truffleruby with ffi gem due to FFI STRUCT_BY_VALUE limitation)
```

### Key Features

- **Universal Ruby Support**: Works on MRI Ruby, JRuby, and TruffleRuby
- **10 Parsing Backends** - Choose the right backend for your needs:
    - **Tree-sitter Backends** (high-performance, incremental parsing):
        - **MRI Backend**: Leverages [`ruby_tree_sitter`][ruby_tree_sitter] gem (C extension, fastest on MRI)
            - **Note**: `ruby_tree_sitter` currently requires unreleased fixes in the `pboling` fork, `tree_haver` branch.
        - **Rust Backend**: Uses [`tree_stump`][tree_stump] gem (Rust with precompiled binaries)
            - **Note**: Use `tree_stump` v0.2.0 or newer (fixes are released).
        - **FFI Backend**: Pure Ruby FFI bindings to `libtree-sitter` (JRuby only; TruffleRuby's FFI doesn't support tree-sitter's struct-by-value returns)
        - **Java Backend**: Native Java integration for JRuby with [`java-tree-sitter`](https://github.com/tree-sitter/java-tree-sitter) / [`jtreesitter`][jtreesitter] grammar JARs
    - **Language-Specific Backends** (native parser integration):
        - **Prism Backend**: Ruby's official parser ([Prism][prism], stdlib in Ruby 3.4+)
        - **Psych Backend**: Ruby's YAML parser ([Psych][psych], stdlib)
        - **Commonmarker Backend**: Fast Markdown parser ([Commonmarker][commonmarker], comrak Rust)
        - **Markly Backend**: GitHub Flavored Markdown ([Markly][markly], cmark-gfm C)
    - **Pure Ruby Fallback**:
        - **Citrus Backend**: Pure Ruby PEG parsing via [`citrus`][citrus] (no native dependencies)
        - **Parslet Backend**: Pure Ruby PEG parsing via [`parslet`][parslet] (no native dependencies)
- **Automatic Backend Selection**: Intelligently selects the best backend for your Ruby implementation
- **Language Agnostic**: Parse any language - Ruby, Markdown, YAML, JSON, Bash, TOML, JavaScript, etc.
- **Grammar Discovery**: Built-in `GrammarFinder` utility for platform-aware grammar library discovery
- **Unified Position API**: Consistent `start_line`, `end_line`, `source_position` across all backends
- **Thread-Safe**: Built-in language registry with thread-safe caching
- **Minimal API Surface**: Simple, focused API that covers the most common use cases

### Backend Requirements

TreeHaver has minimal dependencies and automatically selects the best backend for your Ruby implementation. Each backend has specific version requirements:

#### MRI Backend (ruby\_tree\_sitter, C extensions)

**Requires `ruby_tree_sitter` v2.0+**

In ruby\_tree\_sitter v2.0, all TreeSitter exceptions were changed to inherit from `Exception` (not `StandardError`). This was an intentional breaking change made for thread-safety and signal handling reasons.

**Exception Mapping**: TreeHaver catches `TreeSitter::TreeSitterError` and its subclasses, converting them to `TreeHaver::NotAvailable` while preserving the original error message. This provides a consistent exception API across all backends:

| ruby\_tree\_sitter Exception      | TreeHaver Exception       | When It Occurs                               |
|-----------------------------------|---------------------------|----------------------------------------------|
| `TreeSitter::ParserNotFoundError` | `TreeHaver::NotAvailable` | Parser library file cannot be loaded         |
| `TreeSitter::LanguageLoadError`   | `TreeHaver::NotAvailable` | Language symbol loads but returns nothing    |
| `TreeSitter::SymbolNotFoundError` | `TreeHaver::NotAvailable` | Symbol not found in library                  |
| `TreeSitter::ParserVersionError`  | `TreeHaver::NotAvailable` | Parser version incompatible with tree-sitter |
| `TreeSitter::QueryCreationError`  | `TreeHaver::NotAvailable` | Query creation fails                         |

```ruby
# MRI tree-sitter Backend
gem "ruby_tree_sitter",
  github: "pboling/ruby-tree-sitter",
  branch: "tree_haver",
  require: false # DO NOT LOAD, because conflicts with FFI
```

#### Rust Backend (tree\_stump)

**MRI Ruby only** - Does not work on JRuby or TruffleRuby.

The Rust backend uses [tree\_stump][tree_stump], which is a Rust native extension built with [magnus](https://github.com/matsadler/magnus) and [rb-sys](https://github.com/oxidize-rb/rb-sys). These libraries are only compatible with MRI Ruby's C API.

- **JRuby**: Cannot load native `.so` extensions (runs on JVM)
- **TruffleRuby**: magnus/rb-sys are incompatible with TruffleRuby's C API emulation

```ruby
# Rust tree-sitter backend (MRI only)
gem "tree_stump", "~> 0.2.0"
```

#### FFI Backend

**MRI and JRuby only** - Does not work on TruffleRuby.

Requires the `ffi` gem and a system installation of `libtree-sitter`.

- **TruffleRuby**: TruffleRuby's FFI implementation doesn't support `STRUCT_BY_VALUE` return types, which tree-sitter's C API uses for functions like `ts_tree_root_node` and `ts_node_child`.

```ruby
# Add to your Gemfile for FFI backend (MRI and JRuby)
gem "ffi", ">= 1.15", "< 2.0"
```

```bash
# Install libtree-sitter on your system:
# macOS
brew install tree-sitter

# Ubuntu/Debian
apt-get install libtree-sitter0 libtree-sitter-dev

# Fedora
dnf install tree-sitter tree-sitter-devel
```

#### Citrus Backend

Pure Ruby PEG parser with no native dependencies:

```ruby
# Add to your Gemfile for Citrus backend
gem "citrus", "~> 3.0"
```

#### Parslet Backend

Pure Ruby PEG parser with no native dependencies:

```ruby
# Add to your Gemfile for Parslet backend
gem "parslet", "~> 2.0"
```

#### Java Backend (JRuby only)

**Requires jtreesitter \>= 0.26.0** from Maven Central. Older versions are not supported due to breaking API changes.

```ruby
# No gem dependency - uses JRuby's built-in Java integration
# Download the JAR:
# curl -L -o jtreesitter-0.26.0.jar \
#   "https://repo1.maven.org/maven2/io/github/tree-sitter/jtreesitter/0.26.0/jtreesitter-0.26.0.jar"

# Set environment variable:
# export TREE_SITTER_JAVA_JARS_DIR=/path/to/jars
```

**Also requires**:

- Tree-sitter runtime library (`libtree-sitter.so`) version 0.26+ (must match jtreesitter version)
- Grammar `.so` files built against tree-sitter 0.26+ (or rebuilt with `tree-sitter generate`)

### Version Requirements for Tree-Sitter Backends

#### tree-sitter Runtime Library

All tree-sitter backends (MRI, Rust, FFI, Java) require the tree-sitter runtime library. **Version 0.26+ is required** for the Java backend (to match jtreesitter 0.26.0). Other backends may work with 0.24+, but 0.26+ is recommended for consistency.

```bash
# Check your tree-sitter version
tree-sitter --version  # Should be 0.26.0 or newer for Java backend

# macOS
brew install tree-sitter

# Ubuntu/Debian
apt-get install libtree-sitter0 libtree-sitter-dev

# Fedora
dnf install tree-sitter tree-sitter-devel
```

#### jtreesitter (Java Backend)

**The Java backend requires jtreesitter \>= 0.26.0.** This version introduced breaking API changes:

- `Parser.parse()` returns `Optional<Tree>` instead of `Tree`
- `Tree.getRootNode()` returns `Node` directly (not `Optional<Node>`)
- `Node.getChild()`, `getParent()`, `getNextSibling()`, `getPrevSibling()` return `Optional<Node>`
- `Language.load(name)` was removed; use `SymbolLookup` API instead
  Older versions of jtreesitter are **NOT supported**.

```bash
# Download jtreesitter 0.26.0 from Maven Central
curl -L -o jtreesitter-0.26.0.jar \
  "https://repo1.maven.org/maven2/io/github/tree-sitter/jtreesitter/0.26.0/jtreesitter-0.26.0.jar"

# Or use the provided setup script
bin/setup-jtreesitter
```

Set the environment variable to point to your JAR directory:

```bash
export TREE_SITTER_JAVA_JARS_DIR=/path/to/jars
```

#### Grammar ABI Compatibility

**CRITICAL**: Grammars must be built against a compatible tree-sitter version.

Tree-sitter 0.24+ changed how language ABI versions are reported (from `ts_language_version()` to `ts_language_abi_version()`). For the Java backend with jtreesitter 0.26.0, grammars must be built against tree-sitter 0.26+. If you get errors like:

    Failed to load tree_sitter_toml
    Version mismatch detected: The grammar was built against tree-sitter < 0.26

You need to rebuild the grammar from source:

```bash
# Use the provided build script
bin/build-grammar toml

# Or manually:
git clone https://github.com/tree-sitter-grammars/tree-sitter-toml
cd tree-sitter-toml
tree-sitter generate  # Regenerates parser.c for your tree-sitter version
cc -shared -fPIC -o libtree-sitter-toml.so src/parser.c src/scanner.c -I src
```

**Grammar sources for common languages:**

| Language | Repository                                       |
|----------|--------------------------------------------------|
| TOML     | [tree-sitter-grammars/tree-sitter-toml][ts-toml] |
| JSON     | [tree-sitter/tree-sitter-json][ts-json]          |
| JSONC    | [WhyNotHugo/tree-sitter-jsonc][ts-jsonc]         |
| Bash     | [tree-sitter/tree-sitter-bash][ts-bash]          |

#### TruffleRuby Limitations

TruffleRuby has **no working tree-sitter backend**:

- **FFI**: TruffleRuby's FFI doesn't support `STRUCT_BY_VALUE` return types (used by `ts_tree_root_node`, `ts_node_child`, etc.)
- **MRI/Rust**: C and Rust extensions require MRI's C API internals (`RBasic.flags`, `rb_gc_writebarrier`, etc.) that TruffleRuby doesn't expose
  TruffleRuby users should use: **Prism** (Ruby), **Psych** (YAML), **Citrus/Parslet** (e.g., TOML via toml-rb/toml), or potentially **Commonmarker/Markly** (Markdown).

#### JRuby Limitations

JRuby runs on the JVM and **cannot load native `.so` extensions via Ruby's C API**:

- **MRI/Rust**: C and Rust extensions simply cannot be loaded
- **FFI**: Works\! JRuby has excellent FFI support
- **Java**: Works\! The Java backend uses jtreesitter (requires \>= 0.26.0)
  JRuby users should use: **Java backend** (best performance, full API) or **FFI backend** for tree-sitter, plus **Prism**, **Psych**, **Citrus/Parslet** for other formats.

### Why TreeHaver?

tree-sitter is a powerful parser generator that creates incremental parsers for many programming languages. However, integrating it into Ruby applications can be challenging:

- MRI-based C extensions don't work on JRuby
- FFI-based solutions may not be optimal for MRI
- Managing different backends for different Ruby implementations is cumbersome
  TreeHaver solves these problems by providing a unified API that automatically selects the appropriate backend for your Ruby implementation, allowing you to write code once and run it anywhere.

### The `*-merge` Gem Family

The `*-merge` gem family provides intelligent, AST-based merging for various file formats. At the foundation is [tree_haver][tree_haver], which provides a unified cross-Ruby parsing API that works seamlessly across MRI, JRuby, and TruffleRuby.

| Gem                                      |                                                         Version / CI                                                         | Language<br>/ Format | Parser Backend(s)                                                                                     | Description                                                                      |
|------------------------------------------|:----------------------------------------------------------------------------------------------------------------------------:|----------------------|-------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| [tree_haver][tree_haver]                 |                 [![Version][tree_haver-gem-i]][tree_haver-gem] <br/> [![CI][tree_haver-ci-i]][tree_haver-ci]                 | Multi                | Supported Backends: MRI C, Rust, FFI, Java, Prism, Psych, Commonmarker, Markly, Citrus, Parslet       | **Foundation**: Cross-Ruby adapter for parsing libraries (like Faraday for HTTP) |
| [ast-merge][ast-merge]                   |                   [![Version][ast-merge-gem-i]][ast-merge-gem] <br/> [![CI][ast-merge-ci-i]][ast-merge-ci]                   | Text                 | internal                                                                                              | **Infrastructure**: Shared base classes and merge logic for all `*-merge` gems   |
| [bash-merge][bash-merge]                 |                 [![Version][bash-merge-gem-i]][bash-merge-gem] <br/> [![CI][bash-merge-ci-i]][bash-merge-ci]                 | Bash                 | [tree-sitter-bash][ts-bash] (via tree_haver)                                                          | Smart merge for Bash scripts                                                     |
| [commonmarker-merge][commonmarker-merge] | [![Version][commonmarker-merge-gem-i]][commonmarker-merge-gem] <br/> [![CI][commonmarker-merge-ci-i]][commonmarker-merge-ci] | Markdown             | [Commonmarker][commonmarker] (via tree_haver)                                                         | Smart merge for Markdown (CommonMark via comrak Rust)                            |
| [dotenv-merge][dotenv-merge]             |             [![Version][dotenv-merge-gem-i]][dotenv-merge-gem] <br/> [![CI][dotenv-merge-ci-i]][dotenv-merge-ci]             | Dotenv               | internal                                                                                              | Smart merge for `.env` files                                                     |
| [json-merge][json-merge]                 |                 [![Version][json-merge-gem-i]][json-merge-gem] <br/> [![CI][json-merge-ci-i]][json-merge-ci]                 | JSON                 | [tree-sitter-json][ts-json] (via tree_haver)                                                          | Smart merge for JSON files                                                       |
| [jsonc-merge][jsonc-merge]               |               [![Version][jsonc-merge-gem-i]][jsonc-merge-gem] <br/> [![CI][jsonc-merge-ci-i]][jsonc-merge-ci]               | JSONC                | [tree-sitter-jsonc][ts-jsonc] (via tree_haver)                                                        | ⚠️ Proof of concept; Smart merge for JSON with Comments                          |
| [markdown-merge][markdown-merge]         |         [![Version][markdown-merge-gem-i]][markdown-merge-gem] <br/> [![CI][markdown-merge-ci-i]][markdown-merge-ci]         | Markdown             | [Commonmarker][commonmarker] / [Markly][markly] (via tree_haver), [Parslet][parslet]                  | **Foundation**: Shared base for Markdown mergers with inner code block merging   |
| [markly-merge][markly-merge]             |             [![Version][markly-merge-gem-i]][markly-merge-gem] <br/> [![CI][markly-merge-ci-i]][markly-merge-ci]             | Markdown             | [Markly][markly] (via tree_haver)                                                                     | Smart merge for Markdown (CommonMark via cmark-gfm C)                            |
| [prism-merge][prism-merge]               |               [![Version][prism-merge-gem-i]][prism-merge-gem] <br/> [![CI][prism-merge-ci-i]][prism-merge-ci]               | Ruby                 | [Prism][prism] (`prism` std lib gem)                                                                  | Smart merge for Ruby source files                                                |
| [psych-merge][psych-merge]               |               [![Version][psych-merge-gem-i]][psych-merge-gem] <br/> [![CI][psych-merge-ci-i]][psych-merge-ci]               | YAML                 | [Psych][psych] (`psych` std lib gem)                                                                  | Smart merge for YAML files                                                       |
| [rbs-merge][rbs-merge]                   |                   [![Version][rbs-merge-gem-i]][rbs-merge-gem] <br/> [![CI][rbs-merge-ci-i]][rbs-merge-ci]                   | RBS                  | [tree-sitter-rbs][ts-rbs] (via tree_haver), [RBS][rbs] (`rbs` std lib gem)                            | Smart merge for Ruby type signatures                                             |
| [toml-merge][toml-merge]                 |                 [![Version][toml-merge-gem-i]][toml-merge-gem] <br/> [![CI][toml-merge-ci-i]][toml-merge-ci]                 | TOML                 | [Parslet + toml][toml], [Citrus + toml-rb][toml-rb], [tree-sitter-toml][ts-toml] (all via tree_haver) | Smart merge for TOML files                                                       |

#### Backend Platform Compatibility

tree_haver supports multiple parsing backends, but not all backends work on all Ruby platforms:

| Platform 👉️<br> TreeHaver Backend 👇️          | MRI | JRuby | TruffleRuby | Notes                                                                      |
|-------------------------------------------------|:---:|:-----:|:-----------:|----------------------------------------------------------------------------|
| **MRI** ([ruby_tree_sitter][ruby_tree_sitter])  |  ✅  |   ❌   |      ❌      | C extension, MRI only                                                      |
| **Rust** ([tree_stump][tree_stump])             |  ✅  |   ❌   |      ❌      | Rust extension via magnus/rb-sys, MRI only                                 |
| **FFI** ([ffi][ffi])                            |  ✅  |   ✅   |      ❌      | TruffleRuby's FFI doesn't support `STRUCT_BY_VALUE`                        |
| **Java** ([jtreesitter][jtreesitter])           |  ❌  |   ✅   |      ❌      | JRuby only, requires grammar JARs                                          |
| **Prism** ([prism][prism])                      |  ✅  |   ✅   |      ✅      | Ruby parsing, stdlib in Ruby 3.4+                                          |
| **Psych** ([psych][psych])                      |  ✅  |   ✅   |      ✅      | YAML parsing, stdlib                                                       |
| **Citrus** ([citrus][citrus])                   |  ✅  |   ✅   |      ✅      | Pure Ruby PEG parser, no native dependencies                               |
| **Parslet** ([parslet][parslet])                |  ✅  |   ✅   |      ✅      | Pure Ruby PEG parser, no native dependencies                               |
| **Commonmarker** ([commonmarker][commonmarker]) |  ✅  |   ❌   |      ❓      | Rust extension for Markdown (via [commonmarker-merge][commonmarker-merge]) |
| **Markly** ([markly][markly])                   |  ✅  |   ❌   |      ❓      | C extension for Markdown  (via [markly-merge][markly-merge])               |

**Legend**: ✅ = Works, ❌ = Does not work, ❓ = Untested

**Why some backends don't work on certain platforms**:

- **JRuby**: Runs on the JVM; cannot load native C/Rust extensions (`.so` files)
- **TruffleRuby**: Has C API emulation via Sulong/LLVM, but it doesn't expose all MRI internals that native extensions require (e.g., `RBasic.flags`, `rb_gc_writebarrier`)
- **FFI on TruffleRuby**: TruffleRuby's FFI implementation doesn't support returning structs by value, which tree-sitter's C API requires

**Example implementations** for the gem templating use case:

| Gem                      | Purpose         | Description                                   |
|--------------------------|-----------------|-----------------------------------------------|
| [kettle-dev][kettle-dev] | Gem Development | Gem templating tool using `*-merge` gems      |
| [kettle-jem][kettle-jem] | Gem Templating  | Gem template library with smart merge support |

[tree_haver]: https://github.com/kettle-rb/tree_haver
[ast-merge]: https://github.com/kettle-rb/ast-merge
[prism-merge]: https://github.com/kettle-rb/prism-merge
[psych-merge]: https://github.com/kettle-rb/psych-merge
[json-merge]: https://github.com/kettle-rb/json-merge
[jsonc-merge]: https://github.com/kettle-rb/jsonc-merge
[bash-merge]: https://github.com/kettle-rb/bash-merge
[rbs-merge]: https://github.com/kettle-rb/rbs-merge
[dotenv-merge]: https://github.com/kettle-rb/dotenv-merge
[toml-merge]: https://github.com/kettle-rb/toml-merge
[markdown-merge]: https://github.com/kettle-rb/markdown-merge
[markly-merge]: https://github.com/kettle-rb/markly-merge
[commonmarker-merge]: https://github.com/kettle-rb/commonmarker-merge
[kettle-dev]: https://github.com/kettle-rb/kettle-dev
[kettle-jem]: https://github.com/kettle-rb/kettle-jem
[tree_haver-gem]: https://bestgems.org/gems/tree_haver
[ast-merge-gem]: https://bestgems.org/gems/ast-merge
[prism-merge-gem]: https://bestgems.org/gems/prism-merge
[psych-merge-gem]: https://bestgems.org/gems/psych-merge
[json-merge-gem]: https://bestgems.org/gems/json-merge
[jsonc-merge-gem]: https://bestgems.org/gems/jsonc-merge
[bash-merge-gem]: https://bestgems.org/gems/bash-merge
[rbs-merge-gem]: https://bestgems.org/gems/rbs-merge
[dotenv-merge-gem]: https://bestgems.org/gems/dotenv-merge
[toml-merge-gem]: https://bestgems.org/gems/toml-merge
[markdown-merge-gem]: https://bestgems.org/gems/markdown-merge
[markly-merge-gem]: https://bestgems.org/gems/markly-merge
[commonmarker-merge-gem]: https://bestgems.org/gems/commonmarker-merge
[kettle-dev-gem]: https://bestgems.org/gems/kettle-dev
[kettle-jem-gem]: https://bestgems.org/gems/kettle-jem
[tree_haver-gem-i]: https://img.shields.io/gem/v/tree_haver.svg
[ast-merge-gem-i]: https://img.shields.io/gem/v/ast-merge.svg
[prism-merge-gem-i]: https://img.shields.io/gem/v/prism-merge.svg
[psych-merge-gem-i]: https://img.shields.io/gem/v/psych-merge.svg
[json-merge-gem-i]: https://img.shields.io/gem/v/json-merge.svg
[jsonc-merge-gem-i]: https://img.shields.io/gem/v/jsonc-merge.svg
[bash-merge-gem-i]: https://img.shields.io/gem/v/bash-merge.svg
[rbs-merge-gem-i]: https://img.shields.io/gem/v/rbs-merge.svg
[dotenv-merge-gem-i]: https://img.shields.io/gem/v/dotenv-merge.svg
[toml-merge-gem-i]: https://img.shields.io/gem/v/toml-merge.svg
[markdown-merge-gem-i]: https://img.shields.io/gem/v/markdown-merge.svg
[markly-merge-gem-i]: https://img.shields.io/gem/v/markly-merge.svg
[commonmarker-merge-gem-i]: https://img.shields.io/gem/v/commonmarker-merge.svg
[kettle-dev-gem-i]: https://img.shields.io/gem/v/kettle-dev.svg
[kettle-jem-gem-i]: https://img.shields.io/gem/v/kettle-jem.svg
[tree_haver-ci-i]: https://github.com/kettle-rb/tree_haver/actions/workflows/current.yml/badge.svg
[ast-merge-ci-i]: https://github.com/kettle-rb/ast-merge/actions/workflows/current.yml/badge.svg
[prism-merge-ci-i]: https://github.com/kettle-rb/prism-merge/actions/workflows/current.yml/badge.svg
[psych-merge-ci-i]: https://github.com/kettle-rb/psych-merge/actions/workflows/current.yml/badge.svg
[json-merge-ci-i]: https://github.com/kettle-rb/json-merge/actions/workflows/current.yml/badge.svg
[jsonc-merge-ci-i]: https://github.com/kettle-rb/jsonc-merge/actions/workflows/current.yml/badge.svg
[bash-merge-ci-i]: https://github.com/kettle-rb/bash-merge/actions/workflows/current.yml/badge.svg
[rbs-merge-ci-i]: https://github.com/kettle-rb/rbs-merge/actions/workflows/current.yml/badge.svg
[dotenv-merge-ci-i]: https://github.com/kettle-rb/dotenv-merge/actions/workflows/current.yml/badge.svg
[toml-merge-ci-i]: https://github.com/kettle-rb/toml-merge/actions/workflows/current.yml/badge.svg
[markdown-merge-ci-i]: https://github.com/kettle-rb/markdown-merge/actions/workflows/current.yml/badge.svg
[markly-merge-ci-i]: https://github.com/kettle-rb/markly-merge/actions/workflows/current.yml/badge.svg
[commonmarker-merge-ci-i]: https://github.com/kettle-rb/commonmarker-merge/actions/workflows/current.yml/badge.svg
[kettle-dev-ci-i]: https://github.com/kettle-rb/kettle-dev/actions/workflows/current.yml/badge.svg
[kettle-jem-ci-i]: https://github.com/kettle-rb/kettle-jem/actions/workflows/current.yml/badge.svg
[tree_haver-ci]: https://github.com/kettle-rb/tree_haver/actions/workflows/current.yml
[ast-merge-ci]: https://github.com/kettle-rb/ast-merge/actions/workflows/current.yml
[prism-merge-ci]: https://github.com/kettle-rb/prism-merge/actions/workflows/current.yml
[psych-merge-ci]: https://github.com/kettle-rb/psych-merge/actions/workflows/current.yml
[json-merge-ci]: https://github.com/kettle-rb/json-merge/actions/workflows/current.yml
[jsonc-merge-ci]: https://github.com/kettle-rb/jsonc-merge/actions/workflows/current.yml
[bash-merge-ci]: https://github.com/kettle-rb/bash-merge/actions/workflows/current.yml
[rbs-merge-ci]: https://github.com/kettle-rb/rbs-merge/actions/workflows/current.yml
[dotenv-merge-ci]: https://github.com/kettle-rb/dotenv-merge/actions/workflows/current.yml
[toml-merge-ci]: https://github.com/kettle-rb/toml-merge/actions/workflows/current.yml
[markdown-merge-ci]: https://github.com/kettle-rb/markdown-merge/actions/workflows/current.yml
[markly-merge-ci]: https://github.com/kettle-rb/markly-merge/actions/workflows/current.yml
[commonmarker-merge-ci]: https://github.com/kettle-rb/commonmarker-merge/actions/workflows/current.yml
[kettle-dev-ci]: https://github.com/kettle-rb/kettle-dev/actions/workflows/current.yml
[kettle-jem-ci]: https://github.com/kettle-rb/kettle-jem/actions/workflows/current.yml
[prism]: https://github.com/ruby/prism
[psych]: https://github.com/ruby/psych
[ffi]: https://github.com/ffi/ffi
[ts-json]: https://github.com/tree-sitter/tree-sitter-json
[ts-jsonc]: https://gitlab.com/WhyNotHugo/tree-sitter-jsonc
[ts-bash]: https://github.com/tree-sitter/tree-sitter-bash
[ts-rbs]: https://github.com/joker1007/tree-sitter-rbs
[ts-toml]: https://github.com/tree-sitter-grammars/tree-sitter-toml
[dotenv]: https://github.com/bkeepers/dotenv
[rbs]: https://github.com/ruby/rbs
[toml-rb]: https://github.com/emancu/toml-rb
[toml]: https://github.com/jm/toml
[markly]: https://github.com/ioquatix/markly
[commonmarker]: https://github.com/gjtorikian/commonmarker
[ruby_tree_sitter]: https://github.com/Faveod/ruby-tree-sitter
[tree_stump]: https://github.com/joker1007/tree_stump
[jtreesitter]: https://central.sonatype.com/artifact/io.github.tree-sitter/jtreesitter
[citrus]: https://github.com/mjackson/citrus
[parslet]: https://github.com/kschiess/parslet

### Comparison with Other Ruby AST / Parser Bindings

| Feature                   | [tree\_haver][📜src-gh] (this gem)              | [ruby\_tree\_sitter][ruby_tree_sitter] | [tree\_stump][tree_stump] | [citrus][citrus] | [parslet][parslet] |
|---------------------------|-------------------------------------------------|----------------------------------------|---------------------------|------------------|--------------------|
| **MRI Ruby**              | ✅ Yes                                           | ✅ Yes                                  | ✅ Yes                     | ✅ Yes            | ✅ Yes              |
| **JRuby**                 | ✅ Yes (FFI, Java, Citrus, or Parslet backend)   | ❌ No                                   | ❌ No                      | ✅ Yes            | ✅ Yes              |
| **TruffleRuby**           | ✅ Yes (FFI, Citrus, or Parslet)                 | ❌ No                                   | ❓ Unknown                 | ✅ Yes            | ✅ Yes              |
| **Backend**               | Multi (MRI C, Rust, FFI, Java, Citrus, Parslet) | C extension only                       | Rust extension            | Pure Ruby        | Pure Ruby          |
| **Incremental Parsing**   | ✅ Via MRI C/Rust/Java backend                   | ✅ Yes                                  | ✅ Yes                     | ❌ No             | ❌ No               |
| **Query API**             | ⚡ Via MRI/Rust/Java backend                     | ✅ Yes                                  | ✅ Yes                     | ❌ No             | ❌ No               |
| **Grammar Discovery**     | ✅ Built-in `GrammarFinder`                      | ❌ Manual                               | ❌ Manual                  | ❌ Manual         | ❌ Manual           |
| **Security Validations**  | ✅ `PathValidator`                               | ❌ No                                   | ❌ No                      | ❌ No             | ❌ No               |
| **Language Registration** | ✅ Thread-safe registry                          | ❌ No                                   | ❌ No                      | ❌ No             | ❌ No               |
| **Native Performance**    | ⚡ Backend-dependent                             | ✅ Native C                             | ✅ Native Rust             | ❌ Pure Ruby      | ❌ Pure Ruby        |
| **Precompiled Binaries**  | ⚡ Via Rust backend                              | ✅ Yes                                  | ✅ Yes                     | ✅ Pure Ruby      | ✅ Pure Ruby        |
| **Zero Native Deps**      | ⚡ Via Citrus/Parslet backend                    | ❌ No                                   | ❌ No                      | ✅ Yes            | ✅ Yes              |
| **Minimum Ruby**          | 3.2+                                            | 3.0+                                   | 3.1+                      | 0+               | 0+                 |

**Note:** Java backend works with grammar `.so` files built against tree-sitter 0.24+. The grammars must be rebuilt with `tree-sitter generate` if they were compiled against older tree-sitter versions. FFI is recommended for JRuby as it's easier to set up.

**Note:** TreeHaver can use `ruby_tree_sitter` (MRI) or `tree_stump` (MRI) as backends, or `java-tree-sitter` / `jtreesitter` \>= 0.26.0 ([docs](https://tree-sitter.github.io/java-tree-sitter/), [maven][jtreesitter], [source](https://github.com/tree-sitter/java-tree-sitter), JRuby), or FFI on any backend, giving you TreeHaver's unified API, grammar discovery, and security features, plus full access to incremental parsing when using those backends.

**Note:** Use `tree_stump` v0.2.0 or newer (fixes are released).

#### When to Use Each

**Choose TreeHaver when:**

- You need JRuby or TruffleRuby support
- You're building a library that should work across Ruby implementations
- You want automatic grammar discovery and security validations
- You want flexibility to switch backends without code changes
- You need incremental parsing with a unified API

**Choose ruby\_tree\_sitter directly when:**

- You only target MRI Ruby
- You need the full Query API without abstraction
- You want the most battle-tested C bindings
- You don't need TreeHaver's grammar discovery

**Choose tree\_stump directly when:**

- You only target MRI Ruby
- You prefer Rust-based native extensions
- You want precompiled binaries without system dependencies
- You don't need TreeHaver's grammar discovery
- **Note:** Use `tree_stump` v0.2.0 or newer (fixes are released).

**Choose citrus or parslet directly when:**

- You need zero native dependencies (pure Ruby)
- You're using a Citrus or Parslet grammar (not tree-sitter grammars)
- Performance is less critical than portability
- You don't need TreeHaver's unified API

## 💡 Info you can shake a stick at

| Tokens to Remember      | [![Gem name][⛳️name-img]][⛳️gem-name] [![Gem namespace][⛳️namespace-img]][⛳️gem-namespace]                                                                                                                                                                                                                                                                          |
|-------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Works with JRuby        | [![JRuby current Compat][💎jruby-c-i]][🚎10-j-wf] [![JRuby HEAD Compat][💎jruby-headi]][🚎3-hd-wf]|
| Works with Truffle Ruby | [![Truffle Ruby 24.2 Compat][💎truby-24.2i]][🚎truby-24.2-wf] [![Truffle Ruby 25.0 Compat][💎truby-25.0i]][🚎truby-25.0-wf] [![Truffle Ruby current Compat][💎truby-c-i]][🚎9-t-wf]|
| Works with MRI Ruby 4   | [![Ruby 4.0 Compat][💎ruby-4.0i]][🚎11-c-wf] [![Ruby current Compat][💎ruby-c-i]][🚎11-c-wf] [![Ruby HEAD Compat][💎ruby-headi]][🚎3-hd-wf]|
| Works with MRI Ruby 3   | [![Ruby 3.2 Compat][💎ruby-3.2i]][🚎ruby-3.2-wf] [![Ruby 3.3 Compat][💎ruby-3.3i]][🚎ruby-3.3-wf] [![Ruby 3.4 Compat][💎ruby-3.4i]][🚎ruby-3.4-wf]|
| Support & Community     | [![Join Me on Daily.dev's RubyFriends][✉️ruby-friends-img]][✉️ruby-friends] [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite] [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork] [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor]                                       |
| Source                  | [![Source on GitLab.com][📜src-gl-img]][📜src-gl] [![Source on CodeBerg.org][📜src-cb-img]][📜src-cb] [![Source on Github.com][📜src-gh-img]][📜src-gh] [![The best SHA: dQw4w9WgXcQ!][🧮kloc-img]][🧮kloc]                                                                                                                                                         |
| Documentation           | [![Current release on RubyDoc.info][📜docs-cr-rd-img]][🚎yard-current] [![YARD on Galtzo.com][📜docs-head-rd-img]][🚎yard-head] [![Maintainer Blog][🚂maint-blog-img]][🚂maint-blog] [![GitLab Wiki][📜gl-wiki-img]][📜gl-wiki] [![GitHub Wiki][📜gh-wiki-img]][📜gh-wiki]                                                                                          |
| Compliance              | [![License: AGPL-3.0-only][📄license-img]][📄license-ref] [![Apache license compatibility: Category X][📄license-compat-img]][📄license-compat] [![📄ilo-declaration-img]][📄ilo-declaration] [![Security Policy][🔐security-img]][🔐security] [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct] [![SemVer 2.0.0][📌semver-img]][📌semver] |
| Style                   | [![Enforced Code Style Linter][💎rlts-img]][💎rlts] [![Keep-A-Changelog 1.0.0][📗keep-changelog-img]][📗keep-changelog] [![Gitmoji Commits][📌gitmoji-img]][📌gitmoji] [![Compatibility appraised by: appraisal2][💎appraisal2-img]][💎appraisal2]                                                                                                                  |
| Maintainer 🎖️          | [![Follow Me on LinkedIn][💖🖇linkedin-img]][💖🖇linkedin] [![Follow Me on Ruby.Social][💖🐘ruby-mast-img]][💖🐘ruby-mast] [![Follow Me on Bluesky][💖🦋bluesky-img]][💖🦋bluesky] [![Contact Maintainer][🚂maint-contact-img]][🚂maint-contact] [![My technical writing][💖💁🏼‍♂️devto-img]][💖💁🏼‍♂️devto]                                                      |
| `...` 💖                | [![Find Me on WellFound:][💖✌️wellfound-img]][💖✌️wellfound] [![Find Me on CrunchBase][💖💲crunchbase-img]][💖💲crunchbase] [![My LinkTree][💖🌳linktree-img]][💖🌳linktree] [![More About Me][💖💁🏼‍♂️aboutme-img]][💖💁🏼‍♂️aboutme] [🧊][💖🧊berg] [🐙][💖🐙hub]  [🛖][💖🛖hut] [🧪][💖🧪lab]                                                                   |

### Compatibility

Compatible with MRI Ruby 3.2.0+, and concordant releases of JRuby, and TruffleRuby.

| 🚚 _Amazing_ test matrix was brought to you by | 🔎 appraisal2 🔎 and the color 💚 green 💚             |
|------------------------------------------------|--------------------------------------------------------|
| 👟 Check it out!                               | ✨ [github.com/appraisal-rb/appraisal2][💎appraisal2] ✨ |

### Federated DVCS

<details markdown="1">
  <summary>Find this repo on federated forges (Coming soon!)</summary>

| Federated [DVCS][💎d-in-dvcs] Repository        | Status                                                                | Issues                    | PRs                      | Wiki                      | CI                       | Discussions                  |
|-------------------------------------------------|-----------------------------------------------------------------------|---------------------------|--------------------------|---------------------------|--------------------------|------------------------------|
| 🧪 [kettle-rb/tree_haver on GitLab][📜src-gl]   | The Truth                                                             | [💚][🤝gl-issues]         | [💚][🤝gl-pulls]         | [💚][📜gl-wiki]           | 🐭 Tiny Matrix           | ➖                            |
| 🧊 [kettle-rb/tree_haver on CodeBerg][📜src-cb] | An Ethical Mirror ([Donate][🤝cb-donate])                             | [💚][🤝cb-issues]         | [💚][🤝cb-pulls]         | ➖                         | ⭕️ No Matrix             | ➖                            |
| 🐙 [kettle-rb/tree_haver on GitHub][📜src-gh]   | Another Mirror                                                        | [💚][🤝gh-issues]         | [💚][🤝gh-pulls]         | [💚][📜gh-wiki]           | 💯 Full Matrix           | [💚][gh-discussions]         |
| 🎮️ [Discord Server][✉️discord-invite]          | [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite] | [Let's][✉️discord-invite] | [talk][✉️discord-invite] | [about][✉️discord-invite] | [this][✉️discord-invite] | [library!][✉️discord-invite] |

</details>

[gh-discussions]: https://github.com/kettle-rb/tree_haver/discussions

### Enterprise Support [![Tidelift](https://tidelift.com/badges/package/rubygems/tree_haver)](https://tidelift.com/subscription/pkg/rubygems-tree_haver?utm_source=rubygems-tree_haver&utm_medium=referral&utm_campaign=readme)

Available as part of the Tidelift Subscription.

<details markdown="1">
  <summary>Need enterprise-level guarantees?</summary>

The maintainers of this and thousands of other packages are working with Tidelift to deliver commercial support and maintenance for the open source packages you use to build your applications. Save time, reduce risk, and improve code health, while paying the maintainers of the exact packages you use.

[![Get help from me on Tidelift][🏙️entsup-tidelift-img]][🏙️entsup-tidelift]

- 💡Subscribe for support guarantees covering _all_ your FLOSS dependencies
- 💡Tidelift is part of [Sonar][🏙️entsup-tidelift-sonar]
- 💡Tidelift pays maintainers to maintain the software you depend on!<br/>📊`@`Pointy Haired Boss: An [enterprise support][🏙️entsup-tidelift] subscription is "[never gonna let you down][🧮kloc]", and *supports* open source maintainers

Alternatively:

- [![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]
- [![Get help from me on Upwork][👨🏼‍🏫expsup-upwork-img]][👨🏼‍🏫expsup-upwork]
- [![Get help from me on Codementor][👨🏼‍🏫expsup-codementor-img]][👨🏼‍🏫expsup-codementor]

</details>

## ✨ Installation

Install the gem and add to the application's Gemfile by executing:

```console
bundle add tree_haver
```

If bundler is not being used to manage dependencies, install the gem by executing:

```console
gem install tree_haver
```

### 🔒 Secure Installation

<details markdown="1">
  <summary>For Medium or High Security Installations</summary>

This gem is cryptographically signed and has verifiable [SHA-256 and SHA-512][💎SHA_checksums] checksums by
[stone_checksums][💎stone_checksums]. Be sure the gem you install hasn’t been tampered with
by following the instructions below.

Add my public key (if you haven’t already; key expires 2045-04-29) as a trusted certificate:

```console
gem cert --add <(curl -Ls https://raw.github.com/galtzo-floss/certs/main/pboling.pem)
```

You only need to do that once.  Then proceed to install with:

```console
gem install tree_haver -P HighSecurity
```

The `HighSecurity` trust profile will verify signed gems, and not allow the installation of unsigned dependencies.

If you want to up your security game full-time:

```console
bundle config set --global trust-policy MediumSecurity
```

`MediumSecurity` instead of `HighSecurity` is necessary if not all the gems you use are signed.

NOTE: Be prepared to track down certs for signed gems and add them the same way you added mine.

</details>

## ⚙️ Configuration

### Available Backends

TreeHaver supports 10 parsing backends, each with different trade-offs. The `auto` backend automatically selects the best available option.

#### Tree-sitter Backends (Universal Parsing)

| Backend  | Description                           | Performance | Portability | Examples                                                                                                                        |
|----------|---------------------------------------|-------------|-------------|---------------------------------------------------------------------------------------------------------------------------------|
| **Auto** | Auto-selects best backend             | Varies      | ✅ Universal | [JSON](examples/auto_json.rb) · [JSONC](examples/auto_jsonc.rb) · [Bash](examples/auto_bash.rb) · [TOML](examples/auto_toml.rb) |
| **MRI**  | C extension via ruby\_tree\_sitter    | ⚡ Fastest   | MRI only    | [JSON](examples/mri_json.rb) · [JSONC](examples/mri_jsonc.rb) · \~\~Bash\~\~\* · [TOML](examples/mri_toml.rb)                   |
| **Rust** | Precompiled via tree\_stump           | ⚡ Very Fast | ✅ Good      | [JSON](examples/rust_json.rb) · [JSONC](examples/rust_jsonc.rb) · \~\~Bash\~\~\* · [TOML](examples/rust_toml.rb)                |
| **FFI**  | Dynamic linking via FFI               | 🔵 Fast     | ✅ Universal | [JSON](examples/ffi_json.rb) · [JSONC](examples/ffi_jsonc.rb) · [Bash](examples/ffi_bash.rb) · [TOML](examples/ffi_toml.rb)     |
| **Java** | JNI bindings (jtreesitter \>= 0.26.0) | ⚡ Very Fast | JRuby only  | [JSON](examples/java_json.rb) · [JSONC](examples/java_jsonc.rb) · [Bash](examples/java_bash.rb) · [TOML](examples/java_toml.rb) |

#### Language-Specific Backends (Native Parser Integration)

| Backend          | Description                 | Performance | Portability | Examples                                                                                                     |
|------------------|-----------------------------|-------------|-------------|--------------------------------------------------------------------------------------------------------------|
| **Prism**        | Ruby's official parser      | ⚡ Very Fast | ✅ Universal | [Ruby](examples/prism_ruby.rb)                                                                               |
| **Psych**        | Ruby's YAML parser (stdlib) | ⚡ Very Fast | ✅ Universal | [YAML](examples/psych_yaml.rb)                                                                               |
| **Commonmarker** | Markdown via comrak (Rust)  | ⚡ Very Fast | ✅ Good      | [Markdown](examples/commonmarker_markdown.rb) · [commonmarker-merge](examples/commonmarker_merge_example.rb) |
| **Markly**       | GFM via cmark-gfm (C)       | ⚡ Very Fast | ✅ Good      | [Markdown](examples/markly_markdown.rb) · [Merge](examples/markly_merge_example.rb)                          |
| **Citrus**       | Pure Ruby parsing           | 🟡 Slower   | ✅ Universal | [TOML](examples/citrus_toml.rb) · [Finitio](examples/citrus_finitio.rb) · [Dhall](examples/citrus_dhall.rb)  |
| **Parslet**      | Pure Ruby parsing           | 🟡 Slower   | ✅ Universal | [TOML](examples/parslet_toml.rb)                                                                             |

**Selection Priority (Auto mode):** MRI → Rust → FFI → Java → Prism → Psych → Commonmarker → Markly → Citrus → Parslet

**Known Issues:**

- \*MRI + Bash: ABI incompatibility (use FFI instead)
- \*Rust + Bash: Version mismatch (use FFI instead)
  **Backend Requirements:**

```ruby
# Tree-sitter backends
gem "ruby_tree_sitter", "~> 2.0"  # MRI backend
gem "tree_stump"                   # Rust backend
gem "ffi", ">= 1.15", "< 2.0"     # FFI backend
# Java backend: no gem required (uses JRuby's built-in JNI)

# Language-specific backends
gem "prism", "~> 1.0"              # Ruby parsing (stdlib in Ruby 3.4+)
# Psych: no gem required (Ruby stdlib)
gem "commonmarker", ">= 0.23"      # Markdown parsing (comrak)
gem "markly", "~> 0.11"            # GFM parsing (cmark-gfm)

# Pure Ruby fallbacks
gem "citrus", "~> 3.0"             # Citrus backend
gem "parslet", "~> 2.0"            # Parslet backend
# Plus grammar gems: toml-rb (citrus), toml (parslet), dhall, finitio, etc.
```

**Force Specific Backend:**

```ruby
# Tree-sitter backends
TreeHaver.backend = :mri    # Force MRI backend (ruby_tree_sitter)
TreeHaver.backend = :rust   # Force Rust backend (tree_stump)
TreeHaver.backend = :ffi    # Force FFI backend
TreeHaver.backend = :java   # Force Java backend (JRuby only)

# Language-specific backends
TreeHaver.backend = :prism        # Force Prism (Ruby parsing)
TreeHaver.backend = :psych        # Force Psych (YAML parsing)
TreeHaver.backend = :commonmarker # Force Commonmarker (Markdown)
TreeHaver.backend = :markly       # Force Markly (GFM Markdown)
TreeHaver.backend = :citrus       # Force Citrus (Pure Ruby PEG)
TreeHaver.backend = :parslet      # Force Parslet (Pure Ruby PEG)

# Auto-selection (default)
TreeHaver.backend = :auto   # Let TreeHaver choose
```

**Block-based Backend Switching:**

Use `with_backend` to temporarily switch backends for a specific block of code.
This is thread-safe and supports nesting—the previous backend is automatically
restored when the block exits (even if an exception is raised).

```ruby
# Temporarily use a specific backend
TreeHaver.with_backend(:mri) do
  parser = TreeHaver::Parser.new
  tree = parser.parse(source)
  # All operations in this block use the MRI backend
end
# Backend is restored to its previous value here

# Nested blocks work correctly
TreeHaver.with_backend(:rust) do
  # Uses :rust
  TreeHaver.with_backend(:citrus) do
    # Uses :citrus
    parser = TreeHaver::Parser.new
  end
  # Back to :rust
  TreeHaver.with_backend(:parslet) do
    # Uses :parslet
    parser = TreeHaver::Parser.new
  end
  # Back to :rust
end
# Back to original backend
```

This is particularly useful for:

- **Testing**: Test the same code with different backends
- **Performance comparison**: Benchmark different backends
- **Fallback scenarios**: Try one backend, fall back to another
- **Thread isolation**: Each thread can use a different backend safely

```ruby
# Example: Testing with multiple backends
[:mri, :rust, :citrus, :parslet].each do |backend_name|
  TreeHaver.with_backend(backend_name) do
    parser = TreeHaver::Parser.new
    result = parser.parse(source)
    puts "#{backend_name}: #{result.root_node.type}"
  end
end
```

**Check Backend Capabilities:**

```ruby
TreeHaver.backend              # => :ffi
TreeHaver.backend_module       # => TreeHaver::Backends::FFI
TreeHaver.capabilities         # => { backend: :ffi, parse: true, query: false, ... }
```

See [examples/](examples/) directory for **26 complete working examples** demonstrating all 10 backends with multiple languages (JSON, JSONC, Bash, TOML, Ruby, YAML, Markdown) plus markdown-merge integration examples.

### Security Considerations

**⚠️ Loading shared libraries (.so/.dylib/.dll) executes arbitrary native code.**

TreeHaver provides defense-in-depth validations, but you should understand the risks:

#### Attack Vectors Mitigated

TreeHaver's `PathValidator` module protects against:

- **Path traversal**: Paths containing `/../` or `/./` are rejected
- **Null byte injection**: Paths containing null bytes are rejected
- **Non-absolute paths**: Relative paths are rejected to prevent CWD-based attacks
- **Invalid extensions**: Only `.so`, `.dylib`, and `.dll` files are accepted
- **Malicious filenames**: Filenames must match a safe pattern (alphanumeric, hyphens, underscores)
- **Invalid language names**: Language names must be lowercase alphanumeric with underscores
- **Invalid symbol names**: Symbol names must be valid C identifiers

#### Secure Usage

```ruby
# Standard usage - paths from ENV are validated
finder = TreeHaver::GrammarFinder.new(:toml)
path = finder.find_library_path  # Validates ENV path before returning

# Maximum security - only trusted system directories
path = finder.find_library_path_safe  # Ignores ENV, only /usr/lib etc.

# Manual validation
if TreeHaver::PathValidator.safe_library_path?(user_provided_path)
  language = TreeHaver::Language.from_library(user_provided_path)
end

# Get validation errors for debugging
errors = TreeHaver::PathValidator.validation_errors(path)
# => ["Path is not absolute", "Path contains traversal sequence"]
```

#### Trusted Directories

The `find_library_path_safe` method only returns paths in trusted directories.

**Default trusted directories:**

- `/usr/lib`, `/usr/lib64`
- `/usr/lib/x86_64-linux-gnu`, `/usr/lib/aarch64-linux-gnu`
- `/usr/local/lib`
- `/opt/homebrew/lib`, `/opt/local/lib`
  **Adding custom trusted directories:**
  For non-standard installations (Homebrew on Linux, luarocks, mise, asdf, etc.), register additional trusted directories:

```ruby
# Programmatically at application startup
TreeHaver::PathValidator.add_trusted_directory("/home/linuxbrew/.linuxbrew/Cellar")
TreeHaver::PathValidator.add_trusted_directory("~/.local/share/mise/installs/lua")

# Or via environment variable (comma-separated, in your shell profile)
export TREE_HAVER_TRUSTED_DIRS = "/home/linuxbrew/.linuxbrew/Cellar,~/.local/share/mise/installs/lua"
```

**Example: Fedora Silverblue with Homebrew and luarocks**

```bash
# In ~/.bashrc or ~/.zshrc
export TREE_HAVER_TRUSTED_DIRS="/home/linuxbrew/.linuxbrew/Cellar,~/.local/share/mise/installs/lua"

# tree-sitter runtime library
export TREE_SITTER_RUNTIME_LIB=/home/linuxbrew/.linuxbrew/Cellar/tree-sitter/0.26.3/lib/libtree-sitter.so

# Language grammar (luarocks-installed)
export TREE_SITTER_TOML_PATH=~/.local/share/mise/installs/lua/5.4.8/luarocks/lib/luarocks/rocks-5.4/tree-sitter-toml/0.0.31-1/parser/toml.so
```

#### Recommendations

1.  **Production**: Consider using `find_library_path_safe` to ignore ENV overrides
2.  **Development**: Standard `find_library_path` is convenient for testing
3.  **User Input**: Always validate paths before passing to `Language.from_library`
4.  **CI/CD**: Be cautious of ENV vars that could be set by untrusted sources
5.  **Custom installs**: Register trusted directories via `TREE_HAVER_TRUSTED_DIRS` or `add_trusted_directory`

### Backend Selection

TreeHaver automatically selects the best backend for your Ruby implementation, but you can override this behavior:

```ruby
# Automatic backend selection (default)
TreeHaver.backend = :auto

# Force a specific backend
TreeHaver.backend = :mri     # Use ruby_tree_sitter (MRI only, C extension)
TreeHaver.backend = :rust    # Use tree_stump (MRI, Rust extension with precompiled binaries)
                             # Note: Use tree_stump v0.2.0 or newer (fixes are released).
TreeHaver.backend = :ffi     # Use FFI bindings (works on MRI and JRuby)
TreeHaver.backend = :java    # Use Java bindings (JRuby only, coming soon)
TreeHaver.backend = :citrus  # Use Citrus pure Ruby parser
                             # NOTE: Portable, all Ruby implementations
                             # CAVEAT: few major language grammars, but many esoteric grammars
TreeHaver.backend = :parslet # Use Parslet pure Ruby parser
                             # NOTE: Portable, all Ruby implementations
                             # CAVEAT: few major language grammars, but many esoteric grammars
```

**Auto-selection priority on MRI:** MRI → Rust → FFI → Citrus → Parslet

You can also set the backend via environment variable:

```bash
export TREE_HAVER_BACKEND=rust
```

### Backend Registry

TreeHaver provides a `BackendRegistry` module that allows external gems to register their backend availability checkers. This enables dynamic backend detection without hardcoding dependencies.

#### Registering a Backend Availability Checker

External gems (like `commonmarker-merge`, `markly-merge`, `rbs-merge`) can register their availability checker when loaded:

```ruby
# In your gem's backend module
TreeHaver::BackendRegistry.register_availability_checker(:my_backend) do
  # Return true if backend is available
  require "my_backend_gem"
  true
rescue LoadError
  false
end
```

#### Checking Backend Availability

```ruby
# Check if a backend is available
TreeHaver::BackendRegistry.available?(:commonmarker)  # => true/false
TreeHaver::BackendRegistry.available?(:markly)        # => true/false
TreeHaver::BackendRegistry.available?(:rbs)           # => true/false

# Check if a checker is registered
TreeHaver::BackendRegistry.registered?(:my_backend)   # => true/false

# Get all registered backend names
TreeHaver::BackendRegistry.registered_backends        # => [:mri, :rust, :ffi, ...]
```

#### How It Works

1. Built-in backends (MRI, Rust, FFI, Java, Prism, Psych, Citrus, Parslet) automatically register their checkers when loaded
2. External gems register their checkers when their backend module is loaded
3. `TreeHaver::RSpec::DependencyTags` uses the registry to dynamically detect available backends
4. Results are cached for performance (use `clear_cache!` to reset)

#### RSpec Integration

The `BackendRegistry` is used by `TreeHaver::RSpec::DependencyTags` to configure RSpec exclusion filters:

```ruby
# In your spec_helper.rb
require "tree_haver/rspec/dependency_tags"

# Then in specs, use tags to skip tests when backends aren't available
it "requires commonmarker", :commonmarker_backend do
  # This test only runs when commonmarker is available
end

it "requires markly", :markly_backend do
  # This test only runs when markly is available
end
```

### Environment Variables

TreeHaver recognizes several environment variables for configuration:

**Note**: All path-based environment variables are validated before use. Invalid paths are ignored.

#### Security Configuration

- **`TREE_HAVER_TRUSTED_DIRS`**: Comma-separated list of additional trusted directories for grammar libraries

  ```bash
  # For Homebrew on Linux and luarocks
  export TREE_HAVER_TRUSTED_DIRS="/home/linuxbrew/.linuxbrew/Cellar,~/.local/share/mise/installs/lua"
  ```

  Tilde (`~`) is expanded to the user's home directory. Directories listed here are considered safe for `find_library_path_safe`.

#### Core Runtime Library

- **`TREE_SITTER_RUNTIME_LIB`**: Absolute path to the core `libtree-sitter` shared library
  ```bash
  export TREE_SITTER_RUNTIME_LIB=/usr/local/lib/libtree-sitter.so
  ```

If not set, TreeHaver tries these names in order:

- `tree-sitter`
- `libtree-sitter.so.0`
- `libtree-sitter.so`
- `libtree-sitter.dylib`
- `libtree-sitter.dll`

#### Language Symbol Resolution

When loading a language grammar, if you don't specify the `symbol:` parameter, TreeHaver resolves it in this precedence:

1.  **`TREE_SITTER_LANG_SYMBOL`**: Explicit symbol override
2.  Guessed from filename (e.g., `libtree-sitter-toml.so` → `tree_sitter_toml`)
3.  Default fallback (`tree_sitter_toml`)

```bash
export TREE_SITTER_LANG_SYMBOL=tree_sitter_toml
```

#### Language Library Paths

For specific languages, you can set environment variables to point to grammar libraries:

```bash
export TREE_SITTER_TOML_PATH=/usr/local/lib/libtree-sitter-toml.so
export TREE_SITTER_JSON_PATH=/usr/local/lib/libtree-sitter-json.so
```

#### JRuby-Specific: Java Backend Configuration

For the Java backend on JRuby, you need:

1.  **jtreesitter \>= 0.26.0** JAR from Maven Central
2.  **Tree-sitter runtime library** (`libtree-sitter.so`) version 0.26+
3.  **Grammar `.so` files** built against tree-sitter 0.26+

```bash
# Download jtreesitter JAR (or use bin/setup-jtreesitter)
export TREE_SITTER_JAVA_JARS_DIR=/path/to/java-tree-sitter/jars

# Point to tree-sitter runtime (must be 0.26+)
export TREE_SITTER_RUNTIME_LIB=/usr/local/lib/libtree-sitter.so

# Point to grammar libraries (must be built for tree-sitter 0.26+)
export TREE_SITTER_TOML_PATH=/path/to/libtree-sitter-toml.so
```

**Building grammars for Java backend:**

If you get "version mismatch" errors, rebuild the grammar:

```bash
# Use the provided build script
bin/build-grammar toml

# This regenerates parser.c for your tree-sitter version and compiles it
```

For more see [docs](https://tree-sitter.github.io/java-tree-sitter/), [maven][jtreesitter], and [source](https://github.com/tree-sitter/java-tree-sitter).

### Language Registration

Register languages once at application startup for convenient access:

```ruby
# Register a TOML grammar
TreeHaver.register_language(
  :toml,
  path: "/usr/local/lib/libtree-sitter-toml.so",
  symbol: "tree_sitter_toml",  # optional, will be inferred if omitted
)

# Now you can use the convenient helper
language = TreeHaver::Language.toml

# Or still override path/symbol per-call
language = TreeHaver::Language.toml(
  path: "/custom/path/libtree-sitter-toml.so",
)
```

### Grammar Discovery with GrammarFinder

For libraries that need to automatically locate tree-sitter grammars (like the `*-merge` family of gems), TreeHaver provides the `GrammarFinder` utility class. It handles platform-aware grammar discovery without requiring language-specific code in TreeHaver itself.

```ruby
# Create a finder for any language
finder = TreeHaver::GrammarFinder.new(:toml)

# Check if the grammar is available
if finder.available?
  puts "TOML grammar found at: #{finder.find_library_path}"
else
  puts finder.not_found_message
  # => "tree-sitter toml grammar not found. Searched: /usr/lib/libtree-sitter-toml.so, ..."
end

# Register the language if available
finder.register! if finder.available?

# Now use the registered language
language = TreeHaver::Language.toml
```

#### GrammarFinder Automatic Derivation

Given just the language name, `GrammarFinder` automatically derives:

| Property         | Derived Value (for `:toml`)                          |
|------------------|------------------------------------------------------|
| ENV var          | `TREE_SITTER_TOML_PATH`                              |
| Library filename | `libtree-sitter-toml.so` (Linux) or `.dylib` (macOS) |
| Symbol name      | `tree_sitter_toml`                                   |

#### Search Order

`GrammarFinder` searches for grammars in this order:

1.  **Environment variable**: `TREE_SITTER_<LANG>_PATH` (highest priority)
2.  **Extra paths**: Custom paths provided at initialization
3.  **System paths**: Common installation directories (`/usr/lib`, `/usr/local/lib`, `/opt/homebrew/lib`, etc.)

#### Usage in \*-merge Gems

The `GrammarFinder` pattern enables clean integration in language-specific merge gems:

```ruby
# In toml-merge
finder = TreeHaver::GrammarFinder.new(:toml)
finder.register! if finder.available?

# In json-merge
finder = TreeHaver::GrammarFinder.new(:json)
finder.register! if finder.available?

# In bash-merge
finder = TreeHaver::GrammarFinder.new(:bash)
finder.register! if finder.available?
```

Each gem uses the same API—only the language name changes.

#### Adding Custom Search Paths

For non-standard installations, provide extra search paths:

```ruby
finder = TreeHaver::GrammarFinder.new(:toml, extra_paths: [
  "/opt/custom/lib",
  "/home/user/.local/lib",
])
```

#### Debug Information

Get detailed information about the grammar search:

```ruby
finder = TreeHaver::GrammarFinder.new(:toml)
puts finder.search_info
# => {
#      language: :toml,
#      env_var: "TREE_SITTER_TOML_PATH",
#      env_value: nil,
#      symbol: "tree_sitter_toml",
#      library_filename: "libtree-sitter-toml.so",
#      search_paths: ["/usr/lib/libtree-sitter-toml.so", ...],
#      found_path: "/usr/lib/libtree-sitter-toml.so",
#      available: true
#    }
```

### Checking Capabilities

Different backends may support different features:

```ruby
TreeHaver.capabilities
# => { backend: :mri, query: true, bytes_field: true }
# or
# => { backend: :ffi, parse: true, query: false, bytes_field: true }
# or
# => { backend: :citrus, parse: true, query: false, bytes_field: false }
# or
# => { backend: :parslet, parse: true, query: false, bytes_field: false }
```

### Compatibility Mode

For codebases migrating from `ruby_tree_sitter`, TreeHaver provides a compatibility shim:

```ruby
require "tree_haver/compat"

# Now TreeSitter constants map to TreeHaver
parser = TreeSitter::Parser.new  # Actually creates TreeHaver::Parser
```

This is safe and idempotent—if the real `TreeSitter` module is already loaded, the shim does nothing.

#### ⚠️ Important: Exception Hierarchy

**Both ruby\_tree\_sitter v2+ and TreeHaver exceptions inherit from `Exception` (not `StandardError`).**

This design decision follows ruby\_tree\_sitter's lead for thread-safety and signal handling reasons. See [ruby\_tree\_sitter PR \#83](https://github.com/Faveod/ruby-tree-sitter/pull/83) for the rationale.

**What this means for exception handling:**

```ruby
# ⚠️ This will NOT catch TreeHaver errors
begin
  TreeHaver::Language.from_library("/nonexistent.so")
rescue => e
  puts "Caught!"  # Never reached - TreeHaver::Error inherits Exception
end

# ✅ Explicit rescue is required
begin
  TreeHaver::Language.from_library("/nonexistent.so")
rescue TreeHaver::Error => e
  puts "Caught!"  # This works
end

# ✅ Or rescue specific exceptions
begin
  TreeHaver::Language.from_library("/nonexistent.so")
rescue TreeHaver::NotAvailable => e
  puts "Grammar not available: #{e.message}"
end
```

**TreeHaver Exception Hierarchy:**

    Exception
    └── TreeHaver::Error              # Base error class
        ├── TreeHaver::NotAvailable   # Backend/grammar not available
        └── TreeHaver::BackendConflict # Backend incompatibility detected

**Compatibility Mode Behavior:**

The compat mode (`require "tree_haver/compat"`) creates aliases but **does not change the exception hierarchy**:

```ruby
require "tree_haver/compat"

# TreeSitter constants are now aliases to TreeHaver
TreeSitter::Error       # => TreeHaver::Error (still inherits Exception)
TreeSitter::Parser      # => TreeHaver::Parser
TreeSitter::Language    # => TreeHaver::Language

# Exception handling remains the same
begin
  TreeSitter::Language.load("missing", "/nonexistent.so")
rescue TreeSitter::Error => e  # Still requires explicit rescue
  puts "Error: #{e.message}"
end
```

**Best Practices:**

1.  **Always use explicit rescue** for TreeHaver errors:

    ```ruby
    begin
      finder = TreeHaver::GrammarFinder.new(:toml)
      finder.register! if finder.available?
      language = TreeHaver::Language.toml
    rescue TreeHaver::NotAvailable => e
      warn("TOML grammar not available: #{e.message}")
      # Fallback to another backend or fail gracefully
    end
    ```

2.  **Never rely on `rescue => e`** to catch TreeHaver errors (it won't work)
    **Why inherit from Exception?**
    Following ruby\_tree\_sitter's reasoning:

- **Thread safety**: Prevents accidental catching in thread cleanup code
- **Signal handling**: Ensures parsing errors don't interfere with SIGTERM/SIGINT
- **Intentional handling**: Forces developers to explicitly handle parsing errors
  See `lib/tree_haver/compat.rb` for compatibility layer documentation.

## 🔧 Basic Usage

### Quick Start

The simplest way to parse code is with `TreeHaver.parser_for`, which handles all the complexity of language loading, grammar discovery, and backend selection:

```ruby
require "tree_haver"

# Parse TOML - auto-discovers grammar and falls back to Citrus if needed
parser = TreeHaver.parser_for(:toml)
tree = parser.parse("[package]\nname = \"my-app\"")

# Parse JSON
parser = TreeHaver.parser_for(:json)
tree = parser.parse('{"key": "value"}')

# Parse Bash
parser = TreeHaver.parser_for(:bash)
tree = parser.parse("#!/bin/bash\necho hello")

# With explicit library path
parser = TreeHaver.parser_for(:toml, library_path: "/custom/path/libtree-sitter-toml.so")

# With Citrus fallback configuration
parser = TreeHaver.parser_for(
  :toml,
  citrus_config: {gem_name: "toml-rb", grammar_const: "TomlRB::Document"},
)
```

`TreeHaver.parser_for` handles:

1.  Checking if the language is already registered
2.  Auto-discovering tree-sitter grammar via `GrammarFinder`
3.  Falling back to Citrus grammar if tree-sitter is unavailable
4.  Creating and configuring the parser
5.  Raising `NotAvailable` with a helpful message if nothing works

### Manual Parser Setup

For more control, you can create parsers manually:

TreeHaver works with any language through its 10 backends. Here are examples for different parsing needs:

#### Parsing with Tree-sitter (Universal Languages)

```ruby
require "tree_haver"

# Load a tree-sitter grammar (works with MRI, Rust, FFI, or Java backend)
language = TreeHaver::Language.from_library(
  "/usr/local/lib/libtree-sitter-toml.so",
  symbol: "tree_sitter_toml",
)

# Create a parser
parser = TreeHaver::Parser.new
parser.language = language

# Parse source code
source = <<~TOML
  [package]
  name = "my-app"
  version = "1.0.0"
TOML

tree = parser.parse(source)

# Access the unified Position API (works across all backends)
root = tree.root_node
puts "Root type: #{root.type}"              # => "document"
puts "Start line: #{root.start_line}"       # => 1 (1-based)
puts "End line: #{root.end_line}"           # => 3
puts "Position: #{root.source_position}"    # => {start_line: 1, end_line: 3, ...}

# Traverse the tree
root.each do |child|
  puts "Child: #{child.type} at line #{child.start_line}"
end
```

#### Parsing Ruby with Prism

```ruby
require "tree_haver"

TreeHaver.backend = :prism
parser = TreeHaver::Parser.new
parser.language = TreeHaver::Backends::Prism::Language.ruby

source = <<~RUBY
  class Example
    def hello
      puts "Hello, world!"
    end
  end
RUBY

tree = parser.parse(source)
root = tree.root_node

# Find all method definitions
def find_methods(node, results = [])
  results << node if node.type == "def_node"
  node.children.each { |child| find_methods(child, results) }
  results
end

methods = find_methods(root)
methods.each do |method_node|
  pos = method_node.source_position
  puts "Method at lines #{pos[:start_line]}-#{pos[:end_line]}"
end
```

#### Parsing YAML with Psych

```ruby
require "tree_haver"

TreeHaver.backend = :psych
parser = TreeHaver::Parser.new
parser.language = TreeHaver::Backends::Psych::Language.yaml

source = <<~YAML
  database:
    host: localhost
    port: 5432
YAML

tree = parser.parse(source)
root = tree.root_node

# Navigate YAML structure
def show_structure(node, indent = 0)
  prefix = "  " * indent
  puts "#{prefix}#{node.type} (line #{node.start_line})"
  node.children.each { |child| show_structure(child, indent + 1) }
end

show_structure(root)
```

#### Parsing Markdown with Commonmarker or Markly

```ruby
require "tree_haver"

# Choose your backend
TreeHaver.backend = :commonmarker  # or :markly for GFM

parser = TreeHaver::Parser.new
parser.language = TreeHaver::Backends::Commonmarker::Language.markdown

source = <<~MARKDOWN
  # My Document

  ## Section

  - Item 1
  - Item 2
MARKDOWN

tree = parser.parse(source)
root = tree.root_node

# Find all headings
def find_headings(node, results = [])
  results << node if node.type == "heading"
  node.children.each { |child| find_headings(child, results) }
  results
end

headings = find_headings(root)
headings.each do |heading|
  level = heading.header_level
  text = heading.children.map(&:text).join
  puts "H#{level}: #{text} (line #{heading.start_line})"
end
```

### Using Language Registration

For cleaner code, register languages at startup:

```ruby
# At application initialization
TreeHaver.register_language(
  :toml,
  path: "/usr/local/lib/libtree-sitter-toml.so",
)

TreeHaver.register_language(
  :json,
  path: "/usr/local/lib/libtree-sitter-json.so",
)

# Later in your code
toml_language = TreeHaver::Language.toml
json_language = TreeHaver::Language.json

parser = TreeHaver::Parser.new
parser.language = toml_language
tree = parser.parse(toml_source)
```

#### Flexible Language Names

The `name` parameter in `register_language` is an arbitrary identifier you choose—it doesn't
need to match the actual language name. The actual grammar identity comes from the `path`
and `symbol` parameters (for tree-sitter) or `grammar_module` (for Citrus/Parslet).

This flexibility is useful for:

- **Aliasing**: Register the same grammar under multiple names
- **Versioning**: Register different grammar versions (e.g., `:ruby_2`, `:ruby_3`)
- **Testing**: Use unique names to avoid collisions between tests
- **Context-specific naming**: Use names that make sense for your application

```ruby
# Register the same TOML grammar under different names for different purposes
TreeHaver.register_language(
  :config_parser,  # Custom name for your app
  path: "/usr/local/lib/libtree-sitter-toml.so",
  symbol: "tree_sitter_toml",
)

TreeHaver.register_language(
  :toml_v1,  # Version-specific name
  path: "/usr/local/lib/libtree-sitter-toml.so",
  symbol: "tree_sitter_toml",
)

# Use your custom names
config_lang = TreeHaver::Language.config_parser
versioned_lang = TreeHaver::Language.toml_v1
```

### Parsing Different Languages

TreeHaver works with any tree-sitter grammar:

```ruby
# Parse Ruby code
ruby_lang = TreeHaver::Language.from_library(
  "/path/to/libtree-sitter-ruby.so",
)
parser = TreeHaver::Parser.new
parser.language = ruby_lang
tree = parser.parse("class Foo; end")

# Parse JavaScript
js_lang = TreeHaver::Language.from_library(
  "/path/to/libtree-sitter-javascript.so",
)
parser.language = js_lang  # Reuse the same parser
tree = parser.parse("const x = 42;")
```

### Walking the AST

TreeHaver provides simple node traversal:

```ruby
tree = parser.parse(source)
root = tree.root_node

# Recursive tree walk
def walk_tree(node, depth = 0)
  puts "#{"  " * depth}#{node.type}"
  node.each { |child| walk_tree(child, depth + 1) }
end

walk_tree(root)
```

### Incremental Parsing

TreeHaver supports incremental parsing when using the MRI or Rust backends. This is a major performance optimization for editors and IDEs that need to re-parse on every keystroke.

```ruby
# Check if current backend supports incremental parsing
if TreeHaver.capabilities[:incremental]
  puts "Incremental parsing is available!"
end

# Initial parse
parser = TreeHaver::Parser.new
parser.language = language
tree = parser.parse_string(nil, "x = 1")

# User edits the source: "x = 1" -> "x = 42"
# Mark the tree as edited (tell tree-sitter what changed)
tree.edit(
  start_byte: 4,           # edit starts at byte 4
  old_end_byte: 5,         # old text "1" ended at byte 5
  new_end_byte: 6,         # new text "42" ends at byte 6
  start_point: {row: 0, column: 4},
  old_end_point: {row: 0, column: 5},
  new_end_point: {row: 0, column: 6},
)

# Re-parse incrementally - tree-sitter reuses unchanged nodes
new_tree = parser.parse_string(tree, "x = 42")
```

**Note:** Incremental parsing requires the MRI (`ruby_tree_sitter`), Rust (`tree_stump`), or Java (`java-tree-sitter` / `jtreesitter`) backend. The FFI, Citrus, and Parslet backends do not currently support incremental parsing. You can check support with:

**Note:** `tree_stump` currently requires unreleased fixes in the `main` branch.

```ruby
tree.supports_editing?  # => true if edit() is available
```

### Error Handling

```ruby
begin
  language = TreeHaver::Language.from_library("/path/to/grammar.so")
rescue TreeHaver::NotAvailable => e
  puts "Failed to load grammar: #{e.message}"
end

# Check if a backend is available
if TreeHaver.backend_module.nil?
  puts "No TreeHaver backend is available!"
  puts "Install ruby_tree_sitter (MRI), ffi gem with libtree-sitter, citrus gem, or parslet gem"
end
```

### Platform-Specific Examples

#### MRI Ruby

On MRI, TreeHaver uses `ruby_tree_sitter` by default:

```ruby
# Gemfile
gem "tree_haver"
gem "ruby_tree_sitter"  # MRI backend

# Code - no changes needed, TreeHaver auto-selects MRI backend
parser = TreeHaver::Parser.new
```

#### JRuby

On JRuby, TreeHaver can use the FFI backend, Java backend, Citrus backend, or Parslet backend:

##### Option 1: FFI Backend (recommended for tree-sitter grammars)

```ruby
# Gemfile
gem "tree_haver"
gem "ffi"  # Required for FFI backend

# Ensure libtree-sitter is installed on your system
# On macOS with Homebrew:
#   brew install tree-sitter

# On Ubuntu/Debian:
#   sudo apt-get install libtree-sitter0 libtree-sitter-dev

# Code - TreeHaver auto-selects FFI backend on JRuby
parser = TreeHaver::Parser.new
```

##### Option 2: Java Backend (native JVM performance)

```bash
# 1. Download java-tree-sitter JAR from Maven Central
mkdir -p vendor/jars
curl -fSL -o vendor/jars/jtreesitter-0.23.2.jar \
  "https://repo1.maven.org/maven2/io/github/tree-sitter/jtreesitter/0.23.2/jtreesitter-0.23.2.jar"

# 2. Set environment variables
export CLASSPATH="$(pwd)/vendor/jars:$CLASSPATH"
export LD_LIBRARY_PATH="/path/to/libtree-sitter/lib:$LD_LIBRARY_PATH"

# 3. Run with JRuby (requires Java 22+ for Foreign Function API)
JAVA_OPTS="--enable-native-access=ALL-UNNAMED" jruby your_script.rb
```

```ruby
# Force Java backend
TreeHaver.backend = :java

# Check if Java backend is available
if TreeHaver::Backends::Java.available?
  puts "Java backend is ready!"
  puts TreeHaver.capabilities
  # => { backend: :java, parse: true, query: true, bytes_field: true, incremental: true }
end
```

**⚠️ Java Backend Limitation: Symbol Resolution**

The Java backend uses Java's Foreign Function & Memory (FFM) API which loads libraries in isolation. Unlike the system's dynamic linker (`dlopen`), FFM's `SymbolLookup.or()` chains symbol lookups but doesn't resolve dynamic library dependencies.

This means grammar `.so` files with unresolved references to `libtree-sitter.so` symbols won't load correctly. Most grammars from luarocks, npm, or other sources have these dependencies.

**Recommended approach for JRuby:** Use the **FFI backend**:

```ruby
# On JRuby, use FFI backend (recommended)
TreeHaver.backend = :ffi
```

The FFI backend uses Ruby's FFI gem which relies on the system's dynamic linker, correctly resolving symbol dependencies between `libtree-sitter.so` and grammar libraries.

The Java backend will work with:

- Grammar JARs built specifically for java-tree-sitter / jtreesitter (self-contained, [docs](https://tree-sitter.github.io/java-tree-sitter/), [maven][jtreesitter], [source](https://github.com/tree-sitter/java-tree-sitter))
- Grammar `.so` files that statically link tree-sitter

##### Option 3: Citrus Backend (pure Ruby, portable)

```ruby
# Gemfile
gem "tree_haver"
gem "citrus"  # Pure Ruby parser, zero native dependencies

# Code - Force Citrus backend for maximum portability
TreeHaver.backend = :citrus

# Check if Citrus backend is available
if TreeHaver::Backends::Citrus.available?
  puts "Citrus backend is ready!"
  puts TreeHaver.capabilities
  # => { backend: :citrus, parse: true, query: false, bytes_field: false }
end
```

**⚠️ Citrus Backend Limitations:**

- Uses Citrus grammars (not tree-sitter grammars)
- No incremental parsing support
- No query API
- Pure Ruby performance (slower than native backends)
- Best for: prototyping, environments without native extension support, teaching

##### Option 4: Parslet Backend (pure Ruby, portable)

```ruby
# Gemfile
gem "tree_haver"
gem "parslet"  # Pure Ruby parser, zero native dependencies

# Code - Force Parslet backend for maximum portability
TreeHaver.backend = :parslet

# Check if Parslet backend is available
if TreeHaver::Backends::Parslet.available?
  puts "Parslet backend is ready!"
  puts TreeHaver.capabilities
  # => { backend: :parslet, parse: true, query: false, bytes_field: false }
end
```

**⚠️ Parslet Backend Limitations:**

- Uses Parslet grammars (not tree-sitter grammars)
- No incremental parsing support
- No query API
- Pure Ruby performance (slower than native backends)
- Best for: prototyping, environments without native extension support, teaching

#### TruffleRuby

TruffleRuby can use the MRI, FFI, Citrus, or Parslet backend:

```ruby
# Use FFI backend (recommended for tree-sitter grammars)
TreeHaver.backend = :ffi

# Or try MRI backend if ruby_tree_sitter compiles on your TruffleRuby version
TreeHaver.backend = :mri

# Or use Citrus backend for zero native dependencies
TreeHaver.backend = :citrus

# Or use Parslet backend for zero native dependencies
TreeHaver.backend = :parslet
```

### Advanced: Thread-Safe Backend Switching

TreeHaver provides `with_backend` for thread-safe, temporary backend switching. This is
essential for testing, benchmarking, and applications that need different backends in
different contexts.

#### Testing with Multiple Backends

Test the same code path with different backends using `with_backend`:

```ruby
# In your test setup
RSpec.describe("MyParser") do
  # Test with each available backend
  [:mri, :rust, :citrus, :parslet].each do |backend_name|
    context "with #{backend_name} backend" do
      it "parses correctly" do
        TreeHaver.with_backend(backend_name) do
          parser = TreeHaver::Parser.new
          result = parser.parse("x = 42")
          expect(result.root_node.type).to(eq("document"))
        end
        # Backend automatically restored after block
      end
    end
  end
end
```

#### Thread Isolation

Each thread can use a different backend safely—`with_backend` uses thread-local storage:

```ruby
threads = []

threads << Thread.new do
  TreeHaver.with_backend(:mri) do
    # This thread uses MRI backend
    parser = TreeHaver::Parser.new
    100.times { parser.parse("x = 1") }
  end
end

threads << Thread.new do
  TreeHaver.with_backend(:citrus) do
    # This thread uses Citrus backend simultaneously
    parser = TreeHaver::Parser.new
    100.times { parser.parse("x = 1") }
  end
end

threads << Thread.new do
  TreeHaver.with_backend(:parslet) do
    # This thread uses Parslet backend simultaneously
    parser = TreeHaver::Parser.new
    100.times { parser.parse("x = 1") }
  end
end

threads.each(&:join)
```

#### Nested Blocks

`with_backend` supports nesting—inner blocks override outer blocks:

```ruby
TreeHaver.with_backend(:rust) do
  puts TreeHaver.effective_backend  # => :rust

  TreeHaver.with_backend(:citrus) do
    puts TreeHaver.effective_backend  # => :citrus
  end

  TreeHaver.with_backend(:parslet) do
    puts TreeHaver.effective_backend  # => :parslet
  end

  puts TreeHaver.effective_backend  # => :rust (restored)
end
```

#### Fallback Pattern

Try one backend, fall back to another on failure:

```ruby
def parse_with_fallback(source)
  TreeHaver.with_backend(:mri) do
    TreeHaver::Parser.new.tap { |p| p.language = load_language }.parse(source)
  end
rescue TreeHaver::NotAvailable
  # Fall back to Citrus if MRI backend unavailable
  TreeHaver.with_backend(:citrus) do
    TreeHaver::Parser.new.tap { |p| p.language = load_language }.parse(source)
  end
rescue TreeHaver::NotAvailable
  # Fall back to Parslet if Citrus backend unavailable
  TreeHaver.with_backend(:parslet) do
    TreeHaver::Parser.new.tap { |p| p.language = load_language }.parse(source)
  end
end
```

### Complete Real-World Example

Here's a practical example that extracts package names from a TOML file:

```ruby
require "tree_haver"

# Setup
TreeHaver.register_language(
  :toml,
  path: "/usr/local/lib/libtree-sitter-toml.so",
)

def extract_package_name(toml_content)
  # Create parser
  parser = TreeHaver::Parser.new
  parser.language = TreeHaver::Language.toml

  # Parse
  tree = parser.parse(toml_content)
  root = tree.root_node

  # Find [package] table
  root.each do |child|
    next unless child.type == "table"

    child.each do |table_elem|
      if table_elem.type == "pair"
        # Look for name = "..." pair
        key = table_elem.each.first&.type
        # In a real implementation, you'd extract the text value
        # This is simplified for demonstration
      end
    end
  end
end

# Usage
toml = <<~TOML
  [package]
  name = "awesome-app"
  version = "2.0.0"
TOML

package_name = extract_package_name(toml)
```

### 🧪 RSpec Integration

TreeHaver provides shared RSpec helpers for conditional test execution based on dependency availability. This is useful for testing code that uses optional backends.

```ruby
# In your spec_helper.rb
require "tree_haver/rspec"
```

This automatically configures RSpec with exclusion filters for all TreeHaver dependencies. Use tags to conditionally run tests:

```ruby
# Runs only when FFI backend is available
it "parses with FFI", :ffi do
  # ...
end

# Runs only when ruby_tree_sitter gem is available
it "uses MRI backend", :mri_backend do
  # ...
end

# Runs only when tree-sitter-toml grammar works
it "parses TOML", :tree_sitter_toml do
  # ...
end

# Runs only when any markdown backend is available
it "parses markdown", :markdown_backend do
  # ...
end
```

**Available Tags:**

Tags follow a naming convention:

- `*_backend` = TreeHaver backends (mri, rust, ffi, java, prism, psych, commonmarker, markly, citrus, parslet, rbs)
- `*_engine` = Ruby engines (mri, jruby, truffleruby)
- `*_grammar` = tree-sitter grammar files (.so)
- `*_parsing` = any parsing capability for a language (combines multiple backends/grammars)
- `*_gem` = specific library gems

| Tag                     | Description                                                               |
|-------------------------|---------------------------------------------------------------------------|
| **Backend Tags**        |                                                                           |
| `:ffi_backend`          | FFI backend available (dynamic check, legacy alias: `:ffi`)               |
| `:ffi_backend_only`     | FFI backend in isolation (won't trigger MRI check)                        |
| `:mri_backend`          | ruby\_tree\_sitter gem available                                          |
| `:mri_backend_only`     | MRI backend in isolation (won't trigger FFI check)                        |
| `:rust_backend`         | tree\_stump gem available                                                 |
| `:java_backend`         | Java backend available (JRuby + jtreesitter)                              |
| `:prism_backend`        | Prism gem available                                                       |
| `:psych_backend`        | Psych available (stdlib)                                                  |
| `:commonmarker_backend` | commonmarker gem available                                                |
| `:markly_backend`       | markly gem available                                                      |
| `:citrus_backend`       | Citrus gem available                                                      |
| `:parslet_backend`      | Parslet gem available                                                     |
| `:rbs_backend`          | RBS gem available (official RBS parser, MRI only)                         |
| **Engine Tags**         |                                                                           |
| `:mri_engine`           | Running on MRI (CRuby)                                                    |
| `:jruby_engine`         | Running on JRuby                                                          |
| `:truffleruby_engine`   | Running on TruffleRuby                                                    |
| **Grammar Tags**        |                                                                           |
| `:libtree_sitter`       | libtree-sitter.so is loadable via FFI                                     |
| `:bash_grammar`         | tree-sitter-bash grammar available and parsing works                      |
| `:toml_grammar`         | tree-sitter-toml grammar available and parsing works                      |
| `:json_grammar`         | tree-sitter-json grammar available and parsing works                      |
| `:jsonc_grammar`        | tree-sitter-jsonc grammar available and parsing works                     |
| `:rbs_grammar`          | tree-sitter-rbs grammar available and parsing works                       |
| **Parsing Tags**        |                                                                           |
| `:toml_parsing`         | Any TOML parser available (tree-sitter OR toml-rb/Citrus OR toml/Parslet) |
| `:markdown_parsing`     | Any markdown parser available (commonmarker OR markly)                    |
| `:rbs_parsing`          | Any RBS parser available (rbs gem OR tree-sitter-rbs)                     |
| `:native_parsing`       | Native tree-sitter backend and grammar available                          |
| **Library Tags**        |                                                                           |
| `:toml_rb_gem`          | toml-rb gem available (Citrus backend for TOML)                           |
| `:toml_gem`             | toml gem available (Parslet backend for TOML)                             |
| `:rbs_gem`              | rbs gem available (official RBS parser)                                   |

All tags have negated versions (e.g., `:not_mri_backend`, `:not_jruby_engine`, `:not_toml_parsing`) for testing fallback behavior.

**Debug Output:**

Set `TREE_HAVER_DEBUG=1` to print a dependency summary at the start of your test suite:

```bash
TREE_HAVER_DEBUG=1 bundle exec rspec
```

## 🦷 FLOSS Funding

While kettle-rb tools are free software and will always be, the project would benefit immensely from some funding.
Raising a monthly budget of... "dollars" would make the project more sustainable.

We welcome both individual and corporate sponsors! We also offer a
wide array of funding channels to account for your preferences
(although currently [Open Collective][🖇osc] is our preferred funding platform).

**If you're working in a company that's making significant use of kettle-rb tools we'd
appreciate it if you suggest to your company to become a kettle-rb sponsor.**

You can support the development of kettle-rb tools via
[GitHub Sponsors][🖇sponsor],
[Liberapay][⛳liberapay],
[PayPal][🖇paypal],
[Open Collective][🖇osc]
and [Tidelift][🏙️entsup-tidelift].

| 📍 NOTE                                                                                                                                                                                                              |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| If doing a sponsorship in the form of donation is problematic for your company <br/> from an accounting standpoint, we'd recommend the use of Tidelift, <br/> where you can get a support-like subscription instead. |

### Open Collective for Individuals

Support us with a monthly donation and help us continue our activities. [[Become a backer](https://opencollective.com/kettle-rb#backer)]

NOTE: [kettle-readme-backers][kettle-readme-backers] updates this list every day, automatically.

<!-- OPENCOLLECTIVE-INDIVIDUALS:START -->
No backers yet. Be the first!
<!-- OPENCOLLECTIVE-INDIVIDUALS:END -->

### Open Collective for Organizations

Become a sponsor and get your logo on our README on GitHub with a link to your site. [[Become a sponsor](https://opencollective.com/kettle-rb#sponsor)]

NOTE: [kettle-readme-backers][kettle-readme-backers] updates this list every day, automatically.

<!-- OPENCOLLECTIVE-ORGANIZATIONS:START -->
No sponsors yet. Be the first!
<!-- OPENCOLLECTIVE-ORGANIZATIONS:END -->

[kettle-readme-backers]: https://github.com/kettle-rb/tree_haver/blob/main/exe/kettle-readme-backers

### Another way to support open-source

I’m driven by a passion to foster a thriving open-source community – a space where people can tackle complex problems, no matter how small.  Revitalizing libraries that have fallen into disrepair, and building new libraries focused on solving real-world challenges, are my passions.  I was recently affected by layoffs, and the tech jobs market is unwelcoming. I’m reaching out here because your support would significantly aid my efforts to provide for my family, and my farm (11 🐔 chickens, 2 🐶 dogs, 3 🐰 rabbits, 8 🐈‍ cats).

If you work at a company that uses my work, please encourage them to support me as a corporate sponsor. My work on gems you use might show up in `bundle fund`.

I’m developing a new library, [floss_funding][🖇floss-funding-gem], designed to empower open-source developers like myself to get paid for the work we do, in a sustainable way. Please give it a look.

**[Floss-Funding.dev][🖇floss-funding.dev]: 👉️ No network calls. 👉️ No tracking. 👉️ No oversight. 👉️ Minimal crypto hashing. 💡 Easily disabled nags**

[![OpenCollective Backers][🖇osc-backers-i]][🖇osc-backers] [![OpenCollective Sponsors][🖇osc-sponsors-i]][🖇osc-sponsors] [![Sponsor Me on Github][🖇sponsor-img]][🖇sponsor] [![Liberapay Goal Progress][⛳liberapay-img]][⛳liberapay] [![Donate on PayPal][🖇paypal-img]][🖇paypal] [![Buy me a coffee][🖇buyme-small-img]][🖇buyme] [![Donate on Polar][🖇polar-img]][🖇polar] [![Donate to my FLOSS efforts at ko-fi.com][🖇kofi-img]][🖇kofi] [![Donate to my FLOSS efforts using Patreon][🖇patreon-img]][🖇patreon]

## 🔐 Security

See [SECURITY.md][🔐security].

## 🤝 Contributing

If you need some ideas of where to help, you could work on adding more code coverage,
or if it is already 💯 (see [below](#code-coverage)) check [issues][🤝gh-issues] or [PRs][🤝gh-pulls],
or use the gem and think about how it could be better.

We [![Keep A Changelog][📗keep-changelog-img]][📗keep-changelog] so if you make changes, remember to update it.

See [CONTRIBUTING.md][🤝contributing] for more detailed instructions.

### 🚀 Release Instructions

See [CONTRIBUTING.md][🤝contributing].

### Code Coverage

[![Coverage Graph][🏀codecov-g]][🏀codecov]

[![Coveralls Test Coverage][🏀coveralls-img]][🏀coveralls]

[![QLTY Test Coverage][🏀qlty-covi]][🏀qlty-cov]

### 🪇 Code of Conduct

Everyone interacting with this project's codebases, issue trackers,
chat rooms and mailing lists agrees to follow the [![Contributor Covenant 2.1][🪇conduct-img]][🪇conduct].

## 🌈 Contributors

[![Contributors][🖐contributors-img]][🖐contributors]

Made with [contributors-img][🖐contrib-rocks].

Also see GitLab Contributors: [https://gitlab.com/kettle-rb/tree_haver/-/graphs/main][🚎contributors-gl]

<details>
    <summary>⭐️ Star History</summary>

<a href="https://star-history.com/#kettle-rb/tree_haver&Date">
 <picture>
   <source media="(prefers-color-scheme: dark)" srcset="https://api.star-history.com/svg?repos=kettle-rb/tree_haver&type=Date&theme=dark" />
   <source media="(prefers-color-scheme: light)" srcset="https://api.star-history.com/svg?repos=kettle-rb/tree_haver&type=Date" />
   <img alt="Star History Chart" src="https://api.star-history.com/svg?repos=kettle-rb/tree_haver&type=Date" />
 </picture>
</a>

</details>

## 📌 Versioning

This Library adheres to [![Semantic Versioning 2.0.0][📌semver-img]][📌semver].
Violations of this scheme should be reported as bugs.
Specifically, if a minor or patch version is released that breaks backward compatibility,
a new version should be immediately released that restores compatibility.
Breaking changes to the public API will only be introduced with new major versions.

> dropping support for a platform is both obviously and objectively a breaking change <br/>
>—Jordan Harband ([@ljharb](https://github.com/ljharb), maintainer of SemVer) [in SemVer issue 716][📌semver-breaking]

I understand that policy doesn't work universally ("exceptions to every rule!"),
but it is the policy here.
As such, in many cases it is good to specify a dependency on this library using
the [Pessimistic Version Constraint][📌pvc] with two digits of precision.

For example:

```ruby
spec.add_dependency("tree_haver", "~> 6.0")
```

<details markdown="1">
<summary>📌 Is "Platform Support" part of the public API? More details inside.</summary>

SemVer should, IMO, but doesn't explicitly, say that dropping support for specific Platforms
is a *breaking change* to an API, and for that reason the bike shedding is endless.

To get a better understanding of how SemVer is intended to work over a project's lifetime,
read this article from the creator of SemVer:

- ["Major Version Numbers are Not Sacred"][📌major-versions-not-sacred]

</details>

See [CHANGELOG.md][📌changelog] for a list of releases.

## 📄 License

The gem is available under the following license: [AGPL-3.0-only](AGPL-3.0-only.md).
See [LICENSE.md][📄license] for details.

If none of the available licenses suit your use case, please [contact us](mailto:floss@galtzo.com) to discuss a custom commercial license.

### © Copyright

See [LICENSE.md][📄license] for the official copyright notice.

## 🤑 A request for help

Maintainers have teeth and need to pay their dentists.
After getting laid off in an RIF in March, and encountering difficulty finding a new one,
I began spending most of my time building open source tools.
I'm hoping to be able to pay for my kids' health insurance this month,
so if you value the work I am doing, I need your support.
Please consider sponsoring me or the project.

To join the community or get help 👇️ Join the Discord.

[![Live Chat on Discord][✉️discord-invite-img-ftb]][✉️discord-invite]

To say "thanks!" ☝️ Join the Discord or 👇️ send money.

[![Sponsor kettle-rb/tree_haver on Open Source Collective][🖇osc-all-bottom-img]][🖇osc] 💌 [![Sponsor me on GitHub Sponsors][🖇sponsor-bottom-img]][🖇sponsor] 💌 [![Sponsor me on Liberapay][⛳liberapay-bottom-img]][⛳liberapay] 💌 [![Donate on PayPal][🖇paypal-bottom-img]][🖇paypal]

### Please give the project a star ⭐ ♥.

Thanks for RTFM. ☺️

[⛳liberapay-img]: https://img.shields.io/liberapay/goal/pboling.svg?logo=liberapay&color=a51611&style=flat
[⛳liberapay-bottom-img]: https://img.shields.io/liberapay/goal/pboling.svg?style=for-the-badge&logo=liberapay&color=a51611
[⛳liberapay]: https://liberapay.com/pboling/donate
[🖇osc-all-img]: https://img.shields.io/opencollective/all/kettle-rb
[🖇osc-sponsors-img]: https://img.shields.io/opencollective/sponsors/kettle-rb
[🖇osc-backers-img]: https://img.shields.io/opencollective/backers/kettle-rb
[🖇osc-backers]: https://opencollective.com/kettle-rb#backer
[🖇osc-backers-i]: https://opencollective.com/kettle-rb/backers/badge.svg?style=flat
[🖇osc-sponsors]: https://opencollective.com/kettle-rb#sponsor
[🖇osc-sponsors-i]: https://opencollective.com/kettle-rb/sponsors/badge.svg?style=flat
[🖇osc-all-bottom-img]: https://img.shields.io/opencollective/all/kettle-rb?style=for-the-badge
[🖇osc-sponsors-bottom-img]: https://img.shields.io/opencollective/sponsors/kettle-rb?style=for-the-badge
[🖇osc-backers-bottom-img]: https://img.shields.io/opencollective/backers/kettle-rb?style=for-the-badge
[🖇osc]: https://opencollective.com/kettle-rb
[🖇sponsor-img]: https://img.shields.io/badge/Sponsor_Me!-pboling.svg?style=social&logo=github
[🖇sponsor-bottom-img]: https://img.shields.io/badge/Sponsor_Me!-pboling-blue?style=for-the-badge&logo=github
[🖇sponsor]: https://github.com/sponsors/pboling
[🖇polar-img]: https://img.shields.io/badge/polar-donate-a51611.svg?style=flat
[🖇polar]: https://polar.sh/pboling
[🖇kofi-img]: https://img.shields.io/badge/ko--fi-%E2%9C%93-a51611.svg?style=flat
[🖇kofi]: https://ko-fi.com/pboling
[🖇patreon-img]: https://img.shields.io/badge/patreon-donate-a51611.svg?style=flat
[🖇patreon]: https://patreon.com/galtzo
[🖇buyme-small-img]: https://img.shields.io/badge/buy_me_a_coffee-%E2%9C%93-a51611.svg?style=flat
[🖇buyme-img]: https://img.buymeacoffee.com/button-api/?text=Buy%20me%20a%20latte&emoji=&slug=pboling&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff
[🖇buyme]: https://www.buymeacoffee.com/pboling
[🖇paypal-img]: https://img.shields.io/badge/donate-paypal-a51611.svg?style=flat&logo=paypal
[🖇paypal-bottom-img]: https://img.shields.io/badge/donate-paypal-a51611.svg?style=for-the-badge&logo=paypal&color=0A0A0A
[🖇paypal]: https://www.paypal.com/paypalme/peterboling
[🖇floss-funding.dev]: https://floss-funding.dev
[🖇floss-funding-gem]: https://github.com/galtzo-floss/floss_funding
[✉️discord-invite]: https://discord.gg/3qme4XHNKN
[✉️discord-invite-img-ftb]: https://img.shields.io/discord/1373797679469170758?style=for-the-badge&logo=discord
[✉️ruby-friends-img]: https://img.shields.io/badge/daily.dev-%F0%9F%92%8E_Ruby_Friends-0A0A0A?style=for-the-badge&logo=dailydotdev&logoColor=white
[✉️ruby-friends]: https://app.daily.dev/squads/rubyfriends

[✇bundle-group-pattern]: https://gist.github.com/pboling/4564780
[⛳️gem-namespace]: https://github.com/kettle-rb/tree_haver
[⛳️namespace-img]: https://img.shields.io/badge/namespace-TreeHaver-3C2D2D.svg?style=square&logo=ruby&logoColor=white
[⛳️gem-name]: https://bestgems.org/gems/tree_haver
[⛳️name-img]: https://img.shields.io/badge/name-tree__haver-3C2D2D.svg?style=square&logo=rubygems&logoColor=red
[⛳️tag-img]: https://img.shields.io/github/tag/kettle-rb/tree_haver.svg
[⛳️tag]: http://github.com/kettle-rb/tree_haver/releases
[🚂maint-blog]: http://www.railsbling.com/tags/tree_haver
[🚂maint-blog-img]: https://img.shields.io/badge/blog-railsbling-0093D0.svg?style=for-the-badge&logo=rubyonrails&logoColor=orange
[🚂maint-contact]: http://www.railsbling.com/contact
[🚂maint-contact-img]: https://img.shields.io/badge/Contact-Maintainer-0093D0.svg?style=flat&logo=rubyonrails&logoColor=red
[💖🖇linkedin]: http://www.linkedin.com/in/peterboling
[💖🖇linkedin-img]: https://img.shields.io/badge/LinkedIn-Profile-0B66C2?style=flat&logo=newjapanprowrestling
[💖✌️wellfound]: https://wellfound.com/u/peter-boling
[💖✌️wellfound-img]: https://img.shields.io/badge/peter--boling-orange?style=flat&logo=wellfound
[💖💲crunchbase]: https://www.crunchbase.com/person/peter-boling
[💖💲crunchbase-img]: https://img.shields.io/badge/peter--boling-purple?style=flat&logo=crunchbase
[💖🐘ruby-mast]: https://ruby.social/@galtzo
[💖🐘ruby-mast-img]: https://img.shields.io/mastodon/follow/109447111526622197?domain=https://ruby.social&style=flat&logo=mastodon&label=Ruby%20@galtzo
[💖🦋bluesky]: https://bsky.app/profile/galtzo.com
[💖🦋bluesky-img]: https://img.shields.io/badge/@galtzo.com-0285FF?style=flat&logo=bluesky&logoColor=white
[💖🌳linktree]: https://linktr.ee/galtzo
[💖🌳linktree-img]: https://img.shields.io/badge/galtzo-purple?style=flat&logo=linktree
[💖💁🏼‍♂️devto]: https://dev.to/galtzo
[💖💁🏼‍♂️devto-img]: https://img.shields.io/badge/dev.to-0A0A0A?style=flat&logo=devdotto&logoColor=white
[💖💁🏼‍♂️aboutme]: https://about.me/peter.boling
[💖💁🏼‍♂️aboutme-img]: https://img.shields.io/badge/about.me-0A0A0A?style=flat&logo=aboutme&logoColor=white
[💖🧊berg]: https://codeberg.org/pboling
[💖🐙hub]: https://github.org/pboling
[💖🛖hut]: https://sr.ht/~galtzo/
[💖🧪lab]: https://gitlab.com/pboling
[👨🏼‍🏫expsup-upwork]: https://www.upwork.com/freelancers/~014942e9b056abdf86?mp_source=share
[👨🏼‍🏫expsup-upwork-img]: https://img.shields.io/badge/UpWork-13544E?style=for-the-badge&logo=Upwork&logoColor=white
[👨🏼‍🏫expsup-codementor]: https://www.codementor.io/peterboling?utm_source=github&utm_medium=button&utm_term=peterboling&utm_campaign=github
[👨🏼‍🏫expsup-codementor-img]: https://img.shields.io/badge/CodeMentor-Get_Help-1abc9c?style=for-the-badge&logo=CodeMentor&logoColor=white
[🏙️entsup-tidelift]: https://tidelift.com/subscription/pkg/rubygems-tree_haver?utm_source=rubygems-tree_haver&utm_medium=referral&utm_campaign=readme
[🏙️entsup-tidelift-img]: https://img.shields.io/badge/Tidelift_and_Sonar-Enterprise_Support-FD3456?style=for-the-badge&logo=sonar&logoColor=white
[🏙️entsup-tidelift-sonar]: https://blog.tidelift.com/tidelift-joins-sonar
[💁🏼‍♂️peterboling]: http://www.peterboling.com
[🚂railsbling]: http://www.railsbling.com
[📜src-gl-img]: https://img.shields.io/badge/GitLab-FBA326?style=for-the-badge&logo=Gitlab&logoColor=orange
[📜src-gl]: https://gitlab.com/kettle-rb/tree_haver/
[📜src-cb-img]: https://img.shields.io/badge/CodeBerg-4893CC?style=for-the-badge&logo=CodeBerg&logoColor=blue
[📜src-cb]: https://codeberg.org/kettle-rb/tree_haver
[📜src-gh-img]: https://img.shields.io/badge/GitHub-238636?style=for-the-badge&logo=Github&logoColor=green
[📜src-gh]: https://github.com/kettle-rb/tree_haver
[📜docs-cr-rd-img]: https://img.shields.io/badge/RubyDoc-Current_Release-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜docs-head-rd-img]: https://img.shields.io/badge/YARD_on_Galtzo.com-HEAD-943CD2?style=for-the-badge&logo=readthedocs&logoColor=white
[📜gl-wiki]: https://gitlab.com/kettle-rb/tree_haver/-/wikis/home
[📜gh-wiki]: https://github.com/kettle-rb/tree_haver/wiki
[📜gl-wiki-img]: https://img.shields.io/badge/wiki-examples-943CD2.svg?style=for-the-badge&logo=gitlab&logoColor=white
[📜gh-wiki-img]: https://img.shields.io/badge/wiki-examples-943CD2.svg?style=for-the-badge&logo=github&logoColor=white
[👽dl-rank]: https://bestgems.org/gems/tree_haver
[👽dl-ranki]: https://img.shields.io/gem/rd/tree_haver.svg
[👽oss-help]: https://www.codetriage.com/kettle-rb/tree_haver
[👽oss-helpi]: https://www.codetriage.com/kettle-rb/tree_haver/badges/users.svg
[👽version]: https://bestgems.org/gems/tree_haver
[👽versioni]: https://img.shields.io/gem/v/tree_haver.svg
[🏀qlty-mnt]: https://qlty.sh/gh/kettle-rb/projects/tree_haver
[🏀qlty-mnti]: https://qlty.sh/gh/kettle-rb/projects/tree_haver/maintainability.svg
[🏀qlty-cov]: https://qlty.sh/gh/kettle-rb/projects/tree_haver/metrics/code?sort=coverageRating
[🏀qlty-covi]: https://qlty.sh/gh/kettle-rb/projects/tree_haver/coverage.svg
[🏀codecov]: https://codecov.io/gh/kettle-rb/tree_haver
[🏀codecovi]: https://codecov.io/gh/kettle-rb/tree_haver/graph/badge.svg
[🏀coveralls]: https://coveralls.io/github/kettle-rb/tree_haver?branch=main
[🏀coveralls-img]: https://coveralls.io/repos/github/kettle-rb/tree_haver/badge.svg?branch=main
[🖐codeQL]: https://github.com/kettle-rb/tree_haver/security/code-scanning
[🖐codeQL-img]: https://github.com/kettle-rb/tree_haver/actions/workflows/codeql-analysis.yml/badge.svg
[🚎ruby-3.2-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/ruby-3.2.yml
[🚎ruby-3.3-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/ruby-3.3.yml
[🚎ruby-3.4-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/ruby-3.4.yml
[🚎truby-24.2-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/truffleruby-24.2.yml
[🚎truby-25.0-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/truffleruby-25.0.yml
[🚎2-cov-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/coverage.yml
[🚎2-cov-wfi]: https://github.com/kettle-rb/tree_haver/actions/workflows/coverage.yml/badge.svg
[🚎3-hd-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/heads.yml
[🚎3-hd-wfi]: https://github.com/kettle-rb/tree_haver/actions/workflows/heads.yml/badge.svg
[🚎5-st-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/style.yml
[🚎5-st-wfi]: https://github.com/kettle-rb/tree_haver/actions/workflows/style.yml/badge.svg
[🚎9-t-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/truffle.yml
[🚎9-t-wfi]: https://github.com/kettle-rb/tree_haver/actions/workflows/truffle.yml/badge.svg
[🚎10-j-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/jruby.yml
[🚎10-j-wfi]: https://github.com/kettle-rb/tree_haver/actions/workflows/jruby.yml/badge.svg
[🚎11-c-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/current.yml
[🚎11-c-wfi]: https://github.com/kettle-rb/tree_haver/actions/workflows/current.yml/badge.svg
[🚎12-crh-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/dep-heads.yml
[🚎12-crh-wfi]: https://github.com/kettle-rb/tree_haver/actions/workflows/dep-heads.yml/badge.svg
[🚎13-🔒️-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/locked_deps.yml
[🚎13-🔒️-wfi]: https://github.com/kettle-rb/tree_haver/actions/workflows/locked_deps.yml/badge.svg
[🚎14-🔓️-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/unlocked_deps.yml
[🚎14-🔓️-wfi]: https://github.com/kettle-rb/tree_haver/actions/workflows/unlocked_deps.yml/badge.svg
[🚎15-🪪-wf]: https://github.com/kettle-rb/tree_haver/actions/workflows/license-eye.yml
[🚎15-🪪-wfi]: https://github.com/kettle-rb/tree_haver/actions/workflows/license-eye.yml/badge.svg
[💎ruby-3.2i]: https://img.shields.io/badge/Ruby-3.2-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.3i]: https://img.shields.io/badge/Ruby-3.3-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-3.4i]: https://img.shields.io/badge/Ruby-3.4-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-4.0i]: https://img.shields.io/badge/Ruby-4.0-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[💎ruby-c-i]: https://img.shields.io/badge/Ruby-current-CC342D?style=for-the-badge&logo=ruby&logoColor=green
[💎ruby-headi]: https://img.shields.io/badge/Ruby-HEAD-CC342D?style=for-the-badge&logo=ruby&logoColor=blue
[💎truby-24.2i]: https://img.shields.io/badge/Truffle_Ruby-24.2-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-25.0i]: https://img.shields.io/badge/Truffle_Ruby-25.0-34BCB1?style=for-the-badge&logo=ruby&logoColor=pink
[💎truby-c-i]: https://img.shields.io/badge/Truffle_Ruby-current-34BCB1?style=for-the-badge&logo=ruby&logoColor=green
[💎jruby-c-i]: https://img.shields.io/badge/JRuby-current-FBE742?style=for-the-badge&logo=ruby&logoColor=green
[💎jruby-headi]: https://img.shields.io/badge/JRuby-HEAD-FBE742?style=for-the-badge&logo=ruby&logoColor=blue
[🤝gh-issues]: https://github.com/kettle-rb/tree_haver/issues
[🤝gh-pulls]: https://github.com/kettle-rb/tree_haver/pulls
[🤝gl-issues]: https://gitlab.com/kettle-rb/tree_haver/-/issues
[🤝gl-pulls]: https://gitlab.com/kettle-rb/tree_haver/-/merge_requests
[🤝cb-issues]: https://codeberg.org/kettle-rb/tree_haver/issues
[🤝cb-pulls]: https://codeberg.org/kettle-rb/tree_haver/pulls
[🤝cb-donate]: https://donate.codeberg.org/
[🤝contributing]: CONTRIBUTING.md
[🏀codecov-g]: https://codecov.io/gh/kettle-rb/tree_haver/graphs/tree.svg
[🖐contrib-rocks]: https://contrib.rocks
[🖐contributors]: https://github.com/kettle-rb/tree_haver/graphs/contributors
[🖐contributors-img]: https://contrib.rocks/image?repo=kettle-rb/tree_haver
[🚎contributors-gl]: https://gitlab.com/kettle-rb/tree_haver/-/graphs/main
[🪇conduct]: CODE_OF_CONDUCT.md
[🪇conduct-img]: https://img.shields.io/badge/Contributor_Covenant-2.1-259D6C.svg
[📌pvc]: http://guides.rubygems.org/patterns/#pessimistic-version-constraint
[📌semver]: https://semver.org/spec/v2.0.0.html
[📌semver-img]: https://img.shields.io/badge/semver-2.0.0-259D6C.svg?style=flat
[📌semver-breaking]: https://github.com/semver/semver/issues/716#issuecomment-869336139
[📌major-versions-not-sacred]: https://tom.preston-werner.com/2022/05/23/major-version-numbers-are-not-sacred.html
[📌changelog]: CHANGELOG.md
[📗keep-changelog]: https://keepachangelog.com/en/1.0.0/
[📗keep-changelog-img]: https://img.shields.io/badge/keep--a--changelog-1.0.0-34495e.svg?style=flat
[📌gitmoji]: https://gitmoji.dev
[📌gitmoji-img]: https://img.shields.io/badge/gitmoji_commits-%20%F0%9F%98%9C%20%F0%9F%98%8D-34495e.svg?style=flat-square
[🧮kloc]: https://www.youtube.com/watch?v=dQw4w9WgXcQ
[🧮kloc-img]: https://img.shields.io/badge/KLOC-5.053-FFDD67.svg?style=for-the-badge&logo=YouTube&logoColor=blue
[🔐security]: SECURITY.md
[🔐security-img]: https://img.shields.io/badge/security-policy-259D6C.svg?style=flat
[📄copyright-notice-explainer]: https://opensource.stackexchange.com/questions/5778/why-do-licenses-such-as-the-mit-license-specify-a-single-year
[📄license]: LICENSE.md
[📄license-ref]: AGPL-3.0-only.md
[📄license-img]: https://img.shields.io/badge/License-AGPL--3.0--only-259D6C.svg
[📄license-compat]: https://www.apache.org/legal/resolved.html#category-x
[📄license-compat-img]: https://img.shields.io/badge/Apache_Incompatible:_Category_X-✗-C0392B.svg?style=flat&logo=Apache
[📄ilo-declaration]: https://www.ilo.org/declaration/lang--en/index.htm
[📄ilo-declaration-img]: https://img.shields.io/badge/ILO_Fundamental_Principles-✓-259D6C.svg?style=flat
[🚎yard-current]: http://rubydoc.info/gems/tree_haver
[🚎yard-head]: https://tree-haver.galtzo.com
[💎stone_checksums]: https://github.com/galtzo-floss/stone_checksums
[💎SHA_checksums]: https://gitlab.com/kettle-rb/tree_haver/-/tree/main/checksums
[💎rlts]: https://github.com/rubocop-lts/rubocop-lts
[💎rlts-img]: https://img.shields.io/badge/code_style_&_linting-rubocop--lts-34495e.svg?plastic&logo=ruby&logoColor=white
[💎appraisal2]: https://github.com/appraisal-rb/appraisal2
[💎appraisal2-img]: https://img.shields.io/badge/appraised_by-appraisal2-34495e.svg?plastic&logo=ruby&logoColor=white
[💎d-in-dvcs]: https://railsbling.com/posts/dvcs/put_the_d_in_dvcs/
