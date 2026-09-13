+++
title = 'CKS Exam Tips'
date = 2026-08-24T20:28:50+02:00
draft = true
+++


## Intro

Originally i've created this page with just [reading list]()
but later i found it's useless. So it's only consists of TIP and lessons 
i learnt the hard way :) 


## Cluster Setup

- Use Network security policies to restrict
cluster level access
- Use CIS benchmark to review the security
configuration of Kubernetes components
(etcd, kubelet, kubedns, kubeapi)
- Properly set up Ingress objects with TLS
- Protect node metadata and endpoints
- Verify platform binaries before deploying


## Cluster Hardening

- Use Role Based Access Controls to
minimize exposure
- Exercise caution in using service accounts
e.g. disable defaults, minimize permissions
on newly created ones
- Restrict access to Kubernetes API
- Upgrade Kubernetes to avoid vulnerabilities


## System Hardening

- Minimize host OS footprint (reduce attack
surface)
- Using least-privilege identity and access
management
- Minimize external access to the network
- Appropriately use kernel hardening tools
such as AppArmor, seccomp

## Minimize Microservice Vulnerabilities

- Use appropriate pod security standards
- Manage kubernetes secrets
- Understand and implement isolation
techniques (multi-tenancy, sandboxed
containers, etc.)
- Implement Pod-to-Pod encryption
(Cilium, Istio)

## Supply Chain Security

- Minimize base image footprint
- Understand your supply chain (e.g. SBOM,
CI/CD, artifact repositories)
- Secure your supply chain (permitted
registries, sign and validate artifacts, etc.)
- Perform static analysis of user workloads
and container images (e.g. Kubesec,
KubeLinter)


## Monitoring, Logging and Runtime Security
- Perform behavioral analytics to detect
malicious activities
- Detect threats within physical infrastructure,
apps, networks, data, users and workloads
- Investigate and identify phases of attack and
bad actors within the environment
- Ensure immutability of containers at runtime
- Use Kubernetes audit logs to monitor access


## Intro
https://github.com/kubesimplify/cks-certification
https://github.com/techiescamp/cks-certification-guide
https://www.youtube.com/watch?v=_l232KiJHNA


## Falco tips

https://falco.org/docs/concepts/rules/basic-elements/
https://falco.org/docs/reference/rules/supported-fields/


Task: Detect /dev/mem Access:

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: demo3
spec:
  replicas: 1
  selector:
    matchLabels:
      app: demo3
  template:
    metadata:
      labels:
        app: demo3
    spec:
      containers:
      - name: busybox
        image: busybox
        command: ["/bin/sh", "-c", "while true; do cat /dev/mem; sleep 10; done"]
        securityContext:
          privileged: true
```

```bash
cat custom-rules.yaml
```

```yaml
customRules:
  custom-rules.yaml: |-
      - rule:  Detect /dev/mem Access
        desc: Detect processes that attempt to read /dev/mem
        condition: (evt.type=open or evt.type=openat) and fd.name=/dev/mem
        output: "Process %proc.name accessed /dev/mem (command=%proc.cmdline user=%user.name container=%container.id image=%container.image.repository)"
        priority: WARNING
        tags: [security]
```

```bash
helm install falco -f custom-rules.yaml falcosecurity/falco
```

```
15:29:12.407913729: Warning Process cat accessed /dev/mem (command=cat /dev/mem user=root container=197922127b6f image=docker.io/library/busybox) container_id=197922127b6f container_name=busybox container_image_repository=docker.io/library/busybox container_image_tag=latest k8s_pod_name=demo3-54464dfb94-t28qr k8s_ns_name=default
```

how to find existing rule:

```
root@controlplane:/etc/falco$ grep -i "Terminal shell in container"
^C
root@controlplane:/etc/falco$ grep -ri "Terminal shell in container"
falco_rules.local.yaml:- rule: Terminal shell in container
falco_rules.yaml:    unique to your environment. The rule "Terminal shell in container" that fires when using "kubectl exec" is more Kubernetes
falco_rules.yaml:- rule: Terminal shell in container
```

> You need to copy rule to `falco_rules.local.yaml` and modify it, otherwise it won't work



## apiserver

https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noderestriction

```
vim /etc/kubernetes/manifests/kube-apiserver.yaml

