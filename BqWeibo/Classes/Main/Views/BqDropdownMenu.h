//
//  BqDropdownMenu.h
//  BqWeibo
//
//  Created by LinBq on 16/1/2.
//  Copyright © 2016年 Bq. All rights reserved.
//  在蒙版的基础上添加下拉菜单，因此 self 最底层是蒙版

#import <UIKit/UIKit.h>

// 代理协议声明
@class BqDropdownMenu;

@protocol BqDropdownMenuDelegate <NSObject>
@optional
/// 销毁时
- (void)dropdownMenuDidDismiss:(BqDropdownMenu *)dropdownMenu;
/// 同理，显示时
- (void)dropdownMenuDidShow:(BqDropdownMenu *)dropdownMenu;
@end




@interface BqDropdownMenu : UIView

/// 内容一：View
@property (nonatomic, weak) UIView *contentView;

/// 内容二：view controller 中的 View
@property (nonatomic, strong) UIViewController *contentController;

/// 代理属性
@property (nonatomic, weak) id<BqDropdownMenuDelegate> delegate;

/// 快速获取菜单
+ (instancetype)menu;


/// 显示
// - (void)show;
/// 基于某个控件显示
- (void)showFrom:(UIView *)targetView;

/// 销毁
-(void)dismiss;

@end
