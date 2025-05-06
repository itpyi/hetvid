#import "/0.1.0/hetvid.typ": *
#import "@preview/metalogo:1.2.0": TeX, LaTeX // For displaying the LaTeX logo
#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/fancy-units:0.1.1": num, unit, qty

#show: hetvid.with(
  title: [Hetvid: A Typst template for lightweight notes],
  author: "itpyi",
  affiliation: "Xijing Ci'en Institute of Translation, Tang Empire",
  header: "Instruction",
  date-created: "2025-03-27",
  date-modified: "2025-04-22",
  abstract: [This is a template designed for writing scientific notes. ],
  toc: true,
)

In this doc, upcoming features are represented by #text-muted[light font]. 

= Usage<sec-usage>
#let version = "0.1.0"

You can import this template in 3 ways.
- Copy the files (including `hetvid.typ` and `dingli.typ`) to your working directory, and import it by  
  ```typ
  #import "hetvid.typ": *
  ```
- Copy this repository to your dirctory for local packages, then import it by 
  #raw(
    block: true,
    lang: "typ",
    "#import \"@local/hetvid:"+version+"\": *"
  )
- #text-muted[After we have published this to Typst Universe, you can import it by
  #raw(
    block: true,
    lang: "typ",
    "#import \"@local/hetvid:"+version+"\": *"
  )
]
We recommend the second way.

Specifically, the directory for local packages is `{data-dir}/typst/packages/local/`, where `{data-dir}` is
- Linux: `$XDG_DATA_HOME` or `~/.local/share`;
- MacOS: `~/Library/Application Support`;
- Windows: `%APPDATA%`, where `%APPDATA` is a variable, usually being
  ```
  C:\Users\USERNAME\AppData\Roaming
  ```
  You can check this in cmd by command
  ```shell
  $ echo The value of ^%AppData^% is %AppData%
    The value of %AppData% is C:\Users\USERNAME\AppData\Roaming
  ```
  See https://superuser.com/questions/632891/what-is-appdata.
The user should copy this directory to this directory for local packages.
For example for Windows, there should be such a directory in the end:
#raw(
    block: true,
    "C:\Users\USERNAME\AppData\Roaming\typst\packages\local\hetvid\\"+version+"\\"
  )
Then the user can `#import` this template.

After importing, the user can set basic information by the following code.
Note that default values have been given to variables affecting the format.
If you do not need to change these default values, you do not need to write them when you use this template.
```typ
#show: hetvid.with(
  // Information for the title
  // Metadata
  title: [Title],
  author: "The author",
  affiliation: "The affiliation",
  header: "",
  date-created: datetime.today().display(),
  date-modified: datetime.today().display(),
  abstract: [],
  toc: true,

  // Language
  lang: "en",

  // Information for format, only write the term you need to change
  // Paper size
  paper-size: "a4",

  // Fonts
  body-font: ("New Computer Modern", "Libertinus Serif", "TeX Gyre Termes", "Songti SC", "Source Han Serif SC", "STSong", "Simsun", "serif"),
  raw-font: ("DejaVu Sans Mono", "Cascadia Code", "Menlo", "Consolas", "New Computer Modern Mono", "PingFang SC", "STHeiti", "华文细黑", "Microsoft YaHei", "微软雅黑"),
  heading-font: ("Helvetica", "Tahoma", "Arial", "PingFang SC", "STHeiti", "Microsoft YaHei", "微软雅黑", "sans-serif"),
  math-font: ("New Computer Modern Math", "Libertinus Math", "TeX Gyre Termes Math"),
  emph-font: ("New Computer Modern","Libertinus Serif", "TeX Gyre Termes", "Kaiti SC", "KaiTi_GB2312"),
  body-font-size: 11pt,
  body-font-weight: "regular", // set it to 450 if you want book-weight of NewCM fonts
  raw-font-size: 9pt,
  caption-font-size: 10pt,
  heading-font-weight: "regular",

  // Colors
  link-color: link-color,
  muted-color: muted-color,
  block-bg-color: block-bg-color,

  // indention
  ind: 1.5em,
  justify: true,

  // bibliography style, if lang == "zh", defult to be "gb-7714-2015-numeric"
  bib-style: (
    en: "springer-mathphys",
    zh: "gb-7714-2015-numeric",
  ),

  // Numbering level of theorems
  thm-num-lv: 1,
)
```

= Fonts

== Basic settings

We have defined several types of fonts, with their default values shown in the code in @sec-usage. The default values are font families, which in Typst are implemented as an `array` type variable containing several fonts. For each character, the compiler will display it using the first font in the family that supports that character.

The font types are as follows:

