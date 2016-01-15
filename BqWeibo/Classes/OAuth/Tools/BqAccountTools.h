//
//  BqAccountTools.h
//  BqWeibo
//
//  Created by LinBq on 16/1/13.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//  用于处理账号处理相关的操作/业务逻辑：
//  1. 存储账号；
//  2. 取出账号、验证账号；


#import <Foundation/Foundation.h>

@class BqAccount;

@interface BqAccountTools : NSObject

// 存储账号信息
+ (void)saveAccount:(BqAccount *)account;

// 从 archive 文件中获取 account 模型（若账号过期，则返回 nil）
+ (BqAccount *)account;

@end
