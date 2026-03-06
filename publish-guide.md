Publish a new version
=====================

## One-time setup: clone the forked repo

Make sure you have already forked `typst/packages` to your own GitHub account.
Then do a sparse checkout so you only pull down files for your package:

```sh
git clone --depth 1 --no-checkout --filter="tree:0" git@github.com:{your-username}/packages
cd packages
git sparse-checkout init
git sparse-checkout set packages/preview/hetvid
git remote add upstream git@github.com:typst/packages
git config remote.upstream.partialclonefilter tree:0
git checkout main
```

> The `packages` directory you are in still corresponds to the whole repository.
> Do **not** delete or edit `README.md`, `LICENSE`, or any other file at the root.

## Before each publish: finalize and tag in the dev repo

In this dev repo (`hetvid/`):

+ Check the dependency version
+ Update `src/typst.toml` version, `CHANGELOG.md`, and `README.md`.
+ Commit: `git commit -m "release v{version}"` (or per task convention).


## After each publish: finalize and tag in the dev repo

+ Tag the commit: `git tag v{version}`
+ Push: `git push && git push --tags`

## In the packages fork: sync with upstream

```sh
git fetch upstream
git merge upstream/main
```

## Create the version directory and copy files

Create the target directory:

```
packages/preview/hetvid/{version}/
```

Note: `packages/` here is a subdirectory inside the cloned `packages` repository,
so the full path has two consecutive `packages` segments.

Copy all files from `src/` in this dev repo into that directory.
Also copy `README.md` from the dev repo root into the version directory.

The files in `src/` are already split into the right groups:

| Group | What | Action |
|-------|------|--------|
| **Required** | `typst.toml`, `hetvid.typ`, `authors.typ`, `dingli.typ`, `template/`, `thumbnail.png` | Commit & include in archive |
| **Required** | `LICENSE` | Commit & include (never exclude) |
| **Documentation** | `README.md` (copied from dev repo root) | Commit; no need to exclude (lightweight) |

Documentation files (`doc/`) live only in the dev repo and are **not copied** to the packages fork — link to them from `README.md` via GitHub URL instead.

**Do not copy the `.git` folder** from this repo. If you do, Git will treat the copied files as a submodule instead of ordinary files.

After copying, verify:
- Version in `typst.toml` matches the directory name.
- Version referenced inside `template/main.typ` is up to date.
- `README.md` includes a short CHANGELOG entry and links back to this GitHub repo.

## Commit and push

```sh
git add packages/preview/hetvid/{version}
git commit -m "hetvid {version}"
git push origin main
```

## Open a pull request

Open a PR from your fork's `main` branch to `typst/packages:main`.
The PR title conventionally mirrors the commit message: `hetvid {version}`.

## Useful tools

- [`typst-package-check`](https://github.com/typst/package-check) — lint your package before submitting.
- [`typship`](https://github.com/sjfhsjfh/typship) — install locally or submit to Typst Universe.
- [`tytanic`](https://typst-community.github.io/tytanic/) — run regression tests.