/ Body font (`body-font`): Mainly used for the main text. Its size and weight are determined by `body-font-size` and `body-font-weight`.

/ Monospace font (`raw-font`): Used for plain text content, such as code. The default values are all monospaced fonts. Since the size of monospaced fonts may not match regular fonts of the same size, we provide the `raw-font-size` variable for users to adjust the size of monospace fonts.

/ Heading font (`heading-font`): Used for document titles and section headings. The default value is sans-serif fonts (e.g., Heiti), making the headings distinct from the main text and more modern. Users can also modify it to bold serif fonts. The weight of the headings can be adjusted by setting `heading-font-weight`.

/ Math font (`math-font`): Used for mathematical formulas. See @sec:math-font for details.

/ Emphasis font (`emph-font`): For documents in Chinese language, not relevant here. 

Additionally, we provide the `caption-font-size` parameter to control the font size of captions.


== On math fonts <sec:math-font>

From a self-consistent perspective, we recommend setting the math font and the body font to the same font (its math variant and regular form). For example, in the equations, we often encounter characters with textual meaning displayed in upright form. We do not want these characters to appear in different fonts inside and outside the equation. Similarly, numbers frequently appear in formulas and in the main text, possibly referring to the same objects. Therefore, we also do not want them to appear in different fonts.

The default math font is New Computer Modern Math, which corresponds to the body font New Computer Modern. This is the default font for #LaTeX.

== On weight of New Computer Modern font

The default body font used in the template, New Computer Modern, and the math font, New Computer Modern Math, offer two weight options: the regular weight (400), which is the default in our template, and a slightly heavier book weight (450). If you wish to use the latter, set `body-font-weight` to 450.

The default behavior of the New Computer Modern font in Typst (version 0.13.1) can be slightly inconsistent. For example, if you set the fonts as follows:
```typ
#set text(font: "New Computer Modern")
#show math.equation: set text(font: "New Computer Modern Math") 
```
the body text will use the New Computer Modern font with a default weight of regular (400), while the equations will use the New Computer Modern Math font with a default weight of book (450). As a result, the equations may appear slightly bolder than the body text. Our template avoids this issue by explicitly specifying the weight for both fonts.

= Headings 

= Headings

The font size of first-level headings is #qty[1.4][em]. There is a vertical space of #qty[2][em] (relative to the heading font size, the same below) above the first-level heading and #qty[1.2][em] below it.

== Second-level headings

The font size of second-level headings is 1.2 em. There is a vertical space of #qty[1.5][em] above the second-level heading and #qty[1.2][em] below it.

=== Third-level headings

The font size of third-level headings is 1.1 em. There is a vertical space of #qty[1.5][em] above the third-level heading and #qty[1.2][em] below it.

Although Typst provides functionality for higher-level headings, the template author strongly discourages using headings with too many levels, so no special customization has been made for their behavior. Generally, notes under 100 pages rarely use third-level headings. For example, Kitaev's articles #cite(<kitaevQuantumComputationsAlgorithms1997>)#cite(<kitaevAnyonsExactlySolved2006>)#cite(<kitaevAlmostidempotentQuantumChannels2025>) and Witten's lecture notes #cite(<wittenNotesEntanglementProperties2018>)#cite(<wittenMiniIntroductionInformationTheory2020>)#cite(<wittenIntroductionBlackHole2025>) do not use third-level headings.

= Paragraphs and Indentation<sec:par>

Users can adjust whether to justify text alignment by setting `justify: true | false`, with the default of this template being justified alignment.
Users can adjust the indentation amount using the `ind` parameter. 

In Typst, first-line indentation can be controlled using the `all` option to determine whether all paragraphs are indented. However, its behavior is somewhat complex. In summary:
- The default behavior is `all: false`. In this case, for a paragraph, if the preceding block-level element is also a paragraph, the current paragraph will be indented; otherwise, it will not. Non-paragraph block-level elements include:
  - Empty elements: As a result, the first paragraph of block-level elements (e.g., block quotes, theorems) is not indented, which aligns with English typography conventions.
  - Section headings: The first paragraph of each section is not indented, which aligns with English typography conventions.
  - Displayed equations: No indentation follows displayed equations, which is generally expected. However, if a paragraph ends with a displayed equation, special handling is required.
  - Block quotes: Similar to displayed equations, this is generally expected. However, if a paragraph ends with a block quote, special handling is required (see @sec:quote).
  - Unordered and ordered lists: Similar to displayed equations, this is generally expected when lists appear within a paragraph. However, if a paragraph ends with a list, special handling is required.
  - Figures: Paragraph following a non-floating figure is not indented. This is expected only when the figure is part of the paragraph. Other cases require special handling (see @sec:fig).
  - Other block-level elements, such as theorem environments used in this template.
  Overall, this setting generally aligns with conventions but requires special handling in some cases.
