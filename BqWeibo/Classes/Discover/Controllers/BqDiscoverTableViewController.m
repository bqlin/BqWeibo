//
//  BqDiscoverTableViewController.m
//  Bq 微博
//
//  Created by LinBq on 15/12/18.
//  Copyright © 2015年 Bq. All rights reserved.
//

#import "BqDiscoverTableViewController.h"
#import "UIView+BqStyle.h"
#import "BqSearchBar.h"

@interface BqDiscoverTableViewController ()

@end

@implementation BqDiscoverTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 系统自带搜索框
    //UISearchBar *searchBar = [[UISearchBar alloc] init];
    // 但系统自带的搜索框不能实现需求中的效果
    
    
//    // 使用 text filed 自定义搜索框
//    UITextField *searchBar = [[UITextField alloc] init];
//    searchBar.height = 30;
//    searchBar.width = 300;
//    searchBar.font = [UIFont systemFontOfSize:15];
//    searchBar.placeholder = @"搜神马";
//    
//    searchBar.background = [UIImage imageNamed:@"searchbar_textfield_background"];
//    
//    UIImageView *searchIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
//    searchIcon.height = searchIcon.width = searchBar.height;
//    // 设置居中
//    searchIcon.contentMode = UIViewContentModeCenter;
//    
//    // [searchBar addSubview:searchIcon];
//    // 不使用 addSubview 的方式添加搜索栏图标，而通过设置 leftView 与 leftViewMode 来实现
//    searchBar.leftView = searchIcon;
//    searchBar.leftViewMode = UITextFieldViewModeAlways;
//    
//    self.navigationItem.titleView = searchBar;
    // 封装 searchBar 为 BqSearchBar 类的自定义控件
    BqSearchBar *searchBar = [BqSearchBar searchBar];
    searchBar.height = 30;
    searchBar.width = 300;
    // searchBar.searchIconWidth = searchBar.height;
    self.navigationItem.titleView = searchBar;
    
    BqLog(@"BqDiscoverTableViewController-viewDidLoad");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
