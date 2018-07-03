# 对应到编程语言，就是越低级的语言，越贴近计算机，抽象程度低，执行效率高，比如C语言；越高级的语言，越贴近计算，抽象程度高，执行效率低，比如Lisp语言。
# 函数式编程就是一种抽象程度很高的编程范式，纯粹的函数式编程语言编写的函数没有变量，因此，任意一个函数，只要输入是确定的，输出就是确定的，这种纯函数我们称之为没有副作用
# 而允许使用变量的程序设计语言，由于函数内部的变量状态不确定，同样的输入，可能得到不同的输出，因此，这种函数是有副作用的。
# 函数式编程的一个特点就是，允许把函数本身作为参数传入另一个函数，还允许返回一个函数！

# 1.高阶函数(Higher-order function): 既然变量可以指向函数，函数的参数能接收变量，那么一个函数就可以接收另一个函数作为参数，这种函数就称之为高阶函数。
# 1.1 变量可以指向函数
x = abs(-10)
print(x)
f = abs
print(f(-20))

# 1.2 函数名也是变量   那么函数名是什么呢？函数名其实就是指向函数的变量
# abs = 10
# 把abs指向10后，就无法通过abs(-10)调用该函数了！因为abs这个变量已经不指向求绝对值函数而是指向一个整数10！
# 当然实际代码绝对不能这么写，这里是为了说明函数名也是变量。要恢复abs函数，请重启Python交互环境。
# 注：由于abs函数实际上是定义在import builtins模块中的，所以要让修改abs变量的指向在其它模块也生效，要用import builtins; builtins.abs = 10。

# 1.3 传入函数
f = abs
def add(x, y, f):
    return f(x) + f(y)
print('打印传入的函数看看：', add(-31, -2, f))

# 1.4 map/reduce
# map:接收两个参数，一个是函数，一个是Iterable,将传入的函数依次作用到序列的每个元素，并把结果作为新的Iterator返回。
print('\n\nmap')
def f(x):
    return x * x
r = map(f, [1, 2, 3, 4, 5, 6])
print('打印通过f函数的数组', list(r))
print('转成字符串：', list(map(str, [1, 2, 3, 4, 5])))

# 1.5 reduce: 把一个函数作用在一个序列[x1, x2, x3, ...]上，这个函数必须接收两个参数,把结果继续和序列的下一个元素做累积计算
print('\n\nreduce')
from functools import reduce
def add(x, y):
    return x + y
print('打印相加后的数：', reduce(add, [1, 3, 5, 7, 9]))

def fn(x, y):
    return x * 10 + y

def charToNum(s):
    digits = {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}
    return digits[s]

print(reduce(fn, map(charToNum, '13579')))

# 整理下来就变成：
DIGITS = {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9}
def strToInt(s):
    def fn(x, y):
        return x * 10 + y
    def charToNum(s):
        return DIGITS[s]
    return reduce(fn, map(charToNum, s))
print(strToInt('13579'))

# 用lambda进一步简化
def strToInt(s):
    return reduce(lambda x, y: x * 10 + y, map(charToNum, s))
print(strToInt('13579'))

# 练习1
def nameToNor(s):
    return s[0].upper() + s[0:].lower()

print(list(map(nameToNor, ['asdasd', 'QQQQQ'])))

# 练习2
def ride(x):
    return reduce(lambda y, z: y * z, iter(x))
print(ride([1, 2, 3, 4]))

# 练习3
DIGITS = {'0': 0, '1': 1, '2': 2, '3': 3, '4': 4, '5': 5, '6': 6, '7': 7, '8': 8, '9': 9, '.': -1}
def strToFloat(s):
    iss = 0
    def charToNum(s):
        return DIGITS[s]
    def fn(x, y):
        nonlocal iss
        if y == -1:
            iss = 1
            return x
        if iss is 0:
            return x * 10 + y
        else:
            iss = iss * 10
            return x + y / iss
    return reduce(fn, map(charToNum, s))
print(strToFloat('123.123'))

# 1.6 filter 用于过滤序列
# 接收一个函数和一个序列 把传入的函数依次作用于每个元素，然后根据返回值是True还是False决定保留还是丢弃该元素
print('\n\nfilter')
print('删除偶数：', list(filter(lambda x: x % 2 == 1, [1, 2, 3 ,4, 5, 6])))

