---
title: 'Custom Debug Containers'
date: 2026-07-23T19:07:45+02:00
description: "Custom image to debug on K8s clusters"
draft: false
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
- distroless
- golang
- netcat
- tshark
- openssl
- github-actions
- docker
- buildx
- podman
- alpine
- busybox
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
kubectl debug -it \
  example-pod-go --target=example-pod-go \
  --image=asoldatenko/debug \
  --share-processes -- sh
```

As you can see we can specify an image `--image=asoldatenko/debug` or `--image=busybox` to run a debug container.
So we need to make sure all tools we need to debug are included in the image. 
I have created a custom image that includes all the tools I typically use for debugging, such as `Go`, `netcat`, `tshark`, and `openssl`.

## Existing images with different tools

Alternatively, we could simply install tools during the debugging session using `apk add golang` (if using an Alpine base image), 
but this is difficult to manage and must be repeated every time.

Another approach is to use an existing image that comes pre-loaded with various tools, such as [`nicolaka/netshoot`](https://github.com/nicolaka/netshoot). 
However, you are limited to what an author has included; for example, `Go` might be missing, 
or you might need a custom tool you created.

## My debug image

To address this, I created a custom debug image `asoldatenko/debug` to solve these issues for my daily operational needs.

Example of the Dockerfile used to build the image:

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

So we can just build and push the image to DockerHub, and then use it:

```bash
docker build -t asoldatenko/debug:latest .
docker push asoldatenko/debug:latest
```

Furthermore, I wanted to automate the maintenance of this image:  add or remove new tools. 
And of course, I don’t want to do it manually (meaning I don’t want to build and push images by hand, right? We are developers lazy folks).

And last but not least, we can control what we want to include and reduce image size so debugging a little bit faster if the 
image is not cached by kubernetes, but nowadays, it’s not critical.

## Multi-platform builds and CI/CD

Important nuance, on day-to-day basis, I use a MacBook with an Apple Silicon chip (arm64 architecture), 
but the Kubernetes cluster I debug is running on AMD64 or arm architecture.

So I need to make sure the image is built for both architectures.
Since GitHub Actions are free for public repositories, I configured a workflow to automatically build and push the image whenever a PR is merged into the main branch. 
Now, a simple PR automatically renders a fresh image complete with the new tools.

More details can be found here https://github.com/andriisoldatenko/debug/blob/main/.github/workflows/docker-publish.yml#L34-L45

or tl;dr, here is the relevant snippet:
```yaml
  # Build and push Docker image with Buildx (don't push on PR)
  # https://github.com/docker/build-push-action
  - name: Build and push Docker image
    id: build-and-push
    uses: docker/build-push-action@263435318d21b8e681c14492fe198d362a7d2c83 # v6.18.0
    with:
      context: .
      platforms: linux/amd64,linux/arm64
      push: ${{ github.event_name != 'pull_request' }}
      tags: ${{ steps.meta.outputs.tags }}
      labels: ${{ steps.meta.outputs.labels }}
      cache-from: type=gha
      cache-to: type=gha,mode=max
```
This setup builds a multi-architecture image using QEMU and Docker.
This removes the burden of tracking the underlying platform architecture during troubleshooting.
While I currently target linux/amd64 and linux/arm64, this can easily be extended to support other platforms.

## Conclusion

In this post, I demonstrated how to create a custom debug container image that includes all the necessary 
tools for troubleshooting issues in Kubernetes clusters. By automating the build and push process using GitHub Actions, 
we can ensure that the image is always up-to-date with the latest tools and is available for multiple architectures. 