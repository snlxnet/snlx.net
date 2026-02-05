---
updated: 2026-02-05T11:04:41+03:00
created: 2026-01-12T14:34:54+03:00
post: "[snlx.net](/snlx.net)"
state: irrelevant
tags:
  - resource
  - archive
layout: base.njk
---

(used to be a fleeting note)
# maybe switch to sveltekit or astro for snlx.net

## what's the problem now
- firefox doesn't prefetch the pages
- mobile firefox doesn't support view transitions
- i may want to reuse components across different projects
- the secret notes and the public notes are rendered using different markdown processors

## what will get worse after the switch
- the site will require more tools to build

## astro or sveltekit
TODO

see also [loose-sidebar](/loose-sidebar)

## Why I've decided not to do it
Most of the tools I make can work with just a few buttons and inputs, which perfectly fit into the 21x9 card format, so

<div class="card" style="background: #181825; aspect-ratio: 21 / 9; width: 100%; display: flex; justify-content: center; align-items: center; font-size: 1.5rem">
This kind of thing
</div>

That also means that the docs / devlog can co-exist in the same note as the tool itself. The cards themselves are going to be quite a bit different, so there's no sense in trying to unify their components. The logic for them is not complex enough to bring in a framework, and if they grow, js now natively supports modules.

Then, moving the rendering into [mk-bridge](/mk-bridge) with [drop-eleventy](/drop-eleventy)
1. guarantees that what I see in Obsidian is what you see on the site
2. makes it so any obsidian plugins I have are also plugins for my site, no need to re-implement them