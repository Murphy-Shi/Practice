//
//  XMPPLogin.h
//  UIWeb
//
//  Created by Murphy Shi on 2016/11/1.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XMPPFramework.h"

@interface XMPPManager : NSObject<
XMPPStreamDelegate>

+ (XMPPManager *)sharedManager;

typedef NS_ENUM(NSInteger, ConnectServerPurpose)
{
    ConnectServerPurposeLogin,    //登录
    ConnectServerPurposeRegister   //注册
};

@property (nonatomic, strong) NSString *password;

@property (nonatomic, assign) BOOL isSuccess;

// 通信管道、输入输出流
@property (nonatomic, strong) XMPPStream *stream;

// 标记连接服务器属性
@property (nonatomic) ConnectServerPurpose connectServerPurposeType;

// 登录
- (void)loginWithUserName:(NSString *)userAccount
                 password:(NSString *)userPassword;


// 注销
- (void)logout;


@end
