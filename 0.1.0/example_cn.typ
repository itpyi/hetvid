#import "hetvid.typ": *
#import "@preview/metalogo:1.2.0": TeX, LaTeX // For displaying the LaTeX logo
#import "@preview/cetz:0.3.4": canvas, draw
#import "@preview/treet:0.1.1": *


#let version = "0.1.0"

#show: hetvid.with(
  title: [Hetvid：一个轻量级笔记的Typst模板],
  author: "itpyi",
  affiliation: "大唐西京慈恩翻译学院",
  header: "说明文档",
  date-created: "2025-03-27",
  date-modified: "2025-04-28",
  abstract: [Hetvid是一个Typst模板，用于创作轻量级的笔记。本文是该模板的实例和说明文档，在介绍特性的同时，也会谈及作者的设计理念。],
  toc: true,
  body-font: ("Libertinus Serif", "Songti SC"),
  lang: "zh",
)

// #show math.equation: set text(font: "Libertinus Serif")
// #set text(font: "Libertinus Math")

在本文中，以#text-muted[浅色字体]表示的内容是尚未实现的功能或特性。

= 调用本模板<sec-diaoyong>

调用模板的方法有如下三种：
- 将模板文件复制到工作目录下，在文档中通过
  ```typ
  #import "hetvid.typ": *
  ```
  调用。
- 将该项目复制到本地包目录下，在文档中通过
  #raw(
    block: true,
    lang: "typ",
    "#import \"@local/hetvid:"+version+"\": *"
  )
  调用。
#text-muted[
  - 在本模板发布之后，用户或可通过
    #raw(
      block: true,
      lang: "typ",
      "#import \"@preview/hetvid:"+version+"\": *"
    )
    调用。
]
我们推荐使用第二种方法。

具体来说，本地包目录为`{data-dir}/typst/packages/local/`，其中`{data-dir}`为
- Linux系统：`$XDG_DATA_HOME`或`~/.local/share`；
- MacOS：`~/Library/Application Support`；
- Windows系统：`%APPDATA%`。 其中`%APPDATA`表示一个变量，一般为
  ```
  C:\Users\USERNAME\AppData\Roaming
  ```
  可在 cmd 中通过下述命令查看
  ```shell
  $ echo The value of ^%AppData^% is %AppData%
    The value of %AppData% is C:\Users\USERNAME\AppData\Roaming
  ```
  参见 https://superuser.com/questions/632891/what-is-appdata。
用户可将该项目复制到本地包目录下。例如对于 Windows 系统，最终应存在如下文件夹：
#raw(
    block: true,
    "C:\Users\USERNAME\AppData\Roaming\typst\packages\local\hetvid\\"+version+"\\"
  )
此时用户可通过`#import`命令来使用该模板。


引入模板后，通过如下代码即可指定相应信息。格式信息部分所有变量都给出了预设值，如果不需要修改这些默认值，则不用在调用时写出。
```typ
#show: hetvid.with(
  // 标题信息
  title: [Hetvid：一个轻量级笔记的Typst模板], 
  author: "itpyi",
  affiliation: "大唐西京慈恩翻译学院", 
  header: "说明文档", //出现在页眉左侧
  date-created: "2025-03-27", //预设为当天
  date-modified: "2025-04-28", //预设为当天
  abstract: [], //摘要，预设为空；当且仅当不为空时展示“摘要”章节
  toc: true, //是否显示目录，预设值为是，可设为 false 以关闭之

  // 语言，默认为英文，可更改为中文
  lang: "zh", //更改为中文

  // 下为格式信息，不修改则不用写出，有更改需求则写出需更改的项目即可
  // 纸张大小，默认为 a4
  paper-size: "a4",

  // 字体族，下为默认值
  body-font: ("New Computer Modern", "Libertinus Serif", "TeX Gyre Termes", "Songti SC", "SimSun", "serif"),
  raw-font: ("Cascadia Code", "Menlo", "Consolas", "New Computer Modern Mono", "华文细黑", "Microsoft YaHei", "微软雅黑"),
  heading-font: ("Helvetica", "Tahoma", "Arial", "STXihei", "华文细黑", "Microsoft YaHei", "微软雅黑", "sans-serif"),
  math-font: ("New Computer Modern Math", "Libertinus Math", "TeX Gyre Termes Math"),
  emph-font: ("New Computer Modern","Libertinus Serif", "TeX Gyre Termes", "Kaiti SC", "KaiTi_GB2312"),
  body-font-size: 11pt,
  body-font-weight: "regular", // set it to 450 if you want book-weight of NewCM fonts
  raw-font-size: 9pt,
  caption-size: 10pt,
  heading-font-weight: "regular",

  // 颜色
  link-color: link-color, //链接颜色
  muted-color: muted-color, //弱文字颜色，即本文档中浅色字体
  block-bg-color: block-bg-color, //代码块等的背景颜色

  // 段落格式
  ind: 1.5em, //首行缩进，英文默认为 1.5em，中文固定为 2em，无法在用户层面更改
  justify: true, //是否两端对齐，默认为是

  // 引用和参考文献格式，英文默认为 springer-mathphys，中文默认为 gb-7714-2015-numeric
  bib-style: (
    en: "springer-mathphys",
    zh: "gb-7714-2015-numeric"
  )
    
  // 定理编号的层级，默认为 1，此时定理在每个一级标题下编号，详后
  thm-num-lv: 1,
)
```


