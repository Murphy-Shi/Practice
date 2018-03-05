//
//  DateCalendarView.h
//  UIWeb
//
//  Created by Murphy Shi on 2016/11/3.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateCalendarView : UIView

+ (instancetype)addDateView: (UIView *)view;

@property (nonatomic, copy) void(^dateBlock)(NSInteger year, NSInteger month, NSInteger day);

@end
