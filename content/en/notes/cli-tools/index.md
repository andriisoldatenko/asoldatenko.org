---
title: "cli tools"
weight: 1
date: 2024-01-25
categories:
  - cli
  - tools
  - command line tools
---

## This is collection of my favorite cli tools with examples

### [peco](#peco)

[Simplistic interactive filtering tool](https://github.com/peco/peco)

```bash
brew install peco
```

```bash
ps aux | peco

QUERY> podman                                                                                                               IgnoreCase [6 (1/1)]
andrii.soldatenko 24073   6.6 11.0 426452256 7408464 s002  S    Tue10AM  65:10.24 /opt/homebrew/bin/qemu-system-aarch64 -m 15735 -smp 4 -fw_cfg
andrii.soldatenko  1891   0.7  0.3 1588596992 219008   ??  S    10Jan24 104:40.87 /Applications/Podman Desktop.app/Contents/MacOS/Podman Desktop
andrii.soldatenko 24066   0.0  0.1 409920528  49888 s002  S    Tue10AM   0:46.81 /opt/homebrew/Cellar/podman/4.8.3/libexec/podman/gvproxy -mtu 1
andrii.soldatenko  1987   0.0  0.3 1596580736 176496   ??  S    10Jan24   8:30.44 /Applications/Podman Desktop.app/Contents/Frameworks/Podman De
andrii.soldatenko  1984   0.0  0.1 409391136  36000   ??  S    10Jan24   0:04.50 /Applications/Podman Desktop.app/Contents/Frameworks/Podman Des
andrii.soldatenko  1983   0.0  0.1 410238016  82336   ??  S    10Jan24   0:06.02 /Applications/Podman Desktop.app/Contents/Frameworks/Podman Des
```
