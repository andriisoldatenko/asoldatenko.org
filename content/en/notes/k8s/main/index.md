---
title: "k8s"
weight: 1
date: 2024-01-25
categories:
  - k8s
---

[The Almighty Pause Container](https://www.ianlewis.org/en/almighty-pause-container)

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


### Random favorite links:

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
