//
//  Sqlite3ViewController.m
//  UIWeb
//
//  Created by murphy_shi on 16/10/12.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "Sqlite3ViewController.h"

@interface Sqlite3ViewController ()

@property (nonatomic) sqlite3 *dataBase;

@end

@implementation Sqlite3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    NSArray *nameArr = @[@"创建数据列表", @"插入数据", @"查询数据", @"删除数据", @"修改数据"];
    for(int i=0; i<nameArr.count; i++){
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake((10 + 100 * (i % 4)), (80 + i / 4 * 40), 50, 40);
        [btn setTitle:nameArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnAction:) forControlEvents:UIControlEventTouchDown];
        [btn sizeToFit];
        btn.tag = 1000+i;
        [self.view addSubview: btn];
    }
}

- (void)btnAction: (UIButton *)btn{
    switch (btn.tag) {
        case 1000:  //创建数据列表
            [self createTable];
            break;
        case 1001:  //插入数据
            [self inserData];
            break;
        case 1002:  //查询数据
            [self queryData];
            break;
        case 1003:  //删除数据
            [self deleteData];
            break;
        case 1004:  //修改数据
            [self updata];
        default:
            break;
    }
}


/**
 创建数据列表
 */
-(void)createTable{
    if(sqlite3_open([[self path] UTF8String], &(_dataBase)) != SQLITE_OK){
        NSLog(@"创建数据数据库失败");
        return;
    }
    
    char *error;
    const char *createSQL = "create table if not exists list(id integer primary key autoincrement,name text,sex text)";
    
//    第一个参数: 需要执行SQL语句的数据库对象
//    第二个参数: 需要执行的SQL语句
//    第三个参数: 回调函数
//    第四个参数: 第三个参数的参数
//    第五个参数: 接收错误信息
    int tabelResult = sqlite3_exec(self.dataBase, createSQL, NULL, NULL, &error);
    
    if(tabelResult != SQLITE_OK){
        NSLog(@"创建列表失败 %i", tabelResult);
    }
    else{
        NSLog(@"成功创建数据列表");
    }
    
    sqlite3_close(self.dataBase);
}


/**
 插入数据
 */
- (void)inserData{
    
    if(sqlite3_open([[self path] UTF8String], &(_dataBase)) != SQLITE_OK){
        NSLog(@"创建数据数据库失败");
        return;
    }
    
    const char *insertSQL = "insert into list (name,sex) values ('iosRunner','male')";

    sqlite3_stmt *stmt;
    
    int insertResult = sqlite3_prepare_v2(self.dataBase, insertSQL, -1, &stmt, nil);
    if(insertResult != SQLITE_OK){
        NSLog(@"插入数据失败 %i", insertResult);
    }
    else{
        NSLog(@"插入数据成功 %i", insertResult);
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
    sqlite3_close(self.dataBase);
}


/**
 查询数据
 */
-(void)queryData{
    
    if(sqlite3_open([[self path] UTF8String], &(_dataBase)) != SQLITE_OK){
        NSLog(@"创建数据数据库失败");
        return;
    }
    
    const char *querySQL = "select * from list";
    
    sqlite3_stmt *stmt;
    int queryResult = sqlite3_prepare_v2(self.dataBase, querySQL, -1, &stmt, nil);
    if(queryResult != SQLITE_OK){
        NSLog(@"查询数据失败 %i", queryResult);
    }
    else{
        NSLog(@"查询数据中 %i", queryResult);
        while (sqlite3_step(stmt) == SQLITE_ROW) {
            NSLog(@"%i %s %s", sqlite3_column_int(stmt, 0), sqlite3_column_text(stmt, 1), sqlite3_column_text(stmt, 2));
        }
    }
    
    sqlite3_finalize(stmt);
    sqlite3_close(self.dataBase);
}


/**
 修改数据
 */
-(void)updata{
    
    if(sqlite3_open([[self path] UTF8String], &(_dataBase)) != SQLITE_OK){
        NSLog(@"创建数据数据库失败");
        return;
    }
    
    const char *updateSQL = "update list set name = 'buhui' where name = 'iosRunner'";
    
    sqlite3_stmt *stmt;
    int updateResult = sqlite3_prepare_v2(self.dataBase, updateSQL, -1, &stmt, nil);
    if(updateResult != SQLITE_OK){
        NSLog(@"修改数据失败 %i", updateResult);
    }
    else{
        NSLog(@"修改成功");
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
    sqlite3_close(self.dataBase);
}

/**
 删除数据库的数据
 */
-(void)deleteData{
    
    if(sqlite3_open([[self path] UTF8String], &(_dataBase)) != SQLITE_OK){
        NSLog(@"创建数据数据库失败");
        return;
    }
    
    const char *deleteSQL = "delete from list where name = 'iosRunner'";
    
    sqlite3_stmt *stmt;
    int deleteResult = sqlite3_prepare_v2(self.dataBase, deleteSQL, -1, &stmt, nil);
    if(deleteResult != SQLITE_OK){
        NSLog(@"删除数据失败 %i", deleteResult);
    }
    else{
        NSLog(@"删除数据成功");
        sqlite3_step(stmt);
    }
    
    sqlite3_finalize(stmt);
    sqlite3_close(self.dataBase);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/**
 生成路径

 @return 数据库地址
 */
-(NSString *)path{
    //取得数据库的地址，保存在沙盒中
    NSString *documentStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *path = [NSString stringWithFormat:@"%@/crylown.db", documentStr];
    
    return path;
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
