# Slice 1038 Evidence: Platform Support Matrix Research

Companion to `slice-1038-platform-support-matrix-proposal.md`. This file is the
cited evidence base for the platform support data. It exists because the platform
column of `kettle-jem/RRRRrb-Matrix.md` was weakly evidenced and never replicated
into `Kettle::Rb::CompatMatrix`, and because a rebuilt matrix must not repeat that.

Sourced from four parallel primary-source research passes (2026-10-09, ~280 API
calls). Every claim below carries a citation. Items that could not be sourced are
listed under "Unverified" at the end and must not be encoded as fact.

## 1. The vocabulary problem (most important design constraint)

There are **three** distinct platform vocabularies in this space, and the man page
explicitly warns that two of them must not be conflated.

### 1a. Gemfile DSL `platforms:` symbols — Ruby *implementation*, not OS

Valid symbols are exactly `Bundler::CurrentRuby::PLATFORM_MAP.keys`, validated by
`Bundler::DSL`, which raises `` "`#{p}` is not a valid platform" `` otherwise.

| Symbol | Matches | Notes |
|---|---|---|
| `ruby` | MRI, Rubinius, **TruffleRuby** — but NOT Windows | `!windows? && RUBY_ENGINE in ruby/rbx/maglev/truffleruby` |
| `mri` | C Ruby only, NOT Windows | |
| `windows` | Any Windows C Ruby | **Recommended replacement for all deprecated Windows symbols** |
| `mswin`, `mswin64`, `mingw`, `x64_mingw` | Windows variants | **DEPRECATED in Bundler 2.7.0** (PR #8447); all are now aliases of `windows?` |
| `jruby` | JRuby | Maps to `Gem::Platform::JAVA` |
| `truffleruby` | TruffleRuby | Maps to `Gem::Platform::RUBY`; also matches `:ruby` |
| `rbx` | Rubinius | |
| `<sym>_<major><minor>` | e.g. `ruby_31`, `windows_31` | Valid suffixes on master: 18-27, 30-34, 40-41 |

**`linux`, `macos`, `darwin`, `x86_64`, `arm64` are NOT valid Gemfile DSL
symbols.** OS/architecture selection belongs to `Gemfile.lock` PLATFORMS and
`bundle lock --add-platform`, not the DSL.

Source: https://github.com/ruby/rubygems/blob/master/lib/bundler/current_ruby.rb
Source: https://github.com/ruby/rubygems/blob/master/lib/bundler/man/gemfile.5.ronn
Source: https://github.com/ruby/rubygems/blob/master/lib/bundler/dsl.rb

### 1b. `Gem::Platform` strings — OS/architecture (lockfile vocabulary)

| Platform string | Meaning | Status |
|---|---|---|
| `ruby` | Pure-Ruby / platform-agnostic | current (core); installs everywhere |
| `java` | Generic JRuby (`cpu=nil`) | current; nil cpu matches any |
| `universal-java-11` … `universal-java-N` | JRuby *local runtime* form | current (lockfile only) |
| `x86_64-linux` | Linux x86_64 glibc | current; constant is `X64_LINUX` (naming trap) |
| `x86_64-linux-gnu` | Explicit glibc | current; `gnu` strips to versionless |
| `x86_64-linux-musl` | Alpine | current; added 2021, **reverted in 3.2.14** (PR #4434), re-landed 3.3.x |
| `aarch64-linux` | Linux ARM64 glibc | current |
| `arm-linux` | **32-bit ARM only** | since RubyGems 3.6.0 (`14c4c16e9`) no longer matches arm64/aarch64 |
| `arm64-darwin` | macOS Apple Silicon | current; **no dedicated constant, no single "added in" release** |
| `x86_64-darwin` | macOS Intel | current |
| `universal-darwin-N` | Legacy fat macOS | legacy |
| `x64-mingw-ucrt` | Windows x64 UCRT | current; parsing added RubyGems **3.2.28** (2021-09-23, PR #4925) |
| `x64-mingw32` | Windows x64 MSVCRT | **deprecated** by Bundler 2.7.0 (PR #8733); constant `X64_MINGW_LEGACY` |
| `x86-mingw32`, `x86-mswin32-60`, `mswin32` | Legacy 32-bit Windows | legacy |
| `universal-mingw` / `universal-mingw32` | Windows any-CPU | current; since 3.3.18 (`06835c805`) matches `x64-mingw-ucrt` |
| `aarch64-mingw-ucrt` | Windows ARM64 | current/emerging; support landed `96496e3f5` (2025-01-21, v3.7.0+) |
| `wasi` | WebAssembly | current (niche); `1209d3c6b` (2024-05-04, v3.6.0+) |

Constant set verified on RubyGems 4.0.20: `CURRENT, RUBY, JAVA, MSWIN, MSWIN64,
MINGW, X64_MINGW, X64_MINGW_LEGACY, UNIVERSAL_MINGW, WINDOWS, X64_LINUX,
X64_LINUX_MUSL` (all `:nodoc:` except RUBY/CURRENT).

Source: https://github.com/ruby/rubygems/blob/master/lib/rubygems/platform.rb
Source: https://guides.rubygems.org/platforms/

Note the repo moved: `github.com/rubygems/rubygems` redirects to
`github.com/ruby/rubygems`, and Bundler sources moved to `lib/bundler/*` on
master (commit `821f51e29`, 2026-06-24).

### 1c. GitHub runner labels — a THIRD vocabulary, with no authoritative mapping

**No authoritative runner-label → RubyGems-platform mapping is published** by
GitHub, RubyGems, or Bundler. What IS authoritative:

- GitHub documents OS and CPU architecture per label
  (https://docs.github.com/en/actions/reference/runners/github-hosted-runners)
- On the Ruby side the platform is whatever `Gem::Platform.local` computes from
  the build's `RbConfig` arch: `Gem::Platform.local = new(Gem.target_rbconfig['arch'])`

**Therefore the correct programmatic approach is to run
`ruby -e 'puts Gem::Platform.local'` on each runner rather than hardcode a label
mapping.** `gem env platform` prints it locally; `bundle platform` prints lockfile
platforms.

The mapping below is **community convention, derived, NOT authoritative**:

| Runner label | Derived platform |
|---|---|
| `ubuntu-latest`, `ubuntu-22.04`, `ubuntu-24.04` | `x86_64-linux` |
| `ubuntu-22.04-arm`, `ubuntu-24.04-arm`, `ubuntu-26.04-arm` | `aarch64-linux` |
| `macos-13`, `macos-*-intel` | `x86_64-darwin-<N>` |
| `macos-14`, `macos-15`, `macos-26`, `macos-latest` | `arm64-darwin-<N>` |
| `windows-2022`, `windows-2025`, `windows-latest` (RubyInstaller 3.1+) | `x64-mingw-ucrt` |
| `windows-latest` (Ruby 3.0-era x64) | `x64-mingw32` |
| `windows-11-arm` | `aarch64-mingw-ucrt` |

Caveats: darwin *local* platforms carry an OS version suffix (`arm64-darwin-23`)
that released gem platforms do not — `bundle lock --normalize-platforms` strips
it. The Windows mapping depends entirely on which Ruby build the setup action
installs.

### Design consequence

The config key in Slice 1038 (`platforms: [linux, macos, windows]`) uses **none**
of these three vocabularies exactly. It names *CI OS families*, which is a fourth
thing. That is defensible — the key selects runner labels, not gem platforms — but
it must be documented as its own vocabulary with an explicit mapping to runner
labels, and must never be passed to `bundle lock --add-platform` or a Gemfile
`platforms:` DSL without translation. Encoding `linux`/`macos`/`windows` as if
they were `Gem::Platform` strings would be a category error.

## 2. GitHub runner labels: architecture and lifecycle

### macOS

| Label | Arch | Status |
|---|---|---|
| `macos-latest` | **ARM64** | floating; since Jun 15–Jul 15 2026 → macOS 26 Arm64 image |
| `macos-26` | ARM64 (3 vCPU M1-class, 7 GB) | GA since **2026-02-26** (beta 2025-09-11) |
| `macos-26-intel` | Intel x86_64 (4 vCPU, 14 GB) | available; x86_64 macOS ends when macOS 15 Intel retires (~Aug/Fall 2027) |
| `macos-15` | ARM64 | GA 2025-04-10; was `macos-latest` ~Sep 2025–Jul 2026 |
| `macos-15-intel` | Intel x86_64 | available; introduced 2025-09-19 as migration target for Intel `macos-13` users; planned end ~Aug 2027 |
| `macos-14` | ARM64 (3 vCPU M1) | **DEPRECATED — retires 2026-11-02**; first free ARM64 macOS label (2024-01-30) |
| `macos-13` | Intel x86_64 | **REMOVED 2025-12-04** |
| `macos-12` | Intel x86_64 | **REMOVED 2024-12-03. NEVER ARM64.** |
| `macos-11` | Intel x86_64 | removed 2024-06-28 |
| all `-large` / `-xlarge` | mixed | **paid**: require Team/Enterprise Cloud; NOT free for public repos |

`macos-14` brownout windows (jobs intentionally fail): **Oct 5, 12, 16, 19, 23,
26, 29, 30 2026**.

Sources:
https://github.blog/changelog/2026-10-01-github-actions-macos-14-runner-image-retirement/
https://github.blog/changelog/2025-09-19-github-actions-macos-13-runner-image-is-closing-down/
https://github.com/actions/runner-images/issues/10721
https://github.blog/changelog/2026-02-26-macos-26-is-now-generally-available-for-github-hosted-runners/

### `macos-latest` history — the ARM64 transition point

1. Until Oct 2022: macOS 11 (Intel)
2. 2022-10-03: began migrating to macOS 12 — **Intel x86_64 only**
3. 2024-04-01: macOS 14 GA; `macos-latest` migrated Apr 8 → May 19/20 2024.
   Since standard `macos-14` runs exclusively on the M1 ARM64 runner,
   **this April–May 2024 migration is when `macos-latest` became ARM64**.
   GitHub explicitly skipped macOS 13 for `latest`.
4. 2025-07-11: migrated to macOS 15 (ARM64), Aug 4 – Sep 1 2025
5. 2026-05-27 (issue #14167): migrated to macOS 26 (ARM64), Jun 15 – Jul 15 2026

`-large`/`-xlarge` have separate histories: `macos-latest-large` was Intel
throughout; `macos-latest-xlarge` was M1 ARM64 macOS 13 from 2023-10-02, M2 from
macOS 14+.

**This confirms the Slice 1038 finding**: `RRRRrb-Matrix.md`'s column headed
"ARM64 & MacOS 12" conflates two things that never coexisted. `macos-12` was
never ARM64, and no `macos-12-arm64` image ever existed (ARM64 XL labels existed
only for macOS 13: `macos-13-xl-arm64`, `macos-latest-xl-arm64`).

### Windows

| Label | Arch | Status |
|---|---|---|
| `windows-latest` | **x64 only** | now Server 2025 (migrated Sep 2–30 2025) |
| `windows-2025` | x64 | GA 2025-04-08 |
| `windows-2025-vs2026` | x64 | available |
| `windows-2022` | x64 | available |
| `windows-2019` | x64 | **removed 2025-06-30** |
| `windows-11-arm` | **ARM64** (4 vCPU) | GA 2025-08-07; free in public repos; private repos from 2026-01-29 (2 vCPU) |
| `windows-11-vs2026-arm` | ARM64 | GA 2026-08-20 |

There is **no ARM64 `windows-latest`** — ARM64 Windows requires the explicit
`windows-11-arm` labels. `windows-11-arm` switched to the VS2026 image during
Sep 21–30 2026, which GitHub flags as breaking for VS2022-dependent workflows.

Source: https://github.blog/changelog/2025-08-07-arm64-hosted-runners-for-public-repositories-are-now-generally-available/

### Linux ARM64 — free for public repos

- 2024-06-03: arm64 **larger** runners (paid) beta; GA 2024-09-03
- 2025-01-16: standard (free) Linux arm64 preview, **public repos only**, 4 vCPU
  (Microsoft Cobalt 100), labels `ubuntu-24.04-arm`, `ubuntu-22.04-arm`
- 2025-08-07: GA, still free and public-repos-only
- 2026-01-29: available in **private** repos too (2 vCPU there, billed from plan
  minutes at $0.005/min)
- `ubuntu-26.04-arm`: preview 2026-06-11, GA 2026-09-17

Current labels: `ubuntu-22.04-arm`, `ubuntu-24.04-arm`, `ubuntu-26.04-arm`.
Images originally built by Arm, LLC (`actions/partner-runner-images`); GitHub
maintains them directly since 2026-05-14 (issue #14100).

**A typical OSS Ruby gem gets native ARM64 Linux CI for free** by adding
`runs-on: ubuntu-24.04-arm` in a public repo — no paid tier. This is a real
opportunity the old matrix column never expressed.

### Platform caveats that affect Ruby CI

- Community actions may not be arm64-compatible (GitHub's own are)
- Nested virtualization unsupported on arm64 macOS
- arm64 macOS runners have no static UDID (Intel do)
- **An ARM64 CI column proves `arm64-darwin`, NOT `x86_64-darwin`** — native
  extension builds must be verified per arch
- `-latest` means GitHub's latest GA image, not the newest vendor OS; migrations
  are gradual over weeks, so any matrix citing `macos-latest` must be dated

## 3. MRI Ruby per-version platform evidence

**Ruby core publishes source tarballs only.** `cache.ruby-lang.org/pub/ruby/*`;
`github.com/ruby/ruby` GitHub releases carry **zero** binary assets (verified via
API). There are no "official" MRI binaries for any platform. All prebuilts below
are community-built.

### arm64-darwin (Apple Silicon)

| Version | Support | Evidence |
|---|---|---|
| 1.8.7 – 2.5.x | **none** | no darwin-arm64 in ruby-builder toolcache; predates Apple Silicon (2020) |
| 2.2.x | none | documented M1 source-build failure: rbenv/ruby-build#1742 |
| 2.6.0–2.6.6 | compiles with issues, **no prebuilt** | toolcache darwin-arm64 starts at 2.6.7; rbenv/ruby-build#1803, openssl-1.1 issues #1691/#2194 |
| 2.6.7–2.6.10 | **community prebuilt** | toolcache assets verified. 2.6.7 needed `-Wno-error=implicit-function-declaration` (bugs.ruby-lang.org#17777). No native fiber coroutine — 2.6 `configure.ac` lacks the arm64-darwin case, uses ucontext fallback |
| 2.7.0–2.7.1 | compiles with issues, no prebuilt | toolcache starts at 2.7.2; rbenv/ruby-build#1691, #1752 |
| 2.7.2–2.7.8 | **community prebuilt + native** | **2.7.2 is the first MRI whose `configure.ac` recognizes arm64-darwin natively** (arm64 fiber coroutine). Commit `23655e6de5` "Fix build error on Apple silicon macOS" (2020-07-05) present in tag `v2_7_2`, absent from `v2_7_1` and `v2_6_10` — verified by compare API |
| 3.0.x – 3.4.x, head/4.0 | **community prebuilt** | all releases in toolcache; Homebrew bottles for 3.2+; setup-ruby supports "macos-14 and newer" |

`v3_0_0` `configure.ac` contains the arm64-darwin native coroutine case (verified).
Ruby commit `c8121b2e3d` "Adjust CPU name as arm64-darwin" (2021-01-22)
normalized the platform name.

**Correction to a common claim**: "Ruby 3.0.0 was the first release to officially
support Apple Silicon" is **not** stated on ruby-lang.org (3.0.0 release post
checked; no arm64/M1 mention). Support is inferred from `configure.ac` and
toolcache builds only. The verifiable native-support milestone is **2.7.2**.

Sources:
https://github.com/ruby/ruby-builder/releases/tag/toolcache
https://github.com/ruby/ruby/blob/v2_6_10/configure.ac
https://github.com/ruby/ruby/commit/23655e6de5ee989feb8c65c7061fe9a71579dc54
https://bugs.ruby-lang.org/issues/17777
https://github.com/ruby/setup-ruby#supported-platforms

### Windows (RubyInstaller)

| Version | Installer | Notes |
|---|---|---|
| 1.8.7 | yes, **i386 only** | p302–p374; no x64 for any 1.8.x |
| 1.9.x | yes, **i386 only** | 1.9.1–1.9.3-p551; no x64 |
| 2.0.0 | yes, **first x64** | x64 appears at 2.0.0-p0 |
| 2.1.x | yes, x64 | archives 2.1.3–2.1.9 |
| 2.2.x | yes, x64 | last is 2.2.6; setup-ruby: "Ruby 2.2 resolves to 2.2.6 on Windows" |
| 2.3.x | yes, x64 | **only 2.3.0, 2.3.1, 2.3.3** |
| 2.4.x | yes, x64 + x86 | first series built by RubyInstaller2 (MSYS2 toolchain) |
| 2.5.x – 3.3.x | yes, x64 + x86 | full patch coverage |
| 3.4.x | yes, x64 + x86 + **arm64 from 3.4.1** | RubyInstaller-3.4.1-2 (2025-01-18) first ships `-arm.exe`; 3.4.1-1 had only x64/x86 |
| 4.0.x | yes, x64 + arm64, **x86 dropped** | 4.0.7-1 lists arm and x64 only |

**Currently supported by RubyInstaller: 4.0.7, 3.4.11, 3.3.12, 3.2.11.**
`rubyinstaller-head` provides daily dev-branch builds for CI.

Sources: https://rubyinstaller.org/downloads/ ,
https://rubyinstaller.org/downloads/archives/ ,
https://github.com/ruby/setup-ruby/blob/master/windows-versions.json ,
https://github.com/oneclick/rubyinstaller2/releases/tag/RubyInstaller-3.4.1-2

### EOL / support windows (ruby-lang.org)

| Version | EOL | Still security-fixed? |
|---|---|---|
| 1.8.7 | 2014-07-31 | no |
| 1.9.3 | 2015-02-23 | no |
| 2.0.0 | 2016-02-24 | no |
| 2.1 | 2017-03-31 | no |
| 2.2 | 2018-03-31 | no |
| 2.3 | 2019-03-31 | no |
| 2.4 | 2020-03-31 | no |
| 2.5 | 2021-04-05 | no |
| 2.6 | 2022-04-12 | no |
| 2.7 | 2023-03-31 | no |
| 3.0 | 2024-04-23 | no |
| 3.1 | 2025-03-26 | no |
| 3.2 | **2026-04-01** | no (normal maintenance ended 2025-04-01) |
| 3.3 | 2027-03-31 (expected) | **yes** (security maintenance) |
| 3.4 | TBD | **yes** (normal maintenance; released 2024-12-25) |
| 4.0 | TBD | **yes** (normal maintenance; released 2025-12-25; current stable 4.0.7) |

Source: https://www.ruby-lang.org/en/downloads/branches/

### Linux ARM64 (aarch64-linux)

Prebuilt aarch64-linux MRI from:
1. **ruby/ruby-builder toolcache** (consumed by setup-ruby): `ubuntu-NN.NN-arm64`
   archives for Ruby 2.3.5–2.3.8, all 2.4.x, 2.5.x, 2.6.x, 2.7.x, 3.0.x–3.4.x,
   3.5.0-preview1, 4.0.x. setup-ruby supports `ubuntu-22.04-arm`/`24.04-arm`/`26.04-arm`.
2. Official Docker `ruby` image ships arm64 (verified via Docker Hub tags API:
   3.3.12 lists amd64/ppc64le/386/s390x/arm/arm64/riscv64)
3. Homebrew on Linux provides ARM64 bottles

Native source-level aarch64-linux support (fiber coroutine arm64 case in
`configure.ac`) landed in **Ruby 2.7.0**; earlier versions compile via ucontext
fallback.

## 4. JRuby and TruffleRuby

### JRuby — platform support = bundled JNI natives × available JDK

| Version | macOS ARM64 | Windows | Linux ARM64 | Java floor |
|---|---|---|---|---|
| 1.7 | **unsupported** | official | **unsupported** | 6+ |
| 9.1 | **unsupported** | official | works, untested upstream | 7+ |
| 9.2 | works, untested upstream (**from 9.2.18.0**) | official | works, untested upstream | 8+ |
| 9.3 | **official** | official | **official** | 8–17 |
| 9.4 | **official** | official | **official** | 8+ |
| 10.0 | **official** | official | **official** | **21+** |
| 10.1 | **official** | official | **official** | **21+** |

**The macOS ARM64 cutover is binary-verifiable**: the arm64 slice in
`lib/jni/Darwin/libjffi-1.2.jnilib` first ships in **9.2.18.0**. Verified by
extracting Darwin jffi from 9.2.14.0 (i386+x86_64 only), 9.2.16.0 (no arm64),
9.2.17.0 (no arm64), 9.2.18.0 (arm64 present). So jruby-1.7 and jruby-9.1
**cannot run natively on Apple Silicon at all**.

9.1 evidence: `lib/jni` contains aarch64-Linux (ELF ARM aarch64 jffi confirmed
with `file(1)`) but Darwin jffi is i386+x86_64 only.

**JDK availability gates JRuby Apple Silicon** (JRuby is JVM-hosted):
- Temurin has **NO mac aarch64 JDK 8** (Adoptium API returns empty); ships mac
  aarch64 for 11, 17, 21, 25
- Azul Zulu ships `macosx_aarch64` for JDK 8 (`zulu8.96.0.205-ca-jdk8.0.504`)
  and 11, nothing for JDK 7
- Implication: **jruby-9.2 (Java 8 floor) on Apple Silicon needs Zulu 8 aarch64
  or Temurin 11+**; 9.3/9.4 fine on Temurin 11/17/21; 10.x needs Temurin 21+
- Linux aarch64: Temurin exists for 8, 11, 21 — all JRuby ≥ 9.1 have a JVM
- **Windows aarch64: Temurin only from JDK 21** (JDK 17 returns NONE) — so JRuby
  Windows ARM64 is only realistic on 10.x, which also bundle aarch64-Windows jffi (9.3+)

JRuby 10.1 ships Prism "as a set of pre-optimized native builds (for Windows,
Linux, and MacOS on x86_64 or arm64) or as a WASM build on other platforms", and
added riscv64 (#9287). Verified `jruby-bin-10.1.2.0` `lib/jni`: Darwin
(x86_64+arm64), aarch64-Linux, aarch64-Windows, aarch64-OpenBSD, riscv64-Linux.

**JRuby/Windows caveats**: (a) CRuby C extensions cannot be built/used — gems
must be pure-Ruby or ship Java extensions; (b) `jruby-launcher` native gem needs
a MinGW toolchain and historically fails to find java under version managers
(#6454); (c) upstream Windows CI is thinner than Linux/macOS; (d) recurring
Windows fixes in release notes (symlink, gid/stat, path mangling, line endings —
9.3.0.0 #6404/#6458/#6762).

Sources: https://www.jruby.org/2021-09-22/jruby-9-3-0-0.html ,
https://www.jruby.org/2025-04-14/jruby-10-0-0-0.html ,
https://github.com/jruby/jruby/releases/tag/9.2.18.0 ,
https://api.adoptium.net , https://api.azul.com

### TruffleRuby

| Version | macOS ARM64 | Windows | Linux ARM64 |
|---|---|---|---|
| 22.3 | official | **unsupported** | official |
| 23.0 | official | **unsupported** | official |
| 23.1 | official | **unsupported** | official |
| 24.2 | official | **unsupported** | official |
| 25.0 | official | **unsupported** | official |
| 33.0 | official | **unsupported** | official |
| 34.0 | official | **unsupported** | official |

**TruffleRuby has NEVER shipped a Windows build** — zero windows assets across
all 66 GitHub releases (verified via releases API). `ruby/setup-ruby` hard-fails:
"TruffleRuby does not currently support Windows." **Exclude TruffleRuby from all
Windows CI lanes.** This is why turbo_tests2's tier table says "Unsupported" for
TruffleRuby/Windows, and it can now be evidenced rather than asserted.

Timeline: `darwin-aarch64` added in **22.2.0** (#2181); `linux-aarch64` added in
**21.2**; **macOS Intel (`darwin-amd64`) REMOVED in 34.0.0** (#4011, "since both
Apple and GraalVM no longer support it"). setup-ruby enforces the same:
"TruffleRuby 34+ no longer supports macOS Intel, please exclude that combination
from CI."

33.0.0 is the last release with macOS Intel builds; also switched versioning from
GraalVM-based to CRuby-based (#4020: "TruffleRuby version AB.C.D aims to be
compatible with CRuby A.B") and changed Maven coordinates to
`dev.truffleruby:truffleruby` (#4034).

**TruffleRuby CI-relevant constraints:**
- **Forces `Gem.platforms = [Gem::Platform::RUBY]`** so MRI precompiled platform
  gems are never used (different ABI); only an allowlist (`libv8`, `libv8-node`,
  `sass-embedded`, `sorbet-static`, `tailwindcss-ruby`, plus
  `-Xreuse-precompiled-gems`) may install precompiled. Gem installs are source
  builds → CI needs gcc/g++/make, zlib, CA certs, UTF-8 locale.
  **Do not prune the `ruby` platform from a matrix that includes TruffleRuby.**
- `gem update --system` not fully supported (warned since 19.3.0; issue #1479).
  Treat RubyGems/Bundler versions as engine-managed defaults.
- **libyaml**: ≤ 25.0.0 requires *system* libyaml for the psych C extension;
  23.0.0 switched psych to system libyaml (#2089). **Since 33.0.0 TruffleRuby
  bundles its own libyaml** (#3479) and libssl (still needs system CA certs).
- GraalVM coupling per release: 40.0.0↔Truffle 25.3.4.1↔GraalVM 25.3.x;
  34.0.0↔25.0.2; 33.0.0↔25.0.1; 25.0.0↔25.0.0.
- Missing features: no `fork`, no Ractor, no continuation/callcc, io/console +
  io/wait partial, no pty, no RubyVM, QUIT untrappable in JVM mode;
  GEM_HOME/GEM_PATH must be unset when not using a Ruby manager.

Repo note: `github.com/oracle/truffleruby` now 301-redirects to
`github.com/truffleruby/truffleruby`.

Sources: https://github.com/truffleruby/truffleruby/releases/tag/graal-34.0.0 ,
https://github.com/truffleruby/truffleruby/blob/master/lib/truffle/rubygems/defaults/truffleruby.rb ,
https://github.com/truffleruby/truffleruby/blob/graal-25.0.0/doc/user/installing-libyaml.md

### setup-ruby support window (useful CI evidence)

jruby 9.1.17.0–10.1.2.0 and truffleruby 19.3.0–40.0.0 on Ubuntu (incl.
`ubuntu-22.04/24.04/26.04-arm`) and macOS 14+ runners. TruffleRuby refused on
Windows; TruffleRuby ≥ 34 refused on macOS Intel.

Source: https://github.com/ruby/setup-ruby/blob/master/README.md

## 5. Gemspec declaration semantics

A gemspec declares **ONE platform per built artifact** via `spec.platform`
(default `Gem::Platform::RUBY`, the string `"ruby"`). Multi-platform support is
expressed by releasing the same version multiple times, once per platform — e.g.
nokogiri publishes `ruby, java, arm64-darwin, x86_64-darwin, x64-mingw-ucrt,
x64-mingw32, x86-linux, x86-mingw32, x86-mswin32, aarch64-linux(-gnu/-musl),
x86_64-linux(-gnu/-musl), arm-linux(-gnu/-musl)` (verified via
https://rubygems.org/api/v1/versions/nokogiri.json). Cross-compilation is driven
by rake-compiler, not the gemspec.

`spec.platform = Gem::Platform::CURRENT` is the documented shortcut: the builder
replaces it with `Gem::Platform.local`, stamping platform into the gem filename
(`name-version-platform.gem`).

Three orthogonal constraints: `required_ruby_version` (a `Gem::Requirement` on
`RUBY_VERSION`), `required_rubygems_version` (on `Gem::VERSION`), and `platform`
(the CPU/OS/libc the binary was built for). Both `required_*` participate in
resolution and in `Gem::Platform.same_deps?` tie-breaking.

Source: https://guides.rubygems.org/specification-reference/

## 6. Gotchas that will bite a generated matrix

1. **Two vocabularies are not interchangeable.** Gemfile DSL `platforms:`
   (implementation) vs `Gemfile.lock` PLATFORMS (OS/arch). The gemfile(5) man
   page explicitly warns they differ.
2. **`universal-java` lockfile churn.** JRuby's local platform is
   `universal-java-<N>` while published gems use plain `java`. Bundler **2.6.5**
   fixed "lockfile platforms inconveniently added on JRuby" (PR #8494, commit
   `8b6da3e1a`): `validate_platforms!` now also passes when the lockfile contains
   plain `ruby`, so a lockfile with only `ruby` + `java` no longer forces adding
   `universal-java-11`.
3. **musl/Alpine matching is NOT commutative.** For OS `linux` the version is the
   libc name; a runtime with no version means `gnu`. A plain `x86_64-linux` gem
   does not satisfy an `x86_64-linux-musl` runtime — gems must publish explicit
   `-musl` builds. Support depends on the RubyGems/Bundler version in use
   (added 2021, reverted 3.2.14, re-landed 3.3.x).
4. **Generic `arm` no longer matches 64-bit ARM** (RubyGems 3.6.0, `14c4c16e9`).
   Also two spellings: Linux `aarch64-linux` vs Apple `arm64-darwin` — a matrix
   must treat `aarch64` and `arm64` as distinct CPUs.
5. **darwin local platforms carry an OS version** (`arm64-darwin-23`) while
   released gem platforms are unversioned. Frozen-lockfile CI fails with "Your
   bundle only supports platforms [...] but your local platform is ..." unless
   the unversioned or matching platform is locked. Fixes:
   `bundle lock --add-platform x86_64-linux`, `bundle lock --normalize-platforms`.
6. **Constant naming traps**: `X64_LINUX` = `"x86_64-linux"`; `X64_MINGW` =
   `"x64-mingw-ucrt"` while `X64_MINGW_LEGACY` = `"x64-mingw32"`; `MINGW` =
   `"x86-mingw32"`.
7. **TruffleRuby forces the `ruby` platform variant** unless the gem is allowlisted
   in `Gem::Platform::REUSE_AS_BINARY_ON_TRUFFLERUBY`. Bundler also
   unconditionally adds `Gem::Platform::RUBY` on TruffleRuby.
8. **RubyGems 4.1 introduces content-addressable (Ruby-ABI-specific) gems** named
   by SHA-256 prefix instead of platform; selection prefers ABI+platform match
   over platform specificity. A matrix keyed purely on
   `name-version-platform.gem` strings will need to account for these.

## 7. Unverified — do NOT encode as fact

- Exact completion date of the `macos-latest` → macOS 12 migration (2022–23).
  Announced 2022-10-03 "over the next 10 weeks"; issue #6384 planned 2023-03-01;
  no GitHub post confirms actual completion.
- The original 2022 private-beta announcement for M1 macOS larger runners; the
  earliest verifiable GitHub-hosted ARM64 macOS label is the M1 larger runner
  (`macos-latest-xlarge` / `macos-13-xlarge`) from 2023-10-02.
- Precise per-day cutover dates of gradual migrations — GitHub gives windows, not
  per-repo switch dates.
- Whether `ubuntu-26.04-arm` reads "Public preview" or GA in the docs hardware
  table at a given moment (issue #14747 says GA 2026-09-17; a cached docs
  rendering still showed preview).
- **rubygems.org as a distribution channel for Ruby itself** — RubyGems
  distributes gems, not interpreter binaries; no authoritative page found. The
  exact RubyGems release that first added `arm64-darwin` support was not pinned
  (`Gem::Platform` parses cpu-os generically, so no single "addition" exists).
- `binaries.rubylang.org` unreachable from the research host.
- RVM prebuilt binaries: `rvm.io/binaries/rubies/` 404s, no Wayback snapshots,
  Fastly probes 404 for both arm64 and x86_64. RVM currently compiles from source
  on Apple Silicon (rvm/rvm#5275).
- Whether Ruby 2.6.0–2.6.6 / 2.7.0–2.7.1 compile cleanly on *current*
  macOS+Xcode on Apple Silicon — only historical issue reports found.
- "Ruby 3.0.0 first officially supported Apple Silicon" — not stated on
  ruby-lang.org; verifiable milestone is 2.7.2 native `configure.ac` support.
- No formal ruby-lang.org page defines "supported vs community-maintained
  platforms". Closest: `doc/maintainers.md` "Platform Maintainers" (mswin64,
  mingw32, AIX, FreeBSD, Solaris, RHEL/CentOS, macOS, OpenBSD, WASM have named
  maintainers; cygwin explicitly has none).
- Exact macOS darwin version numbers reported by current GitHub macOS runners
  (e.g. whether `macos-15` local platform is `arm64-darwin-24`) — not executed on
  a runner.
- Intel macOS EOL is a moving target: Sep 2025 said `macos-15-intel` is "the last
  x86_64 image" until Aug 2027, but GitHub then shipped `macos-26-intel`. Verify
  against runner-images before publishing a hard date beyond "~2027".
- `macos-13` retirement date inconsistency in GitHub's own sources: changelog and
  issue title say Dec 4 2025; issue body once said Dec 8; issue closed Dec 16
  2025 confirming images disabled. **Treat Dec 4, 2025 as official.**
- JRuby 9.2.18.0+ actually executing end-to-end on Apple Silicon — binary
  evidence only (arm64 jffi slice + Zulu 8/Temurin 11 mac aarch64 JVMs exist); no
  upstream CI or official statement.
- JRuby 1.7/9.1 under Rosetta 2 with an x86_64 JDK — no upstream statement. The
  bundled x86_64 jffi would load, but this is untested upstream; do not claim
  support.
- JRuby 9.4 Java support ceiling — branch README says only "JRE 8 or higher".
- JRuby on Windows ARM64 runtime behavior — aarch64-Windows jffi ships in 9.3+/10.x
  (binary-verified) and Temurin 21 has windows-aarch64 (API-verified), but no
  upstream CI or support statement.
- `jruby.org/download` requirements text (JavaScript-rendered); Java floors sourced
  from release announcements and per-branch READMEs instead.
- 32-bit Windows (`x86-mingw32`/`x86-mswin32`) end-of-support status beyond the
  constants still existing.
- TruffleRuby "officially tested OS list" quoted from README reflects
  master/25.0.0-era docs; older tags only spot-checked at vm-22.3.1, graal-23.1.0,
  graal-25.0.0.

## 8. Fleet exposure check (2026-10-09)

Verified: **no kettle-jem-templated Ruby gem pins `macos-14`.** The packaged
template uses the floating `macos-latest` label
(`gems/kettle-jem/lib/kettle/jem/templates/.github/workflows/current.yml.example`),
which currently resolves to macOS 26 ARM64 and is not affected by the
`macos-14` retirement on 2026-11-02 or its October brownouts.

The only first-party workspace use of `macos-14` is
`structuredmerge/structuredmerge/.github/workflows/{current,publish}.yml`
(4 occurrences), whose workflows are generated by the third-party Alef tool
(`alef.toml`, `xberg-io/alef`) and are not kettle-jem-templated. Out of scope for
this slice; noted so it is not lost.

A workspace-wide scan found the remaining `macos-14` hits only under `vendor/`
and `tmp/` paths, which are not ours to maintain.

**Design note**: floating `macos-latest` avoids pin-rot but is not reproducible —
it silently changes architecture and OS version on GitHub's schedule (Intel →
ARM64 in Apr–May 2024). A generated matrix should record which label it used and
on what date, so a support claim remains interpretable later.