# add
--enable-admission-plugins=NodeRestriction
```



## Troubleshout api-server

```
/var/log/pods
/var/log/containers
crictl logs
kubelet logs: /var/log/syslog or journalctl

# syslogs:
tail -f /var/log/syslog | grep apiserver

# or:
journalctl | grep apiserver
```

## Audit policy from scratch

https://github.com/moabukar/CKS-Exercises-Certified-Kubernetes-Security-Specialist/tree/main/1-cluster-setup

## Ingress

https://github.com/moabukar/CKS-Exercises-Certified-Kubernetes-Security-Specialist/tree/main/2-cluster-hardening


## RBAC
(focus on it and practice daily) CKA/CKS filter by topic
```bash
k create rolebinding -h | grep namespace
  kubectl create rolebinding NAME --clusterrole=NAME|--role=NAME [--user=username] [--group=groupname] [--serviceaccount=namespace:serviceaccountname] [--dry-run=server|client|none] [options]
```

Because of this there are 4 different RBAC combinations and 3 valid ones:

Role + RoleBinding (available in single Namespace, applied in single Namespace)
ClusterRole + ClusterRoleBinding (available cluster-wide, applied cluster-wide)
ClusterRole + RoleBinding (available cluster-wide, applied in single Namespace)
Role + ClusterRoleBinding (NOT POSSIBLE: available in single Namespace, applied cluster-wide)

Test:
```bash
k auth can-i delete deployments --as system:serviceaccount:ns1:pipeline -n ns1 # YES
```

Instead of testing one by one:
```
k -n applications auth can-i --list=true --as=smoke
```

```
kubectl apply -f https://raw.githubusercontent.com/ViktorUJ/cks/refs/heads/master/tasks/cks/mock/01/k8s-6/scripts/task11.yaml
```
- update existing permissions for SA dev in Namespaces rbac-1:
  - delete verb delete for pods
  - add verb watch for pods
- create new role dev in rbac-2 Namespaces:
  - resource configmaps, verbs = get,list
- create rolebinding dev in rbac-2, sa = dev in rbac-1 Namespace , role = dev
- create pod dev-rbac NS=rbac-1 image = viktoruj/cks-lab, command = sleep 60000, SA=dev


## Network polices
(focus on it and practice daily) CKA/CKS filter by topic
Also practice on homelab

NP: Enable trafic from all ns WITH label hello=world
```bash
```

Netpol deny for all outgoing traffic from all pods in ns=app,except DNS (port=53, tcp+udp)
```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-out
  namespace: app
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - ports:
    - protocol: TCP
      port: 53
    - protocol: UDP
      port: 53
```


Netpol for which allows egress traffic to all IPs (0.0.0.0/0 ) except 1.1.1.1 and only affect Pods with label `trust=nope`
TIP: find a mask for IP so we can use it in `except`:

```yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: metadata-server
  namespace: default
spec:
  podSelector:
    matchLabels:
      trust: nope
  policyTypes:
  - Egress
  egress:
  - to:
    - ipBlock:
        cidr: 0.0.0.0/0
        except:
          - 1.1.1.1/32
```

## Passing parameters to Kubelet through systemd unit file

## gVisor

## appArmor


https://apparmor.net/getting-started/confine-your-application/#put-the-profile-in-complain-mode

> Each time AppArmor denies an operation, it logs the event. 
Depending on your system configuration, events may appear in the kernel
log, syslog, auditd, or journald:
```
sudo journalctl -fx -k --grep=apparmor
```

find current installed profiles:
```
apparmor_status
# or
aa-status | grep -f <list-items-to-grep>
# or
sudo cat /sys/kernel/security/apparmor/profiles | grep custom


# load profile (NOTE: usually need to do on every node)
apparmor_parser /root/profile

scp /root/profile node01:/root/profile

ssh node01
scp /root/profile node01:/root/profile
```

## Trivy
