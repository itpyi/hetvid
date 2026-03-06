# `src/authors.typ` — Author / Affiliation Rendering

## Public API

### `format-authors(authors, old-affiliation: none, emph-func: emph)`

Called by `hetvid.typ` in the title block. Never called directly by users.

| Argument | Type | Description |
|----------|------|-------------|
| `authors` | str \| content \| array of dicts | If str/content → old single-author mode. If array → multi-author mode. |
| `old-affiliation` | content \| none | Used only in old single-author mode (the `affiliation` parameter from `hetvid`). |
| `emph-func` | function | The `emph` show rule from the outer scope, passed in so `authors.typ` doesn't need its own show context. |

---

## Multi-Author Dict Schema

```typst
(
  name:        str | content,   // required
  affiliation: str | content    // optional; can also be an array for multiple affiliations
               | array,
  email:       str | none,      // optional
)
```

---

## Algorithm

### `_collect-affils(authors)` (internal)

Returns `(affil-list, author-nums)`:

1. For each author, collect their affiliations as an array (wrap scalar in array; default to empty).
2. For each affiliation, compute `repr(affil)` and search `affil-list` for a match.
   - Not found → append to `affil-list`, record its 1-based index.
   - Found → reuse the existing index.
3. `author-nums` is a parallel array of arrays: `author-nums.at(i)` = list of affiliation indices for author `i`.

`repr()` is used for comparison so both `str` and `content` values deduplicate correctly.

### `format-authors` rendering logic

```
if authors is array:
  (affil-list, author-nums) = _collect-affils(authors)
  show-affil-nums = affil-list.len() > 1

  for each author:
    name-part = name (+ superscript affil numbers if show-affil-nums)
    if has email:
      append footnote(numbering: _ => [])[Name: raw(email)]
  join author parts with ", "

  if show-affil-nums:
    for each affil: render "^i  emph(affil)"
  else if exactly one affil:
    render emph(affil) without numbering
else:
  render authors as-is
  if old-affiliation: linebreak + emph(old-affiliation)
```

---

## Design Decisions

- **`repr()` for deduplication**: handles both `str` and `content` values uniformly. Two content blocks with identical markup will deduplicate; two with different markup will not — acceptable for typical academic use.
- **Email footnote suppresses inline marker**: `footnote(numbering: _ => [])` passes an anonymous function that returns empty content, which hides the in-text superscript. Using `numbering: none` was tried first but caused a Typst error in that version.
- **Superscript numbers sorted**: `nums.sorted()` before `.join(",")` ensures numbers always appear in ascending order (e.g., `1,3` not `3,1`) regardless of the order affiliations were listed.
- **Footnote counter NOT reset here**: `counter(footnote).update(0)` lives in `hetvid.typ` so this module stays stateless and reusable.
