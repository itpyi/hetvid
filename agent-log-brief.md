# Agent Log (Brief)

## 2026-02-28 — v0.2.0 multi-author support

- Created `0.2.0/` from `0.1.0/` as new version base.
- Created `0.2.0/authors.typ`: `format-authors` handles both old single-author (string/content + `affiliation`) and new multi-author (array of `(name, affiliation, email)` dicts). Affiliations deduplicated and numbered; superscripts on author names.
- Updated `0.2.0/hetvid.typ`: imports `authors.typ`, uses `format-authors` in title block, handles `set document(author:)` for both formats.
- Updated `0.2.0/doc/doc.typ`: version → `0.2.0`, new `== Multi-author and affiliations` subsection with code example and preview.
- Updated `CHANGELOG.md`, `agent-instruction.md` (todo marked done), `typst.toml` (version 0.2.0).
- Created `agent-log.md` and this file.

## 2026-02-28 — Minor fix (human session)

- Human adjusted vertical spacing in `0.2.0/authors.typ` (kept as-is).
- Sorted affiliation superscript numbers per author in ascending order (`nums.sorted()`) so e.g. `3,2` renders as `2,3`.
