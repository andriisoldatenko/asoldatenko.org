---
title: "KubeCon EU 2025"
date: 2025-04-03T09:04:16+02:00
description: "Different links and notes from kubecon in London 2025"
toc: true
categories:
  - kubernetes
  - cncf
  - opentelemetry
  - copacetic
  - prometheus
  - litmuschaos
  - Perses
  - Kepler
  - Vitness
  - flux
  - Buildpacks
  - Strimzi
  - gRPC
  - OpenFGA
  - Porter
  - Konveyor AI
  - kai
  - Capsule
  - CNAP/CNPE
  - LLMS
  - c
  - rust
  - Observability
  - Cert-manager
  - CRD
  - Inspektor Gadget
  - pipeCD
tags:
- kubernetes
- cncf
- opentelemetry
- copacetic
- prometheus
- litmuschaos
- Perses
- Kepler
- Vitness
- flux
- Buildpacks
- Strimzi
- gRPC
- OpenFGA
- Porter
- Konveyor AI
- kai
- Capsule
- CNAP/CNPE
- LLMS
- c
- rust
- Observability
- Cert-manager
- CRD
- Inspektor Gadget
- pipeCD
---

In this article, I'll document notes from [kubecon](https://events.linuxfoundation.org/kubecon-cloudnativecon-europe/)
talks, I've attended and some interesting ideas or tools I found useful.

## Day01

The First day was day of Lighting talks, so the log is pretty long, and each topic pretty short.
Many talks were just a couple slides, even then lots of interesting ideas, links.

### A Hitchhiker's Guide to the CNCF Landscape- Katherine Druckman, Lori Lorusso

* History of CNCF
* Landscape important
* how to use landscape

**Random facts:**

