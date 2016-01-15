//
//  UIBarButtonItem+item.m
//  Bq 微博
//
//  Created by LinBq on 15/12/20.
//  Copyright © 2015年 Bq. All rights reserved.
//

#import "UIBarButtonItem+Item.h"

@implementation UIBarButtonItem (item)

/// 快速设置 bar button 按钮
+ (instancetype)barButtonwithImage:(UIImage *)image highlightImage:(UIImage *)hImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    // 创建按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    // 设置按钮样式
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button setBackgroundImage:hImage forState:UIControlStateHighlighted];
    [button sizeToFit];
    // 设置按钮实现
    [button addTarget:target action:action forControlEvents:controlEvents];
    // 使用该按钮创建 bar button，并返回
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}

@end
