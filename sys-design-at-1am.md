---
tags:
  - resource
created: 2025-12-13
updated: 2026-01-07
up: "[setting-up-api](/setting-up-api)"
post: "[snlx.net](/snlx.net)"
layout: base.njk
---

it's 12:33 and clearly i won't sleep until i write this down

so i can fix [setting-up-api](/setting-up-api) this way:
- if i have a server that's convenient to manage externally and that i don't need the shell of that often, i can use alpine in disk install with an answerfile and manage it with ansible from another machine or github actions
- if i don't need containers, i can afford a diskless install
- if i have more memory there, i can afford a nixos installation with root on tmpfs and unattended updates enabled