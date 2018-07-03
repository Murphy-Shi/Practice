def my_abc(x):
    if not isinstance(x, (int, float)):
        raise TypeError('boad operand type')
    if x >= 0:
        return x
    else:
        return -x
print(my_abc(22))

# 1. pass语句什么也不做，用作占位符
if 22:
    pass

# 2. 异常处理的方法如下
# if not isinstance(x, int, float):
# raise TypeError('boad operand type')
# my_abc('A')

# 3. 函数返回多个值
def returnMoreValue(x, y):
    return x,y

print('返回来的值：', returnMoreValue(10, 20))
x, y = returnMoreValue(10, 20)
print('查看赋值的数字：', x, y)

# 4. 函数的参数
def power(x, n=2):
    s = 1
    while n > 0:
        n = n - 1
        s = s * x
    return s
print('查看power的次幂：', power(2, 4))
print('111:', power(5))
# 注意：下面情况会不断加END; 默认参数L的值就被计算出来了，即[]，
# 因为默认参数L也是一个变量，它指向对象[]，每次调用该函数，如果改变了L的内容，则下次调用时，默认参数的内容就变了，不再是函数定义时的[]了
def add_end(L = []):
    L.append('END')
    return L
print(add_end(), add_end(), add_end())

# 5. 可以这样处理：
def add_endd(L = None):
    if L is None:
        L = []
    L.append('END')
    return L
print(add_endd(), add_endd(), add_endd())

# 6.可变参数  传入的参数个数是可变的0-任意
def calc(numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
        return sum
print(calc([1, 2, 3, 4]))
# 可变参数+ *
def calcA(*numbers):
    sum = 0
    for n in numbers:
        sum = sum + n * n
    return sum
print(calcA(1, 2))
numberLsTmp = [1,2,3]
print('数组', calcA(*numberLsTmp))

# 7.关键字参数 扩展函数的功能
print('\n\n关键参数')
def person(name, age, **kw):
    print('name:', name, 'age:', age, 'other:', kw)
person('name', 18, city='benjing')
person('name', 18, city='benjing', job='hello')
# 可以直接传入一个dict
tmpDict = {'city': 'Beijing', 'gender':'M', 'job':'developer'}
person('hhhh', 88, **tmpDict)

# 8.命名关键参数 通过kw检查
print('\n\n命名关键参数')
def person(name, age, **kw):
    if 'city' in kw:
        print('来到这里city')
    if 'job' in kw:
        print('来到了这里job')
    print('name:', name, 'age:', age, 'other:', kw)
person('hhhh', 88, **tmpDict)
# 只接收city和job，其他不接收
def person(name, age, *, city, job):
    print('name:', name, 'age:', age, 'other:', city, job)
person('hhhh', 88, city='bejing', job='sss')
# city可以不填写
def person(name, age, *, city='aaaa', job):
    print('name:', name, 'age:', age, 'other:', city, job)
person('hhhh', 88, job='sss')

# 9.参数组合
# 可以用必选参数、默认参数、可变参数、关键字参数和命名关键字参数，这5种参数都可以组合使用。
# 但是请注意，参数定义的顺序必须是：必选参数、默认参数、可变参数、命名关键字参数和关键字参数。
print('\n\n参数组合')
def f1(a, b, c=0, *args, **kw):
    print('a =', a, 'b =', b, 'c =', c, 'args =', args, 'kw =', kw)
def f2(a, b, c=0, *, d, **kw):
    print('a =', a, 'b =', b, 'c =', c, 'd =', d, 'kw =', kw)
f2(3,4, d='11')
args = {1, 2, 3, 4}
kw = {'d':99, 'x':'#'}
f1(*args, **kw)
args = {1, 2, 3}
f1(*args, **kw)
f2(*args, **kw)

# 递归函数  注意防止栈溢出,函数调用是通过栈（stack）
print('\n\n递归函数')
def fact(n):
    if n == 1:
        return 1
    return n * fact(n-1)
print(fact(2))
# print(fact(100))
# 解决递归调用栈溢出的方法是通过尾递归优化
# 尾递归是指，在函数返回的时候，调用自身本身，并且，return语句不能包含表达式。
# 这样，编译器或者解释器就可以把尾递归做优化，使递归本身无论调用多少次，都只占用一个栈帧，不会出现栈溢出的情况。
def fact(n):
    return fact_iter(n, 1)
def fact_iter(num, product=1):
    if num == 1:
        return product
    return fact_iter(num - 1, num * product)
print(fact_iter(800))

