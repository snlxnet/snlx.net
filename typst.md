---
tags:
  - resource
created: 2025-07-24
updated: 2026-01-07
post: "[snlx.net](/snlx.net)"
layout: base.njk
---

I learned about it from [an SDR episode called "typst is pretty neat"](https://sdr-podcast.com/episodes/typst-is-pretty-neat) and it is actually pretty neat

## Typst is Pretty Much Markdown
```typst
= L1 heading
== L2 heading
Regular text. *Bold* text. _Italic_ text:
+ ordered list item 1
+ item 2
+ item 3
  - unordered list item
  - another
  - another

#link("https://example.com")[See example.com], or, you know,
https://automatic.links

Code is done the same way it is in markdown
```

## Until it Comes to Math
It has way nicer math syntax than LaTeX:
```typst
$a = F / m$
```
instead of
```markdown
$a = \frac{F}{m}$
```

and

```typst
$ lim_(x -> +oo) x^2/x^3 = ... $
```
instead of
```markdown
$$
\lim_{x \to +\infty} \frac{x^2}{x^3} = ...
$$
```

## And Complex Formatting
This is a figure, or an image that has a customizable caption. The `#` character at the start switches the line into code mode, so it's looks like C instead of MarkDown. This is done for flexibility, check out [the docs](https://typst.app/docs/tutorial/formatting/) if you want to see some examples.
```typst
#figure(
  image("lab-signal-types.svg", width: 50%),
  caption: [ Hello, world! ],
)
```

Here's a simple presentation, for example:
```typst
// you can specify the colors manually or import them from a package
#import "@preview/catppuccin:1.0.0": catppuccin, flavors
#let flavor = flavors.mocha
#show: catppuccin.with(flavor)
#let palette = flavor.colors

#set page(
  paper: "presentation-16-9",
  margin: (x: 6%, y: 10%),
  header: [
    #set align(right + horizon)
    #text(fill: palette.teal.rgb)[Presentation Name]
  ]
)
#set text(font: "JetBrains Mono", size: 16pt)
#set align(center + horizon)
#show emph: set text(fill: palette.lavender.rgb)

= Hello world
#lorem(10) // filler

#pagebreak() // new slide

...
```

## And Other things
I'm still exploring this one, but typst is so much more than an office suite replacement

This is it *doing* math, not just displaying it:
```typst
#import "@preview/eqalc:0.1.4": math-to-func

// the equation to display
#let equation = $(4 pi r^3)/3$

// convert it into a function
#let get-sphere-volume = math-to-func(equation)

// solve
#let radius = 10
#let volume = calc.round(get-sphere-volume(radius), digits: 2)

// display
$ V = equation = volume $
```

And you can draw [geometry](https://typst.app/universe/package/cetz/).