---
title: "kubectl tip and tricks"
weight: 1
date: 2024-01-25
categories:
  - k8s
  - kubectl
  - oneliners
  - different tips
---

## Intro

This page is dedicated to different `kubectl` tips I'm using on my daily job. So feel free to add contact me or suggest another one.

### Current running pods per node

Similar to `k9s`, if you type `:nodes` but in kubectl:

```bash
NAME↑                                       STATUS ROLE    TAINTS  VERSION                PODS  CPU   MEM  %CPU  %MEM  CPU/A  MEM/A AGE   
gke-andrii-test-default-pool-c1873b05-cxm7  Ready  <none>  0       v1.30.6-gke.1125000      12  133  1140     3     8   3920  13261 4h33m 
gke-andrii-test-default-pool-c1873b05-e5lt  Ready  <none>  0       v1.30.6-gke.1125000      12  124  1157     3     8   3920  13261 5h42m
gke-andrii-test-default-pool-c1873b05-onva  Ready  <none>  0       v1.30.6-gke.1125000       9  115  1166     2     8   3920  13261 5h37m 
```

```bash
kubectl get pods \
  -A \
  -o jsonpath='{range .items[?(@.spec.nodeName)]}{.spec.nodeName}{"\n"}{end}' \
  | sort | uniq -c | sort -rn
  16 gke-andrii-test-default-pool-c1873b05-gx4q
  14 gke-andrii-test-default-pool-c1873b05-mdfz
  14 gke-andrii-test-default-pool-c1873b05-1pie
```
