# Skill: Publishing a New Version

**Read this file only when you are about to publish a release.**  
Pre-conditions: the code is complete, tested, and the todo item is marked done.

---

## 1. Finalize in the dev repo

In this repo (`hetvid/`):

- [ ] Check all dependency versions in `src/typst.toml` are correct and up to date.
- [ ] Set the new version string in `src/typst.toml`.
- [ ] Update `CHANGELOG.md` with the new version entry.
- [ ] Update `README.md` if the API or usage has changed.

The following is done by human AFTER the PR is merged. Agent should NEVER do these.

- [ ] Commit: `git commit -m "release v{version}"`
- [ ] Tag: `git tag v{version}`
- [ ] Push: `git push && git push --tags`

---

## 2. One-time setup: sparse checkout of the packages fork

> Skip this section if already set up.

```sh
git clone --depth 1 --no-checkout --filter="tree:0" git@github.com:{your-username}/packages
cd packages
git sparse-checkout init
git sparse-checkout set packages/preview/hetvid
git remote add upstream git@github.com:typst/packages
git config remote.upstream.partialclonefilter tree:0
git checkout main
```

> The `packages/` directory corresponds to the entire `typst/packages` monorepo.  
> Do **not** touch `README.md`, `LICENSE`, or any other root-level file there.

---

## 3. Sync the packages fork with upstream

```sh
cd packages   # the forked typst/packages repo
git fetch upstream
git merge upstream/main
```

---

## 4. Create the version directory and copy files

Create the target directory:

```
packages/preview/hetvid/{version}/
```

(Note: `packages/` here is a subdirectory inside the cloned `packages` repository — the full path has two consecutive `packages` segments.)

Copy from this dev repo into that directory:

| Source | Destination | Notes |
|--------|-------------|-------|
| `src/typst.toml` | version dir | Required |
| `src/hetvid.typ` | version dir | Required |
| `src/authors.typ` | version dir | Required |
| `src/dingli.typ` | version dir | Required |
| `src/template/` | version dir | Required |
| `src/thumbnail.png` | version dir | Required |
| `src/LICENSE` | version dir | Required — never omit |
| `README.md` (dev repo root) | version dir | Lightweight, include it |

**Do not copy**: `doc/`, `.agent/`, `dev-doc/`, `scripts/`, `.git/`. Documentation files link back to the GitHub repo from `README.md` instead.

**Verify after copying**:
- Version in `typst.toml` matches the directory name.
- Version referenced inside `template/main.typ` is correct.
- `README.md` has an up-to-date short changelog entry and links back to this repo.

---

## 5. Commit and push the packages fork

```sh
cd packages   # the forked typst/packages repo
git add packages/preview/hetvid/{version}
git commit -m "hetvid {version}"
git push origin main
```

---

## 6. Open a pull request

Open a PR from your fork's `main` branch to `typst/packages:main`.  
PR title conventionally mirrors the commit message: `hetvid {version}`.

