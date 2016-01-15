//
//  UIColor+BqColor.h
//  Bq 微博
//
//  Created by LinBq on 15/12/29.
//  Copyright © 2015年 Bq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (BqColor)

/// 获取随机色
+ (instancetype)randomColor;

/// RGB 颜色
+ (instancetype) colorInR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b;

@end
