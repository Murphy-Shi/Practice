//
//  OperationViewController.m
//  UIWeb
//
//  Created by murphy_shi on 16/10/24.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "OperationViewController.h"
#import "customOperation.h"

#define IMAGE_URL @"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg"

@interface OperationViewController ()

@property (nonatomic, strong) NSOperationQueue *queueOne;

@end

@implementation OperationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSArray *arr = @[@"invocation", @"BlockOperation", @"自定义", @"任务队列", @"依赖关系", @"最大并发数", @"任务挂起/恢复（先按“最大。。”）", @"任务取消"];
    NSUInteger count = [arr count];
    for (int i=0; i<count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        btn.frame = CGRectMake(80, 80+50*i, 60, 40);
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        
        btn.tag = 100 + i;
        
        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(btnAcntion:) forControlEvents:UIControlEventTouchDown];
        
        [self.view addSubview: btn];
    }
    
    // Do any additional setup after loading the view.
}

-(void)btnAcntion :(UIButton *)btn
{
    switch (btn.tag) {
        case 100:   //invocation
            [self invocationOperation];
            break;
        case 101:
            [self BlockOperation];
            break;
        case 102:
            [self custom];
            break;
        case 103:
            [self mainQueue];
            break;
        case 104:
            [self depenDency];
            break;
        case 105:
            [self maxConcurreatCount];
            break;
        case 106:
            [self suspdendAndCancel:@"suspdend"];
            break;
        case 107:
            [self suspdendAndCancel:@"cancel"];
            break;
        default:
            break;
    }
}

//invocationOperation
- (void) invocationOperation
{
    //默认情况下，调用start方法后，并不回开启新的线程去执行操作，而是在当线程中进行同步操作
    //只有讲NSOperation放到NSOperationQueue中才会执行异步操作
    
    NSInvocationOperation *ip = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(invocationOperationAction) object:nil];
    
    //开启任务
    [ip start];
    
//    [self per]
}
- (void) invocationOperationAction
{
    NSLog(@"----1---%@", [NSThread currentThread]);
}


//BlockOperation
- (void) BlockOperation
{
    //只要NSBlockOperation封装的操作数大于1，就回开启线程，异步执行
    
    //在主线程中完成
    NSBlockOperation *bp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"----2---%@", [NSThread currentThread]);
    }];
    
    //额外任务，在子线程中执行
    [bp addExecutionBlock:^{
        NSLog(@"----3 ---%@", [NSThread currentThread]);
    }];
    
    [bp start];
}


// 自定义(需要重写main方法)
- (void) custom {
    [super didReceiveMemoryWarning];
    
    customOperation *co = [[customOperation alloc] init];
    
    [co start];
}


// 主队列
- (void) mainQueue
{
    // 创建队列(默认创建并行队列)
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSInvocationOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(mainAction:) object: @"op"];
    
    NSInvocationOperation *opT = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(mainAction:) object: @"opT"];
    
    // 将操作放置于队列中, 不需要用start开启
    [queue addOperation: op];
    [queue addOperation: opT];
    
    [queue addOperationWithBlock:^{
        NSLog(@"-----6---- %@", [NSThread currentThread]);
    }];
}

-(void)mainAction :(NSString *)str
{
    if([str isEqualToString: @"op"]){
        NSLog(@"-----4---- %@", [NSThread currentThread]);
    }
    else if([str isEqualToString: @"opT"]){
        NSLog(@"-----5---- %@", [NSThread currentThread]);
    }
    
}

// 任务依赖  --- 如果一依赖二， 等二执行完成，再执行一
- (void)depenDency
{
    // 任务之间不能相互依赖
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    NSBlockOperation *bp = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务一:%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *bpTwo = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务二:%@", [NSThread currentThread]);
    }];
    
    NSBlockOperation *bpThree = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"任务三:%@", [NSThread currentThread]);
    }];
    
    // 前者依赖于后者，先执行后者，再执行前者
    [bpTwo addDependency: bp];
    
    [queue addOperation: bp];
    [queue addOperation: bpTwo];
    [queue addOperation: bpThree];
}

// 最大并发数量
- (void)maxConcurreatCount
{
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    queue.maxConcurrentOperationCount = 2;
    
    [queue addOperationWithBlock:^{
        for(int i=0; i<1000; i++){
            NSLog(@"线程一,%@， %d", [NSThread currentThread], i);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for(int i=0; i<1000; i++){
            NSLog(@"线程二,%@, %d", [NSThread currentThread], i);
        }
    }];
    
    [queue addOperationWithBlock:^{
        for(int i=0; i<1000; i++){
            NSLog(@"线程三,%@, %d", [NSThread currentThread], i);
        }
    }];
    
    self.queueOne = queue;
}

// 任务挂起与取消
- (void)suspdendAndCancel : (NSString *)str
{
    if([str isEqualToString: @"suspdend"]){
        if(!self.queueOne.suspended){
            self.queueOne.suspended = YES;
        }
        else{
            self.queueOne.suspended = NO;
        }
    }
    //如果是自定义的队列需要在自定义中使用self.cancelled判断是否已经取消.若无判断将继续执行
    else if([str isEqualToString:@"cancel"]){
        [self.queueOne cancelAllOperations];
    }
}

- (void)didReceiveMemoryWarning {
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
