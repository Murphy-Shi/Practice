//
//  RunLoopViewController.m
//  UIWeb
//
//  Created by Murphy Shi on 2016/11/1.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "RunLoopViewController.h"

@interface RunLoopViewController ()

@end

@implementation RunLoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self performSeector];
    [self timer];
    // Do any additional setup after loading the view from its nib.
}

-(void)performSeector{
    [self performSelector:@selector(run) withObject:nil afterDelay:2 inModes:@[NSRunLoopCommonModes]];
}

- (IBAction)btnAction:(UIButton *)sender {
    // 如果给runLoop 添加观察者，需要CF类
    
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        NSLog(@"----%lu", activity);
    });
    
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
}

- (void) timer{
    // 自动加在runLoop下，可以直接运行
    //    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(run) userInfo:nil repeats:YES];
    
    // 只应用于默认模式下, TextView滚动模式下不执行
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    // 只能运行于滚动模式下
    //    [[NSRunLoop currentRunLoop] addTimer:timer forMode:UITrackingRunLoopMode];
    
    // 滚动和不滚动都能运行
    // NSRunLoopCommonModes它只是一个标记, 模式有：UITrackingRunLoopMode、NSDefaultRunLoopMode
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)run
{
    NSLog(@"Run");
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
