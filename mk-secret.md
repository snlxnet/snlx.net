---
tags:
  - project
updated: 2026-01-11T14:08:10+03:00
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
- `snlx.net/404.html` that reads it and makes the requset
- `GET api.snlx.net/find?name=...&among=...,...`

## Tweaking what I have
- The links to private notes [were being replaced with UUIDs](https://github.com/snlxnet/bridge/commit/4e28e005d609eceb86d9dc5b0b86ef76ac917b0e)