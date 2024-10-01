---
title: Eloquent fibonacci sequences in python
date: 2016-12-31T21:30:00+02:00
tags: ["python", "tips", "tricks", "python3", "fibonacci"]
categories:
- python
- tips 
- tricks 
- python3 
- fibonacci
---


> "If by chance I have omitted anything more or less proper or necessary, I beg forgiveness, since there is no one who is without fault and circumspect in all matters." 

> ― Leonardo Bonacci - italian mathematician

![Leonardo Bonacci](/assets/Fibonacci2.jpg)

## Quick introduction
The idea of this article to collect eloquent python patterns using well-known
Fibonacci sequence.

## Recursive approach
```bash
cat fibonacci1.py
```

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
My favorite advice: you should know you language standard library.
You can find lot's of info under [functools](https://docs.python.org/3/library/functools.html#functools.lru_cache) module docs.
Default `maxsize` is `128` for `lru_cache` decorator.

```bash
$ cat fibonacci2.py
```

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
$ python3 fibonacci2_bench.py # On my MacBook Pro (Mid 2015) 2.5 GHz Intel Core i7, 16 GB 1600 MHz DDR3
0.09731649799505249
```

```bash
$ cat fibonacci_generator.py
```

## Generator approach for using yield
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
$ python3 fibonacci_generator.py # On my MacBook Pro (Mid 2015) 2.5 GHz Intel Core i7, 16 GB 1600 MHz DDR3
1.1730475709991879
```

## About timeit instead of conclusion.
Also keep in mind:
> Note By default, timeit() temporarily turns off garbage collection during the timing. The advantage of this approach is that it makes independent timings more comparable. This disadvantage is that GC may be an important component of the performance of the function being measured. If so, GC can be re-enabled as the first statement in the setup string.

More info about timeit [Lib/timeit.py](https://hg.python.org/cpython/file/2.7/Lib/timeit.py)
