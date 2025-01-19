---
title: "snippets"
weight: 1
date: 2024-01-31
categories:
  - go
  - golang
  - snippets
---


## This is collection of my random golang snippets

### [Prefixes for binary multiples](#prefixes-for-binary-multiples)

If you're looking for `1024` constants to prefix you binary multiples may be somewhere in `math` package, unfortunately
it doesn't exist there. But luckily I found Rob Pike's suggestion inside [go-nuts](https://groups.google.com/g/golang-nuts/c/AHoxOtHCOyw?pli=1)

```go
package main 

const (
    _ = 1 << (10*iota)
    // Prefixes for binary multiples.
 Kibi
 Mebi
 Gibi
 Tebi
 Pebi
 Exbi
)

func main() {
    println(Kibi)
}
// 1024
```
