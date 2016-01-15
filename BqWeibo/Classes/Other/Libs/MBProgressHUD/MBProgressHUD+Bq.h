//
//  MBProgressHUD+Bq.h
//  BqWeibo
//
//  Created by LinBq on 16/1/12.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//  便捷的 MBProgressHUD

#import "MBProgressHUD.h"

@interface MBProgressHUD (Bq)


+ (void)showSuccess:(NSString *)success toView:(UIView *)view;

+ (void)showError:(NSString *)error toView:(UIView *)view;


+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;


+ (void)showSuccess:(NSString *)success;
+ (void)showError:(NSString *)error;
+ (MBProgressHUD *)showMessage:(NSString *)message;

+ (void)hideHUDForView:(UIView *)view;
+ (void)hideHUD;

@end
