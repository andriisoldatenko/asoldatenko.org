+++
title = 'Scc Reading List'
date = 2025-11-12T16:26:15+01:00
draft = true
+++



## Useful docs and tips about SCC


SCC - is 




* [Managing SCCs in OpenShift](https://www.redhat.com/en/blog/managing-sccs-in-openshift)
* [How to add proper Security Context Constraint (SCC) to the application in the OCP](https://access.redhat.com/solutions/7058224)
* [Chapter 15. Managing security context constraints](https://docs.redhat.com/en/documentation/openshift_container_platform/4.12/html/authentication_and_authorization/managing-pod-security-policies)


* [Seccomp defaults in Red Hat OpenShift](https://www.redhat.com/en/blog/seccomp-defaults-in-red-hat-openshift-container-platform)

> One of the reasons behind introducing the new (...)-v2 SCCs in Red Hat OpenShift Container Platform was the automatic enforcement of the RuntimeDefault seccomp profile for pods.

```bash
$ oc get scc restricted -o custom-columns=SECCOMP_PROFILE:.seccompProfiles
SECCOMP_PROFILE
<none>

$ oc get scc restricted-v2 -o custom-columns=SECCOMP_PROFILE:.seccompProfiles
SECCOMP_PROFILE
[runtime/default]
```
