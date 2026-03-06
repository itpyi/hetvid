# `src/dingli.typ` — Theorem Environments

## Public API

### Environment constructors

| Symbol | Kind | Numbered | Cross-referenceable | CJK alias |
|--------|------|----------|---------------------|-----------|
| `theorem(..name, body)` | base | yes | yes | `dingli` |
| `lemma(..name, body)` | derived | yes | yes | `yinli` |
| `corollary(..name, body)` | derived | yes | yes | `tuilun` |
| `definition(..name, body)` | derived | yes | yes | `dingyi` |
| `example(..name, body)` | derived | yes | yes | `lizi` |
| `remark(body)` | special | no | no | — |
| `proof(body, pre:)` | special | no | no | `zhengming` |

`..name` is a positional rest argument. If provided, it appears in parentheses after the counter: `Theorem 1.2 (Name).`

CJK aliases set `pre` to the Chinese term and `indent: true` (inserts `parvirtual` for correct first-line indent).

### `dingli-rules(doc, level: 0, upper: 2em, lower: 2em)`

A Typst show rule; applied as `#show: dingli-rules.with(...)` in `hetvid.typ`.

| Parameter | Role |
|-----------|------|
| `level` | Heading depth at which theorem counters reset. 0 = never reset (global numbering). |
| `upper` | Vertical space above theorem environments. |
| `lower` | Vertical space below theorem environments. |

---

## Counter Architecture

Each numbered environment has its own Typst `counter`:

```
c-thm  → theorem, dingli
c-lem  → lemma, yinli
c-cor  → corollary, tuilun
c-def  → definition, dingyi
c-rmk  → remark  (stepped but display is suppressed when level=0)
c-xmp  → example, lizi
```

Counters are stored in `c-list` and reset together inside `dingli-rules`'s `show heading:` rule whenever `it.level <= level`.

---

## Numbering Format

`dingli-inpackage-numbering-format` is a closure that reads `dingli-inpackage-numbering-level` (a Typst `state`) at render time:

- `level = 0` → returns `""` (no prefix, counter still steps)
- `level = n` → reads `counter(heading)` up to depth `n` and formats as `"H1.H2.…."`, e.g., `"2.3."` for the 3rd theorem in section 2.

The theorem number itself (e.g., `c-thm`) is appended directly: `"2.3.1"`.

---

## Cross-Reference Mechanism

Numbered environments are wrapped as `figure` elements with a custom `kind` string (e.g., `"theorem"`). This means:

- `@label` triggers Typst's `ref` element.
- `dingli-rules` installs a `show ref:` rule that detects `it.element.kind in kind-list` and renders the reference as `Theorem 2.3.1` (supplement + formatted number).

**Remark and Proof** use plain `block`, not `figure`, so they cannot be cross-referenced.

---

## Design Decisions

- **`figure` wrapper for cross-references**: Typst's native cross-reference system works through `figure`. Wrapping theorem environments as figures with custom kinds is the standard Typst idiom for referenceable environments.
- **Separate counters per kind**: Allows independent numbering (Theorem 1, Lemma 1, Theorem 2, Lemma 2 …). If shared numbering is ever needed, a single counter could be used — but the current design matches mathematical convention.
- **`state` for numbering level**: Using Typst `state` (rather than a plain parameter) lets `dingli-inpackage-numbering-format` close over it and read the correct value at document compile time, even though the format function is constructed before `dingli-rules` is called.
- **`parvirtual` in CJK aliases**: Block-level environments break Typst's paragraph tracking. `parvirtual` restores the indent for the first paragraph inside the environment when `indent: true`.
