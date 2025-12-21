+++
title = 'Notes from best Go Talks of 2025'
date = 2025-10-23T19:19:33+02:00
draft = false
toc = true
+++


## Intro

Already wrote a note about [why](../notes/watch-public-talks)

## GopherCon UK 2025

| title                                                                                        |   viewCount | id          | url                                         |
|----------------------------------------------------------------------------------------------|-------------|-------------|---------------------------------------------|
| What's coming in Go 1.25 - Daniel Marti                                                      |        9534 | 0SX7zjE5cuI | https://www.youtube.com/watch?v=0SX7zjE5cuI |
| Building a coding agent from scratch - Bill Kennedy                                          |        3749 | ybBVOa572Tw | https://www.youtube.com/watch?v=ybBVOa572Tw |
| Unleashing the Go Toolchain - Kemal Akkoyun                                                  |        2857 | 8Rw-fVEjihw | https://www.youtube.com/watch?v=8Rw-fVEjihw |
| Observability made painless: Go, Otel & LGTM stack - Haseeb Majid                            |        2851 | t3Xz-IrxNwk | https://www.youtube.com/watch?v=t3Xz-IrxNwk |
| The Right Kind of Abstraction - John Cinnamond                                               |        2353 | oP_-eHZSaqc | https://www.youtube.com/watch?v=oP_-eHZSaqc |
| Go Security – Past, Present, and Future - Roland Shoemaker                                   |        2069 | oLtq2sKxjto | https://www.youtube.com/watch?v=oLtq2sKxjto |
| Swiss Maps in Go - Bryan Boreham                                                             |        1928 | M05t7Q6LbFs | https://www.youtube.com/watch?v=M05t7Q6LbFs |
| How Just Eat uses tooling to deploy Go micro-services in minutes - Ainsley Clark             |        1670 | JnjKQZOsvcw | https://www.youtube.com/watch?v=JnjKQZOsvcw |
| Climbing the Testing Pyramid: From Real Service to Interface Mocks in Go - Naveen Ramanathan |        1417 | TBl_BQmu_-A | https://www.youtube.com/watch?v=TBl_BQmu_-A |
| K8s CPU Limits Deconstructed - Bill Kennedy                                                  |        1395 | jECXV2BdsI8 | https://www.youtube.com/watch?v=jECXV2BdsI8 |
| When Failure Is Not an Option: Surviving Cloud Outages in Go - Kevin Holditch                |        1322 | vrnIrHsG7HE | https://www.youtube.com/watch?v=vrnIrHsG7HE |
| Hello, MCP World! - Daniela Petruzalek                                                       |        1266 | WzfYd6cV4gE | https://www.youtube.com/watch?v=WzfYd6cV4gE |
| Deep dive into a go binary - Jesús Espino                                                    |        1249 | 5VkYXgUqxcE | https://www.youtube.com/watch?v=5VkYXgUqxcE |
| The Quest for Speed: Journey to 50% Better P99 Times with Go - David Vella                   |        1232 | AKAe9dIPdas | https://www.youtube.com/watch?v=AKAe9dIPdas |
| Deep dive into the sync package - Jesús Espino                                               |        1119 | DOj1G7CMT-I | https://www.youtube.com/watch?v=DOj1G7CMT-I |
| A Gopher's Guide to Vibe Coding - Daniela Petruzalek                                         |        1103 | keh-_VJtIwE | https://www.youtube.com/watch?v=keh-_VJtIwE |
| Go Module Hygiene: Keeping go.sum and go.mod in check - Emily Achieng                        |        1072 | sopfY7z8vyk | https://www.youtube.com/watch?v=sopfY7z8vyk |
| A Gopher's Guide to *NIX Plumbing - Eleanor McHugh                                           |         940 | sCe7V66hmOU | https://www.youtube.com/watch?v=sCe7V66hmOU |
| The Strengths of the `weak` Package: Weak Pointers Arrive in Go - Sam Burns                  |         808 | DbSQX0ERrp0 | https://www.youtube.com/watch?v=DbSQX0ERrp0 |
| Opening high traffic access points using Go - George Kampanos                                |         732 | e8dWSzd9AsM | https://www.youtube.com/watch?v=e8dWSzd9AsM |

### What's coming in Go 1.25 - Daniel Marti

