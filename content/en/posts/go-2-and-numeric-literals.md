---
title: "Go 2 and Numeric Literals"
date: 2019-08-22T19:13:15+02:00
tags: ["golang", "numeric literals", "go2"]
categories:
- golang
- numeric literals
- go2
---

Tl;dr Go version 2 is going to add some changes that will affect numeric literals. Everybody already knew it didn't they?
Let's see what is already in the go repo in the master branch:

```bash
$ git clone git@github.com:golang/go.git
$ cd go/src && ./all.bash
$ go version devel +eee07a8e68 Wed Aug 21 15:20:00 2019 +0000 darwin/amd64
```
One of the most noticeable for me is of course _ in numbers).

here is example:

```go
package main

func main() {
    println("1_200_000 -> ", 1_200_000)
    println("3.1415_9265 -> ", 3.1415_9265)
    println("0b0110_1101_1101_0010 -> ",0b0110_1101_1101_0010)
    // println("0___ -> ", 0___) invalid example from discussion
    // println(" 0__.0__e-0__ -> ",0__.0__e-0__) invalid example from discussion
    // println("1__2", 1__2) invalid
}
```

So:

```bash
$ go version
$ go1.12.7 darwin/amd64
$ go run main.go
# command-line-arguments
./main.go:4:28: syntax error: unexpected _200_000, expecting comma or )
./main.go:5:35: syntax error: unexpected _9265, expecting comma or )
./main.go:6:39: syntax error: unexpected b0110_1101_1101_0010, expecting comma or )
```

Oops 😬


Second attempt:
```bash
./go version
devel +eee07a8e68 Wed Aug 21 15:20:00 2019 +0000 darwin/amd64
./go run main.go
1_200_000 -> 1200000
3.1415_9265 -> +3.141593e+000
0b0110_1101_1101_0010 -> 28114


Go 1.13RC1:
go get golang.org/dl/go1.13rc1
go1.13rc1 run main.go
1_200_000 -> 1200000
3.1415_9265 -> +3.141593e+000
0b0110_1101_1101_0010 -> 28114
```

🎉🎉🎉🎉

P.S. It's not entirely clear why it seems to be the way it should be in Go2, but got into Go 1.13 ... I probably missed something, I'll go read GIthub ...

[1] https://go.googlesource.com/proposal/+/master/design/19308-number-literals.md
