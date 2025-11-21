+++
title = 'Kubernetes Security reading list'
date = 2025-11-06T08:39:07+01:00
draft = false
+++


## Beginner

### Minimize Microservices Vulnerabilities

- [Pod Security Standards (PSP)](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [pod spec](https://kubespec.dev/kubernetes/v1/Pod)
- [Kubernetes-API PodSpec](https://kubernetes.io/docs/reference/generated/kubernetes-api/v1.26/#podspec-v1-core)
- [Pod Security Admission (PSA)](https://kubernetes.io/docs/concepts/security/pod-security-admission/)

#### Admission controllers

- [ImagePolicyWebhook](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#imagepolicywebhook)

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



## Footnotes

SELinux
- [What is SELinux (Security-Enhanced Linux)](https://www.redhat.com/en/topics/linux/what-is-selinux)
- [Check if SELinux is Enabled](https://docs.oracle.com/cd/E17952_01/mysql-5.7-en/selinux-checking.html)



### Install containerd and k8s 1.32 on ubuntu 24.04

1. Create t3.small ec2 instance based on ubuntu, because we need atleast 2GB RAM for k8s.

https://github.com/zealvora/certified-kubernetes-security-specialist/blob/main/domain-1-cluster-setup/kubeadm-install.md


2. Install containerd 
```
sudo apt-get update
sudo apt-get install containerd
```

3. Check
```
# check
ctr

# check runc
runc
```

4. Install kubeadm
```
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


