# Agent Rules — General

These rules apply to **every** task on any project. Read this file at the start of every session.

---

## Workflow

For every task:

1. Read the task tracker (e.g., `todo.md`) to identify the current task.
2. Read `dev-doc/doc.md` to orient yourself in the codebase.
3. If the task involves a specific module, read its `dev-doc/<module>.md`.
4. If the task requires a specific procedure, read the relevant skill from `.agent/skills/`.
5. Also read `.agent/rules/project.md` for project-specific conventions.
6. Plan the implementation.
7. Execute code changes.
8. **[CRITICAL]** Update `dev-doc/` to reflect the new state (see *Documentation* below).
9. Mark the task as done in the task tracker.
10. Commit changes to Git.

---

## Git Commits

- Commit once per logical task (one finished todo item).
- Use descriptive commit messages following Conventional Commits:
  - `feat:` — new user-visible feature
  - `fix:` — bug fix
  - `refactor:` — internal restructuring, no behaviour change
  - `docs:` — documentation only
  - `chore:` — tooling, scripts, config
- Before committing, verify there are no leftover debug changes or temporary files.

---

## Destructive Commands

Always ask the user for permission before:
- Deleting files or directories
- Any irreversible operation (force pushes, dropping data, etc.)

---

## Documentation

**`dev-doc/` is the single source of truth for project architecture. Updating code without updating docs is strictly forbidden.**

- **Entry point**: `dev-doc/doc.md` — the master index. Always start here.
- **Hierarchical reading**: Never read all of `dev-doc/` at once. Start with `doc.md`, then open a specific `dev-doc/<module>.md` only if your task directly involves that module.
- **When you create a new module**:
  1. Create the module source file.
  2. Create `dev-doc/<module>.md` documenting its public API, algorithm, and design decisions.
  3. Add a row to the Module Map table in `dev-doc/doc.md` with a link.
- **When you rename or delete a module**: update all references in `dev-doc/`.

---

## Available Skills

| Skill file | When to invoke |
|---|---|
| `publish.md` | Cutting a release and submitting to the Typst package registry |
| `sync-docs.md` | Auditing or updating `dev-doc/` — checks if docs exist and match code, uses git log to find undocumented changes |

---

## Pitfall System ("Immune System")

This project records past bugs to avoid repeating them.

- **Index**: `dev-pitfalls/dev-pitfalls.md` — a bulleted list of symptom summaries + links.
- **Detail files**: `dev-pitfalls/<id>-<slug>.md` — one file per pitfall with Symptom / Root Cause / Resolution / Prevention Rule.

**When reading**: If you hit a stubborn or unexpected error, check `dev-pitfalls/dev-pitfalls.md` first. Only open a specific detail file if its summary matches your problem.

**When writing**: After resolving any complex, non-obvious, or environment-specific bug:
1. Create `dev-pitfalls/<next-id>-<slug>.md` with the four sections above.
2. Prepend a one-sentence link entry to `dev-pitfalls/dev-pitfalls.md`.

