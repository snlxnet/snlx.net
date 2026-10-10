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

  let header = box(
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
  let footer(it) = context if target() == "html" {
    html.footer(it)
  } else {
    box(fill: colorscheme.header, width: 100%, outset: 10mm, it)
  }

  context if target() == "html" {
    html.header(html.frame(box(width: 180mm, header)))
  } else {
    header
  }
  squiggles(
    seed,
    fill: colorscheme.header,
    stroke: 0.3mm + colorscheme.border,
    up: 3,
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
  footer[
    \@snlxnet
    | #link("https://snlx.net")[home]
    | #link("https://github.com/snlxnet/snlx.net")[source code]
    | #link(path + ".pdf")[print version]
  ]
}

#html.style(colors.css.dark)
#html.style(```css
body {
  padding: 0 1em;
  padding-bottom: 8em;
  max-width: 90ch;
  margin: auto;
  overflow-x: hidden;
  position: relative;
}
.squiggles {
  display: flex;
  justify-content: center;
}
.squiggles svg {
  height: unset;
}

html, body {
  background: var(--page);
  color: var(--text);
  font-size: 16px;
  font-family: "JetBrainsMono NF";
}
header svg {
  width: 100% !important;
  height: unset !important;
}
header, footer {
  background: var(--header);
  box-shadow: 0 0 0 100vmax var(--header);
  clip-path: inset(0 -100vmax);
  padding: 1em 0;
}
.squiggles:last-of-type svg {
  position: absolute;
  bottom: 3.2em;
}
footer {
  position: absolute;
  bottom: 0;
  left: 0;
  right: 0;
  text-align: center;
}
h1, h2, h3, h4, a, strong {
  color: var(--accent);
}
```.text)
#show: theme("/site", colors.screen.dark, 0)

= Heading

Was it worh making this typst thing?

Next question

#lorem(2000)
