---
updated: 2026-02-02T23:02:43+03:00
created: 2026-01-30T18:45:32+03:00
post: "[snlx.net](/snlx.net)"
state: idea
tags:
  - project
layout: base.njk
---

## Purpose
- fleeting notes
- status updates
- for public comments?

## Log
It turns out making bots like this for yourself is way too easy. I won't even put it on GitHub properly, here's the source:
```ts
import { Bot } from "https://deno.land/x/grammy@v1.39.3/mod.ts";

const bot = new Bot(process.env.TOKEN);
const owner = process.env.OWNER

bot.on("message", (ctx) => {
  const text = ctx.message.text
  const user = ctx.message.chat.username

  if (!user) {
    ctx.reply("Sorry, but you don't have a username, so I can't save your note.")
    return
  }

  if (text === "/start") {
    ctx.reply("Hi! Send a message to save it as a fleeting note. It will be deleted from here to keep the history clean")
  }

  // status updates
  if (text.startsWith(":")) {
    if (user !== owner) {
      ctx.reply("Remove the | at the beginning")
      return
    }

    const [action, location] = text.slice(1).split("@").map(part => part.trim())
    console.log({action, location})
  } else {
    const sanitized = text.replaceAll(" ", "-")
      .replace(/[^\wа-яА-Я \-]/gm, "")
      .slice(0, 64)
      .toLowerCase()
    const name = "bot-" + sanitized + ".md"
    const body = new Date() + " from t.me/" + user + "\n#fleeting ::\n\n" + text

    Deno.writeTextFileSync(name, body)
    console.log("Saved", name)
  }

  ctx.react("⚡")
  setTimeout(() => ctx.deleteMessage(), 30 * 1000)
});

bot.start();
```

It's that simple. I've moved it into the vault and starting from terminal with deno. I'll probably wrap it in an obsidian plugin later to make it a bit easier to host though. For now it's running with

```bash
deno run --watch --allow-import --allow-net --allow-env --allow-write bot.ts
```