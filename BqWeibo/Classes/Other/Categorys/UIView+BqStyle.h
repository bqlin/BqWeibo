//
//  UIView+BqStyle.h
//  Bq 微博
//
//  Created by LinBq on 15/12/30.
//  Copyright © 2015年 Bq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (BqStyle)

/// x 坐标
@property (nonatomic, assign) CGFloat x;
/// y 坐标
@property (nonatomic, assign) CGFloat y;
/// 宽
@property (nonatomic, assign) CGFloat width;
/// 高
@property (nonatomic, assign) CGFloat height;

/// 尺寸
@property (nonatomic, assign) CGSize size;
/// 坐标
@property (nonatomic, assign) CGPoint origin;

/// 中点的横坐标
@property (nonatomic, assign) CGFloat centerX;
/// 中点的纵坐标
@property (nonatomic, assign) CGFloat centerY;

// 分类中添加的属性需要实现 setter 方法和 getter 方法

/// 快速获取图片按钮
+ (instancetype)imageButton:(NSString *)keyName withTarget:(id)target action:(SEL)action;
@end
