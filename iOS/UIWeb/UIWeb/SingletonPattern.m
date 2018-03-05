//
//  SingletonPattern.m
//  UIWeb
//
//  Created by murphy_shi on 16/9/22.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "SingletonPattern.h"

@implementation SingletonPattern

//+ (SingletonPattern *)shareManager
//{
//    static dispatch_once_t onceToken;
//    static SingletonPattern *singletonPattern;
//    dispatch_once(&onceToken , ^{
//        singletonPattern = [[SingletonPattern alloc] init];
//    });
//    
//    return singletonPattern;
//}

+ (SingletonPattern *)shareManager
{
    static dispatch_once_t onceToken;
    static SingletonPattern *singletoPattern;
    dispatch_once(&onceToken, ^{
        singletoPattern = [[SingletonPattern alloc] init];
    });
    
    return singletoPattern;
}

@end
