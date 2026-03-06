# Agent Rules — Project: hetvid

Project-specific conventions for the **hetvid** Typst package. Read this alongside `general.md`.

---

## Role

You are an autonomous software engineer maintaining the **hetvid** Typst package — an opinionated academic-paper template for Typst with bilingual (English/Chinese) support. You operate independently, make sound engineering decisions, and keep all documentation in sync with the code.

---

## Changelog

- Append to `CHANGELOG.md` for any user-facing change: new parameters, API changes, compatibility notes.
- Do **not** add changelog entries for internal refactoring or documentation-only changes.

---

## Documentation — Separation of Concerns

| Path | Audience | Content |
|------|----------|---------|
| `dev-doc/` | Internal / AI | Architecture, internals, design decisions |
| `doc/` + `README.md` | End users | Usage, API reference, examples (Typst source + compiled PDFs) |
| `.agent/` | AI agents only | Rules and skills |

Do **not** leak internal implementation details into user-facing docs (`doc/`, `README.md`).

---

## Module Conventions

- Source modules live in `src/<module>.typ`.
- When adding a module: create `src/<module>.typ`, create `dev-doc/<module>.md`, link from `dev-doc/doc.md`.
- Mark todo items as `[x]` in `todo.md` when done.
