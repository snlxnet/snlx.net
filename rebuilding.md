---
tags:
  - project
  - archive
post: "[snlx.net](/snlx.net)"
created: 2025-12-06
updated: 2026-01-10T15:24:03+03:00
layout: base.njk
---

There are a few small things I'd like to rebuild today which were annoying me for the past few months.

## My editor
I've been using helix since (checks dotfiles) the end of June 2024. The reason I switched initially was that I didn't like installing a package manager into neovim and not knowing what half of my config did. I have 2 problems with helix:
- non-standard keymap (see [Tris's video](https://www.namtao.com/writing-at-the-speed-of-thought/) for more info on that)
- a lot of features that I don't use.

Reasons for going back to *neovim* specifically:
- I've found [an article on setting up LSP from scratch](https://blog.diovani.com/technology/2025/06/13/configuring-neovim-011-lsp.html)
- It works in the terminal, so plays nice with zellij.

It's been a while since I've tried configuring nvim, so I took the basic setup from [this article](https://ww2.coastal.edu/mmurphy2/oer/alpine/neovim/).

The default hotkey for showing the diagnostics is `<C-w>d`, control window diagnosics, which I find completely reasonable.

The colorscheme is weird though. Since I don't want any huge plugins, I've decided to take vim's theme and it's not the same as the helix's! Okay, I'll adapt [helix's theme](https://github.com/catppuccin/helix/blob/main/themes/default/catppuccin_mocha.toml).

After fighting it for an hour I gave up and cloned the official catppuccin theme manually (I still don't want a plugin manager). I don't want it to pollute the root of my config, so I put it in `.config/nvim/pack/vendor/start/catppuccin`, which I learned about from [this article](https://vonheikemen.github.io/devlog/tools/installing-neovim-plugins-without-a-plugin-manager/). *Great article* by the way, I now know that I can use ansible or a shell script as my plugin manager. Then I added a fallback in case the theme is not installed.

With the editor done, I can now move onto

## CSS on my website
My problem with the current CSS file is that it's 226 lines, does almost nothing and yet has some strong opinions. The way I want to shrink it down is by having a few utility classes and nothing else. That won't work for markdown pages though, so I'll add a separate file there.

Okay, not just utility classes, I need a reset.

I've tried writing utils like `.row, .col, .items-center, .sticky, .sideways` and I don't like them. They feel like tailwind. But worse. I'll make a few semantic blocks:
![rebuilding-excali-0.dark.svg](/rebuilding-excali-0.dark.svg)

Okay, I've ended up kind of rethinking the design system a bit.
![rebuilding-excali-1.dark.svg](/rebuilding-excali-1.dark.svg)
The site now has 2 layouts: one for the garden and the other for other apps.

Each note can be in 4 states:
- idea (lightbulb)
- in progress (construction)
- done (checkmark)
- irrelevant (shredder)

## The API
And that's a new project. I'm writing this line on 2026-01-02, the rest of the note was completed on 2025-12-06, this was supposed to be a quick one day project, I'm not doing it here.

2026-01-06 update, it was moved to [mk-api](/mk-api).