- Setting `all: true` indents all paragraphs. This setting also introduces some issues requiring special handling, such as paragraphs following displayed equations or block quotes. Usually we do not mean to start a new paragraph in these cases, but the contents are always indented. We can avoid this by enclosing for example the equations in a box.

The template author believes that maintaining the simplicity of Typst's native syntax for displayed equations is crucial. Therefore, we adopt the first approach, i.e., not setting all paragraphs to be indented, while applying special handling to paragraphs that require indentation.

The implementation of this special handling is straightforward: a virtual paragraph is added before paragraphs that need indentation but are not indented by default. This makes the compiler treat it as a block-level "paragraph" element, but it does not appear in the compiled output. To achieve this, we provide the `par-vir` function to create such virtual paragraphs. In the template, we have already added virtual paragraphs where adjustments are needed for Chinese documents. In most cases, users do not need to worry about indentation behavior. Only when a user-written paragraph ends with a non-paragraph block-level element (e.g., equations, quotes, lists) and the following content needs to start a new paragraph, the user must insert:
```typ
#par-vir
```
to achieve correct indentation. See the example below.

#example[
  This paragraph ends with an equation,
  $ 1+1=2. $
  #par-vir
  We want to start a new paragraph.

  Without adding a virtual paragraph, we cannot start a new paragraph after the equation, even if we add a blank line.
  $ 1+1=2. $

  We failed to start a new paragraph. Of course, this blank line does not affect the vertical spacing.
]

= Quotes<sec:quote>


The template customizes the behavior of block quotes: they are indented by $2 times "ind"$ on both sides, where "ind" takes the value given to `ind` by the user, or takes the default value #qty[1.5][em]. There is a vertical spacing of #qty[1.5][em] above and below the block quote, and the subsequent content is treated as a continuation of the previous paragraph, with no first-line indentation.
#quote(attribution: [Lorem ipsum], block: true)[
  #lorem(33)

  #lorem(24)
]
As you see here, by default, the template does not create a new paragraph (that is, make an indentation) after a quote. If you need to start a new paragraph and want the subsequent content to have a first-line indentation, you can insert a virtual paragraph.

= Equation 



Displayed equations are numbered by default, such as  
$ cal(F)f (k) = 1/(2 pi "i") integral dif k thin "e"^("i"k x) f(x), $<eq:fourier>  
and can be referenced by their numbers, such as #eqref(<eq:fourier>). When referencing equations, we provide the custom command `@{KEY}` to display only the number, leaving the prefix and parentheses to the user. This is because users may use different prefixes in the same document, such as Equation (1), the integral (1), or the isomorphism (1), and may also reference multiple equations simultaneously, such as properties (1-3). On the other hand, we provide a command `#eqref` for referring equations with abbreviation "Eq." or "Eqs.", depending on the number of keys in the argument. For example, `#eqref(<eq:fourier>)` outputs #eqref(<eq:fourier>), while `#eqref(<eq:fourier>, <eq:trivial>)` outputs #eqref(<eq:fourier>, <eq:trivial>). We do this becase the space after the dot in "Eq." is supposed to be small and non-breaking, which is tedious for the user to type.

Displayed equations have vertical spacing of #qty[1.2][em] above and below, consistent with the default behavior of #LaTeX. Without this spacing, the layout would be too crowded, as shown in the example below.

#example[
  #show math.equation.where(block: true): set block(above: 0.5em, below: 0.5em)
  If the text before and after the equation fills an entire line, and there is no spacing between the equation and the surrounding text, such as  
  $ 1+1=2, $<eq:trivial>
  the visual effect will be very crowded. We want to avoid such an effect, so we add spacing above and below the equation.
]

= Theorems

Our template provides several theorem environments through a theorem package `dingli`. For convenience of the user, we have copied the package file into this template.

#theorem[This is a theorem.]

This is a paragraph after a theorem. Note the vertical space.

For theorems with a name, we set it to look like the default behaviour of the `amsthm` package.
The "theorem" is strong, the "name" is put in a parenthesis while the point is put after the name.

#theorem("some theorem")[This is a theorem with name.]

#theorem[This is a theorem.
The space is set to weak so that no extra space is added between two theorems.]
#proof[This is the proof.
$ 1 + 1 = 2 $
This is what to be prooved. 

Another paragraph of the proof. #lorem(46)
]

Now we have other types.

#lemma[This is a lemma.]<lemma:test>
#corollary[This is a lemma.]
#definition[This is a lemma.]

