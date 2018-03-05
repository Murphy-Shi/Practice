//
//  LoginViewController.h
//  UIWeb
//
//  Created by Murphy Shi on 16/10/30.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end
