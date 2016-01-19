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

#import "BqTitleButton.h"
#import "BqLoadMoreButton.h"

#import "UIImageView+WebCache.h"

#import "MJExtension.h"

#import "BqWeiboUser.h"
#import "BqWeiboStatus.h"

#import "BqWeiboStatusCell.h"
#import "BqWeiboStatusFrame.h"



// 遵守下拉菜单的代理协议、载入更多代理协议
@interface BqHomeTableViewController ()<BqDropdownMenuDelegate, BqLoadMoreButtonDelegate>

//@property (nonatomic, strong) UIView *menuContentView;
/// 微博数组，内容：字典，一个字典为一条微博
@property (nonatomic, strong) NSMutableArray *statuses;

@end

@implementation BqHomeTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 设置导航栏标题
    [self setupNav];
    
    /// 获取的用户信息（昵称）
    [self setupUserInfo];
    
    /// 加载最新的微博数据
    [self loadNewStatus];
    
    /// 下拉刷新，使用系统自带
    [self dropdownRefresh];
    
    /// 设置footerview
    CGRect footerViewBound = CGRectMake(0, 0, 320, 44);
    BqLoadMoreButton *loadMoreButton = [[BqLoadMoreButton alloc] initWithFrame:footerViewBound];
    self.tableView.tableFooterView = loadMoreButton;
    loadMoreButton.delegate = self;
    
    BqLog(@"BqHomeTableViewController-viewDidLoad");
}

/// 下拉刷新，使用系统自带
- (void)dropdownRefresh{
    UIRefreshControl *control = [[UIRefreshControl alloc] init];
    [self.tableView addSubview:control];
    [control addTarget:self action:@selector(refreshNewStatus:) forControlEvents:UIControlEventValueChanged];
    
}


/// 刷新更新微博（下拉）
- (void)refreshNewStatus:(UIRefreshControl *)control{

    // 请求获取最新的微博并添加到最前面
    // 1. 请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 2. 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [BqAccountTools account].access_token;
    BqWeiboStatus *currentStatus = [self.statuses firstObject];
    // 若为空，则不加这个参数
    if (currentStatus) {
        params[@"since_id"] = currentStatus.idstr;
    }
    
    // 3. 发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // 3.1. 取得最新的微博模型数组
        NSMutableArray *latestStatuses = [BqWeiboStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];

        // 3.2. 加到最前面
        [latestStatuses addObjectsFromArray:self.statuses];
        self.statuses = latestStatuses;
        
//        // 方法二
//        NSRange range = NSMakeRange(0, latestStatuses.count);
//        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:range];
//        [self. statuses insertObjects:latestStatuses atIndexes:set];
        // 3.3. 刷新数据
        [self.tableView reloadData];
        
        // 3.4. 结束刷新
        [control endRefreshing];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BqLog(@"request fail - %@", error);
        // 若加载失败也结束刷新
        [control endRefreshing];
    }];
        BqLog(@"refreshNewStatus");
}

/// 载入更旧的微博
- (void)loadEarlierStatuses{
    // 在页尾加载更旧/早的微博
    // 1. 请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 2. 拼接请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [BqAccountTools account].access_token;
    BqWeiboStatus *currentStatus = [self.statuses lastObject];
    // 若为空，则不加这个参数
    if (currentStatus) {
        params[@"max_id"] = @([currentStatus.idstr longLongValue] + 1);
    }
    
    // 3. 发送请求
    [manager GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *earlierStatues = [BqWeiboStatus mj_objectArrayWithKeyValuesArray:responseObject[@"statuses"]];
        [self.statuses removeLastObject];
        [self.statuses addObjectsFromArray:earlierStatues];
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BqLog(@"request fail - %@", error);
    }];
    BqLog(@"loadEarlierStatuses");
}

 /// 加载最新的微博数据
- (void)loadNewStatus{
    // URL: https://api.weibo.com/2/statuses/home_timeline.json
    // 请求方式：GET
    // 请求参数：access_token
    // 可选参数：
    // count：返回的微博数量
    
    // 1. 请求管理者
    AFHTTPRequestOperationManager *mananger = [AFHTTPRequestOperationManager manager];
    
    // 2. 拼接请求参数
    BqAccount *account = [BqAccountTools account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
//    params[@"count"] = @10;
    
    // 3. 发送请求
    [mananger GET:@"https://api.weibo.com/2/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        BqLog(@"request success - %@",responseObject);
        // 取得 微博字典 数组
        NSArray *dicArray = responseObject[@"statuses"];
        // 将 微博字典 数组 转为 微博模型 数组
        self.statuses = [BqWeiboStatus mj_objectArrayWithKeyValuesArray:dicArray];
        
        // 刷新数组
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BqLog(@"request fail - %@", error);
        
    }];
}

