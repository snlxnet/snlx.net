#let use(..args) = for name in args.pos() { asset(name, read(name)) }

#context if target() == "bundle" {
  document("index.html", include "index.typ")

  document("magnets.html", include "magnets.typ")
  document("magnets.pdf", include "magnets.typ")
  use(
    "magnets-sketch.svg",
    "dc.svg", "brushless.svg", "stepper.svg",
    "magnets.css",
    "magnets.js",
  )
}
