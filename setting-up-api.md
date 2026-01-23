---
tags:
  - project
  - archive
created: 2025-11-05
updated: 2026-01-21T23:15:51+03:00
up: "[my-infra](/my-infra)"
post: "[snlx.net](/snlx.net)"
layout: base.njk
state: done
---

# Setting up `api.snlx.net`

## The idea

### Goodbye Ubuntu!
The sever is currently running Ubuntu Noble because, well, that was one of the default images. I don't like it because of its imperative nature.

I came up with 2 options for the base system:
1. Immutable NixOS (declarative by default)
2. Diskless Alpine (diskless = immutable basically, could be made declarative by building the `.apkovl` with a script)

The second option would allow me to save some space, but it takes away the *unified config file*, which is not worth it to me.

### Why not Dokploy / Coolify?
Those are nice for deploying apps, but I don't just want a production server, I want a *devbox*. Running an immutable OS with a fully declarative config means that if I break something, I can reboot the system and forget about it. If the provider goes down, again, I can redeploy and it will be unchanged. Except the state, I'll have to manage the backups for that manually :)

### Goodbye NGINX!
Don't get me wrong, there's nothing wrong with NGINX, but... When I was reading [Gleam's guide on deploying to a Linux server](https://gleam.run/deployment/linux-server/), one of the parts that stood out to me was the use of Caddy instead of, you know, NGINX or HTTPD. The main benefit to using Caddy, as I understand it, is the ease of configuration. It has HTTPS out of the box. You don't need to think about SSL. You don't need to set up certbot, and that sounds nice.

### The Backend
I've already mentioned Gleam and I want to try using that for the new services. The admin panel is going to be interesting, though that's a topic for a future note. For now I'll just mention that the server is going to be connected to my tailnet.

Now for the existing services. https://qrs.snlx.net needs a peerjs server instance which is running in a container, no problem there. It also needs coturn which is just `services.coturn.enable = true;`.

https://github.com/snsalx/sld is running a custom container image that has 2 exposed ports. The start command used to be:
```bash
docker run -p 3000:3000 -p 8090:8090 -e BACKEND_URL="https://sld-backend.snlx.net" -v sld:/pb/pb_data sld:latest
```

So the new config should run a container that:
- publishes port 3000 to 8089 (since I'll need 3000 for development)
- publishes port 8090
- sets `BACKEND_URL` to `https://pb.api.snlx.net`
- mounts a volume

Another thing I need to do with it is close down registration. Right now (morning of 2025-11-04) anyone can upload images, and the storage is unlimited.

### Containers
This node is both my prod server and my devbox.

As a prod server, it needs to run the containers declared in the system config. This can be set up using `virtualisation.oci-containers`.

As a devbox, it needs to run containers without root permissions. This can be done imperatively (just using the podman CLI).
## Attempt 0
What I've learned:
1. installing NixOS on a device with 1 core and a gig of RAM is kinda fun if you do it remotely through `nixos-anywhere`
2. what isn't fun is running `nixos-rebuild` on that same limited system
3. and if you install the unstable version it won't let you rebuild lower than the `system.stateVersion`
4. and if you force it to rebuild, you can say goodbye to your bootloader. It did warn me :)
5. my VPS provider *does* allow booting from and installation CD, but the boot order is set up so that it first tries the disk. Wiping the bootloader on the disk (or the entire disk, for that matter), makes it boot from the CDROM

See [dynamic-attempt-1-log](/dynamic-attempt-1-log) for more details.

## Attempt 1
The plan is to use diskless alpine this time. It is tiny, immutable by default and NOT declarative. Although...

Since I need an API server anyway, I can put it on the OS directly, no container and make an endpoint that check GitHub for updates, pulls them and *sets up containers* with a compose file, *making it declarative*.

There are 3 components to this
### The Bootstrap Script
This is a shell script that can be `curl | sh`'ed. It installs the erlang runtime, installs zellij, clones the server repo, adds zellij with it to boot and starts them.

I want to be a bit more careful and do it in a VM so I can iterate quicker.

### The github action
It tells the server to update itself.

### The first endpoint
The first endpoint is `api.snlx.net/update`, it downloads the repo, builds it and restarts the server.

I'll use [wisp](https://github.com/gleam-wisp/wisp/tree/main) for the API framework because *popularity matters*, meaning I'm more likely to be able to find resources. The runtime will be `erlang`, its concurrency model is one of the reasons I chose gleam in the first place, though I won't use that part much for now to save time.

For actually running the update I'm using the [shellout](https://github.com/tynanbe/shellout) library to run a `git pull`. Long-term the server should be hot-loaded by erlang, but I need to get this running quickly, so I'll wrap the server in mprocs and make it send a restart command.

### Minimal setup
To configure a new server: 1) boot into alpine and 2) type
```shell
root
setup-interfaces -ar && wget snlx.net/api && sh api
```

### The first *actual* endpoint
`api.snlx.net/mail` is an unauthenticated endpoint that requires you to provide the SMTP credentials in the request body and then uses them to send the given emails to the given server.

Or I wanted it to. It didn't work, I couldn't make yandex accept my auth credentials. Fine, I'll try plunk and remove the requirement of SMTP credentials. May as well use something like emailjs, but its free tier is way worse and if I exceed plunk's free tier, I can self-host it.

Unfortunately, the plunk gleam library does not support attachments, so I'll have to encode them myself. Or... [2-hours](/2-hours)