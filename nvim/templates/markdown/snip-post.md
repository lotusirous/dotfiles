---
layout: layouts/post.njk
title: {{_expr_:substitute(matchstr(expand("%:p:t:r"), '^[0-9-]\+\zs.*'), '[-_]', ' ', 'g')}}
date: {{_expr_:strftime('%Y-%m-%d', localtime())}}
description: How to Detect Byte Order in Go.
tags:
  - "golang"
---
{{_cursor_}}
