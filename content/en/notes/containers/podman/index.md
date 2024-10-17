---
title: "podman"
weight: 1
date: 2024-02-07
categories:
  - podman
---

### Random favorite links:

- [Running amd64 docker images with Podman on Apple Silicon (M1)](https://edofic.com/posts/2021-09-12-podman-m1-amd64/)
tl;dr
```bash
podman machine ssh
sudo -i
rpm-ostree install qemu-user-assets
systemctl reboot
podman run --rm -it docker.io/amd64/alpine:3.14 sh
```