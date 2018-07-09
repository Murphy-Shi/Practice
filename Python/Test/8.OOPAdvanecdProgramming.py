# 数据封装、继承和多态只是面向对象程序设计中最基础的3个概念。
# 1.0 使用__solots__
class Student(object):
    pass
# 给实例绑定一个属性
s = Student()
s.name = 'Micheael'
print(s.name)
# 给实例绑定一个方法
def set_age(self, age):
    self.age = age

from types import MethodType
s.set_age = MethodType(set_age, s)  #给实例绑定一个方法
s.set_age(25)
print('打印年龄：%s' % s.age)
s2 = Student()
# s2.set_age(25)  #尝试调用会失败
# 给所有实例都绑定方法,可以给class绑定方法
def set_score(self, score):
    self.score = score
Student.set_score = set_score
b = Student()
b.set_score(20)
print('打印绑定的实例：', b.score)

# 1.1 __slots__： 用来限制添加的对象
class Strudent(object):
    __slots__ = ('name', 'age') #用tuple定义允许绑定的属性名称
s = Strudent()
s.name = 'HHHH'
s.age = 11
# s.score = 00  #会报错AttributeError
# 使用__slots__要注意，__slots__定义的属性仅对当前类实例起作用，对继承的子类是不起作用的：
# 除非在子类中也定义__slots__，这样，子类实例允许定义的属性就是自身的__slots__加上父类的__slots__。

# 2.0 @property :负责把一个方法变成属性调用的
print('\n\nproperty')
class Student(object):
    @property
    def score(self):
        return self._score

    @score.setter
    def score(self, value):
        if not isinstance(value, int):
            raise ValueError('score must be an integer!')
        if value < 0 or value > 100:
            raise ValueError('score must between 0 - 100')
        self._score = value

s = Student()
s.score = 60
print(s.score)
# 可以定义只读属性，只定义getter方法，不定义setter方法就是一个只读属性：
class Student(object):
    @property
    def birth(self):
        return self._birth

    @birth.setter
    def birth(self, value):
        self._birth = value

    @property
    def age(self):
        return 2015 - self._birth

test = Student()
test.birth = 2013
print('查看出生：', test.birth)
print('查看年龄：', test.age)
# test.age = 22 #只读不能写

# 3.0 多重继承
print('\n\n多重继承')
class Animal(object):
    pass
class Mammal(Animal):
    pass

class Runnable(object):
    def run(self):
        print('Running....')

class Flyable(object):
    def fly(self):
        print('Flying')

class Dog(Mammal, Runnable):
    pass
class Bat(Mammal, Flyable):
    pass

# 3.1 Mixin
# 如果需要“混入”额外的功能，通过多重继承就可以实现，比如，让Ostrich除了继承自Bird外，再同时继承Runnable。这种设计通常称之为MixIn。
class CarnivorousMixIn(Animal):
    pass
class Dog(Mammal, Runnable, CarnivorousMixIn):
    pass

# 4.0 定制类
print('\n\n定制类')
class Student(object):
    def __init__(self, name):
        self.name = name
print('打印的是地址：', Student('Michael'))

class Student(object):
    def __init__(self, name):
        self.name = name
    def __str__(self):
        return 'Student object (name: %s)' % self.name
        __str__ = __repr__

print(Student('HHHH'))
s = Student('HHH')
print('打印的还是地址11：', s)

# 4.1 __iter__
# 如果一个类想被用于for ... in循环，类似list或tuple那样，就必须实现一个__iter__()方法，该方法返回一个迭代对象
# 然后，Python的for循环就会不断调用该迭代对象的__next__()方法拿到循环的下一个值，直到遇到StopIteration错误时退出循环。
class Fib(object):
    def __init__(self):
        self.a, self.b = 0, 1

    def __iter__(self):
        return self # 实例本身就是迭代对象，故返回自己

    def __next__(self):
        self.a, self.b = self.b, self.a + self.b
        if self.a > 100000: #退出循环条件
            raise StopAsyncIteration('1212')
        return self.a   # 返回下一个值
# for n in Fib():
    # print('测试数据：', n)

# 4.2 __getitem__
# Fib实例虽然能作用于for循环，看起来和list有点像，但是，把它当成list来使用还是不行，比如，取第5个元素：
# 用__getitem__可以做到
class Fib(object):
    def __getitem__(self, n):
        if isinstance(n, int):   #n是int
            a, b = 1, 1
            for x in range(n):
                a, b = b, a + b
            return a
        elif isinstance(n, slice):  #   n是切片
            start = n.start
            stop = n.stop
            if start is None:
                start = 0
            a, b = 1, 1
            L = []
            for x in range(stop):
                if x >= start:
                    L.append(a)
                a, b = b, a + b
            return L
print(Fib()[10])
print('查看切片：', Fib()[5:10])
print('查看切片：', Fib()[:10:2])

