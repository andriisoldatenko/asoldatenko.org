---
title: "Watch public talks"
weight: 1
date: 2024-02-12
categories:
  - youtube
  - watch talks
  - tech talks
---

### Motivation

Recently I've decided to watch tech talks mostly everyday, instead of some random videos.
I don't remember where, but I read about similar challenge from others.

### how?

Few years ago I had a bash script to fetch vidoes stattistics from youtube and sort it by number of likes and number of vies.
And I decided to created small cli tool to do it again:

```bash
go install github.com/andriisoldatenko/ytstat@latest

ytstat -playListID PLHhKcdBlprMdIMzUZX6ho0OPTikTamLwa -apiKey <apiKey> | jq

...
  {
    "title": "Hands-On with an Envoy API Gateway, Now with GraphQL! - Jim Barton, Solo.io",
    "viewCount": 352
  },
  {
    "title": "Container-native pipelines with Drone CI - Jim Sheldon, Harness",
    "viewCount": 427
  },
  {
    "title": "Hobbyfarm - an OpenSource Kubernetes Training Environment - Enrico Bartz, SVA",
    "viewCount": 506
  },
  {
    "title": "IPv6 / Dual-Stack in Kubernetes - Why, When, Where and How? - Rastislav Szabo, Kubermatic",
    "viewCount": 697
  },
  {
    "title": "ContainerDays 2022 Aftermovie",
    "viewCount": 857
  },
  {
    "title": "The future of CRDs in a post-cluster world - Sebastian Scheele & Stefan Schimanski",
    "viewCount": 957
  }
]
```

### Favorite Talks

* TODO

### Watched Talks

1. #### [The future of CRDs in a post-cluster world - Sebastian Scheele & Stefan Schimanski](https://www.youtube.com/watch?v=dg0g15Qv5Fo&list=WL)

Interesting idea how to connect CRD/operators and SaaS providers like MongoDB.
`TIL`: https://github.com/kube-bind/kube-bind
