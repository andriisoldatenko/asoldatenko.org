---
title: Eloquent fibonacci sequences in python
date: 2025-12-11T10:00:00+02:00
tags: ["python", "tips", "tricks", "python3", "fibonacci"]
toc: true
categories:
- python
- tips 
- tricks 
- python3 
- fibonacci
---

## Quick introduction

The idea of this article to collect eloquent python solutions for generating Fibonacci sequence and/or
related problems.

## Recursive approach

```python
def fibonacci1(n):
    if n < 2:
        return n
    return fibonacci1(n - 2) + fibonacci1(n - 1)
    
if __name__ == '__main__':
    from timeit import timeit
    print(timeit("fibonacci1(5)", setup="from __main__ import fibonacci1")) 
```

```bash
$ python3 fibonacci1_bench.py # On my MacBook Pro (Mid 2015) 2.5 GHz Intel Core i7, 16 GB 1600 MHz DDR3
2.0335577040023054
```

## Recursive approach using caching

My favorite advice: you should know your language standard library.
You can find lots of info under [functools](https://docs.python.org/3/library/functools.html#functools.lru_cache) module docs.
Default `maxsize` is `128` for `lru_cache` decorator.

```python
import functools


@functools.lru_cache()
def fibonacci2(n):
    if n < 2:
        return n
    return fibonacci2(n - 2) + fibonacci2(n - 1)

    
if __name__ == '__main__':
    from timeit import timeit
    print(timeit("fibonacci2(5)", setup="from __main__ import fibonacci2"))
```

```bash
$ python3 fibonacci2_bench.py
0.09731649799505249
```

## Iterative approach

```python
def fibonacci_iterative(n):
    if n <= 1:
        return n

    previous = 0
    current = 1

    for _ in range(n - 1):
        previous, current = current, previous + current

    return current
```

or more pythonic way using generators:

```python
def fibonacci_generator():
    a, b = 0, 1
    while True:
        yield a
        a, b = b, a + b

if __name__ == '__main__':
    from timeit import timeit
    print(timeit("list(itertools.islice(fibonacci_generator(), 5))",
                 setup="from __main__ import fibonacci_generator"))
```

```bash
$ python3 fibonacci_generator.py
1.1730475709991879
```

## Pisano period

If you need to calculate huge fib number modulo m, you can use [Pisano period property](https://en.wikipedia.org/wiki/Pisano_period).

tl;dr: The sequence of Fibonacci numbers taken modulo m is periodic. The length of the period is called the Pisano period.

here is python implementation:

```python
def get_fibonacci_huge(n, m):
    if n <= 1:
        return n

    arr = [0, 1]
    previousMod = 0
    currentMod = 1

    for i in range(n - 1):
        tempMod = previousMod
        previousMod = currentMod % m
        currentMod = (tempMod + currentMod) % m
        arr.append(currentMod)
        if currentMod == 1 and previousMod == 0:
            index = (n % (i + 1))
            return arr[index]
```

## Fast implementation using matrix exponentiation

```python
```

# https://stackoverflow.com/questions/18172257/efficient-calculation-of-fibonacci-series/23462371#23462371

## About timeit instead of conclusion

Also keep in mind:
> Note By default, timeit() temporarily turns off garbage collection during the timing. The advantage of this approach is that it makes independent timings more comparable. This disadvantage is that GC may be an important component of the performance of the function being measured. If so, GC can be re-enabled as the first statement in the setup string.

More info about timeit [Lib/timeit.py](https://hg.python.org/cpython/file/2.7/Lib/timeit.py)
