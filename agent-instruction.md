Instructions for agent
======================

## General rule

- This file is intended for instructing AI agents to maintain this project.
- This file is structured by the logic of the project itself. In each section, there is a "Description" subsection and a "Todo" subsection. The Description is for a general description. The Todo is a todo list for AI agents to read. After finishing, the agent should mark the item.
- The AI agent should maintain a `agent-log.md`. After each execution, the agent should write done briefly what it has done in the log.
- Human modification should also be documented in the `agent-log.md`. Human maintainer will tell AI agent to do so explicitly after modifying. But this information will not be documented in this file, so this file is not a complete source for what has been done.
- AI agent should maintain a `agent-log-brief.md` for a much briefer version of the `agent-log.md`. Explicit instruction will be given for update it from `agent-log.md`. AI agent can also update it automatically when necessary.
- One a new session is turned on, the agent should refer to the `agent-log-brief.md` to understand what has been done in this project, for particularly important details, it can further refer to the `agent-log.md`.

## Version 0.1.0

This version has been published to Typst Universe.
This is a template for academic notes.

## Version 0.1.1

### Description

Add multi-author to this version, while compatible with the single-author syntax in 0.1.0.
Now the title and authors are all left-aligned, a modern view.
Refer to `doc.typ`, `doc-cn.typ` for more details on the design logic.

### Todo

- [ ] Give me suggestions on how multiple authors will be aligned.