/// 获取的用户信息（昵称）
-  (void)setupUserInfo{
//    URL: https://api.weibo.com/2/users/show.json
//    支持格式: JSON
//    HTTP请求方式: GET
//    请求参数：access_token、uid
    
    // 1. 请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // 2. 拼接请求参数
    // 获得账号
    BqAccount *account = [BqAccountTools account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = account.access_token;
    params[@"uid"] = account.uid;
    
    // 3. 发送请求
    [manager GET:@"https://api.weibo.com/2/users/show.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        BqLog(@"request success - %@",responseObject);
        // 获取昵称
        NSString *userName = responseObject[@"name"];
        // 更新标题
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        [titleButton setTitle:userName forState:UIControlStateNormal];
        [titleButton sizeToFit];
        // 存入沙盒
        account.userName = userName;
        [BqAccountTools saveAccount:account];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        BqLog(@"request fail - %@", error);
    }];
}



/// 设置导航栏按钮
- (void)setupNav{
    // 导航栏 左右按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView imageButton:@"navigationbar_friendsearch" withTarget:self action:nil]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView imageButton:@"navigationbar_pop" withTarget:self action:nil]];
    
   // 导航栏标题
    UIButton *titleBtn = [BqTitleButton titleButton];
    // 设置为导航栏标题视图
    self.navigationItem.titleView = titleBtn;
    // 绑定事件
    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
     // 设置按钮
    NSString *userName = [BqAccountTools account].userName;
    [titleBtn setTitle:userName?userName:@"首页" forState:UIControlStateNormal];

    
//    // 标题按钮
//    UIButton *titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    // 设置为导航栏标题视图
//    self.navigationItem.titleView = titleBtn;
//    // 设置按钮
//    NSString *userName = [BqAccountTools account].userName;
//    //    [titleBtn setTitle:@"首页" forState:UIControlStateNormal];
//    [titleBtn setTitle:userName?userName:@"首页" forState:UIControlStateNormal];
//    [titleBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    titleBtn.titleLabel.font = [UIFont systemFontOfSize:17];
//    //titleBtn.backgroundColor = [UIColor greenColor];
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
//    [titleBtn setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
//    [titleBtn sizeToFit];
//    
//    // 调整 titleBtn 子控件
//    //    BqLog(@"titleBtn.titleLabel: %f", titleBtn.titleLabel.width);
//    //    BqLog(@"titleBtn.imageView: %f", titleBtn.imageView.width);
//    //    BqLog(@"titleBtn.titleLabel: %f", titleBtn.titleLabel.width);
//    //    BqLog(@"titleBtn: %f", titleBtn.width);
//    CGFloat scaleFactor = [[UIScreen mainScreen] scale];
//    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, titleBtn.titleLabel.width, 0, 0);
//    titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, - titleBtn.imageView.width * scaleFactor - 10, 0, 0);
//    //    titleBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
//    //titleBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, titleBtn.imageView.width);
//    // 绑定事件
//    [titleBtn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
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

/// 加载更多按钮
- (void)loadMoreButtonDidClick:(BqLoadMoreButton *)loadMoreButton{
    [self loadEarlierStatuses];
}




#pragma mark - Table view data source

// 各组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.statuses.count;
}

// 各行显示的内容
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//    static NSString *reuseID = @"status";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseID];
//    if (!cell) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
//    }
//    
//    // 设置内容
////    // 取出该行的微博字典
////    NSDictionary *statusDic = self.statuses[indexPath.row];
//    // 优化：使用模型
//    BqWeiboStatus *status = self.statuses[indexPath.row];
//    // 设置微博文字内容
//    cell.detailTextLabel.text = status.text;
//    
//    // 取出微博用户
////    NSDictionary *weiboUser = statusDic[@"user"];
//    // 优化：使用模型
//    
//    // 用户昵称
//    cell.textLabel.text = status.user.screen_name;
//    
//    // 用户头像
//    NSString *profileImageURL = status.user.profile_image_url;
//    // 占位图
//    UIImage *placehoder = [UIImage imageNamed:@"avatar_default_small"];
//    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:profileImageURL] placeholderImage:placehoder];
    
    BqWeiboStatusCell *cell = [BqWeiboStatusCell weiboStatusCellOnTableView:tableView];
    BqWeiboStatusFrame *statusFrame = [[BqWeiboStatusFrame alloc] init];
    statusFrame.status = self.statuses[indexPath.row];
    cell.statusFrame = statusFrame;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    BqWeiboStatusFrame *statusFrame = [[BqWeiboStatusFrame alloc] init];
    statusFrame.status = self.statuses[indexPath.row];
//    BqLog(@"setting rowhieght");
    return statusFrame.rowHeight;
}

#pragma mark - 系统方法
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
