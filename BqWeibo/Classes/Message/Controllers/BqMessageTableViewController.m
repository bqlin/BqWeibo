//
//  BqMessageTableViewController.m
//  Bq 微博
//
//  Created by LinBq on 15/12/18.
//  Copyright © 2015年 Bq. All rights reserved.
//

#import "BqMessageTableViewController.h"
// 导入测试 view
#import "BqTestViewController.h"
#import "BqNavigationController.h"

@interface BqMessageTableViewController ()

@end

@implementation BqMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"写私信" style: UIBarButtonItemStylePlain target:self action:nil];
    
    BqLog(@"BqMessageTableViewController-viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"test-string-%02ld", (long)indexPath.row];
    return cell;
}




#pragma mark - 实现跳转的代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    BqTestViewController *testVC = [[BqTestViewController alloc] init];
    testVC.title = @"测试";
    
    [self.navigationController pushViewController:testVC animated:YES];
}
@end
