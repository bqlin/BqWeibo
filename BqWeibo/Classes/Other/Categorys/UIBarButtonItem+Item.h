//
//  UIBarButtonItem+item.h
//  Bq 微博
//
//  Created by LinBq on 15/12/20.
//  Copyright © 2015年 Bq. All rights reserved.
//  快速设置 bar button 按钮

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (item)

/// 快速设置 bar button 按钮
+ (instancetype)barButtonwithImage:(UIImage *)image highlightImage:(UIImage *)hImage target:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

@end
