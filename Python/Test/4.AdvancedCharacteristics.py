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