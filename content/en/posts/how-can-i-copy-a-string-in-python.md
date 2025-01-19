---
title: Can I copy string in Python 3.5? And how?
date: 2016-11-22T15:30:00+02:00
category: Python
tags: ["python","copy","strings","python3"]
categories:
- python
- copy
- strings
- python3
---

> “Mathematics reveals its secrets only to those who approach it with pure love, for its own beauty.”
> ― Archimedes

![Domenico Fetti Archimedes](/assets/450px-Domenico-Fetti_Archimedes_1620.jpg)

## Quick introduction

Why do you need to copy a Python strings? It's interesting question,
because Python string is immutable. Also any tries of copy will returns
the original string. Python tries to keep just the one copy,
as that makes dictionary lookups faster.

### May be use slice?

```bash
$ python3
Python 3.5.2 (default, Sep 15 2016, 07:38:42)
[GCC 4.2.1 Compatible Apple LLVM 7.3.0 (clang-703.0.31)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> a = 'python'
>>> b = a[:]
>>> b = a[:]
>>> id(a), id(b)
(4400931648, 4400931648)
```

### Add empty string? No

```bash
>>> a = 'python'
>>> id(a)
4400931648
>>> b = a + ''
>>> id(b)
4400931648  
```

### Or use str function?

```bash
>>> a = 'python'
>>> id(a)
4400931648
>>> b =str(a)
>>> id(b)
4400931648
```

### Try to use copy?

```bash
>>> a = 'python'
>>> id(a)
4400931648
>>> import copy
>>> b = copy.copy(a)
>>> id(b)
4400931648
```

### Let's do deepcopy

```bash
>>> a = 'python'
>>> id(a)
4400931648
>>> b = copy.deepcopy(a)
>>> id(b)
4400931648
>>> print('No chance!')
No chance!
```

### Another tries with using slice?

```bash
>>> a = 'python'
>>> b = (a + '.')[:-1]
>>> id(a)
4400931648
>>> id(b)
4400931760
>>> print('Eureka!')
Eureka!
```

### Last try with encode and decode

```bash
>>> a = 'python'
>>> id(a)
4400931648
>>> b = a.encode().decode()
>>> b
'python'
>>> id(b)
4400931984
>>> print('Eureka!')
Eureka!
```

## Conclusion

Try to answer the first question:

> Can I copy or clone string in Python?

Answer is: **no you can't**.

Every time we create new string, both working examples
uses the same idea:

```bash
>>> a = 'a' * 1024
>>> b = 'a' * 1024
>>> id(a)
140726834891776
>>> id(b)
140726843315712
```

P.S. Thanks for ideas from Pavel's talk from PyCon Russian 2016 and some
more info you can find in references.

## References

- [How can you copy (clone) a string?](https://mail.python.org/pipermail/python-list/2000-October/034442.html)
- [How can I copy a Python string?](http://stackoverflow.com/questions/24804453/how-can-i-copy-a-python-string)
- [About the changing id of a Python immutable string](http://stackoverflow.com/questions/24245324/about-the-changing-id-of-a-python-immutable-string/24245514#24245514)
- [Хочу всё знать! Павел Петлинский, Rambler&Co](https://www.youtube.com/watch?v=wWEy5DkvH4Q)
