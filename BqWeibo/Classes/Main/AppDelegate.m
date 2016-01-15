//
//  AppDelegate.m
//  Bq 微博
//
//  Created by LinBq on 15/12/11.
//  Copyright (c) 2015年 Bq. All rights reserved.
//

#import "AppDelegate.h"
// 导入 BqTabBarController 类
#import "BqTabBarController.h"
#import "BqNewFeatureController.h"
#import "BqOAuthController.h"

#import "BqAccount.h"
#import "BqAccountTools.h"

#import "UIWindow+Extension.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 1.创建窗口
    // 创建/初始化窗口属性
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    // 设置窗口显示
    [self.window makeKeyAndVisible];
    // 测试：设置窗口背景色
    self.window.backgroundColor = [UIColor yellowColor];
    
    
    // 2. 设置根控制器
    
    // 版本处理
    NSString *versionKey = @"CFBundleVersion";
    // 当前软件的版本号
    NSDictionary *info = [NSBundle mainBundle].infoDictionary;
    //    BqLog(@"info 信息：\n%@", info);
    NSString *currentVersion = info[versionKey];
    //    BqLog(@"the last version: %@\t the current version: %@", lastVersion, currentVersion);
//    // 比较版本
//    if ([currentVersion isEqualToString:lastVersion]) {   // 版本号相同：这次打开和上次打开是同一个版本
////        // 根控制器设置为 BqTabBarController
////        self.window.rootViewController = [[BqTabBarController alloc] init];
//        
//        [self account];
//    }else{  // 这次打开的版本与上次的不一样，显示新特性
//        // 使用新特性控制器作为根控制器
//        self.window.rootViewController = [[BqNewFeatureController alloc] init];
//    }
    
    // #切换控制器#
    [self.window switchRootViewController];
    
    // 将当前的版本号存入沙盒（最简单的方式）
    [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:versionKey];
    // 立即同步
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    // 测试
    // self.window.rootViewController = [[BqNewFeatureController alloc] init];

    return YES;
}


#pragma mark - 抽取的方法
///// 账号处理
//- (void)account{
//    
////    // 沙盒路径
////    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
////    NSString *path = [docPath stringByAppendingPathComponent:@"account.data"];
//    // 获取文件中的账号
////    NSDictionary *account = [NSDictionary dictionaryWithContentsOfFile:path];
//    BqAccount *account = [BqAccountTools account];
//    
//    // 如果获取的字典能够加载数据，说明之前已经登录成功
//    if (account) {
//        // 根控制器设置为 BqTabBarController
//        self.window.rootViewController = [[BqTabBarController alloc] init];
//    } else {
//        self.window.rootViewController = [[BqOAuthController alloc] init];
//    }
//}



#pragma mark - 系统方法
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
