---
title: Kubernetes Security reading list
date: 2025-11-06T08:39:07+01:00
tags: ["cks"]
categories:
- cks
- k8s
---

## About exam

- Duration : 2 hours
- Number of questions: 15-20 hands-on performance based tasks
- Passing score: 67%
- Certification validity: two (2) years
- Prerequisite: valid CKA
- [CKS_Curriculum](https://github.com/cncf/curriculum/blob/master/CKS_Curriculum%20v1.34.pdf)
- videos:
  - [Kubernetes CKS Full Course Theory + Practice + Browser Scenarios](https://www.youtube.com/watch?v=d9xfB5qaOfg)
- practise:
  - killer.sh
  - killer Koda
- [CKS Tips Kubernetes 1.34](https://killer.sh/attendee/cef7d7f1-fca3-4052-bf76-ba374b710ec4/tips)


### Setup

tmux:

```bash
# vim ~/.tmux.conf
set -g prefix C-f
unbind C-b
bind C-f send-prefix
set-window-option -g mode-keys vi
```

Vim:

```bash
# vim ~/.vimrc
set expandtab
set tabstop=2
set shiftwidth=2
```
### Practice, practice, practice

- or install your own cluster https://github.com/killer-sh/cks-course-environment/tree/master

- https://killercoda.com/killer-shell-cks/scenario/apiserver-misconfigured


### Mostly used articles during solving problems by me
- [Encrypting Confidential Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)
- [Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)
- [Restrict a Container's Syscalls with seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
- [Configure Service Accounts for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)
- [Apply Pod Security Standards at the Namespace Level](https://kubernetes.io/docs/tutorials/security/ns-level-pss/)


### Tips:

Verify checksum of many binaries:
```bash
cat sha.txt
sha file
```

```bash
sha512sum -c sha.txt
```

Refresh yaml structure using `k explain pods.spec`:
```bash
root@k8s:~# k explain pods.spec | grep -C5 nodeName
    then using the max of of that value or the sum of the normal containers.
    Limits are applied to init containers in a similar fashion. Init containers
    cannot currently be added or removed. Cannot be updated. More info:
    https://kubernetes.io/docs/concepts/workloads/pods/init-containers/

  nodeName      <string>
    NodeName indicates in which node this pod is scheduled. If empty, this pod
    is a candidate for scheduling by the scheduler defined in schedulerName.
    Once this field is set, the kubelet for this node becomes responsible for
    the lifecycle of this pod. This field should not be used to express a desire
    for the pod to be scheduled on a specific node.

root@k8s:~# k explain deployments.spec.template.spec
```

### Cluster setup (15%)

- [Use Network security policies to restrict cluster level access](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Use CIS benchmark to review the security configuration of Kubernetes components (etcd, kubelet, kubedns, kubeapi)](https://www.cisecurity.org/benchmark/kubernetes/)
- Properly set up Ingress objects with TLS
- [Protect node metadata and endpoints](https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/#restricting-cloud-metadata-api-access)
  - Setting up secure endpoints in Kubernetes
**Related materials:**
* [Securing a Cluster](https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/)
* [Kube-bench](https://github.com/aquasecurity/kube-bench)
* [Ingress objects with security control](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls)
* [Minimize use of, and access to, GUI elements](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/#accessing-the-dashboard-ui)
- https://github.com/stackrox/Kubernetes_Security_Specialist_Study_Guide#cluster-hardening---15



### Cluster Hardening (15%)

- [Use Role Based Access Controls to minimize exposure](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- Exercise caution in using service accounts e.g. 
[disable defaults](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-the-default-service-account-to-access-the-api-server)
minimize permissions on newly created ones
- [Restrict access to Kubernetes API](https://kubernetes.io/docs/reference/access-authn-authz/controlling-access/))
- Upgrade Kubernetes to avoid vulnerabilities

Related materials:
* [Control anonymous requests to Kube-apiserver](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#anonymous-requests)


### System Hardening (10%)

- Minimize host OS footprint (reduce attack
surface)
- Using least-privilege identity and access
management
- Minimize external access to the network
- Appropriately use kernel hardening tools
such as AppArmor, seccomp

Minimize host OS footprint (reduce attack surface)
   <details><summary> :clipboard: :confused: Reduce host attack surface </summary>
  * [seccomp which stands for secure computing was originally intended as a means of safely running untrusted compute-bound programs](https://kubernetes.io/docs/tutorials/clusters/seccomp/)
  * [AppArmor can be configured for any application to reduce its potential host attack surface and provide greater in-depth defense.](https://kubernetes.io/docs/tutorials/clusters/apparmor/)
  * [PSA enforces](https://kubernetes.io/docs/concepts/security/pod-security-admission/)
  * Apply host updates
  * Install minimal required OS fingerprint
  * Identify and address open ports
  * Remove unnecessary packages
  * Protect access to data with permissions
    *  [Restirct allowed hostpaths](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems)

   </details>

Minimize IAM roles [Access authentication and authorization](https://kubernetes.io/docs/reference/access-authn-authz/authentication/)
Minimize external access to the network
  * [AppArmor](https://kubernetes.io/docs/tutorials/clusters/apparmor/)
  * [Seccomp](https://kubernetes.io/docs/tutorials/clusters/seccomp/)

### Minimize Microservice Vulnerabilities (20%)

- Use appropriate pod security standards
- [Manage kubernetes secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- Understand and implement isolation techniques (multi-tenancy, sandboxed containers, etc.)
- [Implement pod to pod encryption (Cilium, Istio)](https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/)

Setup appropriate OS-level security domains e.g. using PSA, OPA, security contexts:

  - [Open Policy Agent](https://kubernetes.io/blog/2019/08/06/opa-gatekeeper-policy-and-governance-for-kubernetes/)
  - [Security Contexts](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
Use [container runtime](https://kubernetes.io/docs/concepts/containers/runtime-class/) sandboxes in multi-tenant environments (e.g. [gvisor, kata containers](https://github.com/kubernetes/enhancements/blob/5dcf841b85f49aa8290529f1957ab8bc33f8b855/keps/sig-node/585-runtime-class/README.md#examples))


### Supply Chain Security (20%)

- Minimize base image footprint
- Understand your supply chain (e.g. SBOM, CI/CD, artifact repositories)
- Secure your supply chain (permitted registries, sign and validate artifacts, etc.)
- Perform static analysis of user workloads and container images (e.g. Kubesec, KubeLinter)

Minimize base image footprint

   <details><summary> :clipboard: Minimize base Image </summary>

* Use distroless, UBI minimal, Alpine, or relavent to your app nodejs, python but the minimal build.
* Do not include uncessary software not required for container during runtime e.g build tools and utilities, troubleshooting and debug binaries.
  * :triangular_flag_on_post: [LearnKube: 3 simple tricks for smaller Docker images](https://learnkube.com/blog/smaller-docker-images)
  * :triangular_flag_on_post: [GKE 7 best practices for building containers](https://cloud.google.com/blog/products/gcp/7-best-practices-for-building-containers)

   </details>

Secure your supply chain: [whitelist allowed image registries](https://kubernetes.io/blog/2019/03/21/a-guide-to-kubernetes-admission-controllers/#why-do-i-need-admission-controllers), sign and validate images
* Using [ImagePolicyWebhook admission Controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#imagepolicywebhook)
Use static analysis of user workloads (e.g. [kubernetes resources](https://kubernetes.io/blog/2018/07/18/11-ways-not-to-get-hacked/#7-statically-analyse-yaml), docker files)
[Scan images for known vulnerabilities](https://kubernetes.io/blog/2018/07/18/11-ways-not-to-get-hacked/#10-scan-images-and-run-ids)
  * [Aqua security Trivy]( https://github.com/aquasecurity/trivy)
  * :triangular_flag_on_post: [Anchore command line scans](https://github.com/anchore/anchore-cli#command-line-examples)

### Monitoring, Logging and Runtime Security (20%)

- Perform behavioral analytics to detect
malicious activities
- Detect threats within physical infrastructure,
apps, networks, data, users and workloads
- Investigate and identify phases of attack and
bad actors within the environment
- Ensure immutability of containers at runtime
- Use Kubernetes audit logs to monitor access

Perform behavioural analytics of syscall process and file activities at the host and container level to detect malicious activities
  - [Falco installation guide](https://falco.org/docs/)
  - :triangular_flag_on_post: [Sysdig Falco 101](https://learn.sysdig.com/falco-101)
  - :triangular_flag_on_post: [Falco Helm Chart](https://github.com/falcosecurity/charts/tree/master/falco)
  - :triangular_flag_on_post: [Falco Kubernetes helmchart](https://github.com/falcosecurity/charts)
  - :triangular_flag_on_post: [Detect CVE-2020-8557 using Falco](https://falco.org/blog/detect-cve-2020-8557/)
Detect threats within a physical infrastructure, apps, networks, data, users and workloads
Detect all phases of attack regardless where it occurs and how it spreads

   <details><summary> :clipboard:  Attack Phases </summary>

  - :triangular_flag_on_post: [Kubernetes attack martix Microsoft blog](https://www.microsoft.com/security/blog/2020/04/02/attack-matrix-kubernetes/)
  - :triangular_flag_on_post: [MITRE attack framwork using Falco](https://sysdig.com/blog/mitre-attck-framework-for-container-runtime-security-with-sysdig-falco/)
  - :triangular_flag_on_post: [Lightboard video: Kubernetes attack matrix - 3 steps to mitigating the MITRE ATT&CK Techniques](https://www.youtube.com/watch?v=0fnWu06eQCU)
  - :triangular_flag_on_post: [CNCF Webinar: Mitigating Kubernetes attacks](https://www.cncf.io/webinars/mitigating-kubernetes-attacks/)

   </details>

Perform deep analytical investigation and identification of bad actors within the environment
  - [Sysdig documentation](https://docs.sysdig.com/)
  - [Monitoring Kubernetes with sysdig](https://kubernetes.io/blog/2015/11/monitoring-kubernetes-with-sysdig/)
  - :triangular_flag_on_post: [CNCF Webinar: Getting started with container runtime security using Falco](https://youtu.be/VEFaGjfjfyc)
[Ensure immutability of containers at runtime](https://kubernetes.io/blog/2018/03/principles-of-container-app-design/)
[Use Audit Logs to monitor access](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/)


Exam tasks:
- https://github.com/ramanagali/Interview_Guide/blob/main/CKS_Preparation_Guide.md
- https://github.com/walidshaari/Certified-Kubernetes-Security-Specialist

**Links from CKS Udemy course:**
### Minimize Microservices Vulnerabilities

- [Pod Security Standards (PSP)](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [pod spec](https://kubespec.dev/kubernetes/v1/Pod)
- [Kubernetes-API PodSpec](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.26/#podspec-v1-core)
- [Pod Security Admission (PSA)](https://kubernetes.io/docs/concepts/security/pod-security-admission/)

#### Admission controllers

- [ImagePolicyWebhook](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#imagepolicywebhook)
- [NodeRestriction](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noderestriction)


#### Secrets

- [Distribute Credentials Securely Using Secrets](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/)

#### Cilium

- [Layer 3 Examples](https://docs.cilium.io/en/stable/security/policy/language/)
- [Transparent Encryption](https://docs.cilium.io/en/stable/security/network/encryption/#gsg-encryption)

#### Istio

- [PeerAuthentication](https://istio.io/latest/docs/reference/config/security/peer_authentication/)

### System Hardening

- [Restrict a Container's Access to Resources with AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/)
- [Container Runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
- [Runtime Class](https://kubernetes.io/docs/concepts/containers/runtime-class/)

### Supply Chain Security

- [kube-bench](https://github.com/aquasecurity/kube-bench)
- [kube-bench installation](https://github.com/aquasecurity/kube-bench/blob/main/docs/installation.md)
- [checkov](https://github.com/bridgecrewio/checkov)
> [!NOTE]
> Checkov is a static code analysis tool for infrastructure as code (IaC) and also a software composition analysis (SCA) tool for images and open source packages.
- [Docker group security](https://github.com/zealvora/certified-kubernetes-security-specialist/blob/main/domain-5-supply-chain-security/docker-security.md#docker-group-security)

### Monitoring, Logging and Runtime Security

- [falco](https://falco.org/docs/)
- [falco basic rules](https://falco.org/docs/concepts/rules/basic-elements/)
- [sysdig](https://github.com/draios/sysdig)
- [K8s Audit](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)

## Footnotes

SELinux
- [What is SELinux (Security-Enhanced Linux)](https://www.redhat.com/en/topics/linux/what-is-selinux)
- [Check if SELinux is Enabled](https://docs.oracle.com/cd/E17952_01/mysql-5.7-en/selinux-checking.html)
- [Issue a Certificate for a Kubernetes API Client Using A CertificateSigningRequest](https://kubernetes.io/docs/tasks/tls/certificate-issue-client-csr/)

### Install containerd and k8s 1.32 on ubuntu 24.04

1. Create t3.small ec2 instance based on ubuntu, because we need atleast 2GB RAM for k8s.

https://github.com/zealvora/certified-kubernetes-security-specialist/blob/main/domain-1-cluster-setup/kubeadm-install.md


2. Install containerd 
```bash
sudo apt-get update
sudo apt-get install containerd
```

3. Check
```bash
# check
ctr

# check runc
runc
```

4. Install kubeadm
```bash
sudo apt-get update

# apt-transport-https may be a dummy package; if so, you can skip that package
sudo apt-get install -y apt-transport-https ca-certificates curl gpg

# If the directory `/etc/apt/keyrings` does not exist, it should be created before the curl command, read the note below.
# sudo mkdir -p -m 755 /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.32/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

# This overwrites any existing configuration in /etc/apt/sources.list.d/kubernetes.list
echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.32/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo systemctl enable --now kubelet
```


### Similar notes for exam:
- https://github.com/jangroth/kubernetes-certification-notes/blob/main/cks/studycard.md#17-reconfigure-cluster


## Footnotes

SELinux
- [What is SELinux (Security-Enhanced Linux)](https://www.redhat.com/en/topics/linux/what-is-selinux)
- [Check if SELinux is Enabled](https://docs.oracle.com/cd/E17952_01/mysql-5.7-en/selinux-checking.html)