* 208 CNCF Projects
* 756 CNCF members
* Linux foundation managed CNCF
* An Interesting tool for the overall health of your project is [CLO monitor](https://clomonitor.io/search?page=1).

### What is [Copa](https://github.com/project-copacetic/copacetic)?

CNCF Sandbox project and CLI tool for directly patching container images using reports from
vulnerability scanners.

### Empowering Data Protection for Stateful Applications of k8s with[kanister.io](https://www.kanister.io/)

Datadog real world Container Use Report 2022 ([link](https://www.datadoghq.com/container-report/))
The DAM book Digital Asses Management for Photograpers (link)
Install via helm kanister controller, 3 new CRs: BluePrints, ActionSets and...

### Kubernetes SIG Storage report

* Volume Populators in k8s 1.33
* Goal: challenges: adding support for mew data sources cannot break existing behaviour
* Always honor P±V reclaim policy

### Prometheus v3

7 years stability
9900 commits (v2 - v3)
1021 vommits
367 uniq contributors
(Deep Dive talk Prome)
Native histograms

[//]: # (### Falco monitors infrastructure for sec events)
[//]: # ()
[//]: # (Falco journey from scratch)

### [LitmusChaos](https://litmuschaos.io/)

Litmus is an open source Chaos Engineering platform that enables teams to identify weaknesses & potential outages
in infrastructures by inducing chaos tests in a controlled way.

### [Perses](https://perses.dev/) project update v0.51 in beta

Observability tools like Grafana. Also nn open specification for dashboards. The open dashboard tool for Prometheus
and other data sources.
New pluging system, more details in docs.

[//]: # (### )
[//]: # (Recording Application Behaviour into CRD)
[//]: # (Node agent based on eBPF and store data in CR)
[//]: # (Huge CRD ->)
[//]: # (Inspector Gadget)

### [Kepler Project](https://github.com/sustainable-computing-io/kepler) Updates by Sunanay IBM research
>
>Kepler (Kubernetes-based Efficient Power Level Exporter) uses eBPF to probe energy related system stats
and exports as Prometheus metrics.

### CI/CD observability using OpenTelemetry

New SIG, Semantic Conventions
Attris for:
*CI/CD pipelienes `cicd.pipelinename`

* deployments `cicd.pipelinename.result`
* VCS
* testings
* ...

### Extend Large Lang Models Training beyond single k8s cluster

LLM challenges: not enough "resources"
the scalability of a single cluster is not enough
the resource utilization is not good enough
frameworks did not talk with infra

### [Vitness](https://vitess.io/) is
>
> MySQL-compatible, horizontally scalable, cloud-native database solution.

* created by youtube (store video metadata)
* migrated in google (borg, ex borg)
* contributed to CNCF
* sacale by sharding
* cong sharding key
* zero downtime sharding operations
* vitess.io/slack
* vitessio/vitess

### [Dapr](https://dapr.io/) by Marc Duiker

APIs for building secure and relable microservices
Dapr Workflow - long running jobs
llm conversation API
Dapr agents (pytho)

### [flux](https://fluxcd.io/) by tamao nakahara
>
> Open and extensible continuous delivery solution for Kubernetes. Powered by GitOps Toolkit.
what do you need from CI/CD?
GitOps & Progressive deliver
automation/relability/security/scale
Usually we use it but we don't even know.
Security Slam

### [Buildpacks](https://www.cncf.io/projects/buildpacks/)

WHY?
heroku

### [Strimzi](https://strimzi.io/)

Operator for Apache Kafka
Doing mostly what we do in dynatrace-operator
Strimzicon June 4, 2025 (remote)
@strimzi

### Essension gRPC resources for Development Jung-Yu

grpci youtuebe channel
grpc-io-announce mailing list
gRPCConf 2025 (Aug 26 2025)
Call for Speakers still open
https://events.linuxfoundation.org/kubecon-cloudnativecon-europe/program/schedule/

### [OpenFGA](https://www.cncf.io/projects/openfga/)
>
>OpenFGA is a high performance and flexible authorization/permission system built for
> developers and inspired by Google Zanzibar

Authorization system for developers
ReBAC is an evolution of RBAC and ABAC. Used in Google drive, Google Cloud etc
Maintened by Okta and Grafana,
how is being used?
search github by "OpenFGA"

### What [Porter](https://www.cncf.io/projects/Porter/)?
>
>Porter enables you to package your application artifact, client tools, configuration and deployment logic
> together as an installer that you can distribute, and install with a single command.

Porter yaml example:
k8s operator \ with mongoDB as storage

### What is[Konveyor AI?](https://github.com/konveyor/kai)

more details in [README.md](https://github.com/konveyor/kai)

[//]: # (### Why LWS?)
[//]: # ()
[//]: # (picture on phone)
[//]: # (Superpod as an unit)
[//]: # (dual-template, one for leader and one fro the workers)
[//]: # (a scale subresources)
[//]: # (rollout and rolling update)
[//]: # (tooplogiy-aware placemements)
[//]: # (all-kr nothing restart for failure)
[//]: # (Project integrations:)
[//]: # ()
[//]: # (llmaz)
[//]: # (sglang)
[//]: # (vLLM)

### Project [Capsule](https://www.cncf.io/projects/capsule/) by auth

multi-tenancy in k8s is hard we mad it simple
Manging multi-tenancy envs in k8s is complex, costly and often inefficient.
(based on Operator, CRDS)
looking for maintainers

[//]: # (### Keynote 1 )
[//]: # ()
[//]: # (Tag Security)
[//]: # (OpenSSF)
[//]: # (The Fukami Map)

## Day02

First day with big keynotes and huge audience: pic from phone

### Keynote 1 by Chrish Aniszczyk

* 12000 attendees largest kubecon
* Cloud Native: 10-years old
* History of  KubeCon 2016 London (first kubecon) Dec 2016 first board meeting, march 2016 also #cNTEcf meetups this year
* Golden kubeastrounat includes not only k8s certification but others like istio, argo
* New certifications: CNAP/CNPE.
* Certified Open source Developer Export(CODE).
* [kcp project](https://github.com/kcp-dev/kcp) (check)
* Future kubecons (2026-2027):
* KbeCon Ch, KubeCon India, KubeCon Japan, KubeCon North America
* Next year → 2026 KubeCon EU in Amsterdam, LA kubeCon North America 2026, 2027 Barcelona, Spain 2027

### Keynote 2: Christine honey comp

* LLm != like APIs we know and love
* Normal APIs against LLMs

|              | Normal API | LLMS |
|--------------|------------|------|
| unit test    | can cscope |      |
| reproducible |            |      |

* [honeycomom hard stuff nobody talks about llm](https://www.honeycomb.io/blog/hard-stuff-nobody-talks-about-llm)
* [Book Observability LLM models](https://www.oreilly.com/library/view/observability-for-large/9781098159757/)( orelly )
* [Observability engineering](https://www.oreilly.com/library/view/observability-engineering/9781492076438/

### Keynote 3: Dynamic scheduling every layer

* SIG Node
* SIG Scheduling
* SIG Multicluster

### Keynote 5: Evolving the k8s UX

* In-cluster web portal k8s dashboard++
* unified management UI
* k8s desktop experience (local) to bring more users
* when talk is published, there was a slide with demostrating how windows UI brough 10mln users
compare to windows CMD old school interface.

[Headlamp project](https://headlamp.dev/) sanbox project, now in SIG-UI
really nice one!

### Keynote 6: Rust in the linux Kernel: a new era for cloud native performance and security by Greg kroah-hartman

* C and Rust and Linux
* what Linux is?
* 4992 devs

Linux Developer Community

* 76,496 changes accepted
* 8.7 changes per hour
* 40 changes per day in stable trees
* 13 CVEs assigned per day
* New release every 8-9 weeks

Rust can make reviewing code easier

* Enforce validation of untrusted data
* Enforce memory lifetime rules
* Enforce locking rules
* Enforce error handling
* Enforce type safety

**This talk was perfect, highly recommended to rematch!**

[//]: # (?? note may be writing article in more details cause quiet interesting)

### Observability

OpenTelemetry

* instrument once used everywhere
* separate telemetry generation from analysis
* make software bservable by default
* improve how we use telemetry
* OpenTelemetry Operator
* Perses—Open dashboard cncf project (also operator-based)
* node collector (based on Ebpf)

### Standardizing Ci/CI observability wtih Otel: Insights from the ci/cd observability SIG

Great talk and demos!

TODO: will add link when it's published

[//]: # (Idea for my talk to cshow about CI/CD observability)

### Cert manager Contrib fest

https://github.com/cert-manager/community/blob/main/GOVERNANCE.md
https://docs.google.com/spreadsheets/d/1zThfUB22HHdHAiRvS3ctbj4Da7j30imnUleURjxTYE0/edit?gid=421492367#gid=421492367
I've created first PR, and will continue after kubecon.
https://github.com/cert-manager/trust-manager/issues/457
https://github.com/cert-manager/cmctl?tab=readme-ov-file

### Open Telemetry Contrib fest

https://github.com/open-telemetry/opentelemetry-go/issues/6524
https://github.com/cert-manager/csi-driver/issues/171
https://github.com/cert-manager/makefile-modules/issues/154

### Kubernetes CRD Design for the Long Haul: Tips, Tricks, and Lessons Learned

by Christian Schlotter, Broadcom & Fabrizio Pandini, VMware by Broadcom:

* avoiding making mistakes to at will force you
* K8s API linter (KAL)
* Read API types top down
* Define a glossary

great talk. [slides](https://static.sched.com/hosted_files/kccnceu2025/3f/Kubernetes%20CRD%20Design%20for%20the%20Long%20Haul_%20Tips%2C%20Tricks%2C%20and%20Lessons%20Learned.pptx.pdf)

## Day03

### Keynotes

It was hard to distingvish or find useful links/ideas from few leynotes, so I just put it all together.
It is a big talent to talk 40 minutes about nothing and everything without clear ideas or thoughts.

* Peptone
* Backstage https://github.com/backstage/backstage
* apple intelligence: gRPC
* https://gitjobs.dev/
* Podcast secret source (open source podcast )
* Cloud native AI group
* CNCF at Ten: "Next Chapter in Native Cloud Computing" first talk k8s" and  "Introducing the foundation"
* instead of trends find gaps
* MCP (agent and tools)
* Orelly book AI Gateways in enterprice
* kgateway

[//]: # (https://github.com/backstage/backstage/blob/master/CONTRIBUTING.md#review-tips interesting for my talk)
[//]: # (CI/CD from otel project also nice example)
[//]: # (write eBPF node agent )
[//]: # (read containers security book/intro eBPF )

### Talk by Commonly used query language

CNCF Observability Tag is working on research around an open observability query semantic definition.
Google is working on OSS SQL extensions with pipe syntax and timesirees operators
to well support observability quieries and share with the community.

### [Beyond Limits: Scaling k8s controllers horizontally](https://static.sched.com/hosted_files/kccnceu2025/c6/Beyond%20The%20Limits.pdf)

Problem:
Controllers must prevent conflicts

* Perform leader election
* Only a single active instance
* Controllers are not horizontally scalable
* Limits large-scale use cases
* No standard solution exists

Design – Key Feature

* Sharding mechanisms inspired by distributed databases
* Dynamic membership and failure detection
* Automatic failover and rebalancing
* Transparent label-based coordination
* Prevents concurrent reconciliations
* Reusable implementation

### Contribfest about Inspektor Gadget

https://github.com/inspektor-gadget/Contribfest-KubeCon-Europe2025/blob/main/labs/collecting-metrics-with-ig/README.md
https://github.com/inspektor-gadget/inspektor-gadget/issues/1650

### ContribFest KubeStellar

https://clotributor.dev/search

## Day 4

### ContribFest [pipeCD](https://github.com/pipe-cd/pipecd)

>A GitOps style continuous delivery platform that provides consistent deployment and operations experience for any applications

### Flight home :airplane:
