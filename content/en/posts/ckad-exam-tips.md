+++
title = 'CKAD Exam Tips'
date = 2026-02-02T14:49:52+01:00
draft = true
+++

* [Intro](#intro)
* [Application Design and Build](#application-design-and-build)
  * [Define, build and modify container images](#define-build-and-modify-container-images)
  * [Choose and use the right workload resource (Deployment, DaemonSet, CronJob, etc.)](#choose-and-use-the-right-workload-resource-deployment-daemonset-cronjob-etc)
* [Application Deployment](#application-deployment)
  * [Use Kubernetes primitives to implement common deployment strategies (e.g. blue/green or canary)](#use-kubernetes-primitives-to-implement-common-deployment-strategies-eg-bluegreen-or-canary)
  * [Understand Deployments and how to perform rolling updates](#understand-deployments-and-how-to-perform-rolling-updates)
  * [Use the Helm package manager to deploy existing packages](#use-the-helm-package-manager-to-deploy-existing-packages)
  * [Kustomize](#kustomize)
* [Application Observability and Maintenance](#application-observability-and-maintenance)
  * [Understand API deprecations](#understand-api-deprecations)
  * [Implement probes and health checks](#implement-probes-and-health-checks)
  * [Use built-in CLI tools to monitor Kubernetes applications](#use-built-in-cli-tools-to-monitor-kubernetes-applications)
  * [Utilize container logs](#utilize-container-logs)
  * [Debugging in Kubernetes](#debugging-in-kubernetes)
* [Application Environment, Configuration and Security](#application-environment-configuration-and-security)
  * [Discover and use resources that extend Kubernetes (CRD, Operators)](#discover-and-use-resources-that-extend-kubernetes-crd-operators)
  * [Understand authentication, authorization and admission control](#understand-authentication-authorization-and-admission-control)
  * [Understand requests, limits, quotas](#understand-requests-limits-quotas)
  * [Understand ConfigMaps](#understand-configmaps)
  * [Define resource requirements](#define-resource-requirements)
  * [Create & consume Secrets](#create--consume-secrets)
  * [Understand ServiceAccounts](#understand-serviceaccounts)
  * [Understand Application Security (SecurityContexts, Capabilities, etc.)](#understand-application-security-securitycontexts-capabilities-etc)
* [Services and Networking](#services-and-networking)
  * [Demonstrate basic understanding of NetworkPolicies](#demonstrate-basic-understanding-of-networkpolicies)
  * [Provide and troubleshoot access to applications via services](#provide-and-troubleshoot-access-to-applications-via-services)
  * [Use Ingress rules to expose applications](#use-ingress-rules-to-expose-applications)
* [Practice](#practice)

## Intro

Exam takes 2 hours, k8s version is `1.35` (when i'm writing this).

## Application Design and Build

### Define, build and modify container images

It's not possible to edit specifications of an existing POD rather than:
- `spec.containers[*].image`
- `spec.initContainers[*].image`
- `spec.activeDeadlineSeconds`
- `spec.tolerations`

So what we can do, we can `kubectl edit <pod>`, then it will be rejected but stored in temp folder
`/tmp/kubectl-edit-<timestamp>.yaml`. So we can force replace it, which will delete and re-create pod.

```bash
kubectl replace --force -f /tmp/kubectl-edit-<timestamp>.yaml
```

If we want to run pod and change arguments or/and command we can run:

```bash
kubectl run --help
```
and find example section:

```bash
# Start the nginx pod using the default command, but use custom arguments (arg1 .. argN) for that command
kubectl run nginx --image=nginx -- <arg1> <arg2> ... <argN>

# Start the nginx pod using a different command and custom arguments
kubectl run nginx --image=nginx --command -- <cmd> <arg1> ... <argN>
```

Diagram how Docker entrypoint/cmd works together with k8s command/args

```bash
  DOCKERFILE                          KUBERNETES (pod spec)
  ┌─────────────────────────┐         ┌──────────────────────────────┐
  │                         │         │                              │
  │   ENTRYPOINT [...]  ────┼────────>│   command: [...]             │
  │                         │         │   # overrides ENTRYPOINT     │
  │                         │         │   # omit -> use ENTRYPOINT   │
  │                         │         │                              │
  │   CMD [...]         ────┼────────>│   args: [...]                │
  │                         │         │   # overrides CMD            │
  │                         │         │   # omit -> use CMD          │
  │                         │         │                              │
  └─────────────────────────┘         └──────────────────────────────┘
  
  FINAL COMMAND =  command (or ENTRYPOINT)  +  args (or CMD)
                   └──────────────────────┘    └────────────┘
                        the executable           the flags
  
````  

### Choose and use the right workload resource (Deployment, DaemonSet, CronJob, etc.)

### Understand multi-container Pod design patterns (e.g. sidecar, init and others)

### Utilize persistent and ephemeral volumes


## Application Deployment

### Use Kubernetes primitives to implement common deployment strategies (e.g. blue/green or canary)
### Understand Deployments and how to perform rolling updates
### Use the Helm package manager to deploy existing packages
### Kustomize

## Application Observability and Maintenance

### Understand API deprecations
### Implement probes and health checks
### Use built-in CLI tools to monitor Kubernetes applications
### Utilize container logs
### Debugging in Kubernetes

## Application Environment, Configuration and Security

### Discover and use resources that extend Kubernetes (CRD, Operators)

### Understand authentication, authorization and admission control

### Understand requests, limits, quotas

### Understand ConfigMaps

Mount env variable from configMap:

We can go to k8s docs ([Use ConfigMap-defined environment variables in Pod commands](https://kubernetes.io/docs/tasks/configure-pod-container/configure-pod-configmap/#use-configmap-defined-environment-variables-in-pod-commands))
or use `k explain`:

```bash
k explain pod.spec.containers.env.valueFrom | grep '<'
FIELD: valueFrom <EnvVarSource>
  configMapKeyRef       <ConfigMapKeySelector>
```

```bash
k run pod -oyaml --dry-run=client --image=nginx
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: pod
spec:
  containers:
  - image: nginx
    name: pod
    env:
      - name: ENV_NAME
        valueFrom:
          configMapKeyRef:
            name: configmap-name
            key: ENV_NAME
```

### Define resource requirements

<HERE>

### Create & consume Secrets

Similar approach but to mount all env vars from secret, assuming we created secret:

```bash
k create secret generic db-secret --from-literal=DB_Host=sql01 \
  --from-literal=DB_User=root --from-literal=DB_Password=password123
```

It's much faster to use again `k explain` instead of open browser and search for k8s docs with exact similar example
plus if you use combinations of `--recursive` and part of the spec you are interested in:

```bash
k explain pod.spec.containers.envFrom.secretRef

# or to print all fields recursive

k explain pod --recursive
```

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: webapp-pod
spec:
  containers:
  - image: nginx
    name: webapp
    envFrom:
    - secretRef:
        name: db-secret 
```

### Understand ServiceAccounts

### Understand Application Security (SecurityContexts, Capabilities, etc.)

Top (pod) level security context:

```bash
k explain pod.spec.securityContext --recursive
```

or you can grep to see all fields, but `--recursive` is better since we can see all internal 
fields, do it once and copy when necessary during solving tasks:

```bash
k explain deploy.spec.template.spec.containers.securityContext | grep '<'
FIELD: securityContext <SecurityContext>
  allowPrivilegeEscalation      <boolean>
  appArmorProfile       <AppArmorProfile>
  capabilities  <Capabilities>
  privileged    <boolean>
  procMount     <string>
  readOnlyRootFilesystem        <boolean>
  runAsGroup    <integer>
  runAsNonRoot  <boolean>
  runAsUser     <integer>
  seLinuxOptions        <SELinuxOptions>
  seccompProfile        <SeccompProfile>
  windowsOptions        <WindowsSecurityContextOptions>
```

Container level security context:

```bash
k explain pod.spec.containers.securityContext --recursive
```

> `capabilities.add` is only exist on container level 


Find current user which container is running:

```bash
$ k exec pod -- whoami
root
# or id
$ k exec pod -- id
uid=0(root) gid=0(root) groups=0(root)
```

## Services and Networking

### Demonstrate basic understanding of NetworkPolicies

### Provide and troubleshoot access to applications via services

### Use Ingress rules to expose applications

## Links

## Tips

> NOTE: tmux - doesn't exists :( unfortently

Lists all of api-resource:
```bash
kubectl api-resources | grep deploy
deployments                         deploy       apps/v1                           true         Deployment
```

```bash
export F="--grace-period=0 --force"
```


## Practice
- https://github.com/dgkanatsios/CKAD-exercises/tree/main