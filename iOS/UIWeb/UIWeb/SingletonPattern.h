//
//  SingletonPattern.h
//  UIWeb
//
//  Created by murphy_shi on 16/9/22.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SingletonPattern : NSObject

+ (SingletonPattern *)shareManager;

@property (nonatomic, strong) NSString *seesid;
@end
