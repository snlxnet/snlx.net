---
tags:
  - project
updated: 2026-01-11T20:33:14+03:00
created: 2026-01-11T13:43:01+03:00
post: "[snlx.net](/snlx.net)"
state: wip
layout: base.njk
---

## The plan
- `/secret` presents a form
- you enter a UUID there
- the page saves it to localstorage and requests the given file
- then reads its name and redirects you to a page with that name

Notes link to a secret note by its name, not its UUID. Of course, that means that GitHub will return a 404 page:
- the 404-page requests the page by name from the API, providing the list of UUIDs it knows
- the finds the files with those UUIDs and scans all links going out of them to find a note with the given name
- if it fails, it sends back a 404
- otherwise it returns the page

So I need 3 parts:
- `snlx.net/secret` that saves the UUID
- `snlx.net/404.html` that reads it and makes the request
- `GET api.snlx.net/find?name=...&among=...,...`

## Tweaking what I have
- The links to private notes [were being replaced with UUIDs](https://github.com/snlxnet/bridge/commit/4e28e005d609eceb86d9dc5b0b86ef76ac917b0e)
- The note names [were lost in secret notes](https://github.com/snlxnet/bridge/commit/458627162c3599f6e7b29df4eed4e4a72751a8d5)

## Implementing the server logic
I'm writing it AFTER the actual logic, so I'll just link [the current version](https://github.com/snlxnet/api/commit/359ad754113631601a79ccadd6f1c393374d1bcf) and say that I want to refactor it. Eventually, now I just need to get the rest of the system working :)

## The secret page

## 404
Eleventy tried to make it hard by creating `404/index.html` instead of `404.html`. Fortunately, there's a solution in their docs, you simply

```html
---
permalink: 404.html
---
```

I also want to change the logo colors to something orange when a secret note is loaded, that can be done with `element.style.setProperty("--var", "val")`.