---
tags:
  - project
  - archive
created: 2025-12-12
updated: 2026-01-06
up: "[setting-up-api](/setting-up-api)"
post: "[snlx.net](/snlx.net)"
layout: base.njk
---

what i need is a system that updates itself and runs containers, right? Find something immutable where I won't even have shell access and that's it!

Flatcar is *very* interesting. After installing the thing you can't change it. Ever. You can reconfigure nix, you can't change this. It just auto-updates. Forever.

What I don't like about flatcar is that it doesn't guarantee that the set of containers running on the system is declarative.

Photon is less interesting. It's mutable. I can't guarantee that its config will forever remain declarative.

Talos looks very promising. No shell. No package management. Just an API. However, the control plane requires 2 gigs of ram or more, and I have one.

I think I'll just settle for (alpine with an answerfile for installation) or flatcar and Ansible for provisioning. I'm thinking diskless. Oh wait except flatcar also needs 2 gigs of ram too.