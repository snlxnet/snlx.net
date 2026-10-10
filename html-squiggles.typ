#import "squiggles.typ": squiggles

#set page(margin: 10mm, paper: "a6", flipped: true)
#set box(outset: 3mm)
#set text(font: "JetBrainsMono NF")

#set page(fill: rgb("#eee"))
#let fill = rgb("#fff")
#set text(fill: rgb("#000"))
#show strong: set text(fill: rgb("#6c7"))

#let top(it) = context if target() == "html" {
  html.div(class: "top", it)
} else {
  box(fill: fill, width: 100%, outset: 10mm, it)
}

#html.style(```css
body {
  max-width: 80ch;
  margin: auto;
  overflow-x: hidden;
}
.squiggles {
  display: flex;
  justify-content: center;
}
.squiggles svg {
  height: unset;
}

html, body {
  background: #eee;
  font-size: 16px;
  font-family: "JetBrainsMono NF";
}
.top {
  background: #fff;
  box-shadow: 0 0 0 100vmax #fff;
  clip-path: inset(0 -100vmax);
  padding: 1em 0;
}
strong {
  color: #6c7;
}
```.text)

#top[
  Smooth / light, *bold*.
]
#squiggles(0, segment: 30, amplitude: 10, gap: 3, fill: fill, stroke: 0.3mm + rgb("#aaa"), up: 0)
= Heading
#set text(fill: rgb("#444"))
Colors: custom.
