//
//  BqWeiboUser.h
//  BqWeibo
//
//  Created by LinBq on 16/1/16.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//  微博用户模型

#import <Foundation/Foundation.h>

@interface BqWeiboUser : NSObject

/// idstr：用户 ID
@property (nonatomic, copy) NSString *idstr;

/// screen_name：用户昵称
@property (nonatomic, copy) NSString *screen_name;

/// profile_image_url：用户头像缩略图url
@property (nonatomic, copy) NSString *profile_image_url;


@end
