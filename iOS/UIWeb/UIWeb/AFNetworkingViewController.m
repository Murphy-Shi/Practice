//
//  AFNetworkingViewController.m
//  UIWeb
//
//  Created by murphy_shi on 16/10/13.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "AFNetworkingViewController.h"
#import "AFNetworking.h"
#import "Reachability.h"

#define BOOK_URL @"http://new.api.bandu.cn/book/listofgrade?grade_id=2"
#define IMAGE_URL @"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg"

@interface AFNetworkingViewController ()

@property (nonatomic, strong) Reachability *readch;

@end

@implementation AFNetworkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *arr = @[@"AFNetwork监测网络状态", @"发送请求", @"下载任务", @"开启网络监测"];
    NSUInteger count = [arr count];
    for(int i=0; i<count; i++)
    {
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeSystem];
        
        btn.frame = CGRectMake(80, 80+i*60, 50, 30);
        
        [btn setTitle:arr[i] forState:UIControlStateNormal];
        
        btn.tag = 100 + i;
        
        [btn sizeToFit];
        
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview: btn];
    }
    
    
    // Do any additional setup after loading the view.
}

- (void)btnAction :(UIButton *)btn
{
    switch (btn.tag) {
        case 100:
            [self AFNetMonitor];
            break;
        case 101:
            [self AFGetData];
            break;
        case 102:
            [self downloadImage];
            break;
        case 103:
            [self reachbility];
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark -- AFNetwork网络监测 --
- (void)AFNetMonitor
{
    //检查网络连接的状态
    //AFNetworkReachabilityManager 网络连接监测管理类
    
    //开启网络状态监测器
    //shareManager:获得唯一的单例对象
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    //获取网络连接的结果
    [[AFNetworkReachabilityManager sharedManager]
        setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
            
            switch (status) {
                case AFNetworkReachabilityStatusNotReachable:
                    NSLog(@"没有网络连接");
                    break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                    NSLog(@"WIFI连接");
                    break;
                case AFNetworkReachabilityStatusReachableViaWWAN:
                    NSLog(@"通过移动网络,4G");
                    break;
                default:
                    NSLog(@"无法知道网络类型");
                    break;
            }
        }];
}

#pragma mark -
#pragma mark -- 苹果官方监测网络 --
- (void)reachbility
{
    NSLog(@"开启网络监测");
    // 监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeReadchability) name:kReachabilityChangedNotification object:nil];
    
    //开启网络监控
    self.readch = [Reachability reachabilityForInternetConnection];
    
    [self.readch startNotifier];
}

- (void)changeReadchability
{
    // NotReachable = 0,
    // ReachableViaWiFi = 2,
    // ReachableViaWWAN = 1
    switch (self.readch.currentReachabilityStatus) {
        case NotReachable:
            NSLog(@"没有网络");
            break;
        case ReachableViaWWAN:
            NSLog(@"手机连接");
            break;
        case ReachableViaWiFi:
            NSLog(@"WIFI连接");
            break;
        default:
            break;
    }
}


#pragma mark -
#pragma mark -- AFNetwork请求数据 --
- (void) AFGetData
{
    //创建http连接管理对象
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];

    //响应序列化（响应接收到的数据）
    // AFXMLParserResponseSerializer: XML数据
    // AFJSONResponseSerializer: JSON数据
    // AFHTTPResponseSerializer: 二进制数据
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    //转换编码
//    NSString *str = [BOOK_URL stringByAddingPercentEncodingWithAllowedCharacters: [NSCharacterSet URLQueryAllowedCharacterSet]];
    
    //请求体
    NSDictionary *dict = @{@"grade_id":@"2"};
    
    /* GET 方法获取服务器的数据
     GET 通过get方法
     P1:参数传入一个url对象
     P2:通过制定的解构传入参数
     P3:指定下载的进度条UI
     P4:下载成功数据后调用此b语法块(PP1,下载的人物线程，pp2返回的数据内容)
     P5:下载失败后调用此语法块(pp1.下载的任务线程，pp2返回的错误类型) */
    [manager GET:BOOK_URL parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"请求成功 ");
        
        NSError *error = nil;
        
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:responseObject
                                                                options:NSJSONReadingMutableLeaves
                                                                  error:&error];
        
        if(error == nil){
            NSLog(@"%@", jsonDic);
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败！ error = %@", error);
    }];
}


#pragma mark -
#pragma mark -- AFNetwork download file --
-(void)downloadImage
{
    //定义管理器
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    // 下载任务
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:IMAGE_URL]];
    
    __block NSProgress *progresst = nil;
    
    // totalUnitCount 总共下载量
    // completedUnitCount 已下载的数据
    
    
    // progress:监测下载进度
    // block回调
    // targetPath下载后的位置
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress){
        //监测下载进度
        progresst = downloadProgress;
        
        // KVO监测进度
        [progresst addObserver:self forKeyPath:@"completedUnitCount" options:NSKeyValueObservingOptionNew context:nil];
        
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSLog(@"下载的位置%@", targetPath);
        
        //存放到沙盒
        NSString *location = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        
        //返回一个你想让下载的文件放置的位置
        return [NSURL fileURLWithPath: location];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        NSLog(@"filePath = %@", filePath);
        
        NSLog(@"error = %@", error);
    }];
    
    [task resume];
}

//监测下载进度
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSProgress *progress = (NSProgress *)object;
    NSLog(@"已经下载的进度为：%f", 1.0 * progress.completedUnitCount / progress.totalUnitCount);
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
