Publish a new version
=====================

## Clone the forked repo

```bash
git clone --depth 1 --no-checkout --filter="tree:0" git@github.com:itpyi/packages
cd packages
git sparse-checkout init
git sparse-checkout set packages/preview/{your-package-name}
git remote add upstream git@github.com:typst/packages
git config remote.upstream.partialclonefilter tree:0
git checkout main
```

## Copy the new version to the repo

- Copy the new version dir to the repo without doc dir.
- Check the information, especially the version info in `typst.toml`, `template/main.typ`
- Copy the `README.md` to the version dir to be published (no need to do it in this repo), append a short CHANGELOG to the README, and direct to this GitHub repo.