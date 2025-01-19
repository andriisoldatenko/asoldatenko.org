---
title: "Debugging Golang Tests With Delve"
date: 2019-07-17
categories:
- golang
- debugger
- delve
- unit-tests
- tests
- testing
---

How to debug golang unit-tests using delve 🐛🔥?

So, often you need to run 1 test and even in debug mode, for example, when you wrote a test that repeats a bug. It's very simple (although not very obvious from the docks):

```bash
dlv test -- -test.run NameOfYourTest/PartOfTheName* 
```

similar to `go test -run`.

Or a live example:

```bash
➜ debug_test dlv test -- -test.run TestFibonacciBig
(dlv) b main_test.go:6
Breakpoint 1 set at 0x115887f for github.com/andriisoldatenko/debug_test.TestFibonacciBig() ./main_test.go:6
(dlv) c
> github.com/andriisoldatenko/debug_test.TestFibonacciBig() ./main_test.go:6 (hits goroutine(17):1 total:1) (PC: 0x115887f)
1: package main
2:
3: import "testing"
4:
5: func TestFibonacciBig(t *testing.T) {
=> 6: var want int64 = 55
7: got := FibonacciBig(10)
8: if got.Int64() != want {
9: t.Errorf("Invalid Fibonacci value for N: %d, got: %d, want: %d", 10, got.Int64(), want)
10: }
11: }
(dlv)
```

Alternatively, run with -v (remember go test -v):

```bash
➜ debug_test dlv test -- -test.v -test.run TestFibonacciBig
(dlv) c
=== RUN TestFibonacciBig
--- PASS: TestFibonacciBig (0.00s)
PASS
```
