---
tags:
  - project
created: 2025-11-26
updated: 2026-01-06
post: "[snlx.net](/snlx.net)"
layout: base.njk
---

# 2 hours
It's 2025-11-26T23:08. Cert needs to be fully functioning on 2025-11-27T09:00. I wake up at seven. *two hours*. Until release.

## What needs to work
1. generating certs from a horizontal A4 template, check
2. importing the names & emails from a CSV
3. sending the generated certs via email

## Changing the direction a bit
I was going to make an API endpoint that would ask plunk to send the email, see [setting-up-api](/setting-up-api) for more details, but
1. security is a problem (I don't want anyone sending random files from *my* server)
2. the gleam library for plunk doesn't have attachments, and
3. I have 2 hours

So the idea is to make the user create a plunk account and enter the API key, then the client app can send the emails directly.

## Log: CSV
I'll hard-code the email and name columns for now. The only thing needed with that simplification is to read the file as a string, split it into lines, split each line by comas and get 3 elements from that.

1. To read a CSV into a string, I use `new FileReader()`, then call `readAsText(file, "windows-1251")` in it. Auto-detecting the encoding would be nice, but the time is running out.
2. This file is separated by semicolons, not comas
3. Not all participants have an email or even a name!
4. Displaying an alert if a participant is broken and then moving on
5. I now have 1.5 hours left

## Log: Email
1. Plunk has a nice example for how to send them a request [here](https://docs.useplunk.com/guides/send-a-transactional-email-with-attachments)
2. I now have 1 hour left
3. The request to plunk is stuck in the "pending" status
4. It does not work on Rostelecom, weird, I'll set up my own Plunk instance later to fix this
5. But it does work in genreal!

I've sent myself a dev cert, it worked! 0.5 Hour left!