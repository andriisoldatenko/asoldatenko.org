---
title: "k8s"
weight: 1
date: 2024-01-25
categories:
  - k8s
---

## [The Almighty Pause Container](https://www.ianlewis.org/en/almighty-pause-container)

From the article:
> In Kubernetes, the pause container serves as the “parent container” for all of the containers in your pod. The pause container has two core responsibilities. First, it serves as the basis of Linux namespace sharing in the pod. And second, with PID (process ID) namespace sharing enabled, it serves as PID 1 for each pod and reaps zombie processes.

```bash
kubectl debug node/debug-kind-control-plane -it --image=asoldatenko/debug
ps | grep pause
  229 root      0:39 /usr/bin/kubelet --bootstrap-kubeconfig=/etc/kubernetes/bootstrap-kubelet.conf --kubeconfig=/etc/kubernetes/kubelet.conf --config=/var/lib/kubelet/config.yaml --container-runtime=remote --container-runtime-endpoint=unix:///run/containerd/containerd.sock --node-ip=172.18.0.2 --node-labels= --pod-infra-container-image=registry.k8s.io/pause:3.8 --provider-id=kind://docker/debug-kind/debug-kind-control-plane --fail-swap-on=false --cgroup-root=/kubelet
  574 65535     0:00 /pause
  578 65535     0:00 /pause
  587 65535     0:00 /pause
  593 65535     0:00 /pause
  909 65535     0:00 /pause
  993 65535     0:00 /pause
 1144 65535     0:00 /pause
 1155 65535     0:00 /pause
 1318 65535     0:00 /pause
 1512 65535     0:00 /pause
 2453 65535     0:00 /pause
 2509 root      0:00 grep pause
```

Source code of pause container: [pause.c](https://github.com/kubernetes/kubernetes/blob/master/build/pause/linux/pause.c).

Quoting from [What is the role of 'pause' container?](https://groups.google.com/forum/#!topic/kubernetes-users/jVjv0QK4b_o):

> The pause container is a container that holds the network namespace for the pod. It does nothing 'useful'. (It's actually just a little bit of assembly that goes to sleep and never wakes up)
> This means that your 'apache' container can die and come back to life, and all of the network setup will still be there. Normally if the last process in a network namespace dies the namespace would be destroyed and creating a new apache container would require creating all new network setup. With pause, you'll always have that one last thing in the namespace.

## [Kubernetes 1.27: Quality-of-Service for Memory Resources (alpha)](https://kubernetes.io/blog/2023/05/05/qos-memory-resources/)

`spec.containers[].resources.requests`

> When you specify the resource request for containers in a Pod, the Kubernetes scheduler uses this information to decide which node to place the Pod on. The scheduler ensures that for each resource type, the sum of the resource requests of the scheduled containers is less than the total allocatable resources on the node.

`spec.containers[].resources.limits`

> When you specify the resource limit for containers in a Pod, the kubelet enforces those limits so that the running containers are not allowed to use more of those resources than the limits you set.

### Random favorite links

- https://hrishi.dev/kubernetes,/client-go/2020/11/24/mock-the-watch-api.html
- https://gist.github.com/peter-wangxu/a22269b0978ad79ccedb2e13f8e8b9ac
- https://www.freecodecamp.org/news/the-kubernetes-handbook/
- https://kubebyexample.com/
- https://github.com/omerbsezer/Fast-Kubernetes
- https://github.com/ContainerSolutions/kubernetes-examples
- https://github.com/ContainerSolutions/k8s-deployment-strategies
- https://devopscube.com/create-helm-chart/
- https://github.com/stefanprodan/podinfo/blob/master/cmd/podinfo/main.go
- https://learnk8s.io/production-best-practices
