---
tags:
  - resource
created: 2025-06-22
updated: 2026-01-11T13:23:58+03:00
state: wip
post: "[snlx.net](/snlx.net)"
layout: base.njk
---

[xh](https://github.com/ducaale/xh) is a simple http client for the terminal *available in your package manager*.

## Verbs
```shell
# request to http://localhost:300/users
xh get :3000/users

# get
xh get httpbin.org/json
xh httpbin.org/json

# post with body: { "string": "test", "num": 42, "bool": true }
xh post httpbin.org/post string=test num:=42 bool:=true
xh httpbin.org/post key=val

# any other verb
xh delete httpbin.org/delete
```

## Sessions
```shell
export api=":3000"

xh get $api/whoami

xh --session root post $api/login email=AzureDiamond@example.com pass=hunter2
xh --session root get $api/whoami
```

Note that you can create multiple sessions at once.

## Filtering
```shell
# pipes & json filtering
xh get httpbin.org/json --body | jq -r .slideshow.slides[0].title
```

## Sources
- https://www.namtao.com/oxidise-your-cli-2025/
- https://github.com/ducaale/xh
- https://www.youtube.com/watch?v=n8sOmEe2SDg