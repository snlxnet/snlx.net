---
tags:
  - area
  - fleeting
up: "[wall](/wall)"
created: 2025-12-01
updated: 2026-01-06
post: "[snlx.net](/snlx.net)"
layout: base.njk
---

<img src="trk.svg" style="border-radius: 1rem; width: 100%">

Track is an operating system that makes any projector screen touch-sensitive using 2 webcams.

## Status
Pre-alpha, in development

## Motivation
Uni wanted a touch sensitive projector wall, but those cost a fortune. No open-source solutions exist, so I decided to make one.

## Architecture
The base sytem is *NixOS*.

The window manager is hyprland.

The office suite is libreoffice.

The taskbar is (whatever is the simplest one that can have buttons).

The tracking service is...

## Startup
After the system boots up, it opens the browser with a calibration screen. The service sees qr codes in the edges of the screen and remembers where the corners are, then opens pairdrop in the browser.

## Resources
- https://github.com/Recognition2/tfmicro
- https://arxiv.org/abs/2407.08634
- https://github.com/l1npengtul/nokhwa
- https://unix.stackexchange.com/questions/737147/simulate-touch-manipulation-on-linux
- https://who-t.blogspot.com/2016/09/understanding-evdev.html

## Devlogs
- [trk-eyes](/trk-eyes)