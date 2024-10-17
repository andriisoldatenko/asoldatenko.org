---
title: How to read input fast in python and transform into ints
date: 2018-08-07 11:12
tags: ["python","uva","10013","sport programming","map","int","stdin","uva 10013", "super long sums"]
categories:
- python
- uva
- sport programming
- map
- int
- stdin
- super long sum
---


Недавно я решал задачу (UVa 10013 - Super long sums), и там я наткнулся на ситуацию, где нужно было максимально быстро читать входные данные.

Т.е  о чем речь? Необходимо читать данные из стандартного потока ввода [stdin](https://en.wikipedia.org/wiki/Standard_streams) и конвертировать в int/float или что-то еще.

В `C` это делается c помощью стандартной функции [`scanf()`](http://www.cplusplus.com/reference/cstdio/scanf/) .

На `Python` обычно я делаю так:

```python
import sys

for line in sys.stdin:
    a,b = map(int, line.split())
```
Проблема этого кода в том, что мы очень много раз вызываем функцию `int`.

Далее я нашел похожий вопрос/ответ на SO: https://stackoverflow.com/questions/12784192/is-there-a-faster-way-to-get-input-in-python.
В том же ответе на SO я нашел интересный трюк, который сильно ускоряет работу с цифрами, при условии, что мы работаем c ascii от 0 до 9.

Итак вместо того, чтобы вызывать функцию `int`, давайте попробуем вызывать более быструю функцию `ord` со сдвигом `48`,
что позволит нам найти искомое число из строки.

```python
import sys

for line in sys.stdin:
    x,y = [ord(x)-48 for x in line.split()]
```

Короткий бенчмарк:
```python
import timeit

timeit.timeit('ord("1")-48')
# 0.0593524890136905

timeit.timeit('int("1")')
# 0.17183380699134432
```
=)
