//
//  ScheduleView.m
//  UIWeb
//
//  Created by Murphy Shi on 2016/11/8.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "ScheduleView.h"

#import "SchedulleTableViewCell.h"

static NSString * const reuseIdCell = @"SchedulleTableViewCell";

@interface ScheduleView()<
UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;

@property (nonatomic, strong) IBOutlet UIView *scheduleView;

@end

@implementation ScheduleView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

+ (void)addScheduleView: (UIView *)view{
    ScheduleView *schedule = [[ScheduleView alloc] initWithFrame:CGRectMake(0, 350, view.frame.size.width, view.frame.size.height-350)];
    schedule.backgroundColor = [UIColor blackColor];
    
    [schedule addSubview: schedule.tableView];
    [view addSubview: schedule];
}

#pragma mark -
#pragma mark -- 懒加载 --
-(UITableView *)tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
        [_tableView registerNib:[UINib nibWithNibName:reuseIdCell bundle:nil] forCellReuseIdentifier:reuseIdCell];
        [_tableView respondsToSelector:@selector(setSeparatorInset:)];
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _tableView.showsVerticalScrollIndicator = NO;
    }
    return _tableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SchedulleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdCell];
    
    cell.taskLabel.text = @"参加军队训练";
    cell.timeLabel.text = @"21:00";
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 30)];
    [headView.layer setBorderColor: [UIColor grayColor].CGColor];
    [headView.layer setBorderWidth: 0.5];
    [headView.layer setMasksToBounds: YES];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, 30)];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.font = [UIFont boldSystemFontOfSize: 13.0];
    titleLabel.textColor = [UIColor grayColor];
    titleLabel.text = @"今天， 农历十月初二";
    
    [headView addSubview: titleLabel];
    
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
@end
