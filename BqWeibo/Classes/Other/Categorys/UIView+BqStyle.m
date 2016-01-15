//
//  UIView+BqStyle.m
//  Bq 微博
//
//  Created by LinBq on 15/12/30.
//  Copyright © 2015年 Bq. All rights reserved.
//

#import "UIView+BqStyle.h"

@implementation UIView (BqStyle)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

-(CGFloat)x{
    return self.frame.origin.x;
}

-(void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

-(CGFloat)y{
    return self.frame.origin.y;
}

-(void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat)width{
    return self.frame.size.width;
}

-(void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)height{
    return self.frame.size.height;
}

-(void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

-(void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

-(CGFloat)centerY{
    return self.center.y;
}

- (void)setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}


/// 快速获取图片按钮
+ (instancetype)imageButton:(NSString *)keyName withTarget:(id)target action:(SEL)action{
    // 创建按钮
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [customBtn setImage:[UIImage imageNamed:keyName] forState:UIControlStateNormal];
    [customBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_highlighted", keyName]] forState:UIControlStateHighlighted];
    // 设置尺寸
    [customBtn sizeToFit];
    
    // 添加事件监听
    [customBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return customBtn;
}



@end
