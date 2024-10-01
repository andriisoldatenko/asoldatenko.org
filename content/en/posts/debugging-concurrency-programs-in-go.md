---
title: "Debugging concurrency programs in Go"
date: 2023-04-29T11:52:42+02:00
description: "Debugging a Go Application Inside a Multi Stage Docker Container"
categories:
- golang
- debugger
- delve
- docker
draft: true
---


Recently the interest in concurrent programming has grown dramatically. Unfortunately, parallel programs do not always 
have reproducible behavior. Even when they are run with the same inputs, their results can be radically different. 
In this talk I’ll show how to debug concurrency programs in Go.

I’ll start from showing how you can debug your gorotines using delve and gdb debuggers. Then I’ll try to visualize 
goroutines using different scenarios, sometimes it helps to better understand how things work. Next part of the 
topic will be about dumping a goroutine stack trace of your application while it’s running and inspect what each 
goroutine is doing. And I’ll demonstrate how to debug leaking goroutines by tracing the process of how the scheduler 
runs goroutines on logical processors which are bound to a physical processor via the operating system thread that is 
attached.

As a bonus I’ll cover debugging tips on how to find deadlocks and how to avoid race conditions in your application.
