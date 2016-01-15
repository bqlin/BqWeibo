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

#import "AFNetworking.h"
#import "BqAccountTools.h"



// 遵守下拉菜单的代理协议
@interface BqHomeTableViewController ()<BqDropdownMenuDelegate>

//@property (nonatomic, strong) UIView *menuContentView;

@end

@implementation BqHomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 设置导航栏标题
    [self setupNav];
    
    /// 获取的用户信息（昵称）
    [self setupUserInfo];
    
    
    
    BqLog(@"BqHomeTableViewController-viewDidLoad");
}

/// 获取的用户信息（昵称）
-  (void)setupUserInfo{
//    URL: https://api.weibo.com/2/users/show.json
//    支持格式: JSON
//    HTTP请求方式: GET
//    请求参数：access_token、uid
    
    // 请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 拼接请求参数
    // 获得账号
    BqAccount *account = [BqAccountTools account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 发送请求
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        BqLog(@"request success - %@",responseObject);
        // 获取昵称
        NSString *userName = responseObject[@"name"];
        // 如果昵称与沙盒中的不一样才修改标题
        if ([userName isEqualToString:account.userName]) {
            // 设置标题
            UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
            [titleButton setTitle:userName forState:UIControlStateNormal];
            [titleButton sizeToFit];
            // 存入沙盒
            account.userName = userName;
            [BqAccountTools saveAccount:account];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BqLog(@"request fail - %@", error);
    }];
}



/// 设置导航栏标题
- (void)setupNav{
    // 导航栏 左右按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView imageButton:@"navigationbar_friendsearch" withTarget:self action:nil]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView imageButton:@"navigationbar_pop" withTarget:self action:nil]];
    
    // 标题按钮
    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置为导航栏标题视图
    self.navigationItem.titleView = titleBtn;
    // 设置按钮
    NSString *userName = [BqAccountTools account].userName;
//    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitle:userName?userName:@"首页" forState:UIControlStateNormal];
    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    titleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
    //titleBtn.backgroundColor = [UIColor greenColor];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    [titleBtn sizeToFit];
    
    // 调整 titleBtn 子控件
//    BqLog(@"titleBtn.titleLabel: %f", titleBtn.titleLabel.width);
//    BqLog(@"titleBtn.imageView: %f", titleBtn.imageView.width);
//    BqLog(@"titleBtn.titleLabel: %f", titleBtn.titleLabel.width);
//    BqLog(@"titleBtn: %f", titleBtn.width);
    CGFloat scaleFactor = [[UIScreen mainScreen] scale];
    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titleBtn.titleLabel.width, 0, 0);
    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, - titleBtn.imageView.width * scaleFactor - 10, 0, 0);
    //    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
    //titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, titleBtn.imageView.width);
    // 绑定事件
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
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

#pragma mark - 系统方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
