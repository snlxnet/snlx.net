#import "@preview/suiji:0.5.1": gen-rng, integers

#let squiggles(
  seed,
  spikes: false,
  amplitude: 8,
  segment: 10,
  gap: 0,
  up: 5,
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

#set page(fill: rgb("#ddd"))
#set text(fill: rgb("#333"))
#let fill = rgb("#eee")
#box(fill: fill, width: 100%, inset: 5mm)[
  Smooth
]
#squiggles(0, segment: 30, amplitude: 10, gap: 3, fill: fill)

#set page(fill: rgb("#121212"))
#set text(fill: rgb("#eee"))
#let fill = rgb("#2e2d39")
#box(fill: fill, width: 100%, inset: 5mm)[
  High frequency
]
#squiggles(1, segment: 1, amplitude: 5, fill: fill)

#set page(fill: rgb("#321"))
#set text(fill: rgb("#eee"))
#let fill = rgb("#543")
#box(fill: fill, width: 100%, inset: 5mm)[
  Spiky
]
#squiggles(2, spikes: true, segment: 7, fill: fill)
