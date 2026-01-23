---
tags:
  - project
  - archive
created: 2025-11-16
updated: 2026-01-21T23:12:23+03:00
post: "[snlx.net](/snlx.net)"
state: done
layout: base.njk
---

## Generating the certificates
In the previous part (see [cert-site-start](/cert-site-start)) I've realized that rendering with SVGs was not the best idea and I should've used typst. In this part, I'm adding typst.

[typst.ts is a project](https://github.com/Myriad-Dreamin/typst.ts) that allows running the compiler in JS without building my own Rust part. It feels like half of its documentation is in the typescript definition files though. I need a function to add an image so that I can then include it in the typst document. The only method I've found that *could* do it is `addSource`, though I was looking for something like `addFile`, not `addSource`. IIRC `source` files are represented as text?

It's 2 days later and I haven't figured out how to read additional sources, nor did I find any docs on it. Maybe they do exist, but I couldn't find them. Anyway, I'll make my own simple wrapper on top of typst. I'm going to base my thing off the [typst-as-lib crate](https://crates.io/crates/typst-as-lib) because it should have a minimal `World`. I'm going to call the new repo `typ-js`.

It's been half a week, I've returned to this project and it no longer works. [Turns out](https://stackoverflow.com/questions/64308461/fail-to-load-a-wasm-file-in-a-web-application), I should be running `wasm-pack` with `--target` set to `web` or `no-modules`.

The next challange is adding the font. Typst (as far as I can tell) doesn't allow importing fonts from files, all fonts should be added to the `World`. What I want to do is tell the compiler that I have *all* the fonts from fontsource and then download them on-demand. To do that, I'll ask their API for the list of all fonts and then load them from the CDN via the `reqwest` crate.

I was going to use `reqwest` instead of direct `fetch` calls because it's already type-safe, or so I thought. It requires an async executer, which I couldn't figure out how to put there. Okay, the dynamic loading of fonts is in itself a large-ish project which I don't have the time for right now. I'll settle on embedding JetBrains Mono into the library for now.

## Sending emails
The most popular library for connecting to external mail servers from the client seems to be `smtp.js`. It is [dead](https://www.smtpjs.com/) now. The next option is nodemailer which is actually on GitHub, so it's less likely to die. But that library relies on the `net` module instead of the a browser api, so it's a no-go too.

After an hour of looking for a solution I've found none and I'm beginning to unredstand why. SMTP is not HTTP. SMTP is not WebSocket. SMTP is a protocol that browsers don't support natively, which means that what smtp.js was doing is it was sending requests through their server. This also means that if *I* want to send e-mails from the client I have to have a server or a desktop agent.

Sidenote: LLMs are useless for research. I've already read through everything it was giving me and more on my own, and convincing it that `smtp.js` was actually down took 2 attempts.

## 2 months later: what happened?
Since I only had [2-hours](/2-hours) to finish the email part, I've dropped my own server, see [setting-up-api](/setting-up-api) for more on that. [mk-api](/mk-api) was created with a different purpose (initially, at least).

When I eventually get back to [cert](/cert), the updates are going in [revive-cert](/revive-cert).