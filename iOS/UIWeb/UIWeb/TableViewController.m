//
//  TableViewController.m
//  UIWeb
//
//  Created by murphy_shi on 16/10/17.
//  Copyright © 2016年 murphy_shi. All rights reserved.
//

#import "TableViewController.h"

@interface TableViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tabelView;
@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTabelView:[[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped]];
    self.tabelView.dataSource = self;
    self.tabelView.delegate = self;
    self.tabelView.separatorStyle = UITableViewScrollPositionNone;
    [self.view addSubview: self.tabelView];
    
    // Do any additional setup after loading the view.
}

#pragma mark -
#pragma mark -- Delegate --
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
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
