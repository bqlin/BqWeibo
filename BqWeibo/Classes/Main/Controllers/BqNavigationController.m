//
//  BqNavigationController.m
//  Bq 微博
//
//  Created by LinBq on 15/12/30.
//  Copyright © 2015年 Bq. All rights reserved.
//
// 目的：让除了 navigation controller 的根控制器外的子控制器添加左右上角的按钮

#import "BqNavigationController.h"
#import "UIView+BqStyle.h"

@interface BqNavigationController ()

@end

@implementation BqNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// 重写 pushViewController: animated: 方法
/// 拦截 push 进来的控制器（viewController参数）并对其进行设置
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    // 当不是根控制器时才添加左右上角的按钮
    if (self.viewControllers.count > 0) {
        // push 时隐藏所在的 tab bar；pop 时重新显示 tab bar
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 更改导航条返回样式，用按钮初始化导航按钮
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView imageButton:@"navigationbar_back" withTarget:self action:@selector(back)]];
        
        // 同理添加“更多”按钮
        UIButton *moreBtn = (UIButton *)[UIView imageButton:@"navigationbar_more" withTarget:self action:@selector(more)];
        viewController.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:moreBtn];
    }
    [super pushViewController:viewController animated:animated];
}

#pragma mark - 按钮事件
/// 返回上一个控制器
- (void)back{
// 此处一定要写成 self 而不是 self.navigationController
    [self popViewControllerAnimated:YES];
}

/// 回到根控制器
- (void)more{
    [self popToRootViewControllerAnimated:YES];
}


#pragma mark - 特殊时期
+ (void)initialize{
    // 设置整个项目所有 Item （包括导航条和 tab bar）的主题样式
    UIBarButtonItem *item = [UIBarButtonItem appearance];
    
    // 普通状态
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
    /// 前景色/字体样色
    textAttrs[NSForegroundColorAttributeName] = [UIColor orangeColor];
    textAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    
    // 不可用状态
    NSMutableDictionary *disableTextAttrs = [textAttrs mutableCopy];
    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    /// 字体颜色
    disableTextAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    
    
    
}

@end