Refer to theorems by @lemma:test.

= Figure and caption<sec:fig>

This template allows for two kinds of figures. 
First, a figure inside a paragraph.
Such a figure is described by contents round it in the main text and hence
has no caption or label. 
As a result, content following this figure should not be indented
since it is not a new paragraph.
For example, we can plot a bipartite graph as follows:
#figure(
  canvas({
    let N = 6
    let n = 4
    let space = 1
    let vspace = 2
    let offset = (N - n) / 2
    let r = 0.1
    import draw: *
    for i in range(N) {
      circle((i*space, 0), radius: r, fill: black)
    }
    for i in range(n) {
      rect((i*space + offset - r, vspace - r),(i*space + offset + r, vspace + r), fill: black)
      i = i + 1
    }
    let links = ((1,2,4,5),
                 (0,2,3,5),
                 (0,4),
                 (1,4))
    for j in (0,1,2,3) {
      for i in links.at(j) {
        line((i*space, 0), (j*space + offset, vspace))
      }
    }
    }),
  kind: "inline",
  supplement: none
)
and go on to say something about it.

Another kind of figure is a standalone figure, which has a caption and label.
For such figures, we change the typst default behaviour by following 3 features:
- Figure caption is centered if it in within one line, 
 otherwise it is aligned to the left. 
 See @fig:figure_with_a_short_caption and @fig:figure_with_a_long_caption for examples.
 Refer to #link("https://sitandr.github.io/typst-examples-book/book/snippets/layout/multiline_detect.html")[Typst Examples Book: Multipline detection].
- Figure caption has a smaller size than the main text, defined by `caption-size`.
- We add vertical space equal to one line of text before and after such a figure.
The second and the third features are set to avoid mixing the caption with the main text.


#figure(
  canvas({
    let N = 6
    let n = 4
    let space = 1
    let vspace = 2
    let offset = (N - n) / 2
    let r = 0.1
    import draw: *
    for i in range(N) {
      circle((i*space, 0), radius: r, fill: black)
    }
    for i in range(n) {
      rect((i*space + offset - r, vspace - r),(i*space + offset + r, vspace + r), fill: black)
      i = i + 1
    }
    let links = ((1,2,4,5),
                 (0,2,3,5),
                 (0,4),
                 (1,4))
    for j in (0,1,2,3) {
      for i in links.at(j) {
        line((i*space, 0), (j*space + offset, vspace))
      }
    }
    }),
  caption: [A figure with a centered short caption.]
)<fig:figure_with_a_short_caption>

#figure(
  canvas({
    let N = 6
    let n = 4
    let space = 1
    let vspace = 2
    let offset = (N - n) / 2
    let r = 0.1
    import draw: *
    for i in range(N) {
      circle((i*space, 0), radius: r, fill: black)
    }
    for i in range(n) {
      rect((i*space + offset - r, vspace - r),(i*space + offset + r, vspace + r), fill: black)
      i = i + 1
    }
    let links = ((1,2,4,5),
                 (0,2,3,5),
                 (0,4),
                 (1,4))
    for j in (0,1,2,3) {
      for i in links.at(j) {
        line((i*space, 0), (j*space + offset, vspace))
      }
    }
    }),
  caption: [A figure with a long caption. 
  If the caption is long enough such that it occupies multiple lines,
  then the caption is aligned to the left.]
)<fig:figure_with_a_long_caption>

You can see that contents following a standalone figure is indented,
indicating that is is a new paragraph.
The following paragraph is well separated from the figure caption.

#figure(
  canvas({
    let N = 6
    let n = 4
    let space = 1
    let vspace = 2
    let offset = (N - n) / 2
    let r = 0.1
    import draw: *
    for i in range(N) {
      circle((i*space, 0), radius: r, fill: black)
    }
    for i in range(n) {
      rect((i*space + offset - r, vspace - r),(i*space + offset + r, vspace + r), fill: black)
      i = i + 1
    }
    let links = ((1,2,4,5),
                 (0,2,3,5),
                 (0,4),
                 (1,4))
    for j in (0,1,2,3) {
      for i in links.at(j) {
        line((i*space, 0), (j*space + offset, vspace))
      }
    }
    }),
  placement: top,
  caption: [A figure placed at the top of a page.]
)<fig:figure_placement>

You can also force a figure to be placed at the top of a page. See @fig:figure_placement.

= Bibliography and citation

Bibliography and citation style is set in 
```typ
// set citation
set bibliography(style: "american-physics-society")
```
You can also choose other styles, see https://typst.app/docs/reference/model/bibliography/#parameters-style.

#bibliography("ref.bib")