= 字体

== 基础设定

我们设定了几类字体，其预设值见#ref(<sec-diaoyong>)中的代码。
/ 正文字体 (body-font): 主要用于正文。其大小和字重由`body-font-size`和`body-font-weight`给出。预设的西文字体是New Computer Modern，我们预设了常规字重。对于默认使用的西文字体 New Computer Modern, 也可“book”字重,
/ 纯文本字体 (raw-font): 用于纯文本内容，例如代码等。
/ 标题字体 (heading-font): 用于标题。我选择使用无衬线字体，使得标题看起来更具现代感。用户可将其修改为typst预设的加粗衬线字体。具体见@headings。
/ 数学字体 (math-font): 用于数学公式。
/ 强调字体 (emph-font): 以拉丁字母书写的文本中，般使用意大利体（_italic_，斜体）来表示强调。在汉字书写的文本中，一般不使用斜体字形，而使用更接近手写体的_楷体_来表示强调。

对于每种字体，我们提供了若干预设值。对于每个字符，编译器将选择第一个能用的字体。我们希望使用专业的西文字体而非宋体来显示拉丁字母，因此，建议将只覆盖拉丁字母的字体放在前面，将中文字体放在后面。

在选择数学字体时，我们使其前三个候选值与正文字体配套。这是因为公式中仍可能出现文字，若公式中文字与正文中文字字体不一致，则显得不统一。这种不统一在拉丁字母文档中更突出，例见英文文档。

== 关于数学字体

== New Computer Modern 的字重问题

== 中西文之间的空格问题


= 标题

== 调整标题字体 <headings>

标题字号选用typst的预设字号，但使用无衬线字体和普通字重（不加粗）。用户若希望将标题字体重设为typst默认的加粗有衬线字体，可移除注释`// Set headings font`后的一行
```typ
...
// set headings font
set text(font: headings-font, weight: "regular")
...
```

== 二级标题

=== 三级标题<sec-3>

三级标题的字号大小和正文相同。一般来说，100页以下的笔记很少使用三级标题。例如，Kitaev的文章#cite(<kitaevQuantumComputationsAlgorithms1997>)#cite( <kitaevAnyonsExactlySolved2006>)#cite(<kitaevAlmostidempotentQuantumChannels2025>)和Witten的讲义#cite(<wittenNotesEntanglementProperties2018>)#cite(<wittenMiniIntroductionInformationTheory2020>)#cite(<wittenIntroductionBlackHole2025>)都不使用三级标题。

==== 避免使用更高级标题

如果需要使用四级或以上的标题。作者对文档结构的规划可能存在问题。

= 引文

引文如下：
#quote(attribution: [柳宗元《封建論》], block: true)[
  秦有天下，裂都會而為之郡邑，廢侯衛而為之守宰，據天下之雄圖，都六合之上游，攝制四海，運於掌握之內，此其所以為得也。不數載而天下大壞，其有由矣。亟役萬人，暴其威刑，竭其貨賄。負鋤梃謫戍之徒，圜視而合從，大呼而成群。時則有叛人而無叛吏，人怨於下，而吏畏於上，天下相合，殺守劫令而並起。咎在人怨，非郡邑之制失也。

