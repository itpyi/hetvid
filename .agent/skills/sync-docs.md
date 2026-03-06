# Skill: Sync dev-doc with Code

**Invoke this skill when:**
- You are asked to audit or update documentation
- You have just finished a coding task (before committing)
- You suspect docs may be stale after reviewing git history
- A human asks "are the docs up to date?"

---

## Step 0 — Check that dev-doc exists

```sh
ls dev-doc/
```

If the directory is missing, create it:

1. Create `dev-doc/doc.md` as the master index (use the structure described in `.agent/rules/general.md`).
2. For every file in `src/*.typ`, create a corresponding `dev-doc/<module>.md`.
3. Commit: `git commit -m "docs: bootstrap dev-doc/"`

If it exists, proceed to Step 1.

---

## Step 1 — Find undocumented code changes via git log

Scan commits since the last doc-update commit to identify human-edited changes that may not be reflected in `dev-doc/`.

```sh
# Show commits that touched src/ but NOT dev-doc/ — these are documentation gaps
git log --oneline -- src/ | head -30
git log --oneline -- dev-doc/ | head -10
```

Then compare the two lists: any commit that appears in the `src/` list but not as a following entry in the `dev-doc/` list is a potential gap.

For a more precise diff, find the SHA of the most recent commit that touched `dev-doc/`:

```sh
LAST_DOC=$(git log --oneline -- dev-doc/ | head -1 | awk '{print $1}')
git log --oneline ${LAST_DOC}..HEAD -- src/
```

Each commit returned is a coding change made after the last doc update. Read the diff for each:

```sh
git show --stat <sha>
git show <sha> -- src/<file>.typ
```

Record what changed (new parameters, renamed symbols, new modules, deleted functions, behavior changes).

---

## Step 2 — Diff code against docs for each module

For each `src/<module>.typ` file, open both the source and `dev-doc/<module>.md` side-by-side mentally (or read them sequentially) and check:

| Code element | What to verify in dev-doc |
|---|---|
| Public function signature | All parameters listed with correct type, default, and description |
| New parameter added | Row added to the parameter table |
| Parameter removed or renamed | Table row updated/removed |
| Internal helper added or removed | "Internal Helpers" section updated |
| Module-level constants | Listed if they affect behavior or are exposed |
| Imports from another module | Architecture section reflects dependency |
| Algorithm / data-flow change | Prose description matches current logic |

Also check `dev-doc/doc.md`:

- **Module Map** table has a row for every `src/*.typ` file.
- **Version History** reflects any architectural change in the current work.
- **Repository Layout** still matches the actual directory structure.

---

## Step 3 — Update stale docs

For each discrepancy found in Step 2:

1. Open the relevant `dev-doc/<module>.md`.
2. Make the minimal precise edit: update a table row, rewrite a paragraph, add a section.
3. Do **not** leak internal details into `doc/` or `README.md` (those are user-facing).
4. If a module was added, create `dev-doc/<module>.md` and add it to the Module Map in `doc.md`.
5. If a module was deleted, remove its `dev-doc/<module>.md` and its row from `doc.md`.

---

## Step 4 — Commit the doc update

After all edits:

```sh
git add dev-doc/
git commit -m "docs: sync dev-doc with <brief description of what changed>"
```

Use a separate commit from code changes so the git log clearly separates coding and documentation work.

---

## Checklist

- [ ] `dev-doc/` directory exists
- [ ] Every `src/*.typ` has a corresponding `dev-doc/<module>.md`
- [ ] `dev-doc/doc.md` Module Map is complete and accurate
- [ ] All parameters in public functions are documented
- [ ] Git commits that touched `src/` after the last `dev-doc/` commit are accounted for
- [ ] Doc update committed separately with a `docs:` prefix
