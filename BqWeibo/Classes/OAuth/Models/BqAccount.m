//
//  BqAccount.m
//  BqWeibo
//
//  Created by LinBq on 16/1/12.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import "BqAccount.h"

// 遵守 NSCoding 协议
@interface BqAccount ()<NSCoding>

@end

@implementation BqAccount

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        self.access_token = dict[@"access_token"];
        self.expires_in = dict[@"expires_in"];
        self.uid = dict[@"uid"];
    }
    return self;
}

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

#pragma mark - NSCoding 方法实现
/// 归档前调用，需说明哪些属性存入沙盒
- (void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.access_token forKey:@"access_token"];
    [encoder encodeObject:self.expires_in forKey:@"expires_in"];
    [encoder encodeObject:self.uid forKey:@"uid"];
    [encoder encodeObject:self.created_time forKey:@"created_time"];
}

/// 解档前调用，需说明取哪些 key 的值/属性
- (id)initWithCoder:(NSCoder *)decoder{
    if (self = [super init]) {
        self.access_token = [decoder decodeObjectForKey:@"access_token"];
        self.expires_in = [decoder decodeObjectForKey:@"expires_in"];
        self.uid = [decoder decodeObjectForKey:@"uid"];
        self.created_time = [decoder decodeObjectForKey:@"created_time"];
    }
    return self;
}

@end
