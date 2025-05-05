---
title: "Build amd64 images using podman 5.3.x and 5.4.x on OSX with arm64"
date:  2025-01-14T11:53:58+01:00
description: "Podman Osx Arm64 Build Linux Amd Images"
toc: false
categories:
- podman
- podman-desktop
- osx
- rosetta
- arm64
- images
- amd64
- sequoia
---

> UPDATE: for podman 5.4.x version

```bash
brew upgrade podman
podman --version
5.4.2
```

New image from https://builds.coreos.fedoraproject.org/browser?stream=stable&arch=x86_64, because default one still
doesn't work for me:

```bash
podman machine init podman-machine-custom --disk-size 60 \
  --rootful --cpus=4 \
  --memory=8192 \
  --image https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/42.20250410.3.2/aarch64/fedora-coreos-42.20250410.3.2-applehv.aarch64.raw.gz
```


## Problem

You like me to want to use podman on OSX (15.2 Sequoia) and build images for `--platform=linux/amd64` :)

Welcome to my world!

### Make sure you install rosetta

[what is Rosetta?](https://en.wikipedia.org/wiki/Rosetta_(software)):
>Rosetta is a dynamic binary translator developed by Apple Inc. for macOS, an application compatibility layer between different instruction set architectures. It enables a transition to newer hardware, by automatically translating software. The name is a reference to the Rosetta Stone, the artifact which enabled translation of Egyptian hieroglyphs.[2]

```bash
softwareupdate --install-rosetta
```

more details you can find in podman-desktop docs [Native Apple Rosetta translation layer](https://podman-desktop.io/docs/podman/rosetta).

#### podman info

```bash
$ podman info
Client:       Podman Engine
Version:      5.3.1
API Version:  5.3.1
Go Version:   go1.23.4
Git Commit:   4cbdfde5d862dcdbe450c0f1d76ad75360f67a3c
Built:        Thu Nov 21 14:40:20 2024
OS/Arch:      darwin/arm64

Server:       Podman Engine
Version:      5.3.1
API Version:  5.3.1
Go Version:   go1.22.7
Built:        Thu Nov 21 01:00:00 2024
OS/Arch:      linux/arm64
```

#### podman init machine

```bash
podman machine init --disk-size 60 \
  --rootful --cpus=4 \
  --memory=8192 \
  --image https://builds.coreos.fedoraproject.org/prod/streams/stable/builds/40.20241019.3.0/aarch64/fedora-coreos-40.20241019.3.0-applehv.aarch64.raw.gz
```

if you are using the default image from the release page (for me, it didn't work for complicated image)!.

> Reasonable question: how did I find the correct image?

First, I've tried fedora coreOS image directly instead of default image for `podman machine init`, and later
if found its similar image to [podman-machine.aarch64.applehv.raw.zst](https://github.com/containers/podman/releases/download/v5.3.1/podman-machine.aarch64.applehv.raw.zst).
Then I just pulled regular one, with the same version as podman 3.5.1.

#### Now we can check which podman machine we just created (don't forget to run `podman machine start`)

```bash
$ podman machine info
host:
    arch: arm64
    currentmachine: podman-machine-custom
    defaultmachine: ""
    eventsdir: /var/folders/1x/rxqwb15s7l97hwq760gc75dc0000gq/T/storage-run-503/podman
    machineconfigdir: /Users/andrii.soldatenko/.config/containers/podman/machine/applehv
    machineimagedir: /Users/andrii.soldatenko/.local/share/containers/podman/machine/applehv
    machinestate: Running
    numberofmachines: 2
    os: darwin
    vmtype: applehv
version:
    apiversion: 5.3.1
    version: 5.3.1
    goversion: go1.23.4
    gitcommit: 4cbdfde5d862dcdbe450c0f1d76ad75360f67a3c
    builttime: Thu Nov 21 14:40:20 2024
    built: 1732196420
    osarch: darwin/arm64
    os: darwin
```

### Next, if you see a problem during podman build while pulling images

```text
Error: short-name "go:latest" did not resolve to an alias and no unqualified-search registries are defined in "/etc/containers/registries.conf"

// or

Error: short-name resolution enforced but cannot prompt without a TTY
```

You need to ssh to machine and update `containers/registries.conf` config:

```bash
podman machine ssh
```

create dir if it doesn't exist and add config:

```bash
root@localhost:~$ mkdir -p $HOME/.config/containers/
root@localhost:~$ vi $HOME/.config/containers/registries.conf
```

with content:

```bash
short-name-mode="permissive"
unqualified-search-registries = ['docker.io']
```

For more details about configuring registries you can find in official documentations https://github.com/containers/image/blob/main/docs/containers-registries.conf.5.md.

### Conclusion

Now you can build images using `podman build --platform='linux/amd64'` using you local
Mac with arm64 architecture and deploy to kubernetes with amd64 ;)
