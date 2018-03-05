//
//  testProtocolAgain.h
//  UIWeb
//
//  Created by murphy_shi on 16/10/8.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol testProtocolDelegate <NSObject>;



@required
- (void) showProtocol :(NSString *)str;

@optional
- (void) showTestProtocol;
@end

@interface testProtocolAgain : NSObject

@property (nonatomic, weak) id<testProtocolDelegate> delegate;

@property (nonatomic, strong) NSString *testProtocolStr;

-(void) printProcotol :(NSString *)str;;

-(void) printNProcotol;

@end
