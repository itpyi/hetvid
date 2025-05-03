#import "/0.1.0/hetvid.typ": *
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
  body-font: ("TeX Gyre Termes", "Songti SC", "Source Han Serif SC"),
  math-font: ("TeX Gyre Termes Math"),
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
  - 在本模板发布之后，用家或可通过
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
用家可将该项目复制到本地包目录下。例如对于 Windows 系统，最终应存在如下文件夹：
#raw(
    block: true,
    "C:\Users\USERNAME\AppData\Roaming\typst\packages\local\hetvid\\"+version+"\\"
  )
此时用家可通过`#import`命令来使用该模板。


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
  caption-font-size: 10pt,
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

我们设定了几类字体，其预设值见#ref(<sec-diaoyong>)中的代码。预设值是一些字体族，一个字体族在 Typst 中实现为一个`array`类型的变量，包含了若干个字体。对于每一个字符，编译器将以字体族中支持该字符的第一个字体显示之。用家在修改时应注意，我们希望使用专业的西文字体而非宋体来显示拉丁字母，因此，建议将只覆盖拉丁字母的字体放在前面，将中文字体放在后面。

几类字体如下:

/ 正文字体 (`body-font`): 主要用于正文。其大小和字重由`body-font-size`和`body-font-weight`给出。

/ 纯文本字体 (`raw-font`): 用于纯文本内容，例如代码等。预设值都是等宽字体。由于同字号的等宽字体大小与普通字体不一定匹配，我们提供了`raw-font-size`变量供用家调整纯文本字体大小。

/ 标题字体 (`heading-font`): 用于文档标题和各节标题。预设值为无衬线字体（例如黑体），使标题与正文判然有别，且更具现代感。用家也可将其修改为加粗的衬线字体。用家可通过设定`heading-font-weight`来调整标题的字重。
/ 数学字体 (`math-font`): 用于数学公式。详见@sec:math-font。
/ 强调字体 (`emph-font`): 以拉丁字母书写的文本中，一般使用意大利体（_italic_，斜体）来表示强调，但斜体字形与汉字的特性天然互斥。因此，在汉字书写的文本中，一般使用更接近手写体的_楷体_来表示强调。我们通过`emph-font`来表示用于强调的中文字体。如果用家希望修改预设值为一个新的字体族，注意应在字体族中先放入和正文字体（`body-font`）相同的拉丁字体。

另外，我们提供了`caption-font-size`参量以控制脚注的字号大小。

== 关于数学字体<sec:math-font>

从自洽的角度讲，我们建议将数学字体和正文中的西文字体设成同种字体（的数学变种和常规形态）。例如在公式环境中我们也时常遇到有文字意义的、用正体表示的字符，我们不希望这些字符在公式环境和正文中呈现为不同字体。又如公式中常出现数字，而正文中也会有数字，它们可能指代完全一样的对象，因此我们也不希望它们呈现为不同字体。支持数学公式的字体可参考 #link("https://tex.stackexchange.com/questions/425098/which-opentype-math-fonts-are-available")[Which OpenType Math fonts are available? (StackExchange)]。

模板预设的数学字体为 New Computer Modern Math，对应正文字体 New Computer Modern，这是 #LaTeX 的默认字体。本文档使用的正文字体是 TeX Gyre Termes，数学字体为与之匹配的 TeX Gyre Termes Math。该字体是 Times 字体的开源复刻版本，详见#link("https://zhuanlan.zhihu.com/p/506189673")[【字体的故事】Times New Roman（知乎）]。使用该字体的原因详见@sec:latin-cjk-spacing。

== New Computer Modern 的字重问题

模板预设使用的正文字体 New Computer Modern 和数学字体 New Computer Modern Math 可以选择两种字重，一种是我们预设使用的常规（regular， 400）字重，另一种是稍粗一些的 book（450）字重。用家如想使用后者，将`body-font-weight`设为 450 即可。

New Computer Modern 字体的两种字重在 Typst 中的默认行为稍显怪异（0.13.1 版本）。假设用家通过如下代码设置字体：
```typ
#set text(font: "New Computer Modern")
#show math.equation: set text(font: "New Computer Modern Math") 
```
此时正文为 New Computer Modern 字体，字重默认为 regular (400)；公式为 New Computer Modern Math 字体，字重默认为 book (450)。因此公式会显得稍粗于正文。我们的模板通过对两种字体都明确写出字重避免了这一问题。

== 中西文之间的空格问题<sec:latin-cjk-spacing>

在一般的排版中，汉字与拉丁字母、阿拉伯数字之间会稍有分隔。Typst 通过`text`函数中的`cjk-latin-spacing`参量控制是否自动提供此分隔，其预设值为`auto`，即自动提供，用家可将其设为`none`以关闭。

本模板开启了 Typst 提供的自动空格功能，但我们期待该功能具有一定的“稳定性”，即无论用家的源码是否手动在中西文之间添加了空格，编译出的文档都有一个大小相同的空格。如下例：

#lizi[
  下面两行，第一行的源码没有添加空格，第二行的源码添加了空格。
  - 我花了3天时间写好了一个Typst模板。
  - 我花了 3 天时间写好了一个 Typst 模板。
]

