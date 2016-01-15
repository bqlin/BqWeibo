//
//  BqTabBar.m
//  BqWeibo
//
//  Created by LinBq on 16/1/3.
//  Copyright © 2016年 LinBq. All rights reserved.
//

#import "BqTabBar.h"
#import "UIView+BqStyle.h"

@interface BqTabBar ()

@property (nonatomic, strong) UIButton *plusBtn;

@end

@implementation BqTabBar

// 使用代码创建的控件都会调用该方法进行初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 添加一个按钮到 tabbar 中
        UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.plusBtn = plusBtn;
        [self addSubview:plusBtn];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button"] forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
//        plusBtn.backgroundColor =  [UIColor orangeColor];
        
        // 添加事件
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
    
}

/// 调整尺寸
- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置加号按钮的尺寸
    [self.plusBtn sizeToFit];
    
    // 设置加号按钮的位置
    //self.plusBtn.center = self.center;  // 不能使用该方式设置位置
    self.plusBtn.centerX = self.width / 2;
    self.plusBtn.centerY = self.height / 2;
    
    // 设置其他 tab bar 按钮的位置和尺寸
    CGFloat tabBarButtonW = self.width / 5;
    NSInteger tabBarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        // 通过类名获取类
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置高度
            child.width = tabBarButtonW;
            // 设置 x
            child.x = tabBarButtonIndex * tabBarButtonW;
            // 索引递增，当轮到第3个按钮时过
            tabBarButtonIndex ++;
            if (tabBarButtonIndex == 2) {
                tabBarButtonIndex ++;
            }
        }
    }
}


#pragma mark - 按钮点击事件
- (void)plusClick{
    // 通知代理
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}
@end
