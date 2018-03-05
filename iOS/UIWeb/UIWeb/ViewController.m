//
//  ViewController.m
//  UIWeb
//
//  Created by murphy_shi on 16/8/17.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"

#import <QuickLook/QuickLook.h>  

#import <CoreData/CoreData.h>
#import "Card.h"
#import "Pason.h"

#import "KVOPerson.h"

#import "SingletonPattern.h"

// 数据库
#import "Sqlite3ViewController.h"

//网络
#import "NSConnectionViewController.h"
#import "NSURLSessionViewController.h"
#import "AFNetworkingViewController.h"


//多线程
#import "NSThreaedViewController.h"
#import "GCDViewController.h"
#import "OperationViewController.h"
#import "LoginViewController.h"
#import "RunLoopViewController.h"

//UI
#import "TableViewController.h"
#import "DateViewController.h"

#import "YCloudVODClient.h"


@interface ViewController (){
    AppDelegate *app;
}

@property (nonatomic, strong) IBOutlet UIView *firstView;
@property (nonatomic, assign) NSString *name;
@property (nonatomic, strong) KVOPerson *myPerson;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    app = [UIApplication sharedApplication].delegate;
//    [self singletonPattern];
//    [self KVOTest];
//    [self testProtocol];
//    [self testprotocolAgain];
//    [self createButtons];
//    [self dispatch];
    
//    YCloudVODClient *client = [[YCloudVODClient alloc] init:@"11"];
    
    [self useSqlite];

}


#pragma mark -
#pragma mark -- SQListe --
- (void)useSqlite
{
    NSArray * const ary = @[@"SQL", @"Session", @"Connect", @"AFNetwork",
                            @"Thread", @"Queue", @"GCD", @"RunLoop",  @"Table", @"XMPP",
                            @"日历"];
    NSUInteger number = [ary count];
    for(int i=0; i<number; i++){
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [btn addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchDown];
        
        btn.tag = 1001 + i;
        
        btn.frame = CGRectMake((10 + 70 * (i % 4)), (80 + i / 4 * 40), 50, 40);
        
        [btn setTitle:ary[i] forState:UIControlStateNormal];
        
        [btn sizeToFit];
    
        [self.view addSubview: btn];
    }
}


#pragma mark -
#pragma mark -- Button Action --
-(void)buttonAction : (UIButton *)button
{
    switch (button.tag) {
        case 1001:  //SQLite3
        {
            Sqlite3ViewController *sqlite = [[Sqlite3ViewController alloc] init];
            [self.navigationController pushViewController: sqlite animated:YES];
            break;
        }
        case 1002:  //NSURLSession网络
        {
            NSURLSessionViewController *url = [[NSURLSessionViewController alloc] init];
            [self.navigationController pushViewController:url animated:YES];
            break;
        }
        case 1003:  //Connection网络
        {
            NSConnectionViewController *url = [[NSConnectionViewController alloc] init];
            [self.navigationController pushViewController:url animated:YES];
            break;
        }
        case 1004:  //AFNetWorking网络
        {
            AFNetworkingViewController *afn = [[AFNetworkingViewController alloc] init];
            [self.navigationController pushViewController:afn animated:YES];
            break;
        }
        case 1005:  //Thread线程
        {
            NSThreaedViewController *thr = [[NSThreaedViewController alloc] init];
            [self.navigationController pushViewController:thr animated:YES];
            break;
        }
        case 1006:  //任务队列
        {
            OperationViewController *opt = [[OperationViewController alloc] init];
            [self.navigationController pushViewController:opt animated:YES];
            break;
        }
        case 1007:  //GCD
        {
            GCDViewController *gcd = [[GCDViewController alloc] init];
            [self.navigationController pushViewController:gcd animated:YES];
            break;
        }
        case 1008:{
            RunLoopViewController *run = [[RunLoopViewController alloc] init];
            [self.navigationController pushViewController: run animated:YES];
            break;
        }
        case 1009:  //TableView
        {
            TableViewController *tabel = [[TableViewController alloc] init];
            [self.navigationController pushViewController: tabel animated:YES];
            break;
        }
        case 1010:  // XMPP
        {
            LoginViewController *login = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
            [self.navigationController pushViewController:login animated:YES];
            break;
        }
        case 1011:
        {
            [self.navigationController pushViewController:[[DateViewController alloc] init] animated:YES];
            break;
        }
        default:
            break;
    }
}

#pragma mark -
#pragma mark -- 测试单例模式 --
-(void) singletonPattern
{
    SingletonPattern *sid = [[SingletonPattern alloc] init];
    sid = [SingletonPattern shareManager];
    NSLog(@"%@", sid.seesid);
    sid.seesid = @"修改测试的单例模式";
    NSLog(@"%@", sid.seesid);
}


