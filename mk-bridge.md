---
tags:
  - project
created: 2026-01-05
updated: 2026-02-03T11:40:33+03:00
up: "[snlx.net](/snlx.net)"
post: "[snlx.net](/snlx.net)"
layout: base.njk
state: wip
---

bridge is a plugin that ties Obsidian.md to my site

## Which notes
Public notes are easy, they are currently marked as `post: "[snlx.net](/snlx.net)"` because I've been using [post](/post) to extract them.

My old way of dealing with private notes is marking them with `post: "[uni](/uni)"` and putting them into a separate directory with that same tool. 

The new way: if a note has a UUID in its frontmatter, post it to the secure section.

## Link resolution
- go through each linked note and see if it has a UUID or a post tag
- if it has a UUID, replace the link with `[name](/secure?id=uuid)`
- otherwise leave the link

## Publishing
The notes are sorted into secret and public
- secret are sent to the API, see [mk-api](/mk-api)
- public are sent to the github API

## How to even make a plugin
You clone the obsidian-sample plugin and then rely on the plugin developer docs and typescirpt intellisense to find the APIs you need.

## GitHub API?
I thought that would be easy. Silly me. The [obsidian-digital-garden project](https://github.com/oleeskild/obsidian-digital-garden) already does a similar thing and is licensed under MIT, so I've decided to check out how they are doing it. They are [using](https://github.com/oleeskild/obsidian-digital-garden/blob/main/src/repositoryConnection/RepositoryConnection.ts#L282) octokit to make a new commit from individual files.

I've copied to commit logic, tweaking it a bit to my format and I'm delighted to say that it works! That's it for today (2026-01-05), the main tasks for tomorrow are
- making uploads lazy (currently it re-uploads all files even if they haven't changed and this is painful for images)
- implementing (at least in part) the secret note publishing

## How do I even do lazy uploads?
To do lazy uploads I need to know when the file changed here and when it last changed on the server. For the sake of not making more requests than I strictly need, I'll store the last upload datetime of each file in the vault.

So I create a file called `bridge-sys` that uses frontmatter to store filenames as keys, their last update as of the last upload as values. Then the plugin can compare the actual last update to the last update as of last upload and re-upload if that has changed.

## Linked projects are fun!
I've implemented (by 2026-01-06 1PM) the github uploads and now I want to do the rest, but to do the rest I first need to finish [mk-api](/mk-api), switching to that!

## Evening 2026-01-06 update
I'm now using this in my primary vault! The secret notes still don't work because the API is done but not deployed, though.

This very update was pushed using the plugin!

## 2026-01-07 update
I'm using syncthing to keep the vault on my phone & tablet up to date. Running the publish action on mobile results in a full re-upload of everything. That means I need it to rely on the frontmatter updated field instead of the file stats and switch that field to full ISO datetime.

I don't need *my* plugin to update that field as there's already [a plugin for that](obsidian://show-plugin?id=frontmatter-modified-date).

## That wasn't the issue
It's 2026-01-10 I've found out that I told it to update the file no matter if it was changed or not. Still, I like having the update field be more precise, so I'll keep the change with that plugin.

(testing the changes, this line was added on my phone)

And it didn't work. The phone tried to update all images, which takes a while. And that means

## It *was* part of the problem
I don't think there's any real way to add metadata to random files (aside from HTML comments, that would break if I ever added a raster image), so the best option seems to be to compare the updated dates with some margin for sync. Everything usually syncs within a minute at most, so I'll make the wait window 15 minutes just to be sure.

(writing this on my phone to test it) sidenote: I'm not currently using a pomodoro because my timer was running in Obsidian and i need to reload Obsidian to test the plugin. So the timer got stopped and the new one (just a timer on my phone) doesn't switch to break automatically and I keep snoozing it. Dumbest problem ever.

Oh wow [I may have a problem here](https://github.com/snlxnet/snlx.net/commit/e167d55804da7bf2300e8900026a049ea698fb56). The plugin on mobile updated all files. Even though I told it not to. Well, I've added datetime update dates (I don't know how to say that) on all files to see if pushing tomorrow will touch those dates. It shouldn't.

## And now with the API done
2026-01-11 It's time to implement secret note uploading in the plugin. I mean, it *should* be a simple POST request. What could go wrong?

Oh of course I would run into CORS. I've added a snippet from [caddy docs](https://caddyserver.com/docs/caddyfile/directives/import) to my config, now Obsidian gets a 200 OK with status CORS error.

The access control header is not found in the response. That's weird. Rebooting the entire server just to be sure.

Same issue. Ah yes of course I did:
```
api.snlx.net {
	import cors example.com
	reverse_proxy localhost:4242
}
```

With the allow origin header set everything is done and is working! I'm moving the updated plugin build to my primary vault.

## Secret notes
Continued in [mk-secret](/mk-secret).

## Backlinks & Redesign
I've had a pretty good idea of how the site should look like, like, 2 years ago? Then I forgot about it. A few weeks ago, I've found a sketch in the archives and wanted to finally bring it to life.

The plugin [now](https://github.com/snlxnet/bridge/tree/9ae9ea9bdac8f81a4253ca5b8cab1593a52c3265) outputs HTML directly, rendered by Obsidian. This means that callouts are now easier to implement and typst math blocks finally work. I'll get back to this within the week (maybe even today) & make it output both HTML & MD so that the source files are downloadable, too. And I need to add redirects.

I may also put private links into the public garden, I don't know yet. They will obviously still not work, but they may be useful for those who do have access.