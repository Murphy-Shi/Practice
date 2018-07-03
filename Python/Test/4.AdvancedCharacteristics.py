# 1.切片
L = ['Michael', 'Sarah', 'Tracy', 'Bob', 'Jack']
# [0:3], 从第0位-第3位、倒数第一个元素是-1
print(L[0: 3])
print(L[: 3])
print('取后面两位: ', L[-2:])
L = list(range(100))
print(L)
print('所有数，每5个取一个: ', L[::5])
print('前面10个数，每5个取一个: ', L[:10:2])
tp = tuple(range(100))
print(tp)
print('所有数，每5个取一个: ', tp[::5])
# 字符串也可以这样操作

# 2.迭代  不仅可以用在list或tuple上，还可以作用在其他可迭代对象上。
print('\n\n迭代')
temDict = {'a':1, 'b':2, 'c':3}
for key in temDict:
    print('打印数据：', key)
for key in 'ABC':
    print('打印数据：', key)
from collections import Iterable
print('查看是否字符串可迭代:', isinstance('abc', Iterable))
print('查看是否可整数迭代:', isinstance(1223, Iterable))
# 打印出元素-索引
for i, value in enumerate(['a', 'b', 'c']):
    print('打印元素：', value, '索引位置：', i)
for x, y in [(1,1), (2,3), (4,5)]:
    print('打印X：', x, '打印Y：', y)

# 3.列表生成式:即List Comprehensions，是Python内置的非常简单却强大的可以用来创建list的生成式。
print('\n\n列表生成式')
L = []
for x in range(1, 11):
    L.append(x * x)
print('打印L：', L)
print('可以换成：', [x * x for x in range(1, 11)])
print('筛选仅偶数的平方：', [x * x for x in range(1, 11) if x % 2 is 0])
print('两层循环： ', [m + n for m in 'ABC' for n in 'XYZ'])
print('很少用的三层循环：', [x + y + z for x in 'ABC' for y in 'DEF' for z in 'GHI'])
import os
d = [d for d in os.listdir('.')]
print('输出文件名和目录：', d)
d = {'x': 'a', "y":"b", 'z':'z'}
print(':换成= :', [k + '=' + v for k, v in d.items()])
L = ['Helllo', 'Word', 'WWWW']
print('换成小写字母:', [s.lower() for s in L])

# 4.生成器(generator) 一边循环一边计算的机制
print('\n\n生成器')
# 创建L和g的区别仅在于最外层的[]和()，L是一个list，而g是一个generator。
L = [x * x for x in range(10)]
g = (x * x for x in range(10))
print('打印L的数据：', L, '打印g的数据：', g)
for n in g:
    print(n)
# 函数是顺序执行，遇到return语句或者最后一行函数语句就返回。
# 而变成generator的函数，在每次调用next()的时候执行，遇到yield语句返回，再次执行时从上次返回的yield语句处继续执行。
def odd():
    print('1111')
    yield 1
    print('2222')
    yield 2
    print('33333')
    yield 3
    print('44444')
o = odd()
next(o)
next(o)
next(o)

# 5.迭代器     可以被next()函数调用并不断返回下一个值的对象
# isinstance()判断一个对象是否是Iterable(迭代)对象
print('/n/n迭代对象')
from collections import Iterable
print(isinstance([], Iterable),
      isinstance({}, Iterable),
      isinstance('aaa', Iterable))
print('/n/n迭代器')
# 生成器都是Iterator对象，但list、dict、str虽然是Iterable，却不是Iterator
from collections import  Iterator
print(isinstance((x for x in range(10)), Iterator),
      isinstance([], Iterator))
# 把list、dict、str等Iterable变成Iterator可以使用iter()函数：
print(isinstance(iter([]), Iterator))
# 为什么list、dict、str等数据类型不是Iterator
# 因为Python的Iterator对象表示的是一个数据流，Iterator对象可以被next()函数调用并不断返回下一个数据，直到没有数据时抛出StopIteration错误
# 可以把这个数据流看做是一个有序序列，但我们却不能提前知道序列的长度，只能不断通过next()函数实现按需计算下一个数据，所以Iterator的计算是惰性的，只有在需要返回下一个数据时它才会计算
# Iterator甚至可以表示一个无限大的数据流，例如全体自然数。而使用list是永远不可能存储全体自然数的。

