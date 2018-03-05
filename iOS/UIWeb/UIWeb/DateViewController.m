//
//  DateViewController.m
//  UIWeb
//
//  Created by Murphy Shi on 2016/11/3.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "DateViewController.h"
#import "DateCalendarView.h"
#import "ScheduleView.h"

@interface DateViewController ()

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor: [UIColor whiteColor]];
    
    self.navigationController.navigationBar.translucent = NO;
    
    DateCalendarView *dateView = [DateCalendarView addDateView: self.view];
    
    dateView.dateBlock = ^(NSInteger year, NSInteger month, NSInteger day){
        NSLog(@"year: %li, month: %li, day: %li", year, month, day);
    };
    
    [ScheduleView addScheduleView: self.view];
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
