+++
title = 'CKAD Exam Tips'
date = 2026-02-02T14:49:52+01:00
draft = false
+++

## Intro

This document is dump of all my notes during preparing to my CKAD exam. Maybe somebody find
it useful as well.
Exam takes 2 hours, k8s version is `1.35` (when i'm writing this) and there was ~17 questions.
So it means you must be fast or even faster then you think, and after checking existing notes
i found that it's not about knowladge and also about speed and accuracy. So knowing how
to generate corect yaml quickly and know how to test your solution is crucial.


## Setup:
For this exam it's easy to use, in many cases, just simple kind cluster. Since exam is about
k8s 1.35:

```bash
kind create cluster --image=docker.io/kindest/node:v1.35.5
```

Set up vim
```vimrc
set expandtab
set tabstop=2
set shiftwidth=2
set ft=yaml
```

short invariant:
```vimrc
:set nu et ts=2 sw=2 ft=yaml
```

## Define, build and modify container images

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

## Choose and use the right workload resource (Deployment, DaemonSet, CronJob, etc.)

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
> `kubectl create pv <name> --help` WON'T WORK
> same for PV Claims

## Application Observability and Maintenance

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
```bash
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

Very nice tutorial: https://github.com/networkpolicy/tutorial


TIP:
```bash
FRONTEND=<pod-name>
kubectl exec -ti $FRONTEND -- curl -I --connect-timeout 5 backend:8080 | head -1

# or wget

wget --spider --timeout 1 pod-ip
```

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

Node Affinity (restricts pod for certain nodes):

```bash
k explain deploy.spec.template.spec.affinity
```


Find all resources via labels selectors and count:

```bash
kubectl get all --selector env=dev,bu=finance --no-headers | wc -l
```


TIP: how to set env vars for deployment
```bash
k set env deploy/nginx ANDRII=test

k set env deploy/nginx --list
# Deployment nginx, container nginx
DEBUG=true
ANDRII=test
```


VIM TIP:
Apply yaml from vim buffer without saving it to file:
```bash
kubectl run alpha --image=redis --dry-run=client -o yaml | vim -

:%w !kubectl apply -f -
```


Apply command `kubectl` to the current open buffer
```bash
:r!kubectl run complex-pod --dry-run=client -oyaml --image nginx:1.25.1 --port 80
```


CURL Tip:

Lets just use `alpine/curl` image:
```bash
k run test -it --image=alpine/curl
k exec -it test -- sh
# assuming we want to test nginx svc and check nginx version
watch curl -sI http://nginx.default.svc.cluster.local

Every 2.0s: curl -sI nginx                                                       2026-08-02 10:45:36

HTTP/1.1 200 OK
Server: nginx/1.23.4
Date: Sun, 02 Aug 2026 10:45:36 GMT
Content-Type: text/html
Content-Length: 615
Last-Modified: Tue, 28 Mar 2023 15:01:54 GMT
Connection: keep-alive
ETag: "64230162-267"
Accept-Ranges: bytes
```

Custom column TIP with image of container:
It's useful if we want to quickly test image version:
```bash
k get pods -o custom-columns="CONTAINER:.spec.containers[0].name,IMAGE:.spec.containers[0].image"
CONTAINER   IMAGE
grafana     grafana/grafana:10.2.1
grafana     grafana/grafana:10.2.1
grafana     grafana/grafana:10.2.1
grafana     grafana/grafana:10.2.1
grafana     grafana/grafana:10.2.1
grafana     grafana/grafana:10.2.1
nginx       nginx:1.23.0
nginx       nginx:1.23.0
nginx       nginx:1.23.0
nginx       nginx:1.23.4
nginx       nginx:1.23.4
nginx       nginx:1.23.4
test        alpine/curl
```


KIND TIP with `hostPath`

```yaml
apiVersion: kind.x-k8s.io/v1alpha4
kind: Cluster
nodes:
  - role: control-plane
    extraMounts:
      - hostPath: /Users/andrii/work/ckad-prep
        containerPath: /ckad-prep
```

```bash
kind create cluster --config kind-config.yaml
```

Review kubectl commands:
https://kubernetes.io/docs/reference/generated/kubectl/kubectl-commands

Also know when you can use imperative approach with `kubectl create`:
```bash
k create -h | grep -A18 -i avail
Available Commands:
  clusterrole           Create a cluster role
  clusterrolebinding    Create a cluster role binding for a particular cluster role
  configmap             Create a config map from a local file, directory or literal value
  cronjob               Create a cron job with the specified name
  deployment            Create a deployment with the specified name
  ingress               Create an ingress with the specified name
  job                   Create a job with the specified name
  namespace             Create a namespace with the specified name
  poddisruptionbudget   Create a pod disruption budget with the specified name
  priorityclass         Create a priority class with the specified name
  quota                 Create a quota with the specified name
  role                  Create a role with single rule
  rolebinding           Create a role binding for a particular role or cluster role
  secret                Create a secret using a specified subcommand
  service               Create a service using a specified subcommand
  serviceaccount        Create a service account with the specified name
  token                 Request a service account token
```

and when you need quickly go to k8s/docs to copy layout.

> Note: `NetworkPolicies` can't be created via imperatively

```bash
k explain netpol --recursive
```
but still go to k8s/and copy paste first example is the most quickies way
