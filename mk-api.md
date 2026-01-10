---
tags:
  - project
  - archive
post: "[snlx.net](/snlx.net)"
created: 2026-01-01
updated: 2026-01-10T23:56:22+03:00
layout: base.njk
state: done
---

# Starting Again
## Requirements

After failing twice at [setting-up-api](/setting-up-api) and not finding a good [ctr-os-4-api](/ctr-os-4-api), I've come up with a good (I think) idea of what I want the API to look like and what I want it to do.

My publishing workflow has a ton of friction, that's why I update the site like once in a year. I want to get rid of that in the *simplest way possible*. That means
1. centralizing on one note-taking system, see [why-obsi](/why-obsi)
2. making tools for that system, see [mk-bridge](/mk-bridge)

The simplest tooling I could come up with is
1. a bridge for obsidian that pushes private notes to the server and public notes to github, see [mk-bridge](/mk-bridge)
2. and a server that stores private notes, see the rest of this note

My primary requirement for the server is simplicity, so it
- runs alpine
- doesn't give me shell access
- doesn't have a container engine
- runs a single management app (the same app that serves private notes)
- is stateless, wipes the permanent files at reboot

The management app needs to
- mostly work with HTTP requests
- do basic auth (I'll use a UUID for a password with no login and regenerate it at every reboot, I mean zellij is doing that for the web portal)
- manage child processes (coturn, peerjs)
- store files
- work with WS a little

The endpoints
- `GET /status` switches to a WS with the status updates
- `POST /status?pass=...&action=...&link=...&location=...&duration=...` updates the status
- `POST /reboot?pass=...` reboots the entire server
- `POST /upgrade?pass=...` upgrades the server
- `GET /file?id=...` loads a file
- `POST /file?pass=...&id=...` saves a file

Status updates are the "Currently..." thing on my homepage.

More on the server being a backup: it kind of is. It has a copy of my vault ([why-obsi](/why-obsi), that vault), but deletes it at reboot and should not differ from any other device. The reboots ensure it doesn't get any unwanted state.

More on `GET /file?id=...`, this is exposed through https://snlx.net/secure. You go on that page, enter the UUID of a secret file, it goes to the server, requests a bunch of HTML, that HTML can contain links to other secret files which you can then visit. This is so I can have work / uni files that are accessible by a link, but not public.

## Init

I was going to try gleam, but look at what it needs to build and run:
- erlang
- gleam (obviously)
- rebar3
- git

And the build is multiple commands. I want simplicity, so I'll use deno instead. The primary thing I'm loosing is scalability, but I currently have zero users anyway so it's not a problem. I don't want to optimize for a potential future that may never come, I want to build a simple thing now.

`Deno.serve` is quite nice for simple apps like this, auth was done in no time. I'll be running this on a server without SSH, so I need a way to get the API key out of it. One reasonable way to do that is to generate a qr code, print it in the terminal, and scan it. There are a lot of libraries for deno that do that, I've just settled on the first one I found that looked okay.

File uploads were fun because I couldn't figure out if
- the `File` object can give me a readable stream (it can, `file.stream()`)
- `Deno.writeFile` would accept that stream (it would)

Then I wanted to test it, so I made a UI. Spent too much time on that tbh.

## Where did half the day go?
I didn't plan to make a UI. But... https://api.snlx.net it will make debugging a bit nicer.

## Evening 2026-01-06 update
I think the actual server is done, though I haven't deployed it yet. I'll try to get back to this 2026-01-10.

## Making the server (2026-01-10)
The bootstrap already exists, see [setting up api](https://snlx.net/setting-up-api/#:~:text=minimal%20setup) for that. I'll test that in a local VM one last time and then move on to the real thing.

I ended up running into a problem with github serving an older version of the bootstrap script, [this is a known thing](https://github.com/orgs/community/discussions/46691) and the simplest solution for me is to move the script into the main site repo. I've also made it look a bit better by adding comments [did you know ash has multiline comments?](https://stackoverflow.com/questions/43158140/way-to-create-multiline-comments-in-bash) This is a trick I like to use now, you can make a file that is interpreted in different ways by different environments:
```
: '
<h1>Html here</h1>
'

echo "and bash here"
```

The message is generated using `figlet api.snlx.net -f cybermedium`.

Now all that's left is to set up caddy.

the setup is trivial, it's just
```caddyfile
api.snlx.net {
    reverse_proxy localhost:4242
}
```

## Time to install the system
I'm choosing, get this, debian. Why? It's available on all providers and I don't need to think about it. The setup I've come up with has no containers. It has almost no moving parts. All the packages on the system are git, deno, mprocs, and caddy.

The downside is that I have ssh on the system now, so the attack surface is larger. However, the password access is disabled, so who cares.

## Or not
Yep, it's available on all providers, but it has FEWER PACKAGES THAN ALPINE, at least it doesn't have the packages *I need*.

Back to alpine then!

## Reflecting on it
Honestly, I'm pleasantly surprised by caddy. I've tested the server on a VM and it worked there, but after having issues with NGINX the last time I tried to set up the server, deploying this onto the real machine and seeing it work the first time was very nice.

The system is currently (2026-01-10) running in diskless mode, so the entire setup process looked like this:

<link rel="stylesheet" type="text/css" href="/deps/asciinema-player.css">
<div id="cast" class="asciinema"></div>
<script src="/deps/asciinema-player.min.js"></script>
<script>
  AsciinemaPlayer.create('/api-setup.cast', document.getElementById('cast'), {
    terminalFontFamily: "JetBrains Mono",
    terminalFontSize: "0.67rem",
    rows: 24,
    cols: 97,
    fit: false,
  });
</script>

By the way, I've been battling the asciinema standalone player for the past 2 hours because my base styles refused to work with it and then because I wanted to make it fit in.

## What's next?
This project is *done*, now I need to update [mk-bridge](/mk-bridge) to support secret notes and status updates, then make the frontend able to read both.