# 4.3 __getattr__: 当类没有指定属性，可以通过它来动态返回一个属性
# 正常情况下，当我们调用类的方法或属性时，如果不存在，就会报错。比如定义Student类：
class Student(object):
    def __init__(self):
        self.name = 'hhhh'

    def __getattr__(self, item):
        if item is 'score':
            return 99
        if item is 'age':
            return lambda: 25   # 返回一个函数
        raise AttributeError('\'Student\' object has no attribute \'%s\'' % item)

s = Student()
s.name = 'ppppp'
print(s.name, s.score, s.age())
# print(s.aaa)
# 注: 只有在没有找到属性的情况下，才调用__getattr__，已有的属性，比如name，不会在__getattr__中查找。
# 注意到任意调用如s.abc都会返回None，这是因为我们定义的__getattr__默认返回就是None。
# 要让class只响应特定的几个属性，我们就要按照约定，抛出AttributeError的错误：

# 如果要写SDK，给每个URL对应的API都写一个方法，那得累死，而且，API一旦改动，SDK也要改。
# 利用完全动态的__getattr__，我们可以写出一个链式调用：
class Chain(object):
    def __init__(self, path = ''):
        self._path = path

    def __getattr__(self, path):
        return Chain('%s/%s' % (self._path, path))

    def __str__(self):
        return self._path

    __repr__ = __str__
print(Chain().status.user.timeline.list)

# 4.4 __call__
# 任何类，只需要定义一个__call__()方法，就可以直接对实例进行调用
class Student(object):
    def __init__(self, name):
        self.name = name

    def __call__(self, *args, **kwargs):
        print('My name is %s.' % self.name)

s = Student('Michael')
s()
# Callabel:用于判断一个对象能否被调用（是否为函数）
print('查看max函数：', callable(max),
      '\n', callable(Student))

# 5.0 使用枚举
# 当我们需要定义常量时，一个办法是用大写变量通过整数来定义
print('\n\n枚举')
from enum import Enum, unique
Moth = Enum('Month', ('Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'))
for name, member in Moth.__members__.items():
    print(name, '=>', member, ',', member.value)    # value属性则是自动赋给成员的int常量，默认从1开始计数。

# 如果需要更精确地控制枚举类型，可以从Enum派生出自定义类
@unique # 装饰器可以帮助我们检查保证没有重复值
class Weekday(Enum):
    Sun = 0 # Sun的value被设定为0
    Mon = 1
    Tue = 2
    Wed = 3
    Thu = 4
    Fri = 5
    Sat = 6

# 访问枚举类型的方法：
day1 = Weekday.Mon
print(Weekday.Mon)
print(Weekday['Mon'])
print(Weekday.Mon.value)
print(Weekday(1))

# 6.0 使用元类
# type()
# 动态语言和静态语言最大的不同，就是函数和类的定义，不是编译时定义的，而是运行时动态创建的。
# type()函数可以查看一个类型或变量的类型，Hello是一个class，它的类型就是type，而h是一个实例，它的类型就是class Hello。
# 我们说class的定义是运行时动态创建的，而创建class的方法就是使用type()函数。
# type()函数既可以返回一个对象的类型，又可以创建出新的类型，比如，我们可以通过type()函数创建出Hello类，而无需通过class Hello(object)...的定义：
from testModel import Hello
def fn(self, name = 'world'):
    print('Hello %s.' % name)
h = Hello()
h.hello()
print(type(Hello))
print(type(h))

Hello = type('Hello', (object,), dict(hello = fn))  #创建Hello class
h = Hello()
h.hello()
print(h)
print(type(h))
# 要创建一个class对象，type()函数依次传入3个参数
# 1.class的名称；
# 2.继承的父类集合，注意Python支持多重继承，如果只有一个父类，别忘了tuple的单元素写法；
# 3.class的方法名称与函数绑定，这里我们把函数fn绑定到方法名hello上。

# 6.1 metaclass 元类
# 按照默认习惯，metaclass的类名总是以Metaclass结尾，以便清楚地表示这是一个metaclass：
print('\n\nmetaclass')
#   metaclass是类的模板，所以必须从`type`类型派生：
class ListMetaclass(type):
    def __new__(cls, name, bases, attrs):
        attrs['add'] = lambda self, value:self.append(value)
        return type.__new__(cls, name, bases, attrs)
class MyList(list, metaclass=ListMetaclass):
    pass
# 当我们传入关键字参数metaclass时，魔术就生效了，它指示Python解释器在创建MyList时，
# 要通过ListMetaclass.__new__()来创建，在此，我们可以修改类的定义，比如，加上新的方法，然后，返回修改后的定义。
# __new__()方法接收到的参数依次是：当前准备创建的类的对象、类的名字、类继承的父类集合、类的方法集合。
L = MyList()
L.add(1)
print(L)
# 普通的list没有add
# L2 = list()
# L2.add(1)
# print(L2)
