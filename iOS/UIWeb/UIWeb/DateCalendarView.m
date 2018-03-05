//
//  DateCalendarView.m
//  UIWeb
//
//  Created by Murphy Shi on 2016/11/3.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "DateCalendarView.h"
#import "DateCollectionViewCell.h"
#import "NSDate+ChineseDate.h"

#define BUTTON_SIZE 40.0
#define TITLEVIEW_SIZE 150
#define CLLVIEW_SIZE 300
#define DAY_TIME 86400  //一天的时间（S）

static NSString * const reuseIdDate = @"DateCell";
static NSString * const reuseIdWeek = @"WeekCell";

@interface DateCalendarView()<
UICollectionViewDelegate, UICollectionViewDataSource>
{
    CGFloat itemWidth;
    CGFloat itemHeight;
}

@property (nonatomic, strong) IBOutlet NSDate *date;

@property (nonatomic, strong) IBOutlet NSDate *today;

@property (nonatomic, strong) IBOutlet UIView *dateView;

@property (nonatomic, strong) IBOutlet UIView *titleView;

@property (nonatomic, strong) IBOutlet UILabel *titleLabel;

@property (nonatomic, strong) IBOutlet UIButton *nextButton;

@property (nonatomic, strong) IBOutlet UIButton *previousButton;

@property (nonatomic, strong) IBOutlet UICollectionView *collection;

@property (nonatomic, strong) NSArray *weekDayArr;
@end

@implementation DateCalendarView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self reloadDate];
    [self addSwipe];
}

+ (instancetype)addDateView: (UIView *)view{
    DateCalendarView *dateCalendarView = [[DateCalendarView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width, TITLEVIEW_SIZE + CLLVIEW_SIZE)];
    dateCalendarView.dateView = [[UIView alloc] initWithFrame: CGRectMake(0, 50, view.frame.size.width, TITLEVIEW_SIZE)];
    dateCalendarView.dateView.backgroundColor = [UIColor whiteColor];
    dateCalendarView.backgroundColor = [UIColor whiteColor];
    
    [view addSubview: dateCalendarView];
    [view addSubview: dateCalendarView.titleView];
    [view addSubview: dateCalendarView.dateView];
    [view addSubview: dateCalendarView.collection];
    
    return dateCalendarView;
}

- (void)reloadDate{
    NSString *date = [NSString stringWithFormat: @"%@", self.date];
    NSString *year = [date substringToIndex: 4];
    NSString *month = [date substringWithRange:NSMakeRange(5, 2)];
    self.titleLabel.text = [NSString stringWithFormat:@"%@年%@月", year, month];
}


#pragma mark -
#pragma mark - 懒加载控件和数据 -- 
-(UICollectionView *)collection{
    if(!_collection){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        _collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 50, self.dateView.frame.size.width, CLLVIEW_SIZE)
                                         collectionViewLayout:flowLayout];
        
        itemWidth = _collection.frame.size.width / 7;
        itemHeight = _collection.frame.size.height / 7;
        
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);


        _collection.backgroundColor = [UIColor whiteColor];
        _collection.delegate = self;
        _collection.dataSource = self;
        
        [_collection registerClass:[DateCell class] forCellWithReuseIdentifier:reuseIdDate];
        [_collection registerClass:[WeekCell class] forCellWithReuseIdentifier:reuseIdWeek];
        self.weekDayArr = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
    }
    return _collection;
}
-(UIView *)titleView{
    if(!_titleView){
        _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.dateView.frame.size.width, BUTTON_SIZE)];
        _titleView.backgroundColor = [UIColor blueColor];
        
        // 添加next按钮
        self.nextButton = [UIButton buttonWithType: UIButtonTypeSystem];
        self.nextButton.frame = CGRectMake(self.dateView.frame.size.width - BUTTON_SIZE, 0, BUTTON_SIZE, BUTTON_SIZE);
        [self.nextButton setImage:[UIImage imageNamed:@"bt_next"] forState:UIControlStateNormal];
        [self.nextButton setTintColor: [UIColor whiteColor]];
        [self.nextButton addTarget:self action:@selector(nexAction:) forControlEvents:UIControlEventTouchDown];
        [_titleView addSubview: self.nextButton];
        
        // 添加previous按钮
        self.previousButton = [UIButton buttonWithType: UIButtonTypeSystem];
        self.previousButton.frame = CGRectMake(0, 0, BUTTON_SIZE , BUTTON_SIZE);
        [self.previousButton setTintColor: [UIColor whiteColor]];
        [self.previousButton setImage:[UIImage imageNamed:@"bt_previous"] forState:UIControlStateNormal];
        [self.previousButton addTarget:self action:@selector(previouseAction:) forControlEvents:UIControlEventTouchDown];
        [_titleView addSubview: self.previousButton];
        
        // 添加title
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.dateView.frame.size.width, BUTTON_SIZE)];
        [self.titleLabel setTextAlignment: NSTextAlignmentCenter];
        self.titleLabel.textColor = [UIColor whiteColor];
        self.titleLabel.text = @"";
        [_titleView addSubview: self.titleLabel];
    }
    
    return _titleView;
}
- (NSDate *)date{
    if(!_date){
        NSInteger interval = [[NSTimeZone systemTimeZone] secondsFromGMTForDate: [NSDate date]];
        NSDate *localeDate = [[NSDate date]  dateByAddingTimeInterval: interval];
        self.date = localeDate;
        self.today = self.date;
    }
    
    return _date;
}


