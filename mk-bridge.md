---
tags:
  - project
created: 2026-01-05
updated: 2026-01-10T14:48:12+03:00
up: "[snlx.net](/snlx.net)"
post: "[snlx.net](/snlx.net)"
layout: base.njk
---

bridge is a plugin that ties Obsidian.md to my site

## Which notes
Public notes are easy, they are currently marked as `post: "[snlx.net](/snlx.net)"` because I've been using [post](/post) to extract them.

My old way of dealing with private notes is marking them with `post: "[uni](/uni)"` and putting them into a separate directory with that same tool. 

The new way: if a note has a UUID in its frontmatter, post it to the secure section.

## Link resolution
- go through each linked note and see if it has a UUID or a post tag
- if it has a UUID, replace the link with `[name](/secure?id=uuid)`
- if it has a post tag, leave the link
- if it has neither, replace the link with `[name](
- /private)`

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