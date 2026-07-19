---
title: "Debug Distroless Images inside K8s"
date: 2026-07-19T18:46:11+02:00
description: "Debug Distroless Images on K8s using ephemeral containers"
categories:
- k8s
- debug
- distroless
- ephemeral
- containers
---

## Define a problem:

Sometimes we want to attach to a running pod and troubleshoot something from there. But it requires that image which container inside pod is running includes some tools we need ( atleast shell, and some basic linux tools: cat, grep etc. )

## How to debug k8s?

The first simple idea that came to mind is to run `kubectl exec -it <pod-name> - sh`. And if it includes shell we can navigate and do some basic checks for example ping, or check if we have permissions to create or modify files etc. 

But if the image is based on a distroless base image that won’t work. Later i’ll demonstrate error message and how to workaround it.

## What is a distroless image?


[Distroless images](https://github.com/googlecontainertools/distroless) are very small around ~2MiB (`gcr.io/distroless/static-debian13`) compare to `alpine` ~5MiB. It usually helps to follow best practice especially security scanners (e.g. CVE), because less stuff baked inside the image less chance scanner can find some outdated library or dependency, which we probably won’t even use.


## Quick demo
If you don't want to copy and create each file to follow my demo, you can clone it from:

```bash
git clone git@github.com:andriisoldatenko/debug-k8s-pods.git
```

or just create folder and add these files:


#### `cat main.go`

```go
package main

import (
	"fmt"
	"net/http"
)

func okHandler(w http.ResponseWriter, r *http.Request) {
	fmt.Fprintf(w, "OK")
}

func main() {
	http.HandleFunc("/", okHandler)
	fmt.Println("Starting server at port 8080")
	if err := http.ListenAndServe(":8080", nil); err != nil {
		fmt.Println("Server failed:", err)
	}
}
```

#### `cat go.mod`

```go
module example.com/hello

go 1.25.0
```

#### `cat Dockerfile`

```dockerfile
FROM golang:1.26 as build

WORKDIR /go/src/app
COPY . .

RUN go mod download
RUN go vet -v

RUN CGO_ENABLED=0 go build -o /go/bin/app

FROM gcr.io/distroless/static-debian12

COPY --from=build /go/bin/app /
CMD ["/app"]
```

If we build and push such an image which includes basic go web server with one endpoint:

```bash
docker build -t asoldatenko/debug-k8s-pods:1.0.0 .

docker push asoldatenko/debug-k8s-pods:1.0.0 .
```

Then we can run pod inside k8s cluster to demo (i’ll use kind for such simple demo, but we can use any k8s)

```bash
kubectl run example-pod-go --image=asoldatenko/debug-k8s-pods:1.0.0
```

Now we can make sure pod is up and running:

```bash
kubectl get pods
NAME             READY   STATUS    RESTARTS   AGE
example-pod-go   1/1     Running   0          74s
```

And it's time to attempt to use `kubectl exec` to create a shell, but it gives us an error:

```bash
kubectl exec -it example-pod-go -- sh
error: Internal error occurred: Internal error occurred: error executing command in container: failed to exec in container: failed to start exec "f2f9fac3cef6a3c00651849d434f36b73c9c1381fdae4c2e30c13c5d85de8377": OCI runtime exec failed: exec failed: unable to start container process: exec: "sh": executable file not found in $PATH
```

Boom 😡

As you can see we have a problem, that we can’t connect to the running container inside example-pod-go. So how to solve such a problem?
Starting from kubernetes 1.18 we can start [ephemeral container](https://kubernetes.io/docs/concepts/workloads/pods/ephemeral-containers/) for debugging, use the kubectl debug command:

```bash
kubectl debug -it \
  example-pod-go --target=example-pod-go \
  --image=asoldatenko/debug \
  --share-processes -- sh
```

Let’s describe pod:

```bash
kubectl get pods example-pod-go -o yaml
```

And here we have some short version of pod manifest, which includes `ephemeralContainers`:

```yaml
spec:                                 
  containers:
  - image: asoldatenko/debug-k8s-pods:1.0.0
    imagePullPolicy: IfNotPresent
    name: example-pod-go
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-ghlg5
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  ephemeralContainers:
  - command:
    - sh
    image: asoldatenko/debug
    imagePullPolicy: Always
    name: debugger-7ghqd
    resources: {}
    stdin: true
    targetContainerName: example-pod-go
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    tty: true
```

As you can see k8s uses ephemeralContainers to do a trick. 


## Summary 

If you want to debug running pods which includes containers based on distroless images you can use native ephemeral containers via `kubectl debug`
by replacing an image with our custom image (assuming image includes all we need, shell, tools etc.).