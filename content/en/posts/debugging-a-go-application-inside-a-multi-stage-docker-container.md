---
title: "Debugging a Go Application Inside a Multi Stage Docker Container"
date: 2019-07-14T11:52:42+02:00
description: "Debugging a Go Application Inside a Multi Stage Docker Container"
categories:
- golang
- debugger
- delve
- docker
---

Let's imagine that you have a microservice on sale, each of which lives in its own Dockerfile and naturally, like all adult uncles, this is a multi-stage Dockerfile. More details about multi-stage can be found in the docks (https://docs.docker.com/develop/develop-images/multistage-build/), if laziness is just a Dockerfile which has 2 FROM keywords and in we that copy it from one layer to another.

So let's go 🐎:

```bash
docker build -t goapp:latest .
Sending build context to Docker daemon 22.53kB
Step 1/7 : FROM golang AS builder
...
Successfully tagged goapp:latest
```

Every day we need to develop and debug this application: an attentive reader might suggest installing a debugger inside one of the layers. So let's add something like:

```diff
--- a/Dockerfile
+++ b/Dockerfile
@@ -1,4 +1,5 @@
FROM golang AS builder
+RUN go get -u github.com/go-delve/delve/cmd/dlv
ADD . /src
RUN cd /src && go build -o goapp
```

And then we run something like this:

```bash
docker run -it --entrypoint=dlv goapp
docker: Error response from daemon: OCI runtime create failed: container_linux.go:344: starting container process caused "exec: \"dlv\": executable file not found in $PATH": unknown.
```

And here's the bad luck, the same story will be if you have docker-compose for local development or something else. How to be)
Docker build has a wonderful --target flag!

```bash
docker build --target builder -t goapp:latest .
docker run -it goapp sh
# dlv debug main.go
could not launch process: fork/exec /src/__debug_bin: operation not permitted
```

And how to fix this ☝️, read my last post https://t.me/golang_for_two/20)

And Voila! A huge plus ⚡️ of this approach for me personally, the lack of Dockerfile-dev and options.

P.S. If you have docker-compose, then in your docker-compose.override.yml you can write like this:

```yaml
version: "3.4"
services:
app:
image: goapp:dev
build:
context: .
dockerfile: Dockerfile
target: builder
```

🎉💥🎉

P.S. final gist ->:

{{< gist andriisoldatenko 061f3f075d1aa6d93569bbbf0d60e408 >}}
