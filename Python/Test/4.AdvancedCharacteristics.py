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
