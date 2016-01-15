//
//  MBProgressHUD+Bq.m
//  BqWeibo
//
//  Created by LinBq on 16/1/12.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import "MBProgressHUD+Bq.h"

@implementation MBProgressHUD (Bq)

/// 显示信息
+ (void)show:(NSString *)text icon:(UIImage *)icon view:(UIView *)view{
    // 如果传递进来的 view 为空，则设置为最顶层视图
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:icon];
    // 设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 0.5 秒后才消失
    [hud hide:YES afterDelay:0.5];
}


/// 显示错误信息
+ (void)showError:(NSString *)error toView:(UIView *)view{
    // 图标
    UIImage *icon = [UIImage imageNamed:@"MBProgressHUD.bundle/error.png"];
    [self show:error icon:icon view:view];
}

/// 显示成功信息
+ (void)showSuccess:(NSString *)success toView:(UIView *)view{
    UIImage *icon = [UIImage imageNamed:@"MBProgressHUD.bundle/success.png"];
    [self show:success icon:icon view:view];
}

/// 显示提示信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view{
    // 如果传递进来的 view 为空，则设置为最顶层视图
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    // 隐藏时从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // 带蒙版
    hud.dimBackground = YES;
    return hud;
}

#pragma mark - 直接添加到最顶层
+ (void)showSuccess:(NSString *)success{
    [self showSuccess:success toView:nil];
}
+ (void)showError:(NSString *)error{
    [self showError:error toView:nil];
}
+ (MBProgressHUD *)showMessage:(NSString *)message{
    return [self showMessage:message toView:nil];
}

+ (void)hideHUDForView:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD{
    [self hideHUDForView:nil];
}

@end
