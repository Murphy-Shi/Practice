# 1.0 类和实例
# 面向对象最重要的概念就是类（Class）和实例（Instance），必须牢记类是抽象的模板
# 而实例是根据类创建出来的一个个具体的“对象”，每个对象都拥有相同的方法，但各自的数据可能不同。
# 定义类是通过class关键字
# 注：特殊方法“__init__”前后分别有两个下划线！！！
# 第一个参数永远是self，表示创建的实例本身
class Student(object):

    def __init__(self, name, score):
        self.name = name
        self.score = score

    def print_score(self):
        print('%s: %s' %(self.name, self.score))

bart = Student('Bart', 59)
lisa = Student('lisa', 60)
bart.name = 'aaa'
bart.print_score()
lisa.print_score()

# 1.1 访问限制
# 在Class内部，可以有属性和方法，而外部代码可以通过直接调用实例变量的方法来操作数据，这样，就隐藏了内部的复杂逻辑。
# 如果要让内部属性不被外部访问，可以把属性的名称前加上两个下划线__，在Python中，实例的变量名如果以__开头，就变成了一个私有变量（private），只有内部可以访问，外部不能访问
class Student(object):
    def __init__(self, name, score):
        self.__name = name
        self.__score = score

    def print_score(self):
        print('%s %s' %(self.__name, self.__score))

qqq = Student('aaa', 22)
qqq.print_score()

# 变量名类似__xxx__的，也就是以双下划线开头，并且以双下划线结尾的，是特殊变量，特殊变量是可以直接访问的，不是private变量
# _name，这样的实例变量外部是可以访问的，但是，按照约定俗成的规定，当你看到这样的变量时，意思就是，“虽然我可以被访问，但是，请把我视为私有变量，不要随意访问”。
# 双下划线开头的实例变量是不是一定不能从外部访问呢？其实也不是。不能直接访问__name是因为Python解释器对外把__name变量改成了_Student__name，所以，仍然可以通过_Student__name来访问__name变量：
print(qqq._Student__name)   #但是强烈建议你不要这么干，因为不同版本的Python解释器可能会把__name改成不同的变量名。

# 1.2 继承和多态
# 当我们定义一个class的时候，可以从某个现有的class继承，新的class称为子类（Subclass），而被继承的class称为基类、父类或超类（Base class、Super class）。
print('\n\n继承和多态')
class Animal(object):
    def run(self):
        print('Animal run')

class Cat(Animal):
    def run(self):      #   多态
        print('Cat is run')
class Dog(Animal):
    def run(self):
        print('Dog is run')
dog = Dog()
dog.run()

# 判断一个变量是否是某个类型可以用isinstance()判断：
print(isinstance(dog, Animal))
print(isinstance(dog, Dog))
print(isinstance(dog, Cat))

# 1.2.1 静态语言 vs 动态语言
# 对于静态语言（例如Java）来说，如果需要传入Animal类型，则传入的对象必须是Animal类型或者它的子类，否则，将无法调用run()方法。
# 对于Python这样的动态语言来说，则不一定需要传入Animal类型。我们只需要保证传入的对象有一个run()方法就可以了：

# 1.3 获取对象信息
print('\n\n获取对象信息')
# 基本类型都可以使用type()、 type返回对应的Class类型（一般用isinstance()判断）
# 总是优先使用isinstance()判断类型，可以将指定类型及其子类“一网打尽”
print('查看函数：', type(abs), '\n',
      '查看其它：', type('122'))
# 获得一个对象的所有属性和方法，可以使用dir()函数，它返回一个包含字符串的list
print(dir(dog))

class MyObject(object):
    def __init__(self):
        self.x = 9
    def power(self):
        return self.x * self.x
obj = MyObject()
print('是否有x属性：', hasattr(obj, 'x'))
print('是否有y属性：', hasattr(obj, 'y'))
setattr(obj, 'y', 19)   #设置属性y
print('是否有y属性：', hasattr(obj, 'y'))
print('打印y属性：', getattr(obj, 'y'), obj.y)
# getattr(obj, 'z') # 如果试图获取不存在的属性，会抛出AttributeError的错误：
print(getattr(obj, 'z', 404))   # 如果不存在返回404
# 一个正确的用法的例子:
def readImage(fp):
    if hasattr(fp, 'read'):
        # return readData(fp)
        return fp.read
    return None

# 1.4 实例属性和类属性
# 由于Python是动态语言，根据类创建的实例可以任意绑定属性。
# 给实例绑定属性的方法是通过实例变量，或者通过self变量：

