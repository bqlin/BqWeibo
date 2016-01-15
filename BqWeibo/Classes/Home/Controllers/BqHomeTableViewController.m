//
//  BqHomeTableViewController.m
//  Bq 微博
//
//  Created by LinBq on 15/12/18.
//  Copyright © 2015年 Bq. All rights reserved.
//

#import "BqHomeTableViewController.h"
#import "UIView+BqStyle.h"
#import "BqDropdownMenu.h"
// 导入 控制标题下拉菜单的控制器
#import "BqTitleMenuViewController.h"



// 遵守下拉菜单的代理协议
@interface BqHomeTableViewController ()<BqDropdownMenuDelegate>

//@property (nonatomic, strong) UIView *menuContentView;

@end

@implementation BqHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView imageButton:@"navigationbar_friendsearch" withTarget:self action:nil]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView imageButton:@"navigationbar_pop" withTarget:self action:nil]];
    
    
    
    // 标题按钮
    
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    //titleBtn.backgroundColor = [UIColor greenColor];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [titleBtn sizeToFit];
 
    
    // 调整 titleBtn 子控件
    BqLog(@"titleBtn.titleLabel: %f", titleBtn.titleLabel.width);
    BqLog(@"titleBtn.imageView: %f", titleBtn.imageView.width);
    BqLog(@"titleBtn.titleLabel: %f", titleBtn.titleLabel.width);
    BqLog(@"titleBtn: %f", titleBtn.width);
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titleBtn.titleLabel.width, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, - titleBtn.imageView.width * 2, 0, 0);
//    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
//    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 40);
    // 绑定事件
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    self.navigationItem.titleView = titleBtn;
    
    BqLog(@"BqHomeTableViewController-viewDidLoad");
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 按钮点击事件
/// 标题按钮事件
- (void)titleClick:(UIButton *)titleButton{
    // 获取下拉菜单
    BqDropdownMenu *menu = [BqDropdownMenu menu];
    // 设置代理：这个很重要！！！！！！！！！
    menu.delegate = self;
    
    // 设置内容
    BqTitleMenuViewController *vc = [[BqTitleMenuViewController alloc] init];
    //vc.view.height = 150;
    [vc.view sizeToFit];
    vc.view.width = 100;
    
    //self.menuContentView = vc.view;
    //menu.contentView = vc.view;
    menu.contentController = vc;
    
    // 显示下拉菜单
    [menu showFrom:titleButton];
}

/// 处理箭头图标，监听下拉列表的显示与销毁
- (void)dropdownMenuDidDismiss:(BqDropdownMenu *)dropdownMenu{
    // 获取 titleButton
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateNormal];
    titleBtn.selected = NO;
    
    BqLog(@"drop down menu dismiss.");
}
- (void)dropdownMenuDidShow:(BqDropdownMenu *)dropdownMenu{
    UIButton *titleBtn = (UIButton *)self.navigationItem.titleView;
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    titleBtn.selected = YES;
    BqLog(@"drop down menu show.");
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
