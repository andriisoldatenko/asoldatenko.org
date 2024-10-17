---
title: "Debugging Golang With Delve"
date: 2019-02-05
description: "Debugging Golang With Delve"
categories:
- golang
- debugger
- delve
---

# How to debug golang code

Yes, the Go code can and should be debugged. I often clash in different teams, as developers, so far in 2019! debug with prints :)

Delve is the debugger that I usually use every day. If you open the documentation, it's not perfect to say the least.

You can install it:

```bash
go get -u github.com/go-delve/delve/cmd/dlv
```

Most often I use dlv debug <package name>:

```bash
dlv debug github.com/andriisoldatenko/go-blog
```
or

```bash
dlv debug main.go
(dlv) breakpoint main.go:1
(dlv) continue
```

After you have set the breakpoint, you can click continue and the program will stop where needed, and so on. There are also shortcuts (b, c, l and so on).
