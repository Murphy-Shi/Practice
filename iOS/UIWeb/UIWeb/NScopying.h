//
//  NScopying.h
//  UIWeb
//
//  Created by murphy_shi on 16/9/22.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol testDelegate <NSObject>;

-(void) showDelegate;

@end

typedef void (^passBlock)(UILabel *);

@interface NScopying : UIViewController

@property (nonatomic, copy)passBlock passValueBloack;

@property (nonatomic, weak) id<testDelegate> delegate;
@end
