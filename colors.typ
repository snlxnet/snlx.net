#let print = (
  light: (
    header: cmyk(0%, 0%, 0%, 5%),
    border: cmyk(0%, 0%, 0%, 40%),
    page:   cmyk(0%, 0%, 0%, 0%),
    deep:   cmyk(0%, 0%, 0%, 100%),
    text:   cmyk(0%, 0%, 0%, 80%),
    accent: cmyk(90%, 0%, 80%, 0%),
  ),
  paleo: (
    header: cmyk(46%, 55%, 54%, 56%),
    border: cmyk(59%, 63%, 62%, 76%),
    page:   cmyk(59%, 63%, 62%, 76%),
    deep:   cmyk(23%, 21%, 24%, 2%),
    text:   cmyk(30%, 31%, 37%, 10%),
    accent: cmyk(23%, 21%, 24%, 2%),
  ),
)

#let screen = (
  light: (
    header: rgb("#ffffff"),
    border: rgb("#aaaaaa"),
    page:   rgb("#eeeeee"),
    deep:   rgb("#000000"),
    text:   rgb("#444444"),
    accent: rgb("#00ac6d"),
  ),
  dark: (
    header: rgb("#2e2d39"),
    border: rgb("#555566"),
    page:   rgb("#121212"),
    deep:   rgb("#eeeeee"),
    text:   rgb("#cccccc"),
    accent: rgb("#a8a5ff"),
  ),
  paleo: print.paleo.pairs().map(((k, v)) => (k, rgb(v))).to-dict(),
)

#let css = ""
#let tab = "    "
#for (colorscheme, colors) in screen.pairs() {
  css += "." + colorscheme + " {\n"
  css += colors.pairs().map(((k, v)) => tab + k + ": " + v.to-hex() + ";").join("\n")
  css += "\n}\n"
}

#let theme = screen.paleo

#import "squiggles.typ": squiggles
#set page(margin: 10mm)
#set text(font: "JetBrainsMono NF")

#set page(fill: theme.page)
#set text(fill: theme.deep)
#show strong: set text(fill: theme.accent)
#box(fill: theme.header, width: 100%, outset: 10mm)[
  Smooth, *bold*.
]
#squiggles(0, segment: 30, amplitude: 10, gap: 5, fill: theme.header, stroke: 0.3mm + theme.border)
= Heading
#set text(fill: theme.text)
Colors: *custom*.