#pragma mark -
#pragma mark -- Delegate --
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 2;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSInteger count = section;
    return (count == 0 ? [self.weekDayArr count] : 42);
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 1){ // 日期
        NSInteger totalDays =  [self totaldaysInMonth: self.date];
        NSInteger firstWeek = [self firstWeekdayInThisMonth: self.date];
        
        DateCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdDate forIndexPath:indexPath];
        
        if(indexPath.row < firstWeek || indexPath.row >= totalDays + firstWeek){
            cell.dateLabel.text = @"";
            cell.chineseDateLabel.text = @"";
            cell.imgView.backgroundColor = [UIColor whiteColor];
        }
        else if(indexPath.row < totalDays + firstWeek){
            cell.dateLabel.text = [NSString stringWithFormat:@"%li", (long)indexPath.row - firstWeek + 1];
            cell.chineseDateLabel.text = [self chineseDate: indexPath.row - firstWeek];
            
            if((indexPath.row - 1) == [self day: self.date] && [self.today isEqualToDate: self.date]){
                cell.imgView.backgroundColor = [UIColor blueColor];
                cell.chineseDateLabel.textColor = [UIColor whiteColor];
                cell.dateLabel.textColor = [UIColor whiteColor];
            }
            else{
                cell.imgView.backgroundColor = [UIColor whiteColor];
                cell.chineseDateLabel.textColor = [UIColor grayColor];
                cell.dateLabel.textColor = [UIColor blackColor];
            }
        }
        
        return cell;
    }
    else{   // 星期
        WeekCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdWeek forIndexPath:indexPath];
        cell.weekLabel.text = self.weekDayArr[indexPath.row];
        return cell;
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        // 获取被点击的日期
        NSDateComponents *comp = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self.date];
        
        NSInteger firstWeek = [self firstWeekdayInThisMonth: self.date];
        
        NSInteger day = indexPath.row - firstWeek + 1;
        
        if(self.dateBlock){
            self.dateBlock([comp year], [comp month], day);
        }
        
        // 改变按钮颜色
        DateCell *cell = (DateCell *)[collectionView cellForItemAtIndexPath: indexPath];
        cell.imgView.backgroundColor = [UIColor greenColor];
    }
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 1){
        return CGSizeMake(itemWidth, itemHeight);
    }
    else{
        return CGSizeMake(itemWidth, 30);
    }
}

// 按钮响应
- (IBAction)previouseAction:(UIButton *)sender
{
    [UIView transitionWithView:self.collection duration:0.5 options:UIViewAnimationOptionTransitionCurlDown animations:^(void) {
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        dateComponents.month = -1;
        self.date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self.date options:0];
        
        [self.collection reloadData];
        [self reloadDate];
    } completion:nil];
}

- (IBAction)nexAction:(UIButton *)sender
{
    [UIView transitionWithView:self.collection duration:0.5 options:UIViewAnimationOptionTransitionCurlUp animations:^(void) {
        NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
        dateComponents.month = +1;
        self.date = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:self.date options:0];;
        
        [self.collection reloadData];
        [self reloadDate];
    } completion:nil];
}

// 获取农历时间
-(NSString *)chineseDate: (NSInteger)day {
    NSMutableString *dateStr = [NSMutableString stringWithFormat: @"%@", self.date];
    
    [dateStr replaceCharactersInRange:NSMakeRange(8, 2) withString:@"01"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *dateTmp = [dateFormatter dateFromString: [dateStr substringToIndex: 20]];
    
    dateTmp = [dateTmp dateByAddingTimeInterval: DAY_TIME * day];
    
    return [[dateTmp getChineseCalendar] substringWithRange:NSMakeRange(5, 2)];
}


// 添加手势
- (void)addSwipe
{
    UISwipeGestureRecognizer *swipLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(nexAction:)];
    swipLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.collection addGestureRecognizer:swipLeft];
    
    UISwipeGestureRecognizer *swipRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(previouseAction:)];
    swipRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collection addGestureRecognizer:swipRight];
}

// 获取当前月份的天数
- (NSInteger)totaldaysInMonth:(NSDate *)date{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    return daysInLastMonth.length;
}

// 获取当前月份1号的星期
- (NSInteger)firstWeekdayInThisMonth:(NSDate *)date{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    
    [comp setDay:1];
    
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    
    return firstWeekday - 1;
}

// 获取今天的天数
- (NSInteger)day:(NSDate *)date{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}

@end
