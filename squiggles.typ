#curve(
  fill: lime.lighten(80%),
  stroke: lime,
  curve.move((0mm, 0mm)),
  curve.line((10mm, 5mm)),
  curve.line((25mm, 3mm)),
  curve.line((35mm, 7mm)),
  curve.line((42mm, 0mm)),
)

#curve(
  fill: lime.lighten(80%),
  stroke: lime,
  curve.move((0mm, 0mm)),
  curve.cubic(auto, (5mm, 4mm), (10mm, 5mm)),
  curve.cubic(auto, (25mm, 4mm), (30mm, 3mm)),
  curve.cubic(auto, (37mm, 5mm), (45mm, 7mm)),
  curve.cubic(auto, none, (60mm, 0mm)),
)

#import "@preview/suiji:0.5.1": gen-rng, integers

#let spikes = true
#let amplitude = 10
#layout(size => {
  let rng = gen-rng(2)
  let n = 0

  let segments = calc.ceil(size.width / 20mm)
  let points = ()

  for i in range(segments * 2 + 1) {
    (rng, n) = integers(rng, low: 0, high: 10)
    let x = n * 1mm
    (rng, n) = integers(rng, low: 0, high: amplitude)
    let y = n * 1mm

    points.push((10mm*i+x, y))
  }
  points.push((segments*20mm+10mm, 0mm))

  curve(
    fill: lime.lighten(80%),
    stroke: lime,
    curve.line((0mm, 0mm)),
    ..points.chunks(2).map((chunk) => curve.cubic(auto, ..if spikes {(none, chunk.at(1))} else {chunk})),
  )
})

