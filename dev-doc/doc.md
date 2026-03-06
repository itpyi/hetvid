# hetvid — Developer Documentation

> **Entry point for AI agents and internal developers.**  
> Read this file first. Open a module doc **only** when your task touches that module.

---

## Project Overview

**hetvid** is a Typst package providing an opinionated academic-paper template. It targets bilingual (English/Chinese) documents with support for multi-author affiliations, theorem environments, and styled code blocks.

- **Current version**: 0.2.0
- **Publishable source**: `src/`
- **User-facing docs**: `doc/doc.typ`, `doc/doc-cn.typ` + compiled PDFs
- **Package registry entry**: `src/typst.toml`

---

## Repository Layout

```
src/                  # Publishable package source (submitted to typst.app)
  hetvid.typ          # Template entry point
  authors.typ         # Multi-author / affiliation rendering
  dingli.typ          # Theorem environments
  typst.toml          # Package manifest
  template/           # Minimal starter template for users
  thumbnail.png       # Registry preview thumbnail

doc/                  # User-facing documentation
  doc.typ / doc-cn.typ / ref.bib

dev-doc/              # Internal / AI documentation (you are here)
  doc.md              # This file — master index
  hetvid.md           # → hetvid.typ internals
  authors.md          # → authors.typ internals
  dingli.md           # → dingli.typ internals

scripts/              # Helper scripts (thumbnail generation, etc.)
prompts/              # Reusable human prompt templates — DO NOT read autonomously
```

---

## Module Map

| File | One-line role | Detail doc |
|------|--------------|------------|
| `src/hetvid.typ` | Template entry point; `#show: hetvid.with(...)` | [hetvid.md](hetvid.md) |
| `src/authors.typ` | Multi-author / affiliation / email rendering | [authors.md](authors.md) |
| `src/dingli.typ` | Theorem environments + show rules | [dingli.md](dingli.md) |

---

## Key Design Principles

1. **Backward compatibility is non-negotiable.** Every new parameter must have a default that preserves existing document rendering.
2. **Single entry point.** Users only ever write `#show: hetvid.with(...)`. Internal modules are imported by `hetvid.typ`, not by users.
3. **Language-aware.** Any feature touching typography or numbering must handle both `lang: "en"` and `lang: "zh"`.
4. **No state leakage between modules.** `authors.typ` and `dingli.typ` do not read each other's state.

---

## Version History (architectural changes only)

| Version | Change |
|---------|--------|
| 0.1.0 | Initial release. Single-author template. |
| 0.2.0 | Multi-author support (`authors.typ` extracted). Email footnotes on title page. Footnote counter reset after title block. |

> For user-facing changes see `CHANGELOG.md`. For commit history use `git log`.

---

## Adding a New Module

1. Create `src/<module>.typ` and import it in `src/hetvid.typ`.
2. Create `dev-doc/<module>.md` documenting its public API, algorithm, and design decisions.
3. Add a row to the **Module Map** table above.
