//
//  BqTabBarController.m
//  Bq 微博
//
//  Created by LinBq on 15/12/11.
//  Copyright (c) 2015年 Bq. All rights reserved.
//

#import "BqTabBarController.h"
#import "BqNavigationController.h"


#import "UIImage+BqImage.h"
#import "UIColor+BqColor.h"
// 导入 自定义 tab bar
#import "BqTabBar.h"

#import "BqHomeTableViewController.h"
#import "BqMessageTableViewController.h"
#import "BqDiscoverTableViewController.h"
#import "BqProfileTableViewController.h"

#import "BqTest2ViewController.h"

// 遵守 BqTabBar 的事件代理协议
@interface BqTabBarController ()<BqTabBarDelegate>

/// item 模型数组
@property (nonatomic, strong) NSMutableArray *items;
/// 首页
@property (nonatomic, weak) BqHomeTableViewController *home;

@end

@implementation BqTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpAllChildViewController];
    //[self setUpTabBar];
    
    // 使用 KVC 更换系统自带的 tabBar
    [self setValue:[[BqTabBar alloc] init] forKey:@"tabBar"];
    
}

#pragma mark - 抽取的方法
/// 添加所有子控制器
-(void)setUpAllChildViewController{
    // 3.管理/设置 子控制器
    // 3.1 首页
    BqHomeTableViewController *homeVC = [[BqHomeTableViewController alloc] init];
//    [self addChildViewController:homeVC];
    [self setUpTabBarItem:homeVC withImageKeyWord:@"home" andTitle:@"首页"];
    // 测试：设置子控制器背景色
//    homeVC.view.backgroundColor = [UIColor randomColor];
    
    
    // 3.2 消息
    BqMessageTableViewController *messageVC = [[BqMessageTableViewController alloc] init];
//    [self addChildViewController:messageVC];
    // 设置 tab bar 按钮
    [self setUpTabBarItem:messageVC withImageKeyWord:@"message_center" andTitle:@"消息"];
    // 测试：设置子控制器背景色
//    messageVC.view.backgroundColor = [UIColor randomColor];
    
    //[self addChildViewController:[UIViewController new]];
    
    // 3.3 发现
    UIViewController *discoverVC = [[BqDiscoverTableViewController alloc] init];
//    [self addChildViewController:discoverVC];
    // 设置 tab bar 按钮
    [self setUpTabBarItem:discoverVC withImageKeyWord:@"discover" andTitle:@"发现"];
    // 测试
//    discoverVC.view.backgroundColor = [UIColor randomColor];
    
    // 3.4 我
    UIViewController *profileVC = [[BqProfileTableViewController alloc] init];
//    [self addChildViewController:profileVC];
    // 设置 tab bar 按钮
    [self setUpTabBarItem:profileVC withImageKeyWord:@"profile" andTitle:@"我"];
    // 测试：设置子控制器背景色
//    profileVC.view.backgroundColor = [UIColor randomColor];
}


/// 设置 tab bar 按钮
- (void)setUpTabBarItem:(UIViewController *)ChildVC withImageKeyWord:(NSString *)keyWord andTitle:(NSString *)title{
    // 1. 按钮标题（控制器的标题）
//    ChildVC.tabBarItem.title = title;
//    // 设置导航条标题
//    ChildVC.navigationItem.title = title;
    // 优化
    ChildVC.title = title;
    
    
    
    // 2. 图标
    ChildVC.tabBarItem.image = [UIImage imageInOriginalWithName:[NSString stringWithFormat:@"tabbar_%@", keyWord]];
    ChildVC.tabBarItem.selectedImage = [UIImage imageInOriginalWithName:[NSString stringWithFormat:@"tabbar_%@_selected", keyWord]];
    ChildVC.tabBarItem.badgeValue = @"拆";
    
    
    // 3. 给传递过来的子控制器包装一个导航控制器
    BqNavigationController *nav = [[BqNavigationController alloc] initWithRootViewController:ChildVC];
    [self addChildViewController:nav];
    
}

#pragma mark - 特定的时刻

/// 在类初始化方法中全局设置 tab bar 按钮样式
+(void)initialize{
    // 1. 获取所有的 tabBarItem 外观标识
    UITabBarItem *item = [UITabBarItem appearance];
    //UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置 tab bar 按钮选中时字体的样式
    //  创建样式字典
    NSMutableDictionary *selectedTextAttrs = [NSMutableDictionary dictionary];
    //  增加样式
    selectedTextAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    //  应用样式
    [item setTitleTextAttributes:selectedTextAttrs forState:UIControlStateSelected];
    
    // 同理设置普通状态时的字体样式
    NSMutableDictionary *normalTextAttrs = [NSMutableDictionary dictionary];
    normalTextAttrs[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    [item setTitleTextAttributes:normalTextAttrs forState:UIControlStateNormal];
}


#pragma mark - BqTabBar 的代理方法实现
- (void)tabBarDidClickPlusButton:(BqTabBar *)tabBar{
    UIViewController *vc = [[BqTest2ViewController alloc] init];
    
    
    // 切换到该控制器
    [self presentViewController:vc animated:YES completion:nil];
}


























///// 懒加载 模型数组
//- (NSMutableArray *)items{
//    if (!_items) {
//        _items = [NSMutableArray array];
//    }
//    return _items;
//}
//
///// 设置 自定义 tab bar
//- (void)setUpTabBar{
//    // 自定义 tab bar
//    BqTabBar *tabBar = [[BqTabBar alloc] initWithFrame:self.tabBar.frame];
//    [self.view addSubview:tabBar];
//    [self.tabBar removeFromSuperview];
//    tabBar.backgroundColor = [UIColor whiteColor];
//    
//    // 设置代理
//    tabBar.delegate = self;
//    
//    // 给 自定义 tab bar 传递 tabBarItem 模型
//    tabBar.items = self.items;
//}
//
//
//#pragma mark - 当点击 tabBar 上的按钮时调用
//- (void)tabBar:(BqTabBar *)tabBar didClickButton:(NSInteger)index{
//    self.selectedIndex = index;
//}

// 获取所有的 tabBarItem 外观标识
// UITabBarItem *item = [UITabBarItem appearance];

// 获取所有的 tabBarItem 外观标识
// UITabBarItem *item = [UITabBarItem appearance];

// 获取所有的 tabBarItem 外观标识
// UITabBarItem *item = [UITabBarItem appearance];



@end
