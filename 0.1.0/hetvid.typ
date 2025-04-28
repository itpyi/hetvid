// modified from https://github.com/mbollmann/typst-kunskap.git
// #import "@preview/linguify:0.4.2": *
// Set theorem environments
#import "@local/dingli:0.1.0": *

#let parvirtual = {
"" 
context v(-par.spacing -  measure("").height)
}

#let link-color = rgb("#3282B8")
#let muted-color = luma(160)
#let block-bg-color = luma(240)

#let text-muted(it) = {text(fill: muted-color, it)}


// Report template
#let hetvid(
    // Metadata
    title: [Title],
    author: "Phybo",
    affiliation: "Institute for Advanced Study, Tsinghua University",
    header: "",
    date-created: datetime.today().display(),
    date-modified: datetime.today().display(),
    abstract: [],
    toc: true,

    // Paper size
    paper-size: "a4",

    // Language
    lang: "en",

    // Fonts
    body-font: ("New Computer Modern","Latin Modern Roman","Libertinus Serif","Noto Serif", "Songti SC"),
    body-font-size: 11pt,
    body-font-weight: "regular", // set it to 450 if you want book-weight of NewCM fonts
    raw-font: ("New Computer Modern Mono", "Cascadia Code", "Menlo", "CodeNewRoman Nerd Font", "Latin Modern Mono"),
    raw-font-size: 10pt,
    caption-size: 10pt,
    heading-font: ("Helvetica", "New Computer Modern Sans","Latin Modern Sans",  "Libertinus Sans", "Noto Sans","Heiti SC"),
    heading-font-weight: "regular",
    math-font: ("New Computer Modern Math","Latin Modern Math", "Libertinus Math", "Songti SC"),
    emph-font: ("New Computer Modern","Latin Modern Roman","Libertinus Serif","Noto Serif", "Kaiti SC"),

    // Colors
    link-color: link-color,
    muted-color: muted-color,
    block-bg-color: block-bg-color,

    // indention
    ind: 1.5em,
    justify: true,

    // bibliography style, if lang == "zh", defult to be "gb-7714-2015-numeric"
    bib-style: "springer-mathphys",

    // The main document body
    body
) = {
    if lang == "zh" {
        ind = 2em
    }
    set text(lang: "zh") if lang == "zh"
    // Configure page size
    set page(
        paper: paper-size,
        margin: (top: 2.625cm),
    )

    // Set the document's metadata
    set document(title: title, author: author)

    // Set the fonts
    set text(font: body-font, size: body-font-size, weight: body-font-weight) // book weight for New Computer Modern font
    show raw: set text(font: raw-font, size: raw-font-size)
    show emph: set text(font: emph-font, size: body-font-size) if lang == "zh" // Kaiti instead of italic for emphasis
    show math.equation: set text(font: math-font, weight: body-font-weight)

    show heading: it => {
        // Add vertical space before headings
        if it.level == 1 {
            v(6%, weak: true)
        } else {
            v(4%, weak: true)
        }

        // Set headings font
        set text(font: heading-font, weight: heading-font-weight)
        // show math.equation: set text(weight: 600)
        it
        if lang == "zh" {
            parvirtual
        }
        // Add vertical space after headings
        v(3%, weak: true)
    }
    
    // set heading numbering
    set heading(numbering: "1.")


    // Set paragraph properties
    set par(leading: 8pt, spacing: 8pt, justify: justify, first-line-indent: ind)

    // Set list styling
    set enum(indent: ind, numbering: "1.", full: true)
    set list(indent: ind)
    let hang-ind = if lang == "zh" {
        3em
    } else {
        3em
    }
    set terms(indent: ind, hanging-indent: hang-ind)

    // Set equation spacing 
    show math.equation.where(block: true): set block(above: 1.2em, below: 1.2em)

    // Set equation numbering and referring
    set math.equation(numbering: "(1)")
    show ref: it => {
      let eq = math.equation
      let el = it.element
      if el != none and el.func() == eq {
        // Override equation references.
        link(el.location(),numbering(
          el.numbering,
          ..counter(eq).at(el.location())
        ))
      } else {
        // Other references as usual.
        it
      }
    }
    

    // Display block code with padding and shaded background
    show raw.where(block: true): block.with(
        inset: (x: ind, y: 1em),
        // outset: (y: 0em),
        width: 100%,
        fill: block-bg-color,
    )
    show raw.where(block: true): set par(justify: false)

    // Display inline code with shaded background while retaining the correct baseline
    show raw.where(block: false): box.with(
        inset: (x: 3pt, y: 0pt),
        outset: (x: -1pt, y: 3pt),
        fill: block-bg-color,
    )

    // Set block quote styling
    show quote: set block(above: 1.5em, below: 1.5em)
    show quote.where(block: true): it => {
        let attribution = if it.attribution != none {
            align(end, [#it.attribution])
        }
    block(
        width: 100%,
        inset: (x: 2*ind), 
        if it.quotes == true [
        #quote(it.body) 
        #attribution
        ] else [ 
        #if lang == "zh" {
            parvirtual
        }
        #it.body 
        #attribution
        ]
    )
    }

    // Set reference font
    show ref: set text(font: body-font)

    show figure.caption: it => {
        set text(size: caption-size, font: body-font)
        layout(size => [
            #let text-size = measure(
                it
            )
            #let my-align
            #if text-size.width < size.width {
            my-align = center
            } else {
            my-align = left
            }

            #align(my-align, it)
        ])
    }

    show figure: it => {
        if it.caption != none and it.placement == none {
            v(2em, weak: true)
            box(it)
            v(2em, weak: true)
        } else {
            it
        }
    }

    // when directly plot in file, set text in figure as the caption size
    show figure.where(kind: image): set text(size: caption-size)
    show figure.where(kind: "inline"): set text(size: caption-size)


    // Set link styling
    show link: it => {
        set text(fill: link-color)
        it
    }
    
    // Set theorem environments
    show: thmrules

    // Set page header and footer (numbering)
    set page(
        header: context {
            if counter(page).get().first() > 1 [
                #set text(font: heading-font, weight: "regular", fill: muted-color, size: caption-size)
                #header
                #h(1fr)
                #title
            ] else [
                #set text(font: heading-font, weight: "regular")
                #header
            ]
        },
        numbering: (..nums) => {
            set text(font: heading-font, weight: "regular" ,fill: muted-color)
            nums.pos().first()
        },
    )

    // set citation
    if lang == "zh"{
      bib-style = "gb-7714-2015-numeric"
    }
    set bibliography(style: bib-style)

    // TYPESETTING THE DOCUMENT
    // -----------------------------------------------------------------------
    

    // Set title block
    {
        set par(first-line-indent: 0em)
        v(26pt)
        text(font: heading-font, weight: "bold", size: 20pt, title)
        linebreak()
        v(16pt)
        [#author \ 
        #emph(affiliation)]
        v(1em)
        let dc = if lang == "zh" {
            text(font: emph-font)[创建日期：]
        } else {
            smallcaps[Date created:]
        }
        let dm = if lang == "zh" {
            text(font: emph-font)[修改日期：]
        } else {
            smallcaps[Date modified:]
        }
        [#dc
        #date-created \ 
        #dm
        #date-modified]
        let abskey = if lang == "zh" {
            "摘要"
        } else {
            "Abstract"
        }
        if abstract != [] {
            [
                #heading(numbering: none, bookmarked: false, outlined: false)[#abskey]
                #set par(first-line-indent: ind)
                #if lang == "zh" {
                    parvirtual
                }
                #abstract
            ]
        }
    }
    

    if toc{
    outline()
    v(2em)
    if lang == "zh" {
            parvirtual
        }
    }

    // Main body
    {body}
}
