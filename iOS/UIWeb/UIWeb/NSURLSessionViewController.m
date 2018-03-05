//
//  NSURLSessionViewController.m
//  UIWeb
//
//  Created by murphy_shi on 16/10/18.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "NSURLSessionViewController.h"

#define LIST_URL @"http://new.api.bandu.cn/book/listofgrade?grade_id=2"
#define IMAGE_URL @"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg"
#define VIDER_URL @"http://war3down1.uuu9.com/war3/201609/201609131028.rar"

@interface NSURLSessionViewController ()<
NSURLSessionDataDelegate,
NSURLSessionDownloadDelegate
>
{
    //接收数据
    NSMutableData *_data;
    
    UIImageView *imageView;
    
    //区分下载
    BOOL isDonwloadImage;
}

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, strong) NSData *downloadData; //已下载的数据量

@end

@implementation NSURLSessionViewController

-(NSURLSession *)session{
    if(!_session){
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    }
    
    return _session;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.downloadData = [[NSData alloc] init];
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 400, 200, 100)];
    
    NSArray *arr = @[@"POST", @"GET", @"Delegate", @"donwload", @"开始下载", @"暂停下载", @"继续下载", @"取消下载"];
    NSUInteger count = [arr count];
    for(int i=0; i<count; i++){
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeSystem];
        
        btn.frame = CGRectMake(80, 100+i*50, 50, 40);
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        
        btn.tag = 100 + i;
        
        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview: btn];
    }
    // Do any additional setup after loading the view.
}

-(void)btnAction : (UIButton *)btn
{
    switch (btn.tag) {
        case 100:   //post
            [self POST];
            break;
        case 101:   //GET
            [self GET];
            break;
        case 102:   //delegate
            [self delegateRequest];
            break;
        case 103:   //download
            [self downloadImage];
            break;
        case 104:   //start download
        {
            isDonwloadImage = NO;
            
            //根据会话创建下载任务
            self.downloadTask = [self.session downloadTaskWithURL:[NSURL URLWithString: VIDER_URL]];
            
            //启动任务
            [self.downloadTask resume];
            break;
        }
        case 105:   //Pause download
            //可以继续恢复下载
            [self.downloadTask suspend];
            break;
        case 106:   //continue download
        {
            //如果在暂停时候没有保存数据则不需要下面语句
//            self.downloadTask = [self.session downloadTaskWithResumeData: self.downloadData];
            [self.downloadTask resume];
            break;
        }
        case 107:   //stop download
        {
            //取消任务，不能继续下载
            [self.downloadTask cancelByProducingResumeData:^(NSData * _Nullable resumeData) {
                //resumeData 代表当前下载了多少数据
                //如果不需要保存数据则无需赋值
//                self.downloadData = resumeData;
            }];
            break;
        }
        default:
            break;
    }
}


//POST请求方式
-(void)POST
{
    //设置地址
    NSURL *url = [NSURL URLWithString: @"http://new.api.bandu.cn/book/listofgrade"];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: url];
    
    //设置请求方式
    request.HTTPMethod = @"POST";
    
    //设置请求体
    request.HTTPBody = [@"grade_id=2" dataUsingEncoding:NSUTF8StringEncoding];
    
    // 1.创建Session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 2.根据会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"线程： %@", [NSThread currentThread]);
        if(error == nil)
        {
            //解析数据
            NSDictionary *jsoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &error];
            NSLog(@"%@", jsoDic);
        }
        
        //回归到主线程
        
        NSLog(@"POST完毕");
    }];
    
    // 3.启动任务
    [dataTask resume];
}


//GET请求方式
- (void)GET
{
    //设置地址
    NSURL *url = [NSURL URLWithString: LIST_URL];
    
    //封装一个请求类
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 1.创建Session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 2.根据会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"线程： %@", [NSThread currentThread]);
        if(error == nil)
        {
            //解析数据
            NSDictionary *jsoDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error: &error];
            NSLog(@"%@", jsoDic);
        }
        else{
            NSLog(@"error: %@", error);
        }
        
        //回归到主线程
        
        NSLog(@"GET完毕");
    }];
    
    // 3.启动任务
    [dataTask resume];
}

//使用协议来请求数据
-(void)delegateRequest
{
    isDonwloadImage = YES;
    
    // 设置地址
    NSURL *url = [NSURL URLWithString: LIST_URL];
    
    //封装一个请求类
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // 1.创建Session
    /*
     + (NSURLSessionConfiguration *)defaultSessionConfiguration; 默认
     + (NSURLSessionConfiguration *)ephemeralSessionConfiguration; 无痕浏览
     + (NSURLSessionConfiguration *)backgroundSessionConfigurationWithIdentifier:(NSString *)iddentifier 下载任务并通知
     */
    //delegateQueue:协议在哪个线程执行
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:self
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    
    //根据会话创建任务
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    
    //启动任务
    [dataTask resume];
}


#pragma mark -
#pragma mark -- Delegate --
//接收服务器的响应
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    NSLog(@"didReceiveResponse");
    
    if(_data == nil){
        _data = [[NSMutableData alloc] init];
    }
    else{
        _data.length = 0;
    }
    
    //NSURLSessionResponseDisposition:
//    NSURLSessionResponseCancel = 0,       //请求后不接受服务器数据，默认
//    NSURLSessionResponseAllow = 1,        //允许接受服务器的数据
//    NSURLSessionResponseBecomeDownload    //转成下载任务
//    NSURLSessionResponseBecomeStream NS_ENUM_AVAILABLE(10_11, 9_0) = 3,   //转成流
    completionHandler(NSURLSessionResponseAllow);
}

//接收到数据，该方法会调用调用多次
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    
    //拼接数据
    [_data appendData:data];
    
    NSLog(@"%@", _data);
}

// 数据请求完成/请求错误调用的方法
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if(error == nil){
        if(!isDonwloadImage){
            NSLog(@"下载任务完成");
        }
        else{
            id jsoDic = [NSJSONSerialization JSONObjectWithData:_data options:NSJSONReadingMutableContainers error:nil];
            NSLog(@"%@", jsoDic);
        }
        
        NSLog(@"delegate请求完毕");
    }
    else{
        NSLog(@"error = %@", error);
    }
}

- (void)downloadImage
{
    //1.会话
    NSURLSession *session = [NSURLSession sharedSession];
    
    //2.根据会话创建任务
    //location:本地文件url的位置
    NSURLSessionDownloadTask *Dask = [session downloadTaskWithURL:[NSURL URLWithString:IMAGE_URL] completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        //在子线程中运行
        if(error == nil)
        {
            NSLog(@"下载图片中");
            imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL: location]];
            [self.view addSubview: imageView];
        }
    }];
    
    //启动
    [Dask resume];
}

#pragma mark -
#pragma mark -- 下载任务协议 --
//下载的进度
// bytesWritten：当前次下载的数据大小
// totalBytesWritten 总共下载了多少数据量
// totalBytesExpectedToWrite 总数据的大小
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite
{
    NSLog(@"已经下载了%f", 1.0 * totalBytesWritten / totalBytesExpectedToWrite);
}

// 恢复任务调用
- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes
{
    NSLog(@"恢复了下载任务");
}

//下载完之后 文件所在位置
-(void) URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location
{
    NSLog(@"下载位置：%@", location);
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
