//
//  BqLoadMoreButton.h
//  BqWeibo
//
//  Created by LinBq on 16/1/19.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//  加载更多 按钮

#import <UIKit/UIKit.h>

// 代理协议声明
@class BqLoadMoreButton;

@protocol BqLoadMoreButtonDelegate <NSObject>
@optional
- (void)loadMoreButtonDidClick:(BqLoadMoreButton *)loadMoreButton;
@end

@interface BqLoadMoreButton : UIButton
/// 代理属性
@property (nonatomic, weak) id<BqLoadMoreButtonDelegate> delegate;

@end
