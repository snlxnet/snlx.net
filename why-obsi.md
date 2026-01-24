---
tags:
  - resource
created: 2026-01-04
updated: 2026-01-24T12:05:10+03:00
cssclasses: grdn
post: "[snlx.net](/snlx.net)"
layout: base.njk
state: wip
---

![settling-on-obsidian.svg](/settling-on-obsidian.svg)

Let's start by talking about why I didn't want to use it

## Why not markdown
I use the system for the uni, so I need
1. a lot of math blocks
2. a few diagrams
3. very specific document formatting (they want me to do it in MS Word)

That's why in September 2025 I started using [typst](/typst).

## Okay then, why not typst
Well typst is a typesetting tool, not a note-taking system and not a tool for building digital gardens. It has no links between files and doesn't run on mobile (outside of the webapp or termux).

So what did happen this semester (2025-09-01..2026-01-01)?

What happened is now I have an obsidian vault littered with typst documents which are not linked. They are nice for formatting, they generate pretty PDFs (which, funnily enough, are linked into some markdown notes), but I can't use any links *within* them or link *to* them.

## What about the integrations
Initially I tried using the `typst renderer` plugin, but I didn't like it for
1. how it looked with my theme (catppuccin, like on this site)
2. it being unable to open `.typ` files directly
3. it being unable to export PDFs

So I decided that the real solution is to make an Obsidian clone around typst files instead of markdown files. That, uhm... Didn't go very far... I've had a lot of other things to do, so the project was never started.

## Why do anything now?
In the middle of December I've realized that the primary reason I don't put anything new up on the site is that it takes more effort than pressing a shortcut and I don't have the time. Like, I'm writing notes locally anyway, I just never push them.

Another thing is I don't like the fact I can't link to parts of my university notes because each notebook is a single `.typ` file. Now I have a bit of free time, NOW is the time to fix it!

## The compromise
1. I don't reinvent the wheel
2. I use obsidian because it has a plugin system and a mobile app
3. I write notes that require typst using
    1. https://github.com/azyarashi/obsidian-typst-mate
    2. https://typst.app/universe/package/eqalc
    3. https://typst.app/universe/package/cetz
4. Then link to them, they are regular notes after all
5. And build them into finished PDFs with
    1. the regular typst compiler
    2. https://typst.app/universe/package/cmarker
6. The publishing is handleded by a plugin, see [mk-bridge](/mk-bridge)

If I ever actually make the typst-based obsidian clone, migrating to that should be relatively easy.

## Simple Adapter
I've reconfigured the typst mate plugin to only interpret the typst+show code blocks, not the regular typst ones. Now I'm using [this simple script](https://gist.github.com/snlxnet/ff611be55809abc4a852f4fbcd3d04e1) to read markdown with typst used for later formatting. It evaluates the typst+show and math blocks and extracts the frontmatter (using the cmarker plugin).

The only difference between the script I actually use and the gist is that my links look like this:
```typst
#show link: set text(fill: blue)
#show link: underline
#show regex("\\[\\[([\S ]+)\]\]"): (match) => {
  let file = match.text.slice(2, -2)
  let url = "https://snlx.net/" + file
  link(url)[#file]
}
```

## Asciinema Updates: work in progress
```asciinema
api-setup.cast
preload: true
```

This works in Obsidian, but not on the site. What works on the site is

```html
<div id="cast" class="asciinema"></div>
<script>
  document.fonts.load("1em JetBrains Mono").then(() => {
    AsciinemaPlayer.create('/api-setup.cast', document.getElementById('cast'), {
      preload: true,
      terminalFontFamily: "'JetBrains Mono'"
    });
  })
</script>
```

I'll make the site support the first one when doing [drop-eleventy](/drop-eleventy)