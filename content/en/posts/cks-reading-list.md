---
title: Kubernetes Security reading list
date: 2025-11-06T08:39:07+01:00
tags: ["cks"]
categories:
- cks
- k8s
---

## About exam
|                            | <!-- --> |
|----------------------------|----------|
| Duration                   | 2 hours  |
| Number of questions: 15-20 | 15-20    |
| Passing score              | 67%      |
|    Prerequisite                        | CKA      |
 | [CKS_Curriculum](https://github.com/cncf/curriculum/blob/master/CKS_Curriculum%20v1.34.pdf) | |


### Setup

Vim:
```bash
echo "set ai et sw=2 ts=2 sts=2" > ~/.vimrc
```
`ai` = autoindend - Copy indent from current line when starting a new line (typing in Insert mode or when using the "o" or "O" command).
`et` = expandtab - In Insert mode: Use the appropriate number of spaces to insert a .
`sw` = shiftwidth
`sts` = shifttabstop
`ts` = tabspace

### Domains & Weighting

| Domain                                     | Weight |
|--------------------------------------------|--------|
| * Cluster Setup                            | 10%    |
| * Cluster Hardening                        | 15%    |
| * System Hardening                         | 15%    |
| * Minimize Microservice Vulnerabilities    | 20%    |
| * Supply Chain Security                    | 20%    |
| * Monitoring, Logging and Runtime Security | 20%    |


### Mostly used articles during solving problems by me
- [Encrypting Confidential Data at Rest](https://kubernetes.io/docs/tasks/administer-cluster/encrypt-data/)
- [Auditing](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)
- [Configure Service Accounts for Pods](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/)
- [Apply Pod Security Standards at the Namespace Level](https://kubernetes.io/docs/tutorials/security/ns-level-pss/)
- [kubelet](https://kubernetes.io/docs/reference/command-line-tools-reference/kubelet/)
- [Configuring each kubelet in your cluster using kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/kubelet-integration/)
- [Customizing components with the kubeadm API](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/control-plane-flags/#patches)
- [Set Kubelet Parameters Via A Configuration File](https://kubernetes.io/docs/tasks/administer-cluster/kubelet-config-file/) 
- [Generate Certificates Manually](https://kubernetes.io/docs/tasks/administer-cluster/certificates/)
- https://github.com/bmuschko/cks-study-guide/blob/master/app-b/exam-review-guide.adoc
- [Issue a Certificate for a Kubernetes API Client Using A CertificateSigningRequest](https://kubernetes.io/docs/tasks/tls/certificate-issue-client-csr/)
- [Enforce Pod Security Standards with Namespace Labels](https://kubernetes.io/docs/tasks/configure-pod-container/enforce-standards-namespace-labels/)
- [Distribute Credentials Securely Using Secrets](https://kubernetes.io/docs/tasks/inject-data-application/distribute-credentials-secure/)
- [JSONPath Support](https://kubernetes.io/docs/reference/kubectl/jsonpath/)
- [kubectl quick reference](https://kubernetes.io/docs/reference/kubectl/quick-reference/)

Cilium:
- [Layer 3 Examples](https://docs.cilium.io/en/stable/security/policy/language/)
- [Transparent Encryption](https://docs.cilium.io/en/stable/security/network/encryption/#gsg-encryption)

Istio:
- [Istio PeerAuthentication](https://istio.io/latest/docs/reference/config/security/peer_authentication/)

### Cluster setup 10%:
| topics                                                                                                            | notes |
|-------------------------------------------------------------------------------------------------------------------|-------|
| Use Network security policies to restrict cluster level access                                                    |       |
| Use CIS benchmark to review the security configuration of Kubernetes components (etcd, kubelet, kubedns, kubeapi) |       |
| Properly set up Ingress with TLS                                                                                  |       |
| Protect node metadata and endpoints                                                                               |       |
| Verify platform binaries before deploying                                                                         |       |

- [Use Network security policies to restrict cluster level access](https://kubernetes.io/docs/concepts/services-networking/network-policies/)
- [Use CIS benchmark to review the security configuration of Kubernetes components (etcd, kubelet, kubedns, kubeapi)](https://www.cisecurity.org/benchmark/kubernetes/)
- [Ingress objects with security control](https://kubernetes.io/docs/concepts/services-networking/ingress/#tls)
- [Protect node metadata and endpoints](https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/#restricting-cloud-metadata-api-access)
- [Securing a Cluster](https://kubernetes.io/docs/tasks/administer-cluster/securing-a-cluster/)
- [Kube-bench](https://github.com/aquasecurity/kube-bench)
- [Minimize use of, and access to, GUI elements](https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/#accessing-the-dashboard-ui)

### Cluster Hardening 15%:

| topic                                                                                                              |  notes |
|--------------------------------------------------------------------------------------------------------------|-|
| Use Role Based Access Controls to minimize exposure                                                          | |
| Exercise caution in using service accounts e.g. disable defaults, minimize permissions on newly created ones | |
| Restrict access to Kubernetes API                                                                            | |
| Upgrade Kubernetes to avoid vulnerabilities                                                                  | |


- [Use Role Based Access Controls to minimize exposure](https://kubernetes.io/docs/reference/access-authn-authz/rbac/)
- Exercise caution in using service accounts e.g. 
[disable defaults](https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/#use-the-default-service-account-to-access-the-api-server)
minimize permissions on newly created ones
- [Restrict access to Kubernetes API](https://kubernetes.io/docs/reference/access-authn-authz/controlling-access/))
- [Upgrade Kubernetes to avoid vulnerabilities](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/kubeadm-upgrade/)
- [Control anonymous requests to Kube-apiserver](https://kubernetes.io/docs/reference/access-authn-authz/authentication/#anonymous-requests)


### System Hardening 15%:

| topic                                                              | notes |
|--------------------------------------------------------------------|-------|
| Minimize host OS footprint (reduce attack surface)                 |       |
| Using least-privilege identity and access management               |       |
| Minimize external access to the network                            |       |
| Appropriately use kernel hardening tools such as AppArmor, seccomp |       |

- [Restrict a Container's Access to Resources with AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/)
- [Container Runtimes](https://kubernetes.io/docs/setup/production-environment/container-runtimes/)
- [Runtime Class](https://kubernetes.io/docs/concepts/containers/runtime-class/)
- [Restrict a Container's Syscalls with seccomp](https://kubernetes.io/docs/tutorials/security/seccomp/)
- [Using sysctls in a Kubernetes Cluster](https://kubernetes.io/docs/tasks/administer-cluster/sysctl-cluster/)
- [PSA enforces](https://kubernetes.io/docs/concepts/security/pod-security-admission/)
- [Restirct allowed hostpaths](https://kubernetes.io/docs/concepts/policy/pod-security-policy/#volumes-and-file-systems)
- [Access authentication and authorization](https://kubernetes.io/docs/reference/access-authn-authz/authentication/)

### Minimize Microservice Vulnerabilities (20%)

| topic                                                                                     | notes |
|-------------------------------------------------------------------------------------------|-------|
| Use appropriate pod security standards                                                    |       |
| Manage Kubernetes secrets                                                                 |       |
| Understand and implement isolation techniques (multi-tenancy, sandboxed containers, etc.) |       |
| Implement Pod-to-Pod encryption (Cilium, Istio)                                           |       |

- Use appropriate pod security standards
- [Manage kubernetes secrets](https://kubernetes.io/docs/concepts/configuration/secret/)
- Understand and implement isolation techniques (multi-tenancy, sandboxed containers, etc.)
- [Implement pod to pod encryption (Cilium, Istio)](https://kubernetes.io/docs/tasks/tls/managing-tls-in-a-cluster/)
- [Open Policy Agent](https://kubernetes.io/blog/2019/08/06/opa-gatekeeper-policy-and-governance-for-kubernetes/)
- [Security Contexts](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
Use [container runtime](https://kubernetes.io/docs/concepts/containers/runtime-class/) sandboxes in multi-tenant environments (e.g. [gvisor, kata containers](https://github.com/kubernetes/enhancements/blob/5dcf841b85f49aa8290529f1957ab8bc33f8b855/keps/sig-node/585-runtime-class/README.md#examples))
- - [Pod Security Standards (PSP)](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [pod spec](https://kubespec.dev/kubernetes/v1/Pod)
- [Kubernetes-API PodSpec](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.26/#podspec-v1-core)
- [Pod Security Admission (PSA)](https://kubernetes.io/docs/concepts/security/pod-security-admission/)

### Supply Chain Security (20%)
| topic                                                                                     | notes |
|-------------------------------------------------------------------------------------------|-------|
| Minimize base image footprint                                                             |       |
| Understand your supply chain (e.g. SBOM, CI/CD, artifact repositories)                    |       |
| Secure your supply chain (permitted registries, sign and validate artifacts, etc.)        |       |
| Perform static analysis of user workloads and container images (e.g. Kubesec, KubeLinter) |       |

- Secure your supply chain: [whitelist allowed image registries](https://kubernetes.io/blog/2019/03/21/a-guide-to-kubernetes-admission-controllers/#why-do-i-need-admission-controllers), sign and validate images
- Using [ImagePolicyWebhook admission Controller](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#imagepolicywebhook)
- Use static analysis of user workloads (e.g. [kubernetes resources](https://kubernetes.io/blog/2018/07/18/11-ways-not-to-get-hacked/#7-statically-analyse-yaml), docker files)
- [Scan images for known vulnerabilities](https://kubernetes.io/blog/2018/07/18/11-ways-not-to-get-hacked/#10-scan-images-and-run-ids)
- [Aqua security Trivy]( https://github.com/aquasecurity/trivy)
- - [ImagePolicyWebhook](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#imagepolicywebhook)
- [NodeRestriction](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#noderestriction)
- - [kube-bench](https://github.com/aquasecurity/kube-bench)
- [kube-bench installation](https://github.com/aquasecurity/kube-bench/blob/main/docs/installation.md)
- [checkov](https://github.com/bridgecrewio/checkov)
> [!NOTE]
> Checkov is a static code analysis tool for infrastructure as code (IaC) and also a software composition analysis (SCA) tool for images and open source packages.
- [Docker group security](https://github.com/zealvora/certified-kubernetes-security-specialist/blob/main/domain-5-supply-chain-security/docker-security.md#docker-group-security)

### Monitoring, Logging and Runtime Security
| topic                                                                                 | notes |
|---------------------------------------------------------------------------------------|-------|
| Perform behavioral analytics to detect malicious activities                           |       |
| Detect threats within physical infrastructure, apps, networks, data, users and workloads |       |
| Investigate and identify phases of attack and bad actors within the environment       |       |
| Ensure immutability of containers at runtime                                          |       |
| Use Kubernetes audit logs to monitor access                                           |       |

- [falco](https://falco.org/docs/)
- [falco basic rules](https://falco.org/docs/concepts/rules/basic-elements/)
- [sysdig](https://github.com/draios/sysdig)
- [K8s Audit](https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/)
  Perform behavioural analytics of syscall process and file activities at the host and container level to detect malicious activities
  - [Falco installation guide](https://falco.org/docs/)
  - :triangular_flag_on_post: [Sysdig Falco 101](https://learn.sysdig.com/falco-101)
  - :triangular_flag_on_post: [Falco Helm Chart](https://github.com/falcosecurity/charts/tree/master/falco)
  - :triangular_flag_on_post: [Falco Kubernetes helmchart](https://github.com/falcosecurity/charts)
  - :triangular_flag_on_post: [Detect CVE-2020-8557 using Falco](https://falco.org/blog/detect-cve-2020-8557/)
    Detect threats within a physical infrastructure, apps, networks, data, users and workloads
    Detect all phases of attack regardless where it occurs and how it spreads

Perform deep analytical investigation and identification of bad actors within the environment
- [Sysdig documentation](https://docs.sysdig.com/)
- [Monitoring Kubernetes with sysdig](https://kubernetes.io/blog/2015/11/monitoring-kubernetes-with-sysdig/)
- :triangular_flag_on_post: [CNCF Webinar: Getting started with container runtime security using Falco](https://youtu.be/VEFaGjfjfyc)
  [Ensure immutability of containers at runtime](https://kubernetes.io/blog/2018/03/principles-of-container-app-design/)
  [Use Audit Logs to monitor access](https://kubernetes.io/docs/tasks/debug-application-cluster/audit/)


### Tips:

Verify checksum of many binaries (search `shasum` k8s docs): 

If you see:
```bash
shasum: standard input: no properly formatted SHA checksum lines found
```
It must be 2 spaces between sha end binary path!!! if you want to compare in one line:
```bash
echo "$(cat kube-apiserver.sha256)  kube-apiserver" | shasum -a 256 --check
```

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

Falco ([supported_fields](https://falco.org/docs/reference/rules/supported-fields/)):

```bash
# it can take a bit till Falco displays output, use falco -U/--unbuffered to speed up
falco -U | grep <>
```

Cri-O

```bash
crictl ps

crictl ps -n1 # show only latest running container

crictl ps -id f86cd629e71c

crictl pods -id cab6dafd045d5

crictl pods --name collector1

crictl inspect <CONTAINER ID>
```

Using the PIDs we can call strace to find [Syscalls](https://man7.org/linux/man-pages/man2/syscalls.2.html):

```bash
strace -p 14079 | grep -i kill
```


BOM

```bash
bom generate --image registry.k8s.io/kube-apiserver:v1.31.0 --format json --output nginx.spdx.json
```

Trivy

```bash
trivy image --help | grep format
  $ trivy image --format json --output result.json alpine:3.15
  # Generate a report in the CycloneDX format
  $ trivy image --format cyclonedx --output result.cdx alpine:3.15
  -f, --format string              format (table,json,template,sarif,cyclonedx,spdx,spdx-json,github,cosign-vuln) (default "table")
...
```


openssl

```bash
# create new key for new user
openssl genrsa -out myuser.key 2048
openssl req -new -key myuser.key -out myuser.csr

cat <<EOF > CSR.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: john-developer # add
spec:
  request: $(cat myuser.csr | base64 | tr -d "\n")
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
  - digital signature
  - key encipherment
EOF
```


```bash
# View the certificate signing request
openssl req -in new.csr -noout -text
```

kubectl

copy/paste from `kubectl quick ref`
```
alias kx='f() { [ "$1" ] && kubectl config use-context $1 || kubectl config current-context ; } ; f'
alias kn='f() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6 ; } ; f'
```

```bash
# you can list only pods by field selector (e.g. filter by name) a.k.a emulating grep test
# kubectl get pods | grep test
$ kubectl get pods --field-selector=metadata.name=test
NAME   READY   STATUS    RESTARTS   AGE
test   1/1     Running   0          9h
```

Find all images to scan + metadata.name (based on Jsonpath recursive descent)
```bash
# based on jsonpath page
$ kubectl get deploy -o=jsonpath='{range .items[*]}{.metadata.name}{" -> "}{..image}{"\n"}{end}'
deploy -> nginx
image-bouncer-webhook -> kainlite/kube-image-bouncer:latest

# based on kubectl quick ref page also works for pods/deployments

$ kubectl get deploy --output=custom-columns="NAME:.metadata.name,IMAGE:..image"
NAME                    IMAGE
deploy                  nginx
image-bouncer-webhook   kainlite/kube-image-bouncer:latest
```

Find all SC for pods/containers to troubleshoot:
```bash
kubectl get pods -o=custom-columns='N:metadata.name,PSC:..securityContext'
```


Update kubelet-config:
```bash
kubectl -n kube-system edit cm kubelet-config

kubeadm upgrade node phase kubelet-config

systemctl restart kubelet
```

Upgrade k8s version and components on nodes e.g. from `v1.33.4` to `v1.34.1`:

```bash
# show k8s versions
k get node

k drain <node-name> --ignore-daemonsets

kubelet --version
kubeadm version

# not necessary because here kubeadm is already installed in correct version
apt-mark unhold kubeadm
apt-mark hold kubectl kubelet
apt install kubeadm=1.34.1-1.1
apt-mark hold kubeadm

kubeadm upgrade plan

kubeadm upgrade apply v1.34.1

# to check it run again
kubeadm upgrade plan

# kubelet and kubectl

apt update
apt show kubelet | grep 1.34.1
apt install kubelet=1.34.1-1.1 kubectl=1.34.1-1.1

apt-mark hold kubelet kubectl

service kubelet restart
service kubelet status

k get node
k uncordon <node-name>
```

## Footnotes

SELinux
- [What is SELinux (Security-Enhanced Linux)](https://www.redhat.com/en/topics/linux/what-is-selinux)
- [Check if SELinux is Enabled](https://docs.oracle.com/cd/E17952_01/mysql-5.7-en/selinux-checking.html)


### Install containerd and k8s 1.32 on ubuntu 24.04

1. Create t3.small ec2 instance based on ubuntu, because we need atleast 2GB RAM for k8s.

https://github.com/zealvora/certified-kubernetes-security-specialist/blob/main/domain-1-cluster-setup/kubeadm-install.md


### Related materials:
- https://github.com/jangroth/kubernetes-certification-notes/blob/main/cks/studycard.md#17-reconfigure-cluster


## Footnotes

SELinux
- [What is SELinux (Security-Enhanced Linux)](https://www.redhat.com/en/topics/linux/what-is-selinux)
- [Check if SELinux is Enabled](https://docs.oracle.com/cd/E17952_01/mysql-5.7-en/selinux-checking.html)


- https://github.com/stackrox/Kubernetes_Security_Specialist_Study_Guide#cluster-hardening---15
- https://github.com/ramanagali/Interview_Guide/blob/main/CKS_Preparation_Guide.md
- https://github.com/walidshaari/Certified-Kubernetes-Security-Specialist
- https://github.com/zealvora/certified-kubernetes-security-specialist/
- https://github.com/jangroth/kubernetes-certification-notes/blob/main/cks/studycard.md#1-cluster-setup
- [CKS Tips Kubernetes 1.34](https://killer.sh/attendee/cef7d7f1-fca3-4052-bf76-ba374b710ec4/tips)
- videos:
  - [Kubernetes CKS Full Course Theory + Practice + Browser Scenarios](https://www.youtube.com/watch?v=d9xfB5qaOfg)
- practise:
  - killer.sh
  - killer Koda
  - or install your own cluster https://github.com/killer-sh/cks-course-environment/tree/master
  - https://killercoda.com/killer-shell-cks/scenario/apiserver-misconfigured
  - https://github.com/ramanagali/Interview_Guide/blob/main/CKS_Preparation_Guide.md
  - https://github.com/ViktorUJ/cks/blob/master/tasks/cks/mock/01/README.MD
  - https://github.com/ViktorUJ/cks/blob/master/tasks/cks/mock/02/README.MD
  - https://github.com/ViktorUJ/cks/blob/master/tasks/cks/mock/03/README.MD
  - https://github.com/ViktorUJ/cks/blob/master/tasks/cks/mock/04/README.MD
  - killer_shell_a (html dump)
  - killer_shell_b (html dump)
  - https://killercoda.com/killer-shell-cks/
