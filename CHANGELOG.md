# Changelog

## [0.2.0] - 2026-02-28

### Added

- Multi-author support: the `author` parameter now accepts an array of dicts with keys `name`, `affiliation` (content or array of contents), and `email`. Affiliations are automatically deduplicated and numbered; shared affiliations receive the same superscript number.
- New `authors.typ` file implementing the `format-authors` function, imported by `hetvid.typ`.
- Single-author syntax (`author: "Name"` + `affiliation: [...]`) remains fully backward-compatible.

## [0.1.1] - 2026-01-15

### Added 

- A boolean parameter `hyphenate` to control the hyphenation behaviour. Default to be `true` to ensure a good look when `justify: false`.

## [0.1.0] - 2025-07-25

First released version