漢有天下，矯秦之枉，徇周之制，剖海內而立宗子，封功臣。數年之間，奔命扶傷之不暇。困平城，病流矢，陵遲不救者三代。後乃謀臣獻畫，而離削自守矣。然而封建之始，郡國居半，時則有叛國而無叛郡。秦制之得，亦以明矣。繼漢而帝者，雖百代可知也。
]
其后内容接续上段。

= 公式

公式默认编号，如
$ cal(F)f (k) = 1/(2 pi "i") integral dif k thin "e"^("i"k x) f(x), $<eq:fourier>
可引用其编号，如公式 (@eq:fourier)。
一般来说，公式后不分段。如果需要以公式结束一段，则可以手动添加一个段落分隔符`#parvirtual`。例如：
$ 1 + 1 = 2. $
#parvirtual
我们可以在此处继续行文。

= 定理

由于现有定理包在细节上都不令人满意，我们自己定义了定理环境，其风格模仿 #LaTeX 的 `amsthm`包的默认风格。

#dingli[这是一个定理。中文环境中，定理仍然首行缩进2个字符，并且不整体缩进，亦不顶格。]

这是定理后的一段，注意竖直间距。

#dingli([$s$-定理])[这是一个有名字的定理。]

#dingli[这是一个定理。
定理前后的竖直间距设定为weak，故没有额外间距。]
#zhengming[这是一个证明。
$ 1 + 1 = 2 $
这竟然需要证明？

这是证明中的另一段。
]

还有其他类型，包括引理、推论、定义等。

#yinli[这是一个引理。]
#tuilun[这是一个推论。]
#dingyi[这是一个定义。]

再来一段。可以索引@thm:test。

= 定理编号

#dingli[这是一个定理。]<thm:test>
#yinli[这是一个引理。]
#tuilun[这是一个推论。]
#dingyi[这是一个定义。]

= 图片和图注

本模板设定了两种图片。一种是段内图片，它由其上下文描述而不引入独立的图注和索引。因此，图后文字并不另成一段。例如，考虑如下双边图。
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
我们紧随图片继续行文，给出对它的进一步描述，此时不应另起一段。

另一类图片是独立图片，有其独立的图注和索引。对于此类图片，我们设定了三点不同于typst默认行为的特性：
- 图注少于一行则居中，多于一行则居左。例见#ref(<fig:figure_with_a_short_caption>)和#ref(<fig:figure_with_a_long_caption>). 其实现参考#link("https://sitandr.github.io/typst-examples-book/book/snippets/layout/multiline_detect.html")[Typst Examples Book: Multipline detection]。
- 图注字号略小于正文，由`caption-size`给出。
- 在图的上下插入竖直空间，使其与正文稍有分隔。
其中二、三条是为了避免混淆图注和正文。

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
  caption: [短图注居中。]
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
  caption: [若图注长于一行，则采取左对齐。这是一个双边图，上部有5个节点，下部有6个节点，每个上节点与偶数个下节点相连。]
)<fig:figure_with_a_long_caption>

图后内容另成一段。首行仍缩进。由于字号差异和竖直分隔的存在，文字并不与长图注相混淆。

也可将图放在页面固定位置而非相对文字而言的固定位置。见@fig:figure_placement。

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
  caption: [此图固定在页面顶部。注意typst对浮动体的预设行为是，其编号取决于在源代码中的位置而非在生成的文件中的位置。因此建议行文时要么都用浮动体，要么都不用。]
)<fig:figure_placement>

图后自动另起一段。

= 文献引用 <文献引用>

采用国标GB/T 7714-2015的引用格式。通过如下代码设置：
```typ
// set citation
set bibliography(style: "gb-7714-2015-numeric")
```
注意国标格式引用时编号在上脚标的方括号内，其后不应空格。此时应通过`#cite(<$KEY>)`而非`@$KEY`引用文献.
/ 正确示例: 引用文献#cite(<wittenIntroductionBlackHole2025>)后不该有空格.
/ 错误示例: 引用文献@wittenIntroductionBlackHole2025 后有空格. (使用`@$KEY`引用时, 若其后无空格则编译器无法正确识别`$KEY`.)
引用小节、图表亦有此问题。见@spacing。

