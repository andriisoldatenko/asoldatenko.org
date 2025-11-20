+++
title = 'Certified Kubernetes Security [CKS] reading list'
date = 2025-11-06T08:39:07+01:00
draft = true
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




## Footnotes

SELinux
- [What is SELinux (Security-Enhanced Linux)](https://www.redhat.com/en/topics/linux/what-is-selinux)
- [Check if SELinux is Enabled](https://docs.oracle.com/cd/E17952_01/mysql-5.7-en/selinux-checking.html)

