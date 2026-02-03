+++
title = 'Kubernetes Application Developer Reading List'
date = 2026-02-02T14:49:52+01:00
draft = true
+++

## Domains & Weighting

| Domain                                              | Weight |
|-----------------------------------------------------|--------|
| Application Design and Build                        | 20%    |
| Application Deployment                              | 20%    |
| Application Observability and Maintenance           | 15%    |
| Application Environment, Configuration and Security | 25%    |
| Services and Networking                             | 20%    |


## Application Design and Build

| topic                                                                             | notes |
|-----------------------------------------------------------------------------------|-------|
| Define, build and modify container images                                         |       |
| Choose and use the right workload resource (Deployment, DaemonSet, CronJob, etc.) |       |
| Understand multi-container Pod design patterns (e.g. sidecar, init and others)    |       |
| Utilize persistent and ephemeral volumes                                          |       |

## Application Deployment

| topic                                                                                           | notes |
|-------------------------------------------------------------------------------------------------|-------|
| Use Kubernetes primitives to implement common deployment strategies (e.g. blue/green or canary) |       |
| Understand Deployments and how to perform rolling updates                                       |       |
| Use the Helm package manager to deploy existing packages                                        |       |
| Kustomize                                                                                       |       |

## Application Observability and Maintenance

| topic                                                     | notes |
|-----------------------------------------------------------|-------|
| Understand API deprecations                               |       |
| Implement probes and health checks                        |       |
| Use built-in CLI tools to monitor Kubernetes applications |       |
| Utilize container logs                                    |       |
| Debugging in Kubernetes                                   |       |

## Application Environment, Configuration and Security

| topic                                                                  | notes |
|------------------------------------------------------------------------|-------|
| Discover and use resources that extend Kubernetes (CRD, Operators)     |       |
| Understand authentication, authorization and admission control         |       |
| Understand requests, limits, quotas                                    |       |
| Understand ConfigMaps                                                  |       |
| Define resource requirements                                           |       |
| Create & consume Secrets                                               |       |
| Understand ServiceAccounts                                             |       |
| Understand Application Security (SecurityContexts, Capabilities, etc.) |       |

## Services and Networking

| topic                                                        | notes |
|--------------------------------------------------------------|-------|
| Demonstrate basic understanding of NetworkPolicies           |       |
| Provide and troubleshoot access to applications via services |       |
| Use Ingress rules to expose applications                     |       |

## Links


## Tips

tmux - doesn't exists :( unfortently

Lists all of api-resource:
```bash
kubectl api-resources | grep deploy
deployments                         deploy       apps/v1                           true         Deployment
```

```bash
export F=--grace-period=0 --force
```

```
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


## Practice

- https://github.com/dgkanatsios/CKAD-exercises/tree/main
- 