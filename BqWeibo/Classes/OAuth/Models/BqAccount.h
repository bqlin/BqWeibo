//
//  BqAccount.h
//  BqWeibo
//
//  Created by LinBq on 16/1/12.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BqAccount : NSObject

/// access_token    string  用于调用access_token，接口获取授权后的access token。
@property (nonatomic, copy) NSString *access_token;

/// expires_in  string  access_token的生命周期，单位是秒数。
@property (nonatomic, copy) NSString *expires_in;

/// remind_in   string  access_token的生命周期（该参数即将废弃，开发者请使用expires_in）。

/// uid string  当前授权用户的UID。
@property (nonatomic, copy) NSString *uid;

/// accessToken 的创建时间
@property (nonatomic, strong) NSDate *created_time;

/// 使用字典初始化
- (instancetype)initWithDict:(NSDictionary *)dict;
/// 获取用字典初始化的账号
+ (instancetype)accountWithDict:(NSDictionary *)dict;
@end