= 问题及解决方案

== 缩进问题

设置首行缩进时，typst默认的缩进方案是首段不缩进，这是合乎西文习惯的。但在中文文档中，首段首行也应缩进。为解决这个问题，typst给出的解决方案是提供全局缩进的选项。
```typ
#set par(first-line-indent: (amount: 2em, all: true))
```
但此方案会导致其他问题，例如行间公式后会出现缩进。见下例：

#block(
  fill: block-bg-color,
  inset: 8pt,
  width: 100%,
  align(left,
  [
  #set par(first-line-indent: (amount: 2em, all: true))
  考虑一元二次方程 $ a x^2 + b x + c = 0. $ 其实数根的存在性由判别式 $Delta$ 给出。
  ])
)

这一缩进是不合理的，正确效果如下：

#block(
  fill: block-bg-color,
  inset: 8pt,
  width: 100%,
  par(first-line-indent: (amount: 2em, all: true) ,[考虑一元二次方程])+
  [
    $ a x^2 + b x + c = 0. $ 
    其实数根的存在性由判别式 $Delta$ 给出。

    下一段正常缩进。
  ]
)
因此，我们仍不能使用全局缩进，而应使用默认的首行缩进，并处理特殊段落。

具体情境和处理方式见下表：

#show table.cell.where(y: 0): strong
#set table(
  stroke: (x, y) => if y == 0 {
    (bottom: 0.75pt + black)
  },
  // align: (x, y) => (
  //   if x > 0 { center }
  //   else { left }
  // )
  align: horizon
)

#table(
  columns: 4,
  table.hline(stroke: 1.5pt),
  table.header(
    [位置],
    [全局缩进行为],
    [预设缩进行为],
    [调整方案]
  ),
  [目录后第一段],[缩进],[不缩进],[加一虚段],
  [节标题后第一段],[缩进],[不缩进],[加一虚段并减去竖直距离#footnote([如此处理会影响目录中 "目录" 二字到下方内容的距离, 因此应跳过标题内容为 "目录" 者.])],
  [公式后],[缩进],[不缩进],[_符合预期_#footnote([这也导致了公式后无法另起一段。不过一般而言，行文中最好避免以行间公式结束一段。段中图片也有相同的问题。])],
  [段中图片后],[缩进],[不缩进],[_符合预期_],
  [独立图片后],[缩进],[不缩进],[加一虚段，同时实现了独立图片和正文的竖直距离],

  table.hline(stroke: 1.5pt),
)

表和图逻辑一致，嵌在行文中的表后不另起一段，遂不缩进。

== 中西文之间空格问题 <spacing>

汉字和数字、拉丁字母之间应有空格。typst 默认有此空格，但用户若手动添加空格则会导致空格变大。
见下例：
- 未手动添加空格：这是一个typst模板。
- 手动添加空格后：这是一个 typst 模板。
若关闭自动空格，只用手动方式添加空格，空格仍过大：
- 关闭自动空格前，未手动添加空格：这是一个typst模板。
#set text(cjk-latin-spacing: none)
- 关闭自动空格后，手动添加空格后：这是一个 typst 模板。
- 关闭自动空格后，未手动添加空格：这是一个typst模板。
#set text(cjk-latin-spacing: auto)
开启自动空格后是否手动添加空格会影响空格大小不是一个好的特性。目前来说，我们可以只使用自动添加的空格而避免手动添加。采取此种策略，则引用后接文字而非标点时，时应使用`#ref(<$KEY>)`命令而非`@$KEY`命令。参考文献同理，已在#ref(<文献引用>)中讨论。

= 设计理念和文化

该模板得名于“因明”的梵语拉丁转写hetuvidyā。因明学是佛教的逻辑论辩之学，由玄奘法师引入中国。

我们希望该模板有如下属性：

#set par(justify: false)

#bibliography("ref.bib")
