//
//  BqTitleButton.m
//  BqWeibo
//
//  Created by LinBq on 16/1/15.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import "BqTitleButton.h"
#import "UIView+BqStyle.h"

@implementation BqTitleButton

/// 初始化方法
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 设置按钮固定的属性
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
    }
    return self;
}

/// 快速获取带下拉菜单的标题按钮
+ (instancetype)titleButton{
    return [[self alloc] init];
}


/// 调整子控件
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.titleLabel.x = self.imageView.x;
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}

@end
