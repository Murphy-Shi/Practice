# 1.0 错误处理
# 用错误码来表示是否出错十分不便，因为函数本身应该返回的正常结果和错误码混在一起，造成调用者必须用大量的代码来判断是否出错：
# 一旦出错，还要一级一级上报，直到某个函数可以处理该错误（比如，给用户输出一个错误信息）。
# 所以高级语言通常都内置了一套try...except...finally...的错误处理机制，Python也不例外。
try:
    print('try....')
    r = 10 / 1
    print('result: ', r)
except ZeroDivisionError as e:
    print('except: ', e)
except ValueError as e: # 多种错误时候
    print('1111', e)
else:                   # 如果没发生错误就进这里
    print('no error')
finally:
    print('finally...')
print('运行完成')
# Python的错误其实也是class，所有的错误类型都继承自BaseException
# 所以在使用except时需要注意的是，它不但捕获该类型的错误，还把其子类也“一网打尽”。
# https://docs.python.org/3/library/exceptions.html#exception-hierarchy 异常类以及说明
try:
    print('111')
except ValueError as e:
    print('ValueError ')
except UnicodeError as e:
    print('UnicodeError ')
finally:
    print('haha')
# UnicodeError 不会触发，它是ValueError的子类，有错误只触发ValueError

# 使用try...except捕获错误还有一个巨大的好处，就是可以跨越多层调用
#  比如函数main()调用foo()，foo()调用bar()，结果bar()出错了，这时，只要main()捕获到了，就可以处理：
def foo(s):
    return 10 / int(s)

def bar(s):
    return foo(s) * s



