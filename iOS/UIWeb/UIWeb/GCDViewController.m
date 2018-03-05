//
//  GCDViewController.m
//  UIWeb
//
//  Created by murphy_shi on 16/10/20.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "GCDViewController.h"

#define IMAGE_URL @"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg"

@interface GCDViewController ()

@property (nonatomic, strong) IBOutlet UIImageView *imageView;
@end

@implementation GCDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 300, 200, 150)];
    
    NSArray *arr = @[@"并行队列", @"线程通信", @"串行队列", @"主队列", @"全程队列"];
    NSUInteger count = [arr count];
    for(int i=0; i<count; i++){
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeSystem];
        
        btn.frame = CGRectMake(80, 80 + i * 50, 70, 40);
        
        [btn setTitle:arr[i] forState: UIControlStateNormal];
        
        btn.tag = 100 + i;
        
        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(btnAcntion:) forControlEvents:UIControlEventTouchDown];

        [self.view addSubview: btn];
    }
    // Do any additional setup after loading the view.
}

-(void)btnAcntion: (UIButton *)btn
{
    switch (btn.tag) {
        case 100:   //并行同步队列
            [self concurrentSync];
            break;
        case 101:   //线程通信
            [self concurrentAsync];
            break;
        case 102:   //串行队列
            [self serialSync];
            break;
        case 103:   //主队列
            [self mainSync];
            break;
        case 104:   //全程队列
            [self globalSync];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark -- 并发任务 --
- (void)concurrentSync
{
    //并发队列 ＋ 同步任务 ＝ 不会开启新的线程，任务是逐个执行
    //并发队列 ＋ 异步任务 ＝ 会开启新的线程，任务是并发执行
    
    // 创建并发队列
    dispatch_queue_t queue = dispatch_queue_create("concurrentQueue", DISPATCH_QUEUE_CONCURRENT);
    
    // 在队列里面添加任务
    // 同步任务：dispatch_sync
    // 异步任务：dispatch_async
    dispatch_sync(queue, ^{
        for(int i=0; i<5; i++){
            NSLog(@"第一个任务：%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for(int i=0; i<5; i++){
            NSLog(@"第二个任务：%@", [NSThread currentThread]);
        }
    });
}

#pragma mark -
#pragma mark -- 串行队列 --
- (void) serialSync
{
    //串行队列 ＋ 同步任务 ＝ 不会开启新的线程，任务是逐个执行
    //串行队列 ＋ 异步任务 ＝ 会开启新的线程，任务是逐个执行
    
    //创建串行队列
    dispatch_queue_t queue = dispatch_queue_create("queue", NULL);
    
    dispatch_sync(queue, ^{
        for(int i=0; i<5; i++){
            NSLog(@"第一个任务：%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for(int i=0; i<5; i++){
            NSLog(@"第二个任务：%@", [NSThread currentThread]);
        }
    });
}


#pragma mark -
#pragma mark -- 线程通信 --
-(void)concurrentAsync
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //耗时操作
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString: IMAGE_URL]];
        UIImage *image = [UIImage imageWithData: data];
        
        // 回归到主线程
        // 同步：先打印“回归主线程”, 再打印“子线程”。
        // 异步：先打印“子线程”，再打印“回归主线程”；
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"回归主线程");
            self.imageView.image = image;
            [self.view addSubview: self.imageView];
        });
        
        NSLog(@"子线程");
    });
}

#pragma mark -
#pragma mark -- 全局队列 --
-(void)globalSync
{
    //全局队列 ＋ 同步任务 ＝ 不会开启新的线程，任务是逐个执行
    //全局队列 ＋ 异步任务 ＝ 不会开启新的线程，任务是并发执行
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_sync(queue, ^{
        for(int i=0; i<5; i++){
            NSLog(@"第一个任务：%@", [NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for(int i=0; i<5; i++){
            NSLog(@"第二个任务：%@", [NSThread currentThread]);
        }
    });
}

#pragma mark -
#pragma mark -- 主队列 --
-(void) mainSync
{
    //全局队列 ＋ 同步任务 ＝ 会造成死锁的线程
    //全局队列 ＋ 异步任务 ＝ 不会开启新的线程，任务是逐个执行
    
    //获取主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    dispatch_async(queue, ^{
        for(int i=0; i<5; i++){
            NSLog(@"第一个任务：%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for(int i=0; i<5; i++){
            NSLog(@"第二个任务：%@", [NSThread currentThread]);
        }
    });
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
