---
title: "Debugging a Go Application Inside a Docker Container"
date: 2019-07-09T11:44:02+02:00
description: "Debugging a Go Application Inside a Docker Container"
categories:
- golang
- debugger
- delve
- docker
- docker-compose
---


So we need:
straight arms and basin with docker preinstalled:

```
$ cat Dockerfile
FROM golang:1.13

WORKDIR /go/src/app
COPY . .

RUN go get -u github.com/go-delve/delve/cmd/dlv

CMD ["app"]
```

$ docker build -t my-golang-app .


This is just one of the options, sometimes you need to start dlv instead of bash and so on.

```
$ docker run -it --rm my-golang-app bash

$ root@03c1977b1063:/go/src/app# dlv main.go
Error: unknown command "main.go" for "dlv"
Run 'dlv --help' for usage.
root@03c1977b1063:/go/src/app# dlv debug main.go
could not launch process: fork/exec /go/src/app/__debug_bin: operation not permitted
```


OOps...

So let's add the parameters:

```
$ docker run -it --rm --security-opt="apparmor=unconfined" --cap-add=SYS_PTRACE my-golang-app bash
```

voila 🎉

```
$ root@7dc3a7e8b3fc:/go/src/app# dlv debug main.go
Type 'help' for list of commands.
(dlv)
```
P.S. same trick can be used with `docker-compose` or multi-stage builds. If you are interested in how to debug multi-stage builds on Go, please put “+” in the comments or throw a tomato 🍅.
