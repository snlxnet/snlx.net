#import "@preview/catppuccin:1.1.0": catppuccin, flavors, set-code-theme
#import "main.typ": theme
#set document(title: [Home | snlx.net])
#show: catppuccin.with(flavors.mocha)
#show: theme("/", "index.svg", "dark", 1018)

#html.style("footer, .squiggles:last-of-type { display: none; }")

= Projects

- #link("/yap")[yap], a presentation & interactive book
- #link("/dyno")[dyno], a dynamic runtime for Typst
- #link("/eqrun")[eqrun], equation runner for Typst
- #link("/backbone")[backbone], turns android into a browser + termux + BLE API

= Articles

- #link("/magnets")[Magnets] --- how electric motors work

= Contact info
- #link("https://github.com/snlxnet")[GitHub]
- #link("https://t.me/snlxnet")[Telegram]
- #link("mailto:snlxnet@proton.me")[E-Mail]