我们希望自动空格具有上述稳定性的考虑如下：
- 用家是否手动添加空格一般不是一个稳定的行为。
- Typst 的自动空格机制在汉字和数学公式、汉字和纯文本之间不起作用，如@li-raw-eq。
- 我们希望用`@{KEY}`而非`#ref(<{KEY}>)`来快捷地实现引用，但前者后面不能紧跟文字，因此不得不添加空格，详见@文献引用。为了排版行为的自洽，我们希望 Typst 添加的自动空格不受此手动空格的影响。

#lizi[下面两行，第一行的源码没有添加空格，第二行的源码添加了空格，第三行在纯文本两侧没有添加空格，在公式和汉字之间添加了空格。
  - 函数`sqrt(x)`计算了$x^(1\/2)$。
  - 函数 `sqrt(x)` 计算了 $x^(1\/2)$。
  - 函数`sqrt(x)`计算了 $x^(1\/2)$。
]<li-raw-eq>

很不幸，Typst 的自动空格机制并不总是具有这样良好的性质。开启自动空格时，中西文之间的空格是否受源码中用家手动添加的空格的影响，取决于字体和标点压缩等多个因素。下@li-font1、@li-font2 展示了字体的影响，@li-compress 展示了标点压缩的影响。

#lizi[
  #set text(font: ("New Computer Modern", "Songti SC", "Source Han Serif SC"))
  将西文字体设置为 New Computer Modern，则手动添加空格会使空格增大。
  - 我花了3天时间写好了一个Typst模板。
  - 我花了 3 天时间写好了一个 Typst 模板。
]<li-font1>

#lizi[
  #set text(font: ("Libertinus Serif", "Songti SC", "Source Han Serif SC"))
  将西文字体设置为 Libertinus Serif，则手动添加空格不影响编译结果。
  - 我花了3天时间写好了一个Typst模板。
  - 我花了 3 天时间写好了一个 Typst 模板。
]<li-font2>

#lizi[
  下面两行，第一行的源码没有添加空格，第二行的源码添加了空格。可以看到，在压缩量较大时，手动添加空格与否对排版效果影响巨大。（如下效果华文书宋、TeX Gyre Termes 字体配置下可以呈现，其他字体呈现相同效果可能需要略加增减。）
  - 我花了有近30天时间，夜以继日、焚膏继晷、废寝忘食地写好了一个Typst模板，以飨用家。
  - 我花了有近 30 天时间，夜以继日、焚膏继晷、废寝忘食地写好了一个 Typst 模板，以飨用家。
]<li-compress>

考虑到上述细节问题，我们建议讲究的用家在中文文档中如下处理：
- 使用对手动空格不敏感的字体，例如 TeX Gyre Termes、Libertinus Serif 等。
- 在汉字和公式之间_总是_手动添加空格。
- 在汉字和纯文本之间_不_添加空格，因为我们在定制纯文本的背景时已经在背景到两侧字符之间、纯文本字符到背景边框之间放置了横向距离。
换言之，我们建议用家在处理纯文本和公式时采用#ref(<li-raw-eq>)第三行的方式，并通过字体设置以容许在一般的汉字和拉丁字母之间比较随机地添加空格。至于标点压缩导致的对空格的敏感，我们暂时没有好的处理方案，讲究的用家可通过控制自己的习惯（例如总是添加空格）来保持风格的统一。

= 标题

一级标题字号为 1.4 em。

== 二级标题

二级标题字号为 1.2 em。

=== 三级标题

三级标题的字号大小为 1.1 em。一般来说，100页以下的笔记很少使用三级标题。例如，Kitaev的文章#cite(<kitaevQuantumComputationsAlgorithms1997>)#cite( <kitaevAnyonsExactlySolved2006>)#cite(<kitaevAlmostidempotentQuantumChannels2025>)和Witten的讲义#cite(<wittenNotesEntanglementProperties2018>)#cite(<wittenMiniIntroductionInformationTheory2020>)#cite(<wittenIntroductionBlackHole2025>)都不使用三级标题。

尽管 Typst 提供了更高级标题的功能，但模板作者强烈不推荐使用层级过多的标题，因此也未对其行为作特别订制。

= 引文

成段引文如下：
#quote(attribution: [柳宗元《封建論》], block: true)[
  秦有天下，裂都會而為之郡邑，廢侯衛而為之守宰，據天下之雄圖，都六合之上游，攝制四海，運於掌握之內，此其所以為得也。不數載而天下大壞，其有由矣。亟役萬人，暴其威刑，竭其貨賄。負鋤梃謫戍之徒，圜視而合從，大呼而成群。時則有叛人而無叛吏，人怨於下，而吏畏於上，天下相合，殺守劫令而並起。咎在人怨，非郡邑之制失也。

漢有天下，矯秦之枉，徇周之制，剖海內而立宗子，封功臣。數年之間，奔命扶傷之不暇。困平城，病流矢，陵遲不救者三代。後乃謀臣獻畫，而離削自守矣。然而封建之始，郡國居半，時則有叛國而無叛郡。秦制之得，亦以明矣。繼漢而帝者，雖百代可知也。
]
其后内容接续上段。

= 公式

公式默认编号，如
$ cal(F)f (k) = 1/(2 upright(pi) "i") integral dif k thin "e"^("i"k x) f(x), $<eq:fourier>
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


= 设计理念和文化

该模板得名于“因明”的梵语拉丁转写hetuvidyā。因明学是佛教的逻辑论辩之学，由玄奘法师引入中国。

我们希望该模板有如下属性：

#set par(justify: false)

#bibliography("ref.bib")
