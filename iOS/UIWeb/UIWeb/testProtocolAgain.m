//
//  testProtocolAgain.m
//  UIWeb
//
//  Created by murphy_shi on 16/10/8.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "testProtocolAgain.h"

@implementation testProtocolAgain

-(void)printProcotol :(NSString *)str;
{
    [self.delegate showProtocol:str];
    NSLog(@"调用协议内必须的函数:%@",str);
}

- (void) printNProcotol
{
    [self.delegate showTestProtocol];
    NSLog(@"运行协议内非必要的函数");
}
@end
