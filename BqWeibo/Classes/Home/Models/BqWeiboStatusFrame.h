//
//  BqWeiboStatusFrame.h
//  BqWeibo
//
//  Created by LinBq on 16/1/19.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BqScreenNameFontSize 15
#define BqTextFontSize 14

@class BqWeiboStatus;

@interface BqWeiboStatusFrame : NSObject

/// 数据模型
@property (nonatomic, strong) BqWeiboStatus *status;

/// 头像 frame
@property (nonatomic, assign, readonly) CGRect profileImageFrame;

/// 昵称 frame
@property (nonatomic, assign, readonly) CGRect screenNameFrame;

/// 微博内容 frame
@property (nonatomic, assign, readonly) CGRect textFrame;

/// 微博配图 frame
@property (nonatomic, assign, readonly) CGRect picFrame;

// 最终的行高
@property (nonatomic, assign, readonly) CGFloat rowHeight;


@end
