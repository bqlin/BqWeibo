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

/// max_id：本次最旧微博的 ID
@property (nonatomic, copy) NSString *max_id;

/// thumbnail_pic：微博内容缩略图地址
@property (nonatomic, copy) NSString *thumbnail_pic;

/// bmiddle_pic：微博配图中等尺寸
@property (nonatomic, copy) NSString *bmiddle_pic;
@end
