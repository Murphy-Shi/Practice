//
//  ConnectionTwoViewController.m
//  UIWeb
//
//  Created by murphy_shi on 16/10/17.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "NSConnectionViewController.h"
#define LIST_URL @"http://new.api.bandu.cn/book/listofgrade?grade_id=2"

//NSURLConnectionDataDelegate:连接服务器的普通代理协议，作为错误处理等协议完成;
//NSURLConnectionDelegate:连接服务器对象的数据代理协议，当回传数据时使用的协议;
@interface NSConnectionViewController ()<
NSURLConnectionDataDelegate,
NSURLConnectionDelegate>
{
    //定义一个URL连接对象，通过网络地址，可以进行连接工作
    NSURLConnection *_connect;
    
    //接受服务器传回的数据
    NSMutableData *_data;
}
@end

@implementation NSConnectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    _data = [[NSMutableData alloc] init];
    // Do any additional setup after loading the view.
    
    NSArray *arr = @[@"同步请求", @"block异步", @"delegate异步"];
    NSUInteger count = [arr count];
    for(int i=0; i<count; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(80, 70+i*40, 50, 30);
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        
        btn.tag = 100 + i;
        
        [btn sizeToFit];
        
        [self.view addSubview: btn];
    }
}

- (void)btnAction :(UIButton *)sender
{
    // 1.创建NSURL对象
    NSURL *url = [NSURL URLWithString:LIST_URL];
    
    // 2.创建NSURLRequst 默认GET
    NSURLRequest *request = [NSURLRequest requestWithURL: url];
    
    switch (sender.tag) {
        case 100:   //同步请求
        {
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
            
            if(error == nil){
                NSLog(@"request: %@", request);
                
                NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                
                NSLog(@"---%@", str);
            }
            else{
                NSLog(@"--错误信息: %@", error);
            }
            
            NSLog(@"线程：%@", [NSThread currentThread]);
            break;
        }
            
        case 101:   //block方式异步请求
        {
            //[NSOperationQueue mainQueue]为主队列，[[NSOperationQueue alloc] init]子队列
            [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
                
                if(connectionError == nil){
                    NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSLog(@"str = %@", str);
                }
                else{
                    NSLog(@"error = %@", connectionError);
                }
                
                //查看线程
                NSLog(@"currentThread = %@", [NSThread currentThread]);
            }];
            
            break;
        }
            
        case 102:   //delegate请求
        {
            //创建一个网络连接对象
            //参数一：连接的请求对象
            //参数二：代理对象，用来实现回传数据的代理协议
            _connect = [NSURLConnection connectionWithRequest: request delegate:self];
            
            break;
        }
            
        default:
            break;
    }
}

#pragma mark -
#pragma mark -- Delegate --
//处理错误信息的代理协议
//如果有任何连接错误，调用此协议，运行错误的打印查看
//P1:连接对象
//P2:错误信息
- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"error: = %@", error);
}

//处理服务器的响应码
- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    //将响应码转化为http响应码
    NSHTTPURLResponse *res = (NSHTTPURLResponse *) response;
    
    switch (res.statusCode) {
        case 200:
            NSLog(@"连接成功！服务器政策！");
            break;
        case 400:
            NSLog(@"客户端请求语法错误，服务器无法解析");
            break;
        case 404:
            NSLog(@"服务器正常开启，没有找到连接地址网页或数据");
            break;
        case 500:
            NSLog(@"服务器宕机或关机");
            break;
        default:
            break;
    }
}

//接受服务器回传数据时调用
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    //将每次回传的数据连接起来
    [_data appendData:data];
}

- (void) connectionDidFinishLoading:(NSURLConnection *)connection{
    //将二进制数据转化为字符串(解析)
    NSLog(@"baidu page = %@", [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding]);
    
    //查看线程
    NSLog(@"currentThread = %@", [NSThread currentThread]);
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
