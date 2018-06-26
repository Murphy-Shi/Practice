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

# 7.关键字参数
def person(name, age, **kw):
    print('name:', name, 'age:', age, 'other:', kw)
