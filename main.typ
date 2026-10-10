#import "colors.typ"
#import "squiggles.typ": squiggles
#import "qr.typ": qr

#let theme(
  colorscheme,
  seed,
  ..args,
) = (doc) => {
  set page(margin: 10mm)
  set text(font: "JetBrainsMono NF")

  let header(it) = context if target() == "html" {
    html.div(class: "top", it)
  } else {
    box(fill: colorscheme.header, width: 100%, outset: 10mm, it)
  }

  set page(fill: colorscheme.page)
  show heading: set text(fill: colorscheme.deep)
  show strong: set text(fill: colorscheme.accent)

  set text(fill: colorscheme.deep)
  header[
    Smooth / light, *bold*.
  ]
  squiggles(seed, fill: colorscheme.header, stroke: 0.3mm + colorscheme.border, ..args)

  set text(fill: colorscheme.text)
  doc
}

#show: theme(colors.screen.dark, 0)
= Heading
Colors: custom.
