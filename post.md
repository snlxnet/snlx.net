---
tags:
  - area
created: 2025-08-11
updated: 2026-01-06
post: "[snlx.net](/snlx.net)"
layout: base.njk
---

## Context
This is my old tool ([repo](https://github.com/snlxnet/post)), now replaced by [mk-bridge](/mk-bridge).

> post simplifies publishing your markdown files

## Installation
todo

## Usage
File: `~/vault/hello.md`
```markdown
---
post: "[blog](/blog)"
---

Hello, world!
```

File: `~/vault/job-issue-512.md`
```markdown
---
post: "[work notes](/work notes)"
---

## Issue description
![attachment.png](/attachment.png)
(...)
```

All paths are absolute from the vault root (so `attachment.png` is in `~/vault/attachment.png`).

Shell:
```bash
> post ~/vault blog
~/vault/hello.md

> post ~/vault "work notes"
~/vault/job-issue-512.md
~/vault/attachment.png

> post ~/vault blog \
  rsync -av --files-from=- ~/blog/content/
```

