#import "colors.typ"
#import "squiggles.typ": squiggles
#import "qr.typ": qr

#let theme(
  path,
  colorscheme,
  seed,
  ..args,
) = (doc) => {
  set page(margin: 10mm)
  set text(font: "JetBrainsMono NF")

  set page(fill: colorscheme.page)
  show heading: set text(fill: colorscheme.deep)
  show strong: set text(fill: colorscheme.accent)
  set text(fill: colorscheme.text)

  context if target() == "html" {
    todo
  } else {
    box(
      fill: colorscheme.header,
      width: 100%,
      outset: 10mm,
      grid(
        columns: (1fr, auto),
        box(image("./card.svg", height: 6.2cm)),
        [#set text(size: 10pt)
        #qr("https://snlx.net" + path, background: colorscheme.qrbg, color: colorscheme.qrfg)],
      )
    )
  }
  squiggles(
    seed,
    fill: colorscheme.header,
    stroke: 0.3mm + colorscheme.border,
    ..args,
  )

  show link: underline
  show link: set text(fill: colorscheme.accent)
  doc

  set align(bottom + center)
  squiggles(
    seed + 1,
    fill: colorscheme.header,
    stroke: 0.3mm + colorscheme.border,
    down: -10,
    ..args,
  )
  box(fill: colorscheme.header, width: 100%, outset: 10mm)[
    \@snlxnet
    | #link("https://snlx.net")[home]
    | #link("https://github.com/snlxnet/snlx.net")[source code]
    | #link(path + ".pdf")[print version]
  ]
}

#show: theme("/site", colors.screen.dark, 0)
= Heading
Colors: custom.
