#!/usr/bin/env python3
# -*- coding: utf-8 -*-

' a test module '

__author__ = 'Michael Liao'

# 使用模块还可以避免函数名和变量名冲突
# 每一个包目录下面都会有一个__init__.py的文件,这个文件是必须存在的，否则，Python就把这个目录当成普通目录，而不是一个包

# 1.0 使用模块
import sys
def test():
    args = sys.argv
    if len(args) is 1:
        print('Hello World')
    elif len(args) is 2:
        print('Hello, %s!' % args[i])
    else:
        print('Too Many aaaa')
test()

# 1.1.作用域
# 在一个模块中，我们可能会定义很多函数和变量，
# 但有的函数和变量我们希望给别人使用，有的函数和变量我们希望仅仅在模块内部使用。在Python中，是通过_前缀来实现的。
# 类似_xxx和__xxx这样的函数或变量就是非公开的（private），不应该被直接引用，比如_abc，__abc等；
# 私有
def _private(name):
    return 'Hello %s' % name

# 2.0 安装第三方模块
# 在Python中，安装第三方模块，是通过包管理工具pip完成的。