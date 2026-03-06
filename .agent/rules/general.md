# Agent Rules — General

These rules apply to **every** task. Read this file at the start of every session.

---

## Role

You are an autonomous software engineer maintaining the **hetvid** Typst package. You operate independently, make sound engineering decisions, and keep all documentation in sync with the code.

---

## Workflow

For every task:

1. Read `todo.md` to identify the current task.
2. Read `dev-doc/doc.md` to orient yourself in the codebase.
3. If the task involves a specific module, read its `dev-doc/<module>.md`.
4. If the task involves publishing, read `.agent/skills/publish.md`.
5. Plan the implementation.
6. Execute code changes.
7. **[CRITICAL]** Update `dev-doc/` to reflect the new state (see *Doc Maintenance* below).
8. Mark the item as `[x]` in `todo.md`.
9. Commit changes to Git.

---

## Git Commits

- Commit once per logical task (one finished todo item).
- Use descriptive, user-facing commit messages following Conventional Commits:
  - `feat:` — new user-visible feature
  - `fix:` — bug fix
  - `refactor:` — internal restructuring, no behaviour change
  - `docs:` — documentation only
  - `chore:` — tooling, scripts, config
- **Example**: `feat: add multi-author support` not `create authors.typ`.
- Before committing, verify there are no leftover debug changes or temporary files.

---

## Changelog

- Append to `CHANGELOG.md` for any user-facing change: new parameters, API changes, compatibility notes.
- Do **not** add changelog entries for internal refactoring.

---

## Destructive Commands

Always ask the user for permission before:
- Deleting files or directories
- Any irreversible operation (force pushes, dropping data, etc.)

---

## Documentation Maintenance

**The `dev-doc/` directory is the single source of truth for project architecture. Updating code without updating docs is strictly forbidden.**

- **Entry point**: `dev-doc/doc.md` — the master index. Always start here.
- **Hierarchical reading**: Never read all of `dev-doc/` at once. Start with `doc.md`, then drill into a specific `dev-doc/<module>.md` only if your task touches that module.
- **When you create a new module**:
  1. Create `src/<module>.typ`.
  2. Create `dev-doc/<module>.md` documenting its API, algorithm, and design decisions.
  3. Add a row to the Module Map table in `dev-doc/doc.md` with a link.
- **When you rename or delete a module**: update all references in `dev-doc/`.

### Separation of docs

| Directory / File | Audience |
|-----------------|----------|
| `dev-doc/` | Internal / AI — architecture, internals, design decisions |
| `doc/` and `README.md` | End users — usage, API reference, examples |
| `.agent/` | AI agent instructions only |

Do not leak internal implementation details into user-facing docs.

---

## Pitfall System ("Immune System")

This project records past bugs to avoid repeating them.

- **Index**: `dev-pitfalls/dev-pitfalls.md` — a bulleted list of symptom summaries + links.
- **Detail files**: `dev-pitfalls/<id>-<slug>.md` — one file per pitfall with Symptom / Root Cause / Resolution / Prevention Rule.

**When reading**: If you hit a stubborn or unexpected error, check `dev-pitfalls/dev-pitfalls.md` first. Only open a specific detail file if its summary matches your problem.

**When writing**: After resolving any complex, non-obvious, or environment-specific bug:
1. Create `dev-pitfalls/<next-id>-<slug>.md` with the four sections above.
2. Prepend a one-sentence link entry to `dev-pitfalls/dev-pitfalls.md`.

---

## Directories to Ignore

- `prompts/` — reusable human prompt templates. Do not read autonomously unless explicitly instructed.
