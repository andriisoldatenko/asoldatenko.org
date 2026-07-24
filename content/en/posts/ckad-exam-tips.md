+++
title = 'CKAD Exam Tips'
date = 2026-02-02T14:49:52+01:00
draft = true
+++

* [Intro](#intro)
* [Aliases](#aliases)
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

## Aliases

```vimrc
set expandtab
set tabstop=2
set shiftwidth=2
```

```bash
export Y="-oyaml"

export F="--grace-period=0 --force"
```

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

Jobs/Cronsjobs

https://kubernetes.io/docs/concepts/workloads/controllers/ttlafterfinished/
https://kubernetes.io/docs/concepts/workloads/controllers/job/
https://kubernetes.io/docs/concepts/workloads/controllers/cron-jobs/

```yaml
# more details https://kubernetes.io/docs/concepts/workloads/controllers/job/#job-termination-and-cleanup
activeDeadlineSeconds: 20
```
> Another way to terminate a Job is by setting an active deadline. The activeDeadlineSeconds applies to the duration 
> of the job, no matter how many Pods are created. Once a Job reaches activeDeadlineSeconds, 
> all of its running Pods are terminated and the 

> Note that a Job's .spec.activeDeadlineSeconds takes precedence over its .spec.backoffLimit. Therefore, a Job that 
> is retrying one or more failed Pods will not deploy additional Pods once it reaches the time limit specified by 
> activeDeadlineSeconds, even if the backoffLimit is not yet reached.

### Understand multi-container Pod design patterns (e.g. sidecar, init and others)



[Side containers](https://kubernetes.io/docs/concepts/workloads/pods/sidecar-containers/) `restartPolicy: Always`:

```bash
spec:
  containers:
    - name: myapp
      image: alpine:latest
      command: ['sh', '-c', 'while true; do echo "logging" >> /opt/logs.txt; sleep 1; done']
      volumeMounts:
        - name: data
          mountPath: /opt
  initContainers:
    - name: logshipper
      image: alpine:latest
      # Setting restartPolicy: Always makes this a sidecar container.
      restartPolicy: Always
      command: ['sh', '-c', 'tail -F /opt/logs.txt']
      volumeMounts:
        - name: data
          mountPath: /opt
```


### Utilize persistent and ephemeral volumes

> Note:
> Persistence volume can be created only imperatively, not declaratively.
> kubectl create pv <name> --help WON'T WORK
> same for PV Claims

## Application Deployment

### Use Kubernetes primitives to implement common deployment strategies (e.g. blue/green or canary)
### Understand Deployments and how to perform rolling updates
### Use the Helm package manager to deploy existing packages
### Kustomize

## Application Observability and Maintenance

### Understand API deprecations
### Implement probes and health checks

```bash
k explain pod.spec.containers.readinessProbe --recursive
  exec  <ExecAction>
    command     <[]string>
  failureThreshold      <integer>
  grpc  <GRPCAction>
    port        <integer> -required-
    service     <string>
  httpGet       <HTTPGetAction>
    host        <string>
    httpHeaders <[]HTTPHeader>
      name      <string> -required-
      value     <string> -required-
    path        <string>
    port        <IntOrString> -required-
    scheme      <string>
    enum: HTTP, HTTPS
  initialDelaySeconds   <integer>
  periodSeconds <integer>
  successThreshold      <integer>
  tcpSocket     <TCPSocketAction>
    host        <string>
    port        <IntOrString> -required-
  terminationGracePeriodSeconds <integer>
  timeoutSeconds        <integer>
```

liveness probe: `k explain pod.spec.containers.livenessProbe --recursive`

### Use built-in CLI tools to monitor Kubernetes applications

```bash
k top pods --sort-by=memory

k top pods --sort-by=cpu
```

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

```bash
kubectl explain limitrange.spec --recursive

FIELDS:
  limits        <[]LimitRangeItem> -required-
    default     <map[string]Quantity>
    defaultRequest      <map[string]Quantity>
    max <map[string]Quantity>
    maxLimitRequestRatio        <map[string]Quantity>
    min <map[string]Quantity>
    type        <string> -required-
```

```bash
kubectl explain resourcequota.spec --recursive

FIELDS:
  hard  <map[string]Quantity>
  scopeSelector <ScopeSelector>
    matchExpressions    <[]ScopedResourceSelectorRequirement>
      operator  <string> -required-
      enum: DoesNotExist, Exists, In, NotIn
      scopeName <string> -required-
      enum: BestEffort, CrossNamespacePodAffinity, NotBestEffort, NotTerminating, ....
      values    <[]string>
  scopes        <[]string>
```

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

Create Service account:

```bash
k create sa dashboard-sa
```

To decode service account public part
```bash
jwt_decode () {
        jq -R 'split(".") | .[1] | @base64d | fromjson' <<< "$1"
}
```

```bash
jwt_decode `k create token dashboard-sa`
{
  "aud": [
    "https://kubernetes.default.svc.cluster.local"
  ],
  "exp": 1777315468,
  "iat": 1777311868,
  "iss": "https://kubernetes.default.svc.cluster.local",
  "jti": "c9b3bdff-14a6-4eae-b697-43a31fa59a48",
  "kubernetes.io": {
    "namespace": "default",
    "serviceaccount": {
      "name": "dashboard-sa",
      "uid": "5a738c10-058e-4073-9e66-bfd3bf6b1a08"
    }
  },
  "nbf": 1777311868,
  "sub": "system:serviceaccount:default:dashboard-sa"
}
```

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

TIP: create service for existing deployment
```
k expose deploy <deployment-name> --port=80 --target-port=8080 --name=<service-name>
```

### Demonstrate basic understanding of NetworkPolicies

> Note:
> Network Policies can be created only imperatively, not declaratively.
> kubectl create networkpolicy <name> --help WON'T WORK

```bash
k run test --image=busybox --labels=app=test --restart=Never --rm -it -- /bin/sh
nc -zv -w 0 <pod-ip> 80
```

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



Taints and tolerations

```bash
k taint nodes node-name key=value:taint-effect

# taint-effect
# NoSchedule/PreferNoSchedule/NoExecute

k describe node kind-control-plane | grep -i taints
Taints:             <none>
```

```bash
k explain pod.spec.tolerations

FIELDS:
  effect        <string>
  enum: NoExecute, NoSchedule, PreferNoSchedule
  key   <string>
  operator      <string>
  enum: Equal, Exists
  tolerationSeconds     <integer>
  value <string>
```

Node Affinity (restricts pod for certain nodes)
```bash
k explain deploy.spec.template.spec.affinity


```


Find all resources via labels selectors and count:
```bash
kubectl get all --selector env=dev,bu=finance --no-headers | wc -l
```


TIP: how to set env vars for deployment
```
k set env deploy/nginx ANDRII=test

k set env deploy/nginx --list
# Deployment nginx, container nginx
DEBUG=true
ANDRII=test
```


VIM TIP:
How to apply yaml from vim buffer without saving it to file:
```
kubectl run alpha --image=redis --dry-run=client -o yaml | vim -

:%w !kubectl apply -f -
```

Review kubectl commands:
https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

## Practice
- https://github.com/dgkanatsios/CKAD-exercises/tree/main
- https://www.linkedin.com/pulse/my-ckad-exam-experience-atharva-chauthaiwale/
- https://medium.com/@harioverhere/ckad-certified-kubernetes-application-developer-my-journey-3afb0901014
- https://github.com/lucassha/CKAD-resources