+++
title = 'KubeCon EU 2025 Day 01'
date = 2025-03-31T16:38:16+02:00
draft = true
+++

In this series I'll document talks, I've attended and some interesting ideas
or tools I found useful.

First day was day of Lighting talks so log is pretty long and each topic pretty short.
Many talks were just couple slides, even then lot's of interesting ideas, links 


### A Hitchkiers guide by Lori Lorusso and Gerald enzl
* Histroy of CNCF
* Landsacep important
* how to use landscape
Random facts:
- 208 CNCF Projects
- 756 CNCF members
- Linux foundation managed CNCF

Interesting tool for  overall health of your project is CLO monitor.

### What is Copa?
CNCF Sandbox project tot patch container ... 

How it works? There is two modes: 

### Empowering Data Protection for §Stateful Applications of k8s with kanister.io

Datadog real world Container Use Report 2022 (link)
The DAM book Digital Asses MAnagement for Photograpers (link)

Install via helm kanister controller, 3 new CRs: BluePrints, ActionSets and 


### Kubernetes SIG Storage
 
* Volume Populators 1.33
Background
Gola
Challanges:
adding support for mew data sources cannot break existing behaviour
* Always honor P±V reclaim policy


### Prom v3
7 years stability
9900 commits (v2 - v3)
1021 vommits
367 uniq contributors
(Deep Dive talk Prome)
Native histograms

### Falco monitors infractructure for sec events

Falco journey from scratch


### LitmusChaos


### Perses project update v0.51 in beta
Observability tools like Grafana

New pluging system, 

### 
Recording Application Behaviour into CRD
Node agent based on eBPF and store data in CR

Huge CRD -> 

Inspector Gadget


### Kepler Project Updates by Sunanay IBM research
\


### CI/CD observability using OpenTelemetry
New SIG, Semantic Conventions
Attris for: 
*CI/CD pipelienes `cicd.pipelinename`
* deployments `cicd.pipelinename.result`
* VCS
* testings
* ... 

### Extend Large Lang Models Training beyond single k8s cluster
LLM challanges: not enough "resources"
the scalability of single cluster is not enough
the resource utilisation is not good enough
framework did not talk with infra

### Vitness
- created by youtube (store video metadata)
- migrated in google (borg, ex borg)
- contributed to CNCF
- sacale by sharding
- cong sharding key
- zero downtime sharding operations
- vitess.io/slack
- vitessio/vitess

### Dapr by Marc Duiker
APIs for building secure and relable microservices
Dapr Workflow - long runnning jobs
llm conversation API
Dapr agents (pytho)

### flux by tamao nakahara
what do you need from CI/CD?
GitOps & Progressive deliver
automation/relability/security/scale
Usually we use it but we don't even know.
Security Slam

### Buildpacks
WHY?
heroku


### Strimzi
Operator for Apache Kafka
Doing mostly what we do in dynatrace-operator
Strimzicon June 4, 2025 (remote)
@strimzi

### Essension gRPC resources for Developemnt Jung-Yu
grpci youtuebe channel
grpc-io-announce mailing list
gRPCConf 2025 (Aug 26 2025)
Call for Speakers still open
https://events.linuxfoundation.org/kubecon-cloudnativecon-europe/program/schedule/


### OpenFGA
Authorization system for developers
ReBAC - is an evolution RBAC and ABAC. Used in google drive, google cloud etc
Maintened by Okta and Grafana
how is being used?
search github by "OpenFGA" 


### What Porter?
Bundle and ddostribute uoir application

Porter yaml example:
k8s operator \ with mongoDB as storage

### What is Konveyor AI?

https://events.linuxfoundation.org/kubecon-cloudnativecon-europe/program/schedule/

### Why LWS?

picture on phone

Superpod as an unit
dual-template, one for leader and one fro the workers 
a scale subresources
rollout and rolling update
tooplogiy-aware placemements
all-kr nothing restart for failure 
Project integrations:

llmaz
sglang
vLLM


### Project Capsule by auth

multi-tennancy in k8s is hard we mad it simple
Manging multi-tenanncy envs in k8s is complex, constly and often inefficient.
(based on Operator, CRDS)

looking for maintainers