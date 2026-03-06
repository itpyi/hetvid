# hetvid — Developer Documentation

> **Entry point for AI agents and internal developers.**  
> Start here. Drill into linked module docs only when your task touches that module.

---

## Project Overview

**hetvid** is a Typst package providing an opinionated academic-paper template. It targets bilingual (English/Chinese) documents with support for multi-author affiliations, theorem environments, and styled code blocks.

- **Current version**: 0.2.0
- **Publishable source**: `src/`
- **User-facing docs**: `doc/doc.typ`, `doc/doc-cn.typ` (Typst source) + compiled PDFs
- **Package registry entry**: `src/typst.toml`

---

## Repository Layout

```
src/                  # Publishable package source (this is what gets submitted to typst.app)
  hetvid.typ          # Template entry point
  authors.typ         # Multi-author / affiliation rendering
  dingli.typ          # Theorem environments
  typst.toml          # Package manifest
  template/           # Minimal starter template for users
  thumbnail.png       # Preview thumbnail for the registry

doc/                  # User-facing documentation (Typst source + compiled PDFs)
  doc.typ             # English user doc
  doc-cn.typ          # Chinese user doc
  ref.bib             # Shared bibliography for the docs

dev-doc/              # Internal / AI documentation (you are here)
  doc.md              # This file — master index

scripts/              # Helper scripts (thumbnail generation, etc.)
prompts/              # Reusable human prompt templates — DO NOT read autonomously
```

---

## Module Map

### `src/hetvid.typ` — Template Entry Point

**Public API**: `#let hetvid(...)` — a Typst show rule consumed as `#show: hetvid.with(...)`.

**Key parameters** (see user doc for full list):

| Parameter | Type | Role |
|-----------|------|------|
| `title` | content | Document title |
| `author` | string \| content \| array of dicts | Single or multi-author (see `authors.typ`) |
| `affiliation` | content | Legacy single-author affiliation |
| `header` | string | Running header (left side, pages > 1) |
| `lang` | `"en"` \| `"zh"` | Switches bilingual behaviour |
| `thm-num-lv` | int | Theorem numbering depth (0 = unnumbered) |
| `toc` | bool | Whether to render a table of contents |

**Internal helpers** (not exported):
- `#let par-vir` — virtual paragraph used to trigger correct first-line indent after block-level elements in CJK mode.
- `#let eqref(..labels)` — `Eq. (n)` / `Eqs. (n, m)` helper for equation references.
- `#let text-muted(it)` — renders content in muted grey.

**Title block flow**:
1. Render title in bold heading font.
2. Call `format-authors(author, ...)` from `authors.typ`.
3. Reset footnote counter to 0 (`counter(footnote).update(0)`) so body footnotes start from 1.
4. Render creation/modification dates.
5. Render abstract (if non-empty).
6. Optionally render TOC.

**Design decisions**:
- Theorem environments delegate entirely to `dingli.typ` via `show: dingli-rules.with(...)`.
- Code blocks use the `zebraw` package (zebra-striped, no language label, hanging indent).
- CJK emphasis uses Kaiti font instead of italic (italic is visually poor for CJK glyphs).
- `bib-style` defaults differ by language: `springer-mathphys` for English, `gb-7714-2015-numeric` for Chinese.

---

### `src/authors.typ` — Author / Affiliation Rendering

**Public API**: `#let format-authors(authors, old-affiliation:, emph-func:)`

**Backward compatibility**: If `authors` is a `str` or `content`, the function falls back to old single-author rendering (name + `old-affiliation`).

**New multi-author syntax** (`authors` is an `array` of dicts):

```typst
(
  (name: "Alice", affiliation: "MIT", email: "alice@mit.edu"),
  (name: "Bob",   affiliation: ("MIT", "Harvard")),  // multiple affiliations
)
```

**Algorithm** (via `_collect-affils`):
1. Walk authors; for each affiliation entry, check if `repr(affil)` already exists in the accumulated list.
2. If new, append; record 1-based index. If seen, reuse index.
3. Returns `(affil-list, author-nums)`.

**Rendering rules**:
- If all authors share a single unique affiliation → no superscripts; affiliation rendered once below names.
- If 2+ distinct affiliations → superscript numbers on each author name (sorted ascending); numbered affiliation list below.
- `email` field: if non-empty, appends a `footnote(numbering: _ => [])` — suppresses the inline marker but still shows `Name: raw(email)` in the footnote area at the bottom of page 1.

**Design decisions**:
- `repr()` used for affiliation deduplication so both strings and content values compare correctly.
- Email footnote uses `numbering: _ => []` (anonymous function returning empty) rather than `numbering: none` to suppress the in-text superscript while keeping the footnote body visible.
- Footnote counter is reset in `hetvid.typ` *after* `format-authors` returns, not inside this module, to keep concerns separate.

---

### `src/dingli.typ` — Theorem Environments

**Public API**:

| Symbol | Kind | Description |
|--------|------|-------------|
| `theorem` | base constructor | Generic environment builder |
| `lemma` | derived | Standard lemma |
| `corollary` | derived | Standard corollary |
| `definition` | derived | Standard definition |
| `remark` | unnumbered | Italic remark block (no figure wrapper) |
| `example` | derived | Standard example |
| `proof` | special | Proof block with QED symbol |
| `dingli`, `yinli`, `tuilun`, `dingyi`, `lizi`, `zhengming` | CJK variants | Chinese names, indent-on |
| `dingli-rules` | show rule | Must be applied via `show: dingli-rules.with(...)` |

**Counter architecture**:
- Each environment has its own Typst `counter` (e.g., `c-thm`, `c-lem`).
- Counters are **reset at headings** whose level ≤ `thm-num-lv`. This is wired in `dingli-rules`.
- Environments are wrapped as `figure` elements (with a custom `kind`) so that `@label` cross-references work via the standard `ref` show rule override.

**Numbering format**: `dingli-inpackage-numbering-format` reads `dingli-inpackage-numbering-level` (a `state`) and formats as `"H1.H2.n."` up to the configured depth. Level 0 = unnumbered.

**Remark / Proof** are *not* `figure`-wrapped (they use plain `block`), so they are not cross-referenceable by design.

---

## Key Design Principles

1. **Backward compatibility is non-negotiable.** Every new parameter must have a default that preserves existing document rendering.
2. **Single entry point.** Users only ever write `#show: hetvid.with(...)`. Internal modules are imported by `hetvid.typ`, not by users.
3. **Language-aware.** Any feature that touches typography or numbering must handle both `lang: "en"` and `lang: "zh"` paths.
4. **No state leakage between modules.** `authors.typ` and `dingli.typ` do not read each other's state.

---

## Version History (architectural changes only)

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release. Single-author template. |
| 0.2.0 | Multi-author support (`authors.typ` extracted). Email footnotes on title page. Footnote counter reset after title block. |

> For full user-facing change details, see `CHANGELOG.md`.  
> For commit-level history, use `git log`.

---

## Adding a New Module

1. Create `src/<module>.typ`.
2. Import it in `src/hetvid.typ`.
3. Create `dev-doc/<module>.md` with the same structure as the sections above.
4. Add a row to the **Module Map** table in this file and link to the new doc.
