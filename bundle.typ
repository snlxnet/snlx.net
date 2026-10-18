#let use(..args) = for name in args.pos() { asset(name, read(name)) }
#let redir(from, to) = document(from + ".html")[
  #html.script("window.location = 'https://" + to + "'")
]
#let app(name) = redir(name.text, name.text + ".snlx.net")

#context if target() == "bundle" {
  document("index.html", include "index.typ")
  app[yap]
  app[dyno]
  app[backbone]
  redir("eqrun", "typst.app/universe/package/eqrun")

  document("magnets.html", include "magnets.typ")
  document("magnets.pdf", include "magnets.typ")
  use(
    "magnets-sketch.svg",
    "dc.svg", "brushless.svg", "stepper.svg",
    "magnets.css",
    "magnets.js",
  )
}
