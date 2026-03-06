# `src/hetvid.typ` — Template Entry Point

## Public API

`#let hetvid(...)` — a Typst show rule. Users apply it as `#show: hetvid.with(...)`.

### Parameters

| Parameter | Type | Default | Role |
|-----------|------|---------|------|
| `title` | content | `[Title]` | Document title |
| `author` | str \| content \| array of dicts | `"The author"` | Single or multi-author (see [authors.md](authors.md)) |
| `affiliation` | content | `[The affiliation]` | Legacy single-author affiliation (ignored in multi-author mode) |
| `header` | string | `""` | Running header text (left side, pages > 1) |
| `date-created` | string | today | Creation date string |
| `date-modified` | string | today | Modification date string |
| `abstract` | content | `[]` | Abstract block (omitted if empty) |
| `toc` | bool | `true` | Whether to render a table of contents |
| `paper-size` | string | `"a4"` | Typst paper size identifier |
| `lang` | `"en"` \| `"zh"` | `"en"` | Document language; switches typography and numbering behaviour |
| `thm-num-lv` | int | `1` | Theorem numbering depth (0 = unnumbered, 1 = by section, etc.) |
| `body-font-size` | length | `11pt` | Base body font size |
| `ind` | length | `1.5em` (zh: `2em`) | First-line indent and list indent |
| `justify` | bool | `true` | Paragraph justification |
| `hyphenate` | bool | `true` | Hyphenation |
| `bib-style` | dict | see below | Per-language bibliography style |

`bib-style` default: `(en: "springer-mathphys", zh: "gb-7714-2015-numeric")`.

Font parameters (`body-font`, `raw-font`, `heading-font`, `math-font`, `emph-font`) are priority-ordered arrays passed directly to Typst's `text(font: ...)`.

Color parameters (`link-color`, `muted-color`, `block-bg-color`) use the module-level defaults unless overridden.

---

## Internal Helpers (not exported to users)

| Symbol | Description |
|--------|-------------|
| `par-vir` | Virtual paragraph: emits negative vertical space equal to `par.spacing + line height`. Forces the next paragraph to treat the preceding block as a paragraph, enabling correct CJK first-line indent. |
| `eqref(..labels)` | Renders `Eq. (n)` or `Eqs. (n, m)` with thin space before the parenthesis. |
| `text-muted(it)` | Wraps content in `luma(160)` fill. |
| `link-color`, `muted-color`, `block-bg-color` | Module-level color constants; also exposed as template parameters. |

---

## Title Block Flow

```
v(26pt)
title (bold, heading-font, 20pt)
v(16pt)
format-authors(author, old-affiliation: affiliation, emph-func: emph)
counter(footnote).update(0)          ← reset so body footnotes start from 1
date-created / date-modified
abstract heading + body (if non-empty)
outline() (if toc)
v(2em)
body
```

---

## Key Show Rules Applied (in order)

1. `set text(lang:, hyphenate:)`
2. `set page(paper:, margin:)`
3. `set document(title:, author:)` — author extracted to name strings for multi-author arrays
4. Font sets for body, raw, emph (CJK), math
5. `show heading:` — vertical spacing, heading font, CJK `par-vir`, resets theorem counters (delegated to `dingli-rules`)
6. `set heading(numbering: "1.")`
7. `set par(leading:, spacing:, justify:, first-line-indent:)`
8. List / enum / terms indentation
9. `show math.equation.where(block: true):` — block spacing
10. `set math.equation(numbering: "(1)")`
11. `show: zebraw.with(...)` — code block styling
12. `show raw.where(block: false):` — inline code shaded box
13. `show quote.where(block: true):` — block quote with double-indent
14. `show ref:` — custom equation refs (`(n)`) and CJK heading refs (`第n节`)
15. `show figure.caption:` — bold supplement, center/left alignment based on width
16. `show figure:` — vertical spacing for image/table figures
17. `show link:` — colored links
18. `show: dingli-rules.with(level: thm-num-lv, ...)` — theorem show rules
19. `set page(header:, numbering:)` — running header + page numbers

---

## Design Decisions

- **`zebraw` for code blocks**: provides zebra-stripe line backgrounds, hanging indent, and no language tag. The `numbering-separator: true` option adds a visual separator between line numbers and code.
- **CJK emphasis**: `show emph: set text(font: emph-font)` replaces italic with Kaiti when `lang == "zh"` — italic is visually poor for CJK glyphs.
- **Footnote counter reset**: done in `hetvid.typ` after `format-authors` returns, not inside `authors.typ`, to keep the two modules decoupled.
- **`par-vir`**: a common CJK Typst pattern; required because headings and block-level elements break Typst's paragraph-tracking, causing the next paragraph to lose its first-line indent.
