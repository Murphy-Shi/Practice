//
//  XMPPLogin.m
//  UIWeb
//
//  Created by Murphy Shi on 2016/11/1.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "XMPPManager.h"
#import "XMPPConfig.h"

@implementation XMPPManager

#pragma mark -
#pragma mark -- 单例模式 --
+ (XMPPManager *)sharedManager
{
    static XMPPManager *manager = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        manager = [[XMPPManager alloc] init];
    });
    
    return manager;
}

-(XMPPStream *)stream
{
    if(!_stream){
        _stream = [[XMPPStream alloc] init];
        
        _stream.hostName = kHostName;
        
        _stream.hostPort = kHostPort;
        
        [_stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    }
    
    return _stream;
}


#pragma mark -
#pragma mark -- 登录账号 --
-(void)loginWithUserName:(NSString *)userAccount password:(NSString *)userPassword
{
    self.password = userPassword;
    
    self.stream.myJID = [XMPPJID jidWithUser:userAccount domain:kHostName resource:@"IOS"];
    
    [self connectToServer];
}


#pragma make -
#pragma make -- 连接服务器 --
- (void)connectToServer
{
    // 查看是否已连接
    if([self.stream isConnected]){
        [self logout];
    }
    
    NSError *error = nil;
    
    [self.stream connectWithTimeout:10.0f error:&error];
    
    if(error != nil){
        NSLog(@"connectToServer: %@", error);
    }
}


#pragma mark -
#pragma mark -- 连接服务器成功 --
-(void)xmppStreamDidConnect:(XMPPStream *)sender{
    NSLog(@"连接服务器成功");
    
    // 查看请求类型
    NSError *error = nil;
    switch (self.connectServerPurposeType) {
        case ConnectServerPurposeLogin:
            [sender authenticateWithPassword:self.password error:&error];
            break;
            
        case ConnectServerPurposeRegister:
            [sender registerWithPassword:self.password error:&error];
            break;
        default:
            break;
    }
    
    if(error != nil){
        NSLog(@"xmppStreamDidConnect: %@", error);
    }
}


#pragma mark -
#pragma mark -- 连接失败 --
- (void)xmppStream:(XMPPStream *)sender didFailToSendIQ:(XMPPIQ *)iq error:(NSError *)error
{
    NSLog(@"连接失败：%@", error);
}


#pragma mark -
#pragma mark -- 验证成功 --
-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"available"];
    [self.stream sendElement: presence];
    NSLog(@"登录成功");
}

#pragma mark -
#pragma mark -- 验证失败 ——-
-(void)xmppStream:(XMPPStream *)sender didNotAuthenticate:(DDXMLElement *)error{
    NSLog(@"didNotAuthenticate: %@", error);
    
    [[[UIAlertView alloc] initWithTitle:@"登录失败"
                                message:@"账号或密码错误，请重新输入"
                               delegate:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles: nil] show];
}

#pragma mark -
#pragma mark -- 接收消息 --
-(void)xmppStream:(XMPPStream *)sender didReceiveMessage:(XMPPMessage *)message{
    NSString *msg = [[message elementsForName:@"body"] lastObject];
    NSLog(@"msg: %@", msg);
}


#pragma mark -
#pragma mark -- 连接网络超时 --
-(void)xmppStreamConnectDidTimeout:(XMPPStream *)sender{
    NSLog(@"连接超时");
    
    [[[UIAlertView alloc] initWithTitle:@"网络错误"
                                message:@"连接超时，请检查网络"
                               delegate:nil
                      cancelButtonTitle:@"确定"
                      otherButtonTitles: nil] show];
}


#pragma mark -
#pragma mark -- 注销账号 --
-(void)logout
{
    // unavailable:离线
    XMPPPresence *presence = [XMPPPresence presenceWithType:@"unavailable"];
    
    // 向服务器发送离线消息
    [self.stream sendElement: presence];
    
    // 断开连接
    [self.stream disconnect];
}

@end
