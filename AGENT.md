# General Instructions to Agent

## General Rules for AI Agent

- **Role**: You are an autonomous software engineer maintaining this project.
- **Single Source of Truth**: The `dev-doc/` directory contains the absolute truth of the project's architecture and logic. **Updating the code without updating the corresponding doc is strictly forbidden.**
- **Workflow**:
  1. Read `todo.md` to understand the current task.
  2. Read `dev-doc/doc.md` to orient yourself in the codebase.
  3. Plan the implementation.
  4. Execute code changes.
  5. **[CRITICAL]** Update or create files in `dev-doc/` to reflect the new state.
  6. Mark the item as `[x]` in `todo.md`.
  7. Commit changes to Git.
- **Git Commits**: Commit once per logical task (a finished todo item). Use clear, descriptive commit messages (e.g., `feat: add multi-author support` rather than `create authors.typ`).
- **Changelog**: Append user-facing changes (API, parameters, compatibility) to `CHANGELOG.md`. Internal refactoring does not go here.
- Ask the user for permission before executing destructive commands (e.g., deleting files or directories).

## Documentation & Context Management

- **Separation of Docs**:
  - `dev-doc/` is strictly for internal developers and AI agents. It contains system architecture, internal workings, and project state.
  - `doc/` (Typst sources + compiled PDFs) and `README.md` are **end-user** documentation. Do not put internal implementation details there.
- **The `prompts/` directory**: Ignore this directory unless explicitly instructed by the user. These are reusable prompt templates for human use, not for autonomous reading.
- **Entry Point**: Your primary entry point into the project knowledge is `dev-doc/doc.md` (master index / module map).
- **Hierarchical Reading (crucial to save context)**:
  - Do NOT read all files in `dev-doc/` at once.
  - Always start with `dev-doc/doc.md` to understand the architecture and locate relevant module documentation.
  - Drill into specific module docs only when your task directly involves that module.
- **Autonomous Doc Maintenance**: You are responsible for keeping `dev-doc/doc.md` and any nested module docs up to date.
  - If you create a new module, create a corresponding `dev-doc/<module>.md` and link it from `dev-doc/doc.md`.
  - If you rename or delete a module, update all affected links in `dev-doc/`.
  - You decide the exact layout and granularity of nested docs — keep them accurate, organized, and linked.