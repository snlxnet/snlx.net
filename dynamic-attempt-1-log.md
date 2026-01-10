---
tags:
  - resource
  - archive
created: 2025-11-04
updated: 2026-01-10
up: "[setting-up-api](/setting-up-api)"
post: "[snlx.net](/snlx.net)"
layout: base.njk
---

### Flakes?
Flakes mean that I can't have unattended updates. I want unattended updates. So no, no flakes. I'll enable the support, but the system is going to be the regular old 2 files.

### Setting it all up
I could make a local VM and configure everything there, but there are 0 active users on the site, so I'll do it in prod.
```bash
alex@snlx:~$ docker ps --format json
{"Command":"\"docker-entrypoint.s…\"","CreatedAt":"2025-05-13 10:10:13 +0300 MSK","ID":"ef8bbd96e694","Image":"sld:latest","Labels":"","LocalVolumes":"1","Mounts":"sld","Names":"zen_aryabhata","Networks":"bridge","Platform":null,"Ports":"0.0.0.0:3000-\u003e3000/tcp, [::]:3000-\u003e3000/tcp, 0.0.0.0:8090-\u003e8090/tcp, [::]:8090-\u003e8090/tcp","RunningFor":"5 months ago","Size":"0B","State":"running","Status":"Up 4 months"}
{"Command":"\"hbbr\"","CreatedAt":"2025-05-10 16:01:18 +0300 MSK","ID":"0a34a0cb1521","Image":"rustdesk/rustdesk-server","Labels":"org.opencontainers.image.created=2025-01-25T12:55:10.112Z,org.opencontainers.image.description=RustDesk Server Program,org.opencontainers.image.licenses=AGPL-3.0,org.opencontainers.image.revision=8557c4ab8259a9084879ad78a41c5a9539fd75a3,org.opencontainers.image.source=https://github.com/rustdesk/rustdesk-server,org.opencontainers.image.title=rustdesk-server,org.opencontainers.image.url=https://github.com/rustdesk/rustdesk-server,org.opencontainers.image.version=1.1.14","LocalVolumes":"0","Mounts":"/home/alex/data","Names":"hbbr","Networks":"host","Platform":null,"Ports":"","RunningFor":"5 months ago","Size":"0B","State":"running","Status":"Up 8 weeks"}
{"Command":"\"hbbs\"","CreatedAt":"2025-05-10 16:01:01 +0300 MSK","ID":"13810139d247","Image":"rustdesk/rustdesk-server","Labels":"org.opencontainers.image.created=2025-01-25T12:55:10.112Z,org.opencontainers.image.description=RustDesk Server Program,org.opencontainers.image.licenses=AGPL-3.0,org.opencontainers.image.revision=8557c4ab8259a9084879ad78a41c5a9539fd75a3,org.opencontainers.image.source=https://github.com/rustdesk/rustdesk-server,org.opencontainers.image.title=rustdesk-server,org.opencontainers.image.url=https://github.com/rustdesk/rustdesk-server,org.opencontainers.image.version=1.1.14","LocalVolumes":"0","Mounts":"/home/alex/data","Names":"hbbs","Networks":"host","Platform":null,"Ports":"","RunningFor":"5 months ago","Size":"0B","State":"running","Status":"Up 6 weeks"}
{"Command":"\"node peerjs.js\"","CreatedAt":"2025-04-13 16:17:24 +0300 MSK","ID":"1c976b1b3b95","Image":"peerjs/peerjs-server","Labels":"","LocalVolumes":"0","Mounts":"","Names":"pedantic_moser","Networks":"bridge","Platform":null,"Ports":"0.0.0.0:9000-\u003e9000/tcp, [::]:9000-\u003e9000/tcp","RunningFor":"6 months ago","Size":"0B","State":"running","Status":"Up 4 months"}
alex@snlx:~$ uptime
 11:05:17 up 204 days, 17:06,  0 user,  load average: 0.00, 0.00, 0.00
alex@snlx:~$ sudo poweroff
[sudo] password for alex:

The system will power off now!

Goodbye, Ubuntu!
```

My VPS provider gives me an option to select a custom image. Unfortunately, the VM keeps booting into the installed OS rather that the ISO, so I'll try `nixos-anywhere`. Hello, Ubuntu :)

NixOS anywhere expects me to bootstrap the config on my machine and then deploys it via ssh. The system disk is called sda1, not vda.

I'll start with a regular mutable OS. I wanted to go full tmpfs root right from the start, but that's a problem because the box has a gig of RAM.

Running the command, I get `Out of memory: Killed process 1851 (kexec)`. Of course I do. Stopping:
- containerd
- coturn
- snapd
- docker
- multipathd

Well that helped. Goodbye Ubuntu!

It's been stuck on "Deleting garbage" for about 16 minutes now. I've tried to run `free -h` in its console and it's not responding. Poor machine. Don't know what else I expected from a node with 1 vCPU and a gig of RAM. Okay, waiting.

I let the server sit there for about 5 hours. It failed with another out-of-memory error. I'll try to reinstall from the UI again.

Oh, they had a [docs page on this issue the whole time](https://github.com/nix-community/nixos-anywhere/blob/main/docs/howtos/limited-ram.md). And that worked beautifully. Well, great to know.
```bash
[root@nixos:~] # Hello, NixOS

[root@nixos:~] ls /etc/nixos

[root@nixos:~] # Oh yeah, right, the config isn't on the server at all. Okay, let's start from scratch then

[root@nixos:~] nixos-generate-config
writing /etc/nixos/hardware-configuration.nix...
writing /etc/nixos/configuration.nix...
For more hardware-specific settings, see https://github.com/NixOS/nixos-hardware.

[root@nixos:~] cd /etc/nixos

[root@nixos:/etc/nixos] nix-shell --extra-experimental-features flakes -p helix
(cut)

[nix-shell:/etc/nixos] git init
(cut)

[nix-shell:/etc/nixos] git branch -m main

[nix-shell:/etc/nixos] git add .

[nix-shell:/etc/nixos] hx configuration.nix
```

Quick update: I can't rebuild the system. It's using flakes and refusing to build without them. And why is it using flakes? Because I installed it with flake support... The fix is:
```bash
nix-build '<nixpkgs/nixos>' -A config.system.build.toplevel -I nixos-config=./configuration.nix --extra-experimental-features flakes
./result/activate
nixos-rebuild boot
```

(2 hours later) That was fun but I think I accidentally broke the bootloader and the thing booted into THEIR image. Going to install it like normal now. Root on tmpfs, 100m max.