//
//  LoginViewController.m
//  UIWeb
//
//  Created by Murphy Shi on 16/10/30.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "LoginViewController.h"
#import "XMPPmanager.h"

@interface LoginViewController ()<
XMPPMUCDelegate>
@end

@implementation LoginViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [[XMPPManager sharedManager].stream addDelegate:self delegateQueue:dispatch_get_main_queue()];
//    [[XMPPManager sharedManager].xmppStream addDelegate:self delegateQueue:dispatch_get_main_queue()];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)buttonAction:(UIButton *)sender {
    
    if(self.accountText.text.length == 0 || self.passwordText.text.length == 0){
        [[[UIAlertView alloc] initWithTitle:@"登录失败" message:@"账号密码不能为空，请重新输入" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];
    }
    
    [[XMPPManager sharedManager] loginWithUserName:self.accountText.text password:self.passwordText.text];
}

-(void)xmppStreamDidAuthenticate:(XMPPStream *)sender{
    NSLog(@"登录成功返回的信息");
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
