Todo for Agents
======================

## Version-independent actions

### Repository structure

- `src/` — all publishable package files: `typst.toml`, `hetvid.typ`, `authors.typ`, `dingli.typ`, `template/`, `thumbnail.png`, `LICENSE`. This is the directory that gets copied to the Typst packages fork when publishing.
- `doc/` — documentation source and PDFs. Never published to Typst Universe; linked from `README.md` via GitHub URL.
- Root — meta/dev files: `README.md`, `CHANGELOG.md`, `agent-*.md`, `publish-guide.md`, `tips.md`.

### Git tagging convention

After each version is published to Typst Universe (PR merged), create a lightweight tag:

```sh
git tag v{version}
git push --tags
```

This permanently marks the state of the repo at the time of each published release. Historic versions are accessible via `git checkout v{version}` — there is no need to keep old version directories in the repo.

### Todo

- [x] Create a script to auto generate thumbnail.png from the first page of the doc.

## Version 0.1.0

This version has been published to Typst Universe. Tagged as `v0.1.0` at commit `c9395bb`.
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
  - [x] Remove the superscripts for the author footnotes so that normal footnotes on the first page can start from 1. If removing is not convenient, replace with other characters. (I prefer removing)

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
  - [x] Remove the superscripts for the author footnotes so that normal footnotes on the first page can start from 1. If removing is not convenient, replace with other characters. (I prefer removing)

## Version 0.2.1