+++
title = 'Podman OSX Arm64 Build C Go'
date = 2025-04-29T09:21:11+02:00
draft = true
+++


# Introduction

We have basic go program which has some C dependency, so we need to complie it using `CGO=1`.


## Problem

We have podman running on dev machine (at time of writing typically is OSX with arm architecture):

```
uname -a | tr ";" "\n"
Darwin hostname 24.4.0 Darwin Kernel Version 24.4.0: Wed Mar 19 21:16:34 PDT 2025; 
root:xnu-11417.101.15~1/RELEASE_ARM64_T6000 arm64
```

and podman:

```bash
podman version 

Client:       Podman Engine
Version:      5.3.1
API Version:  5.3.1
Go Version:   go1.23.4
Git Commit:   4cbdfde5d862dcdbe450c0f1d76ad75360f67a3c
Built:        Thu Nov 21 14:40:20 2024
OS/Arch:      darwin/arm64

Server:       Podman Engine
Version:      5.2.4
API Version:  5.2.4
Go Version:   go1.22.7
Built:        Mon Oct  7 02:00:00 2024
OS/Arch:      linux/arm64
```


## CGo simple example:
```go
package main

// int c = 1;
import "C"
import (
	"fmt"
)

func main() {
	fmt.Println(C.c)
}

```


## Findings