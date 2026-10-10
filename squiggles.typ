#import "@preview/suiji:0.5.1": gen-rng, integers

#let squiggles(
  seed,
  spikes: false,
  amplitude: 8,
  segment: 10,
  gap: 0,
  overflow: false,
  fill: luma(90%),
  stroke: none,
) = layout(size => {
  let rng = gen-rng(seed)
  let n = 0
  let k = if overflow { 1.2 } else { 1 }

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
      curve.line((0mm, 0mm)),
      ..points.chunks(2).map((chunk) => curve.cubic(auto, ..if spikes {(none, chunk.at(1))} else {chunk})),
      curve.line((end, 0mm)),
    ),
  )
})

#squiggles(5, segment: 30, amplitude: 10, gap: 3)
