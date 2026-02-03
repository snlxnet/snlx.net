---
updated: 2026-02-03T12:50:20+03:00
created: 2026-01-25T11:52:58+03:00
tags:
  - project
post: "[snlx.net](/snlx.net)"
layout: base.njk
---

# Pocket Keyboard
## Initial thoughts

Inspired by [artsy pi](https://www.reddit.com/r/cyberDeck/comments/1qhh6pc/one_handed_headless_journaling_device/), it's SO COOL!

A few months ago, a switch on my keyboard started malfunctioning. I've replaced it, but there are now 9 switches left unused and a microcontroller sitting on a shelf collecting dust. That's enough to make a wireless artsey keyboard / macropad with additional external pins for quick hardware projects. It could have the shape of a credit card (or more like a pi model b+) and use the ([battery recommendation](/battery recommendation)).

The power switch is completely unnecessary as the controller has deep sleep and the ability to shut down wifi / bluetooth.

Or it could be a gridfinity module like so:

![pocket-kb-sketch.svg](/pocket-kb-sketch.svg)

Anyway, the file is `artsey.blend`

## Exploring Different Layouts
I've tried typing "a quick brown fox jumps over the lazy dog" on my keyboard according to the artseyio layout and... I don't really like how much it relies on the pinkies.

There are a few ways to make a layout:
1. phonetic. Though I don't think English steno could ever work on 8 keys, there's just not enough keys to cover all the sounds
2. orthographic. ET on the thumbs, AO on the middle fingers, IN on the index and SH on the ring, the rest as combos. The easiest combos to hit are for words, for example, "ET" = "the"

I've looked at [what else already exists](https://en.wikipedia.org/wiki/Chorded_keyboard) and I don't like those much either. The first stenograph had ten keys, but I guess there's a reason why they have twenty-something now.

https://asetniop.com/ is a thing, but it also requires 10 keys and is not very intuitive, not for me, anyway.

taipo is a thing, but it's very similar to artsey.

Braille would only require 6 keys.

I'm overthinking this, I'll just try artsey and disassamble the project for parts again if it doesn't work.

## Wings
I could add a deployable holder for the phone to one side and a pad to hold with your thumb to the other, making a landscape phone dock. Pretty sure that's unnecessary though.

Update:
1. Yes, it's completely unnecessary
2. There's nowhere I could fit it in a 1x2 gridfinity module

## Firmware language?
CircuitPython because it gives me a REPL which is handy for building other projects on top of this one.

## Features
- fleeting note inbox when disconnected, combo to then reproduce
- site status control and indication (probably not though)
- bt kb, obvi
- multiple exposed gpio
- circuitpy ws shell so that I don't have to care that [webusb works on android and can replace webserial](/webusb works on android and can replace webserial)
- a built-in kind-of IDE, see [fish-ide](/fish-ide)

## Battery thoughts
The 10x20x30mm batteries I have are small and may work okay. But. But. They are non-standard and I only have 2 and don't know where to get more.

18650 is huge, won't work for a 1x2 gridfinity module. AA is kinda big and I'd need 2 of them. CR2032 works, but they are not rechargable. LIR2032 is the same thing, but rechargable. Settling for them.

I've tried not using a battery holder and designing one from scratch, but honestly it's easier to just use the one I have, even though it's kind of too big.

## The general design
I'm opting now (2026-01-29) to not use any screws or glue in the design. The magnets should be embedded in the print, the switches should be press-fit, and the microcontroller should have enough padding with all the wiring and whatnot.

The GCODE stop command that MY printer understands is M25

It's (2026-02-03) and I've modified the middle section to have the magnets glued in and the lid to screw into it. Context: the design consists of 3 pieces

![pocket-kb-sections.svg](/pocket-kb-sections.svg)

The bottom two, in purple and orange, are the microcontroller housing and the battery holder resepctively. They have a cutout for the part they contain and 4 magnets embedded into the print .8 mm from the top. This is so that the attraction to the middle section of the module is stronger than to the gridfinity base plate.

The middle section (in blue) holds the switches and the wires. It also has magnets, but those are glued in because the section's in the middle and no-one will ever see it anyway, yet making the magnets closer to the other parts makes them stick better. Imagine the magnets as cylinders around the red lines on the sketch.

The top section (in green) is the one that holds the switches from the top, and so it has to be attached securely to the middle. It can't have all 8 magnets because those would be in the way of the keycaps, so it only has 4. To compensate for that, I've added 4 screws to the design. Sure, it looks a bit worse, but it will hold together better.