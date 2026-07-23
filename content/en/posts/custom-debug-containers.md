---
title: 'Custom Debug Containers'
date: 2026-07-23T19:07:45+02:00
description: "Custom image to debug on K8s clusters"
categories:
- k8s
- qemu
- multi-arch
- linux
- amd
- arm
- debug
- ephemeral
- containers
---

## Intro

In my [previous post](./debug-distroless-images-on-k8s.md), I wrote about how to run a debug ephemeral container to troubleshoot distroless images in Kubernetes. I also mentioned that we can use a custom image to override a distroless image, allowing us to run specific troubleshooting tools. 
In this post, I will demonstrate how to set up a custom debug container and explain why it is beneficial to do so.

## Problem
Assuming we want to debug an issue within a Kubernetes cluster, we generally have two options:

Run a pod, attach to it, and perform quick checks or run specific tools:

```bash
kubectl run --rm -it busybox --image=busybox --restart=Never -- sh
If you don't see a command prompt, try pressing enter.
/ #
```

Or, run an ephemeral debug container:

```bash
kubectl debug
```

As you can see, if we require a specific tool - such as `Go`, `netcat`, `tshark`, or `openssl` to check certificates - we need 
to find a specialized image that already has that binary installed.

## Existing solutions 

Of course, we could simply install tools during the debugging session using `apk add golang` (if using an Alpine base image), 
but this is difficult to manage and must be repeated every time.

Another approach is to use an existing image that comes pre-loaded with various tools, such as nicolaka/netshoot. 
However, you are limited to what the author has included; for example, `Go` might be missing, or you might need a proprietary tool unique to your project.

## My solution

To address this, I created a custom debug image tailored to my daily operational needs:

```Dockerfile
# source from https://github.com/andriisoldatenko/debug/blob/main/Dockerfile

FROM alpine:3.22.2

RUN apk update && \
    apk add --no-cache \
    # build/code
    build-base git go delve bash bash-completion ncurses vim tmux jq \
    # db
    sqlite \
    # Tracks runtime library calls in dynamically linked programs
    ltrace \
    # Diagnostic, debugging and instructional userspace tracer
    strace \
    # The GNU Debugger
    gdb \
    # network
    bind-tools iputils tcpdump curl nmap tcpflow iftop net-tools mtr netcat-openbsd bridge-utils iperf ngrep \
    && rm -rf /var/lib/apt/lists/*

ENTRYPOINT bash
```

Furthermore, I wanted to automate the maintenance of this image:  add or remove new tools, 
i don’t want to do it manually (meaning i don’t want to build and push images by hand, right? We are developers lazy folks).

And last but not least, theoretically I can reduce image size so debugging a little bit faster if the 
image is not cached by kubernetes, but nowadays it’s not critical.

## Multi platform builds and CI/CD

Since GitHub Actions are free for public repositories, I configured a workflow to automatically build and push the image whenever a PR is merged into the main branch. 
Now, a simple PR automatically renders a fresh image complete with the new tools.

More details can be found here https://github.com/andriisoldatenko/debug/blob/main/.github/workflows/docker-publish.yml#L34-L45

As a bonus, this setup builds a multi-architecture image using QEMU and Docker.
This removes the burden of tracking the underlying platform architecture during troubleshooting.
While I currently target linux/amd64 and linux/arm64, this can easily be extended to support other platforms.

