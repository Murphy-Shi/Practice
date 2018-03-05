//
//  NSThreaedViewController.m
//  UIWeb
//
//  Created by murphy_shi on 16/10/14.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "NSThreaedViewController.h"

@interface NSThreaedViewController ()
{
    NSThread *_thread01;
    NSThread *_thread02;
    NSInteger _counter;
    NSLock *_lock;
}

@end

@implementation NSThreaedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    _lock = [[NSLock alloc] init];
    
    NSArray *ary = @[@"启动线程01", @"启动线程02", @"启动线程03", @"线程休眠01", @"线程休眠02", @"强制退出线程"];
    NSUInteger number = [ary count];
    for(int i=0; i<number; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.frame = CGRectMake(100, 100+80*i, 80, 40);
        
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchDown];
        
        btn.tag = 101 + i;
        
        [btn setTitle:ary[i] forState:UIControlStateNormal];

        [self.view addSubview:btn];
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)pressBtn :(UIButton *)btn
{
    switch (btn.tag) {
        case 101:
        {
            /*创建一个线程对象
             P1:线程对象运行函数的拥有者
             P2:线程处理函数
             P3:线程参数*/
            NSThread *newT = [[NSThread alloc] initWithTarget:self selector:@selector(createThread:) object:@"线程01"];
            
            //启动并且运行线程;
            [newT start];
            break;
        }
        case 102:
        {
            //创建并启动线程
            //不能赋值，因为没有返回值
            [NSThread detachNewThreadSelector:@selector(createThread:) toTarget:self withObject:@"线程02"];
            break;
        }
        case 103:
        {
            //开一个后台线程（子线程）
            [self performSelectorInBackground:@selector(createThread:) withObject:@"线程03"];
            break;
        }
        case 104:
        {
            [self performSelectorInBackground:@selector(createThreadSleep:) withObject:@"休眠线程01"];
            break;
        }
        case 105:
        {
            [self performSelectorInBackground:@selector(createThreadSleep:) withObject:@"休眠线程02"];
            break;
        }
        case 106:
        {
            [self performSelectorInBackground:@selector(createThreadSleep:) withObject:@"强制退出线程"];
            break;
        }
        default:
            break;
    }
}

-(void)createThread :(NSString *)str{
    if(![str isEqualToString:@"线程03"]){
        //第一种方法加同步锁
        for(int i=0; i<2500; i++){
            [_lock lock];
            
            _counter++;
            
            [_lock unlock];
            
            NSLog(@"%ld", _counter);
        }
        
        //第二种方法加同步锁
//        @synchronized(self) {
//            for(int i=0; i<2500; i++){
//                
//                _counter++;
//                
//                NSLog(@"%ld", _counter);
//            }
//        }
        
    
        NSLog(@"thread01: %ld", _counter);
    }
    else if([str isEqualToString:@"线程03"]){
        NSLog(@"线程03 %@", str);
        
        //waitUntilDone: YES:回调函数执行完成，再执行下面代码
        //                NO:同步执行下面代码
        [self performSelectorOnMainThread:@selector(returnThread:) withObject:@"回调函数" waitUntilDone:YES];
        
        NSLog(@"回调函数成功");
    }
    
    NSLog(@"线程：%@, 输出参数：%@", [NSThread currentThread], str);
}

-(void) returnThread:(NSString *)str
{
    NSLog(@"在回调函数中");
}



-(void) createThreadSleep : (NSString *)str
{
    //线程休眠
    NSLog(@"线程：%@，参数：%@", [NSThread currentThread], str);
    
    if([str isEqualToString:@"休眠线程01"]){
        //第一种方法
        //P1:时间（秒）
        [NSThread sleepForTimeInterval:2];
    }
    else if([str isEqualToString:@"休眠线程02"]){
        //第二种方法
        //P1:传入定制的时间
        [NSThread sleepUntilDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    }
    else if([str isEqualToString:@"强制退出线程"]){
        for(int i=0; i<1000; i++){
            
            NSLog(@"%d", i);
            
            if(i == 200){
                [NSThread exit];
            }
        }
        
    }
    
    NSLog(@"再次执行线程");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
