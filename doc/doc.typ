#import "/0.1.0/hetvid.typ": *
#import "@preview/metalogo:1.2.0": TeX, LaTeX // For displaying the LaTeX logo
#import "@preview/cetz:0.3.4": canvas, draw

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

= Usage 
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

#text(red)[Below is not the newest version, but can serve and working examples.]

== Basic settings

== On math fonts 

== On weight of New Computer Modern font

Fonts can be globally adjusted in the `#let hetvid()` block. 
In this block, several types of fonts are specified, including
/ body-font: This is the font used for the main text.
/ raw-font: This is the font used for the `raw text`.
/ heading-font: This is the font used for the headings.
 I choose to use sans serif fonts for the headings for a modern look.
 You can modify it to serif fonts with higher weight if you like. 
 See @headings for details.
/ math-font: This is the font used for the math equations.
For each type of font, I provide several options.
The compiler will choose the first available font in the list.
All these fonts I choose is free to download from the internet.

I would to comment more on the math font.
I have set it to match the body font in the first 3 options. 
I highly recommend this matching since text can appear in equations,
while different fonts for text in and out of equations look really weird.
For example, compare the following two examples:
- The failure probability is $P["fail"] = 1\/2$. (The math font is set to be the same as the body font, i.e., the New Computer Modern font, which is default for #LaTeX.)
#set text(font: "Libertinus Serif")
#show math.equation: set text(font: "Libertinus Math")
- The failure probability is $P["fail"] = 1\/2$. (The math font is set to be the same as the body font, i.e., the Libertinus font.)
#set text(font: "New Computer Modern")
- The failure probability is $P["fail"] = 1\/2$. (The math font is set to be Libertinus Math, not matching the text font.)
Human beings should be uncomfortable with the third example. 
For available opentype fonts supporting math, please refer to 
#link("https://tex.stackexchange.com/questions/425098/which-opentype-math-fonts-are-available")[Which OpenType Math fonts are available?]

#show math.equation: set text(font: "New Computer Modern Math")

The default font is set to be New Computer Modern, which is embeded in typst.
Typst provides two weights of this font for body text: 400 (regular) and 450 (book).
We use the regular weight by default, which has a conventional #LaTeX look.
You can set `body-font-weight` to book yourself as below
```typ
#show: hetvid.with(
  // other parameters
  body-font-weight: 450,
  // other parameters
)
```
This weight is more friendly to screens with low resolution.

= Headings 

== Adjusting fonts of headings <headings>

Headings are set to their default size in typst, but using a sans serif font with normal weight.
You can set it to serif font with higher weight if you like,
by setting
```typ
#show: hetvid.with(
  // other parameters
  heading-font: "New Computer Modern",
  heading-font-weight: 700,
  // other parameters
)
```

== Second-level heading

=== Third-level heading 

Note that third-level heading has the same font size as the body text.
A light note within 100 pages should rarely use a third-level heading.
For example, Kitaev's paper @kitaevQuantumComputationsAlgorithms1997@kitaevAnyonsExactlySolved2006 @kitaevAlmostidempotentQuantumChannels2025 and Witten's note @wittenNotesEntanglementProperties2018@wittenMiniIntroductionInformationTheory2020@wittenIntroductionBlackHole2025 never uses a third-level heading.

==== Please avoid using headings of higher levels

If a still higher-level heading is needed, the note might be malstructured.

= Quotes

Block quotes.

#quote(attribution: "Cicero", block:true)[#lorem(30)]

Then this is still the same paragraph.

Another paragraph. #lorem(30) 

#quote(block:true)[
  #lorem(20)

  #lorem(30)
]

Then this is true.

= Equation 

Equations are numbered by default,
$ cal(F)f(k) = 1/(2 pi "i") integral dif k thin "e"^("i"k x) f(x), $<eq:fourier>
and you can refer to it by its number #eqref(<eq:fourier>), or #eqref(<eq:fourier>, <eq:another>).

By default, line after an equation is not indented,
$ 1 + 1 = 2. $<eq:another>
This is an example. But if you want to end a paragraph by an equation,
you can add a par-break manually by `#parvirtual`.
$ 1+1 = 2. $
#parvirtual
And then you can add a new paragraph.

= Theorems

Our template provides several theorem environments through a theorem package `dingli`.

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

#lemma[This is a lemma.]
#corollary[This is a lemma.]
#definition[This is a lemma.]

Refer to theorems by @lemma:test.

= Theorem by section

#theorem[Recount the theorem]
#lemma[This is a lemma.]<lemma:test>
#corollary[This is a lemma.]
#definition[This is a lemma.]

= Figure and caption

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
