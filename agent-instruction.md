Instructions for agent
======================

## General rule

- This file is intended for instructing AI agents to maintain this project.
- This file is structured by the logic of the project itself. In each section, there is a "Description" subsection and a "Todo" subsection. The Description is for a general description. The Todo is a todo list for AI agents to read. After finishing, the agent should mark the item.
- The AI agent should maintain a `agent-log.md`. After each execution, the agent should write done briefly what it has done in the log.
- Human modification should also be documented in the `agent-log.md`. Human maintainer will tell AI agent to do so explicitly after modifying. But this information will not be documented in this file, so this file is not a complete source for what has been done.
- AI agent should maintain a `agent-log-brief.md` for a much briefer version of the `agent-log.md`. Explicit instruction will be given for update it from `agent-log.md`. AI agent can also update it automatically when necessary.
- One a new session is turned on, the agent should refer to the `agent-log-brief.md` to understand what has been done in this project, for particularly important details, it can further refer to the `agent-log.md`.
- `CHANGELOG.md` is **user-facing**. Only document changes visible to template users (parameters, behaviors, compatibility). Internal file/function changes (e.g., which `.typ` files were created or which internal functions were added) go in `agent-log.md` and `agent-log-brief.md`, not in the changelog.
- **Git commits**: commit once per logical task completion (a finished todo item, a self-contained fix) — not per file and not mid-task. The commit message should describe the change at the user/feature level (e.g. `add multi-author support`, `fix affiliation superscript ordering`), not at the implementation level (e.g. not `create authors.typ`). When the human says "end this session" (or similar), check for any uncommitted changes and commit them before closing.
- **Log ordering**: new entries in `agent-log.md` and `agent-log-brief.md` must be **prepended** (newest entry at the top of the file), not appended.
- Publish. See `publish-guide.md` for instructions for publishing.

## Version 0.1.0

This version has been published to Typst Universe.
This is a template for academic notes.

## Version 0.2.0

### Description

Add multi-author to this version, while compatible with the single-author syntax in 0.1.0.
The new author list is stored in the template parameter `author`, and `affiliation` is not used.
The new `author` parameter is a list of dicts, with keys `name`, `affiliation` and `email`, the value of name is content, value of affiliation can be a list of contents, for multiple affiliations, value of email content.
The author is separated by commas (and a space), and all the affiliations are numbered. 
Two people can have same affiliations, then they share a same number. 
The name-to-affil relation will be displayed by the numbers following each name, as superscript.

### Todo

- [x] Realize the multi-author-affil by a separate typ file, can call it from the template file `hetvid.typ`. Modify doc.typ to show an example. 
- [x] Display an author's email if the corresponding field is non-empty. Put the emails to the footnote of the first (title) page, in the format [full name: email], with the email in mono-space font.