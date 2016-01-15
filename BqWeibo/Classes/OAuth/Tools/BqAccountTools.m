//
//  BqAccountTools.m
//  BqWeibo
//
//  Created by LinBq on 16/1/13.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

/// 将沙盒路径定义为宏
#define BqAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "BqAccountTools.h"
#import "BqAccount.h"

@implementation BqAccountTools

+ (void)saveAccount:(BqAccount *)account{
    // 获取账号存储的时间，约等于 accessToken 的产生时间
    account.created_time = [NSDate date];
    // 将返回的账号数据以模型存入沙盒中
    [NSKeyedArchiver archiveRootObject:account toFile:BqAccountPath];
}

+ (BqAccount *)account{
//    return nil;   // 测试过期账号
    BqAccount *account =  [NSKeyedUnarchiver unarchiveObjectWithFile:BqAccountPath];
    
    // 判断账号是否过期
    // 过期秒数
    long long expires_in = [account.expires_in longLongValue];
    // 过期的时间
    NSDate *expiresTime = [account.created_time dateByAddingTimeInterval:expires_in];
    // 当前时间
    NSDate *now = [NSDate date];
    // 比较时间
    NSComparisonResult result = [expiresTime compare:now];
    
//    BqLog(@"expiresTime: %@\tnow: %@", expiresTime, now);
    
    if (result <= NSOrderedSame ) return nil;
    return account;
}

///// 沙盒路径
//+ (NSString *)path{
//    NSString *docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    return [docPath stringByAppendingPathComponent:@"account.data"];
//}
// 直接抽取成宏
@end