# 1.7 sorted 排序 返回来的是list
# 默认情况下，对字符串排序，是按照ASCII的大小比较的
print('\n\nsorted',
      '普通函数用法:', sorted([1,3, -1, -5]), '\n',
      '高阶函数用法：', sorted([1, 3, -1, -5], key=abs), '\n',
      '高阶函数用法反序:', sorted([1, 3, -1, -5], key=abs, reverse=True))


# 2.0 返回函数
print('\n\n返回函数')
# 通常求和函数
def calc_sum(*args):
    ax = 0
    for n in args:
        ax = ax + n
    return ax
# 返回求和的函数
def lazy_sum(*args):
    def sum():
        ax = 0
        for n in args:
            ax = ax + n
        return ax
    return sum
f = lazy_sum(1, 2, 3, 4)
print('当我们调用lazy_sum时，不是返回结果，而是一个函数：', f, '\n',
      '获得结果的方式是：', f())
# 当我们调用lazy_sum()时，每次调用都会返回一个新的函数，即使传入相同的参数
f1 = lazy_sum(1, 3, 5, 7)
f2 = lazy_sum(1, 3, 5, 7)
print(f1 == f2)

# 2.1 闭包
# 注意到返回的函数在其定义内部引用了局部变量args，所以，当一个函数返回了一个函数后，其内部的局部变量还被新函数引用
def count():
    fs = []
    for i in range(1, 4):
        def f():
            return i * i
        fs.append(f)
    return fs
f1, f2, f3 = count()
print('打印参数看看：', f1(), f2() ,f3())
# 注：返回闭包时牢记一点：返回函数不要引用任何循环变量，或者后续会发生变化的变量。
# 修改：
def count():
    def f(j):
        def g():
            return j * j
        return g
    fs = []
    for i in range(1, 4):
        fs.append(f(i)) #f(i)立刻执行，因此i的当前值被传入f()
    return fs
f1, f2, f3 = count()
print('打印参数看看：', f1(), f2() ,f3())


# 3.0 匿名函数
# 关键字lambda表示匿名函数，冒号前面的x表示函数参数。
# 匿名函数有个限制，就是只能有一个表达式，不用写return，返回值就是该表达式的结果。
print('\n\n匿名函数')
# 用匿名函数有个好处，因为函数没有名字，不必担心函数名冲突。此外，匿名函数也是一个函数对象，也可以把匿名函数赋值给一个变量，再利用变量来调用该函数：
f = lambda x: x * x
print(f, f(5))
# 可以把匿名函数作为返回值返回
def build(x, y):
    return lambda: x * x + y * y
f = build(2, 2)
print(f())

# 4.0 装饰器(Decorator)
# 由于函数也是一个对象，而且函数对象可以被赋值给变量，所以，通过变量也能调用该函数。
print('\n\n装饰器')
def nowaaa():
    print('2015-1-1')
    return '2015-1-1'
f = nowaaa
print(f())
print(nowaaa.__name__)
# 假设我们要增强now()函数的功能，比如，在函数调用前后自动打印日志，但又不希望修改now()函数的定义，这种在代码运行期间动态增加功能的方式，称之为“装饰器”（Decorator）。
def log(func):
    def wrapper(*args, **kw):
        print('call %s():' %func.__name__)
        return func(*args, **kw)
    return wrapper
@log
def now():
    print('2015-5-5')
now()
# 如果decorator本身需要传入参数，那就需要编写一个返回decorator的高阶函数
def log(text):
    def decorator(func):
        def wrapper(*args, **kw):
            print('%s %s():' %(text, func.__name__))
            return func(*args, **kw)
        return wrapper
    return decorator
# 用法：
@log('eeee')
def now():
    print('2015-1-1')
    return '2015-1-1'
now()
now = log('execute')(now)
print(now())    #三层嵌套：
print(now.__name__)     #wrapper
# 因为返回的那个wrapper()函数名字就是'wrapper'，所以，需要把原始函数的__name__等属性复制到wrapper()函数中，否则，有些依赖函数签名的代码执行就会出错。
# 完整的decorator:
import functools
def log(func):
    @functools.wraps(func)
    def wrapper(*args, **kw):
        print('call %s():' %func.__name__)
        return func(*args, **kw)
    return wrapper
# 或者带参数的decorator
def log(text):
    def decorator(func):
        @functools.wraps(func)
        def wrapper(*args, **kw):
            print('%s %s():' % (text, func.__name__))
            return func(*args, **kw)
        return wrapper
    return decorator
@log('eeee')
def now():
    print('2015-5-5')
    return '2015-5-5'
f = log('eeee')(now)
now = log('aaae')(now)
print(now.__name__)

# 5.0 偏函数(Partial function)