full video -> [link](https://www.youtube.com/watch?v=0SX7zjE5cuI)
slides -> https://docs.google.com/presentation/d/1ut3UVJLRAgR9G7otoR6IcqTkOcca9Pf1IsAJPRszMyU/edit?slide=id.g550f852d27_228_0#slide=id.g550f852d27_228_0

* go.mode `ignore` directive https://go.dev/issue/42965
* `go doc -http` https://go.dev/issue/68106
* "work" package pattern https://go.dev/issue/50745
* greentea -> https://go.dev/issue/50745 ( very interesting reading )
* runtime execution tracer https://go.dev/issue/63185 ( very interesting reading )
* don't escape pass strings passed to `make.Unique`  https://go.dev/issue/71926  https://go.dev/issue/73680
* `os.OpenFileIn` https://go.dev/issue/67002
* `io.ReadLinkFS` https://go.dev/issue/49580
* `sync.WaitGroup.Go` https://go.dev/issue/63796
* `testing.TB.Attr` to omit key values https://go.dev/issue/43936
* `testing.TB.Output` https://go.dev/issue/59928 

reading:
- https://go.dev/blog/unique
- future of Json in GO (GopherCon 2023) youtube (it's about new Go json v2)

### Building a coding agent from scratch - Bill Kennedy

- full video -> [📹](https://www.youtube.com/watch?v=ybBVOa572Tw)

tl;dr
* Bill guides us how to build coding agent in go (no deps except http client) 
based on article [How to Build an Agent](https://ampcode.com/how-to-build-an-agent) by Thorsten Ball

### Unleashing the Go Toolchain - Kemal Akkoyun

full video -> [](https://www.youtube.com/watch?v=8Rw-fVEjihw)

tl;dr

* > "Programs must be written for people to read, and only incidentally for machines to execute"
  > from Harold Abelson

* logs (what happend)
* metrics (how much and how fast)
* traces (where did the time go?)


## GopherCon Europe Berlin 2025

| title                                                                                                |   viewCount | id          | url                                         |
|------------------------------------------------------------------------------------------------------|-------------|-------------|---------------------------------------------|
| The Things I Find Myself Repeating About Go - Dave Cheney | GopherCon EU 2025                        |        3438 | RZe8ojn7goo | https://www.youtube.com/watch?v=RZe8ojn7goo |
| Go Protobuf - Michael Stapelberg | GopherCon EU 2025                                                 |        1089 | scNYFVtD5ZM | https://www.youtube.com/watch?v=scNYFVtD5ZM |
| Refactoring Go in Large Codebases - Brittany Ellich | GopherCon EU 2025                              |         967 | fhlnan0dSUE | https://www.youtube.com/watch?v=fhlnan0dSUE |
| Faster Go Maps With Swiss Tables - Michael Pratt | GopherCon EU 2025                                 |         946 | aqtIM5AK9t4 | https://www.youtube.com/watch?v=aqtIM5AK9t4 |
| Evolving Your API - Jonathan Amsterdam | GopherCon EU 2025                                           |         783 | 9Mb0yy8u-Gs | https://www.youtube.com/watch?v=9Mb0yy8u-Gs |
| Taming the Goroutine Beast - Elad Tabak & Massimiliano Ziccardi | GopherCon EU 2025                  |         707 | Z0JJMwsArcA | https://www.youtube.com/watch?v=Z0JJMwsArcA |
| Panel with the Go Team | GopherCon EU 2025                                                           |         568 | etl1Z8T4B9g | https://www.youtube.com/watch?v=etl1Z8T4B9g |
| Testing Time (and other asynchronous code) - Damien Neil | GopherCon EU 2025                         |         522 | oIC3zhTAOsY | https://www.youtube.com/watch?v=oIC3zhTAOsY |
| Y: Recursion The Hard Way - Eleanor McHugh | GopherCon EU 2025                                       |         469 | 1hQN2BuwV4Y | https://www.youtube.com/watch?v=1hQN2BuwV4Y |
| Implementing Parallelism - Ayke van Laethem | GopherCon EU 2025                                      |         374 | t7SOnE6SfwU | https://www.youtube.com/watch?v=t7SOnE6SfwU |
| Lightning Talk: Improving The Security Of Your Go Applications - Elton Vincent | GopherCon EU 2025   |         361 | wGj26xhFQQY | https://www.youtube.com/watch?v=wGj26xhFQQY |
| Lightning Talk: An Update On TinyGo - Ron Evans | GopherCon EU 2025                                  |         315 | GmhzExxX8Xo | https://www.youtube.com/watch?v=GmhzExxX8Xo |
| Lightning Talk: Getting The Most Out Of Go Tool Dependencies - Marco Feltmann | GopherCon EU 2025    |         253 | c7LjUImAYu8 | https://www.youtube.com/watch?v=c7LjUImAYu8 |
| AI-Driven Load Test Analysis: From Routine Toward Action - Andrii Raikov | GopherCon EU 2025         |         238 | QBbdprURuRc | https://www.youtube.com/watch?v=QBbdprURuRc |
| For the Love of Go: How to Contribute Really - Arati Rana | GopherCon EU 2025                        |         222 | c0MntiRvTVA | https://www.youtube.com/watch?v=c0MntiRvTVA |
| Lightning Talk: Go-ing Native: Supercharging Windows Support In Go - Quim Muntal | GopherCon EU 2025 |         187 | NVSZ67gZhK0 | https://www.youtube.com/watch?v=NVSZ67gZhK0 |
| Speakers vs. Audience Game Show | GopherCon EU 2025                                                  |         136 | D8RAl7blJ6I | https://www.youtube.com/watch?v=D8RAl7blJ6I |


## GopherCon 2025

| title                                                                                           | viewCount | url                                         |
|-------------------------------------------------------------------------------------------------|-----------|---------------------------------------------|
| GopherCon 2025: An Operating System in Go - Patricio Whittingslow                               | 8551      | https://www.youtube.com/watch?v=SvsdVe1kgSU |
| GopherCon 2025: Advancing Go Garbage Collection with Green Tea - Michael Knyszek                | 5021      | https://www.youtube.com/watch?v=gPJkM95KpKo |
| GopherCon 2025: Go's Next Frontier - Cameron Balahan                                            | 2275      | https://www.youtube.com/watch?v=M2gduDM-MT0 |
| GopherCon 2025: Go’s Trace Tooling and Concurrency - Bill Kennedy                               | 1852      | https://www.youtube.com/watch?v=Gqo0oCfZSjg |
| GopherCon 2025: The Go Cryptography State of the Union - Filippo Valsorda                       | 1778      | https://www.youtube.com/watch?v=YnyeAQblUyA |
| GopherCon 2025: Next-Gen AI Tooling with MCP Servers in Go - Katie Hockman                      | 1522      | https://www.youtube.com/watch?v=BNVPE8k6Nmw |
| GopherCon 2025: Plowing Through Data  Building Flexible Pipelines with Go - Mindy Ratcliff      | 1457      | https://www.youtube.com/watch?v=R-P9Ltjc_uw |
| GopherCon 2025: My Protobuf Module is Faster than Yours (Because I Cheated) - Tom Lyons         | 1254      | https://www.youtube.com/watch?v=eWZ8pNMpqcU |
| GopherCon 2025: Challenge Series Official Theme Reveal Trailer CodePros CTF Cybersecurity Event | 1208      | https://www.youtube.com/watch?v=oIak1vTLbTw |
| GopherCon 2025: Profiling Request Latency with Critical Path Analysis - Felix Geisendörfer      | 1026      | https://www.youtube.com/watch?v=BayZ3k-QkFw |
| GopherCon 2025: Analysis and Transformation Tools for Go Codebase Modernization - Alan Donovan  | 990       | https://www.youtube.com/watch?v=_VePjjjV9JU |
| GopherCon 2025: Building a Decentralized Social Media App with Go and ATProto - Gautam Dey      | 737       | https://www.youtube.com/watch?v=7ZbefJSvdQ0 |

## GopherCon Israel 2025

| title                                                                                        |   viewCount | id          | url                                         |
|----------------------------------------------------------------------------------------------|-------------|-------------|---------------------------------------------|
| Leak and Seek: A Go Runtime Mystery / Adi Abramovitch & Amit Yahav                           |         244 | 94wG_LJH86U | https://www.youtube.com/watch?v=94wG_LJH86U |
| Building scalable multi-tenant applications with Go / Rotem Tamir                            |         202 | s911eqBYk-c | https://www.youtube.com/watch?v=s911eqBYk-c |
| MCP's in Go - expose your tool to LLMs / Yoni Davidson                                       |         197 | GR_8-D9NWKA | https://www.youtube.com/watch?v=GR_8-D9NWKA |
| Go Hot-Swap Plugins / Sagi Rosenthal                                                         |         187 | ARRk_rjXm_k | https://www.youtube.com/watch?v=ARRk_rjXm_k |
| Concurrency in Action: Go Techniques and Tips / Gili Kamma                                   |         153 | n6xBEqZLLLc | https://www.youtube.com/watch?v=n6xBEqZLLLc |
| One Does Not Simply Iterate over Mordor / Miki Tebeka                                        |         116 | kfs7jUYnueU | https://www.youtube.com/watch?v=kfs7jUYnueU |
| Dependency injection with Go: improved testing with modular code / Igor Bezukh               |         111 | lQi_e-QJSmc | https://www.youtube.com/watch?v=lQi_e-QJSmc |
| Realtime Magic: The Go-Powered Engine Behind Millions of Decisions Per Second / Or Yarnitzky |         109 | iNMFfSCx4AA | https://www.youtube.com/watch?v=iNMFfSCx4AA |
| Preemptive Scheduling Strikes Back: How to Avoid CPU-Hogging Goroutines / Dmitry Rubinstein  |          84 | 704RWBBw0gA | https://www.youtube.com/watch?v=704RWBBw0gA |
| Go call the DevOps - the web3 edition! / Gil Bahat                                           |          81 | ljYatzc0CnE | https://www.youtube.com/watch?v=ljYatzc0CnE |
| Building scalable multi-tenant applications with Go / Rotem Tamir                            |          20 | Lxo5epbeozQ | https://www.youtube.com/watch?v=Lxo5epbeozQ |

