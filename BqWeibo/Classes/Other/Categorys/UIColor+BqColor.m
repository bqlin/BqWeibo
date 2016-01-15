//
//  UIColor+BqColor.m
//  Bq 微博
//
//  Created by LinBq on 15/12/29.
//  Copyright © 2015年 Bq. All rights reserved.
//

#import "UIColor+BqColor.h"

@implementation UIColor (BqColor)

/// 获取随机色
+ (instancetype)randomColor{
    // 随机色
    return [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
}

/// RGB 颜色
+ (instancetype) colorInR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b{
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
}

@end
