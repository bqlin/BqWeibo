//
//  UIWindow+Extension.m
//  BqWeibo
//
//  Created by LinBq on 16/1/14.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "BqAccount.h"
#import "BqAccountTools.h"

#import "BqTabBarController.h"
#import "BqOAuthController.h"
#import "BqNewFeatureController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController{
    //UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    
    // 版本处理
    NSString *versionKey = @"CFBundleVersion";
    
    // 上一次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
    
    // 当前软件的版本号
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    //    BqLog(@"info 信息：\n%@", info);
    NSString *currentVersion = info[versionKey];
    //    BqLog(@"the last version: %@\t the current version: %@", lastVersion, currentVersion);
    
    // 比较版本
    if ([currentVersion isEqualToString:lastVersion]) {   // 版本号相同：这次打开和上次打开是同一个版本
        //        // 根控制器设置为 BqTabBarController
        //        self.window.rootViewController = [[BqTabBarController alloc] init];
        
        // 根据账号文件切换控制器
        // 获取文件中的账号
        BqAccount *account = [BqAccountTools account];
        // 如果获取的字典能够加载数据，说明之前已经登录成功
        if (account) {
            // 根控制器设置为 BqTabBarController
            self.rootViewController = [[BqTabBarController alloc] init];
        } else {
            self.rootViewController = [[BqOAuthController alloc] init];
        }
        
    }else{  // 这次打开的版本与上次的不一样，显示新特性
        // 使用新特性控制器作为根控制器
        self.rootViewController = [[BqNewFeatureController alloc] init];
    }
}



@end
