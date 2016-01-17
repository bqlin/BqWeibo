//
//  BqWeiboStatus.h
//  BqWeibo
//
//  Created by LinBq on 16/1/16.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BqWeiboUser.h"

@interface BqWeiboStatus : NSObject

/// idstr：微博 ID
@property (nonatomic, copy) NSString *idstr;

/// text：微博信息内容
@property (nonatomic, copy) NSString *text;

/// user：微博发送者
@property (nonatomic, strong) BqWeiboUser *user;
@end