#pragma mark -
#pragma mark -- KVO --
- (void) KVOTest
{
    self.myPerson = [[KVOPerson alloc] init];
    self.myPerson.name = @"测试KVO";
    NSLog(@"%@", self.myPerson.name);
    
    //添加观察对象
    [self.myPerson addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew context: @"name't property"];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setBackgroundColor: [UIColor redColor]];
    [btn setTitle:@"点击改变name" forState:UIControlStateNormal];
    btn.frame = CGRectMake(200, 200, 0, 0);
    [btn sizeToFit];
    [btn addTarget: self action:@selector(btnAntion) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview: btn];
}
- (void) btnAntion
{
    self.myPerson.name = @"修改name";
    
    AppDelegate *appBlack = [[AppDelegate alloc] init];
    appBlack.passValue = ^(NSString *blockValue){
        blockValue = @"修个了block的值";
        self.myPerson.name = blockValue;
        self.myPerson.name = @"修个name的值了";
    };
    NSLog(@"block 的值为： %@", self.myPerson.name);
    
}
- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    NSLog(@"监测对象属性所在的路径:%@", keyPath);
    NSLog(@"被观察着:%@", object);
    NSLog(@"属性所有状态的值:%@", change);
    NSLog(@"在注册观察者的时候，传过来的context %@", context);
    NSLog(@"name :%@", self.myPerson.name);
    if(![[change objectForKey:@"new"] isEqualToString: [change objectForKey: @"old"]]){
        self.view.backgroundColor = [UIColor blackColor];
    }
    
    //移除观察者
    [self.myPerson removeObserver:self forKeyPath:keyPath context:context];
}


#pragma mark -
#pragma mark -- Protocol --
-(void)testprotocolAgain
{
    testProtocolAgain *test = [[testProtocolAgain alloc] init];
    test.delegate = self;
    
    [test printNProcotol];
}
-(void)showProtocol:(NSString *)str
{
    NSLog(@"调用必须函数成功: %@", str);
}
-(void)showTestProtocol
{
    NSLog(@"调用非必需函数成功");
}


#pragma mark -
#pragma mark -- GCD --
-(void)dispatch
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, queue, ^{NSLog(@"任务a");});
    dispatch_group_async(group, queue, ^{NSLog(@"任务B");});
    dispatch_group_async(group, queue, ^{
        NSLog(@"任务b");
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        NSLog(@"运行完");
    });

}


#pragma mark -
#pragma mark -- CoreData --
-(void)createButtons{
    NSArray *arr = @[@"增加", @"删除", @"修改", @"查找"];
    
    for (int i=0; i<arr.count; i++) {
        UIButton *button = [UIButton buttonWithType: UIButtonTypeSystem];
        button.frame = CGRectMake(30+i*60, 100, 40, 40);
        [button setTitle:arr[i] forState:UIControlStateNormal];
        [button setTintColor:[UIColor blackColor]];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        button.tag = i;
        [self.view addSubview: button];
    }
}
-(void)buttonClick: (UIButton *)button
{
    switch (button.tag) {
        case 0: //Add
            [self coreDataAdd];
            break;
        case 1: //Delete
            [self coreDataDelete];
            break;
        case 2: //Update
            [self coreDataUpdate];
            break;
        case 3: //Select
            [self coreDataSelect];
            break;
        default:
            break;
    }
}
//Add
-(void)coreDataAdd{
    static NSInteger a = 123;
    a--;
    Pason *pason = [NSEntityDescription insertNewObjectForEntityForName:@"Pason" inManagedObjectContext:app.managedObjectContext];
    pason.name = [NSString stringWithFormat: @"姓名"];
    pason.age = [NSNumber numberWithInteger: a];
    
    Card *card = [NSEntityDescription insertNewObjectForEntityForName:@"Card" inManagedObjectContext:app.managedObjectContext];
    card.no = @"465456";
    
    [pason setValue:card forKey:@"card"];
    
    [app.managedObjectContext save: nil];
}
//find
-(void)coreDataSelect{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pason" inManagedObjectContext:app.managedObjectContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entity];
    NSArray *array = [app.managedObjectContext executeFetchRequest:request error:nil];
    for(Pason *pason in array){
        NSLog(@"%@", pason.age);
        NSLog(@"%@", pason.name);
//        NSLog(@"%@", pason.card);
    }
}
//delete
-(void)coreDataDelete{
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Pason" inManagedObjectContext:app.managedObjectContext];
    NSFetchRequest *reqeust = [[NSFetchRequest alloc] init];
    [reqeust setEntity:entity];
    
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name", @"姓名"];
//    NSArray *array;
}
//UpDate
-(void)coreDataUpdate{
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
