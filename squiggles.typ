#import "@preview/suiji:0.5.1": gen-rng, integers

#let squiggles(
  seed,
  spikes: false,
  amplitude: 8,
  segment: 10,
  gap: 0,
  up: 2,
  overflow: false,
  fill: luma(90%),
  stroke: none,
) = layout(size => {
  let rng = gen-rng(seed)
  let n = 0
  let k = if overflow { 1.5 } else { 1 }

  let segments = calc.ceil(size.width * k / (2mm * segment))
  let points = ()
  let end = 1mm * (segments * segment * 2)

  for i in range(segments * 2 + 1) {
    (rng, n) = integers(rng, low: 0, high: segment)
    let x = n * 1mm
    (rng, n) = integers(rng, low: 0, high: amplitude)
    let y = (gap+n) * 1mm

    points.push((segment*1mm*i+x, y))
  }
  points.push((end, 0mm))

  align(
    center,
    curve(
      fill: fill,
      stroke: stroke,
      curve.move((0mm, -up*1mm)),
      curve.line((0mm, 0mm)),
      ..points.chunks(2).map((chunk) => curve.cubic(auto, ..if spikes {(none, chunk.at(1))} else {chunk})),
      curve.line((end, 0mm)),
      curve.line((end, -up*1mm)),
    ),
  )
})

#set page(margin: 0mm, paper: "a6", flipped: true)
#set box(outset: 3mm)
#set text(font: "JetBrainsMono NF")

#set page(fill: rgb("#eee"))
#let fill = rgb("#fff")
#set text(fill: rgb("#333"))
#show strong: set text(fill: rgb("#6c7"))
#box(fill: fill, width: 100%, inset: 5mm)[
  Smooth / light, *bold*.
]
#squiggles(0, segment: 30, amplitude: 10, gap: 3, fill: fill, stroke: 0.3mm + rgb("#aaa"))

#set page(fill: rgb("#121212"))
#let fill = rgb("#2e2d39")
#set text(fill: rgb("#eee"))
#show strong: set text(fill: rgb("#dbf"))
#box(fill: fill, width: 100%, inset: 5mm)[
  Smooth / dark, *bold*.
]
#squiggles(1, segment: 20, amplitude: 6, fill: fill, stroke: 0.3mm + rgb("#556"))

#set page(fill: rgb("#321"))
#set text(fill: rgb("#eee"))
#let fill = rgb("#543")
#show strong: set text(fill: rgb("#cba"))
#box(fill: fill, width: 100%, inset: 5mm)[
  Spiky, *bold*.
]
#squiggles(2, spikes: true, segment: 7, fill: fill, stroke: 0.8mm + rgb("#111"))
