#import "main.typ": theme
#set document(
  title: "Home | snlx.net",
  description: "I'm Alex, a web developer & maker, and this is my site",
)
#show: theme("/", "/ru", "index.svg", "dark", 1018)

#html.style("footer, .squiggles:last-of-type { display: none; }")

= Projects

- #link("/yap")[yap], a presentation & interactive book (has #link("https://typst.app/universe/package/yap")[a Typst integration])
  - currently rewriting this one, treat it as a beta
- #link("/dyno")[dyno], a dynamic runtime for Typst
- #link("/eqrun")[eqrun], equation runner for Typst
- #link("/backbone")[backbone], turns android into a browser + termux + BLE API

= Articles

- #link("/magnets")[Magnets] --- how electric motors work (work in progress)

= Contact info
- #link("https://github.com/snlxnet")[GitHub]
- #link("https://t.me/snlxnet")[Telegram]
- #link("mailto:snlxnet@proton.me")[E-Mail]

