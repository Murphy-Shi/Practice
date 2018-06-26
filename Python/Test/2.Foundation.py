# 1.数据类型和变量
# 0.000012 = 1.2e-5
# 1.23*10的9次方 = 1.23e9
# 字符串'abc'，有字符'a','b','c'，如果‘也是一个字符需要这样"'"

# 2.布尔型
print(False, True)
print(3 > 2)
print('和:',True and True,
      '\n或:',False or False,
      '\n非:',not True)

# 3.空值用None表示，None不能理解为0

# 4.变量
# 变量本身类型不固定的语言称之为动态语言，与之对应的是静态语言
print('\n\n变量')
print('不精确数:', 10 / 3,
      '\n浮点数:', 9 / 3,
      '\n精确的要整数:', 9 // 3,
      '\n取余处理：', 10 % 3)

# 5.字符编码
print('\n\n字符编码')
print(ord('A'),
      ord('中'),
      chr(25992))
print('计算字符串长度：', len('你好呀'))
print('len是计算str字符, 计算字节数：', len('你好呀'.encode('utf-8')))

# 6.格式化
# %d 整数, %f 浮点数， %s字符串，%x十六进制
print('\n\n格式化')
print('Hello my name is: %s' %'哈哈哈哈')
print('I have %d RMB, get %s to you' %(1000, 'mary'))
print('%.2f' %3.14444)
print('%022d' %3222)
print('%s, %s, 可以将任何类似转换成字符串' %(122, True))
print('我有%s%%的成就度' %2)
# format() 依次替换字符串内的占位符
print('你好， {0},成绩提高了{1:.1f}%'.format('小明', 17.125))

# 7.list是一种有序的集合，可以随时添加和删除其中元素
print('\n\nlist')
classList = ['你好呀', 11, True]
print('查看list长度：', len(classList), ' 打印的内容：', classList, '\n',
      '打印第一个数组元素：', classList[0], '打印最后一个元素', classList[-1])
# 插入到指定的位置 insert
classList.insert(0, 'Jack')
print('查看插入的元素：', classList)
# 删除末尾的元素 pop
classList.pop()
print('删除末尾元素后：', classList)
# 替换元素内容
classList[0] = 121212
print('替换元素：', classList)
# list包含list，包含的list的也只是list中的一个元素
classListTmp = ['12222', 12121221]
classList.insert(0, classListTmp)
print('查看插入list:：', classList, '\n插入后的list长度：', len(classList))
print('拿list中list的元素：', classList[0][1])

# 8.tuple 和list类似，但是初始化后，不能修改
print('\n\ntuple')
classTp = ('鸟按时打算', 'bod', ['1111', 2222])
print('查看tuple:', classTp)
classTp[2][0] = '11211'
print('查看tuple:', classTp)

# 9.条件判断
print('\n\n判断')
age = 3
if age >= 18 :
      print('年龄111')
elif age >= 3 :
      print('年龄3333')
else:
      print('年龄11111')
# 可以写成这样 x只要不是非0、空字符串、空list等就为True, 其他位false
# if x:
#       print('True')

# 10.循环
print('\n\n循环')
# for in循环
namels = ['java', 'objectC', 'mary']
for name in namels:
      print('循环打印名字:', name)
for name in ['java', 'hello']:
      print('循环打印名字:', name)
# range() 根据数字生成至数字的序列，list()转换成list序列
print(list(range(10)))

sum = 0
num = 100
while num > 0:
      sum = sum + num
      num = num - 2
      if num == 20:
            print('打印white循环的语句 num = 20：', sum)
            continue
      elif num == 10:
            print('打印white循环的语句 num = 10：', sum)
            break

# 11.dict 字典 dict内部存放的顺序和key放入的顺序没关系
# 和list比较，dict有以下几个特点：
# 查找和插入的速度极快，不会随着key的增加而变慢；
# 需要占用大量的内存，内存浪费多。
# 而list相反：
# 查找和插入的时间随着元素的增加而增加；
# 占用空间小，浪费内存很少。
print('\n\n字典')
nameDic = {'java': 100, 'objectC': 99, 'c++': True}
print('打印字典的数据：', nameDic, '\n',
      '打印java的分数：', nameDic['java'])
# 如果key不存在会报错，用'key' in dict  或 dict.get('key', -1)处理
if 'javac' in nameDic:
      print('存在dict的javac Key值：', 'java' in nameDic)
else:
      print('不存在dict的javac Key值：', nameDic.get('javac', 100))

# 删除元素：pop('key') 清空字典clear()
nameDic.pop('java')
nameDic.clear()

# 12.set  和dict类似，但不存储value。key也没有重复的.显示的顺序也不表示set是有序的
print('\n\nset')
nameListTep = [1, 2, 3, 2, 3]
nameSet = set(nameListTep)
print(nameSet)
print(list(nameSet))
nameSet.add(33)
nameSet.remove(3)
nameSetB = set(nameListTep)
print('查看nameSet : ', nameSet, '查看nameSetB:', nameSetB, '\n',
      '查看&数组：', nameSet & nameSetB, '查看|数组：', nameSet | nameSetB)



