#let use(..args) = for name in args.pos() { asset(name, read(name)) }
#let redir(from, to) = document(from + ".html")[
  #html.script("window.location = 'https://" + to + "'")
]

#context if target() == "bundle" {
  document("index.html", include "index.typ")
  document("ru/index.html", include "ru/index.typ")
  use("index.svg", "ru/index.svg")

  redir("yap", "yap.snlx.net")
  redir("dyno", "dyno.snlx.net")
  redir("backbone", "backbone.snlx.net")

  redir("eqrun", "typst.app/universe/package/eqrun")
  redir("src", "github.com/snlxnet/snlx.net")

  redir("ru/yap", "yap.snlx.net?lang=ru")
  redir("ru/dyno", "dyno.snlx.net")
  redir("ru/backbone", "backbone.snlx.net/ru")

  redir("ru/eqrun", "typst.app/universe/package/eqrun")

  document("magnets.html", include "magnets.typ")
  document("magnets.pdf", include "magnets.typ")

  redir("ru/magnets", "snlx.net/магниты")
  document("магниты.html", include "ru/magnets.typ")
  document("магниты.pdf", include "ru/magnets.typ")

  use(
    "magnets-sketch.svg",
    "ru/magnets-sketch.svg",
    "dc.svg", "brushless.svg", "stepper.svg",
    "magnets.css",
    "magnets.js",
  )
}
