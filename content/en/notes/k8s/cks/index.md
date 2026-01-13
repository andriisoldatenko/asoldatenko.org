---
title: "CKS"
weight: 1
date: 2026-01-13
categories:
  - k8s
  - different tips
---

## Intro


## Problems
|        **1**        | **kubectl contexts.**                                                                                                                                                                    |
| :-----------------: |:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     Task weight     | 1%                                                                                                                                                                                       |
|       Cluster       | -                                                                                                                                                                                        |
| Acceptance criteria | - write all context names into``/var/work/tests/artifacts/1/contexts`` ,one per line <br/>- save decoded certificate of user **cluster9-admin**  to ``/var/work/tests/artifacts/1/cert`` |

```bash
mkdir -p /var/work/tests/artifacts/1/
kubectl config get-contexts -o name > /var/work/tests/artifacts/1/contexts

k config view --raw
# or cat ~./kube/config

# find cert and decode
# jq -r - remove quotes
# .users[9] - quickest way to start from 0 and find or you can filter by name but harder to remember
k config view --raw -ojson | jq -r '.users[9].user."client-certificate-data"' |base64 -d > > /var/work/tests/artifacts/1/cert
```
---


|        **3**        | **Kube-api disable access via nodePort**                    |
|:-------------------:|:------------------------------------------------------------|
|     Task weight     | 4%                                                          |
|       Cluster       | default                                                     |
| Acceptance criteria | - Kube-api  Only accessible through a **ClusterIP** Service |

https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/

```bash
ps aux | grep kube-apiserver
# find path to static posds manifest

# assuming location is found: 
# change vim /etc/kuebrnetes/manifests/kube-apiserver.yaml
# remove or set to 0 the flag:
# If zero, the Kubernetes master service will be of type ClusterIP.
--kubernetes-service-node-port=0

# Important to delete existing service to recreate it as ClusterIP
k delete svc kubernetes -n kube-system
```
---


|        **4**        | **Pod Security Standard**                                                                                                                                                                                                                            |
|:-------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     Task weight     | 4%                                                                                                                                                                                                                                                   |
|       Cluster       | default                                                                                                                                                                                                                                              |
| Acceptance criteria | - **enforce** the **baseline** **Pod Security Standard** on `team-red` Namespace   <br/>-  delete the Pod of the Deployment mentioned above <br/>- save  events  of ReplicaSet and write the event/log to   ``/var/work/tests/artifacts/4/events.log`` |

```bash
kubectl label --overwrite ns `team-red` \
  pod-security.kubernetes.io/enforce=baseline
 
k get pods -n team-red | grep depl-name
k delete pod <namehere> -n team-red

k events replicasets.apps -n team-red  > /var/work/tests/artifacts/4/events.log
```
---



|        **5**        | **CIS Benchmark**                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|:-------------------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     Task weight     | 3%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         |
|       Cluster       | default                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    |
| Acceptance criteria | - CIS Benchmark is installed on nodes<br/>- fix on `control-plane`:<br/>&nbsp;&nbsp;- `1.2.17` Ensure that the `--profiling` argument is set to false<br/>&nbsp;&nbsp;- `1.3.2` Ensure that the `--profiling` argument is set to false (Automated)<br/>&nbsp;&nbsp;- `1.4.1` Ensure that the `--profiling` argument is set to false (Automated)<br/><br/>- fix on `worker node`:<br/>&nbsp;&nbsp;- `4.2.6` Ensure that the `--protect-kernel-defaults` argument is set to true (Automated) |

https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/
https://kubernetes.io/docs/reference/command-line-tools-reference/kube-apiserver/

```bash
kube-bench run -s master -c '1.2.17,1.3.2,1.4.1'

# vim /etc/kubernetes/manifests/kube-apiserver.yaml
# find --profiling and set to false
--profiling=false

# vim /etc/kubernetes/kubelet.conf
--protect-kernel-defaults=true
# or
# Add argument into the kubelet conbfig file:
# protectKernelDefaults: true

systemctl restart kubelet.service

# rerun: kube-bench run -s node -c '4.2.6'
```
---


|        **9**        | **AppArmor**                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|:-------------------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     Task weight     | 3%                                                                                                                                                                                                                                                                                                                                                                                                                                                                     |
|       Cluster       | default                                                                                                                                                                                                                                                                                                                                                                                                                                                                |
| Acceptance criteria | - install appArmor profile from `/opt/course/9/profile` (work node ) to `worker node` on cluster<br/>- Add label `security=apparmor` to the Node<br/>- Create a `Deployment` named `apparmor` in `apparmor` Namespace with:<br/>&nbsp;&nbsp;- image: `nginx:1.19.2`<br/>&nbsp;&nbsp;- container named `c1`<br/>&nbsp;&nbsp;- AppArmor profile enabled<br/>&nbsp;&nbsp;- nodeSelector to `workerNode`<br/>- save logs of the Pod into `/var/work/tests/artifacts/9/log` |

```

```

---


|          **7**          | **Open Policy Agent - Blacklist Images from very-bad-registry.com** |
|:-----------------------:|:--------------------------------------------------------------------|
|       Task weight       | 6%                                                                  |
|         Cluster         | default                                                             |
|   Acceptance criteria   | - Cannot run a pod with an image from **very-bad-registry.com**     |
---


|       **12**        | **Falco, sysdig**                                                                                                                                                                                                                                       |
|:-------------------:|:--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     Task weight     | 6%                                                                                                                                                                                                                                                      |
|       Cluster       | default                                                                                                                                                                                                                                                 |
| Acceptance criteria | use `falco` or `sysdig`, prepare logs in format:<br/><br/>`time-with-nanosconds,container-id,container-name,user-name,kubernetes-namespace,kubernetes-pod-name`<br/><br/>for pod with image `nginx` and store log to `/var/work/tests/artifacts/12/log` |
---