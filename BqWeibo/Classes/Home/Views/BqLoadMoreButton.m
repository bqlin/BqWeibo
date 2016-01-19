//
//  BqLoadMoreButton.m
//  BqWeibo
//
//  Created by LinBq on 16/1/19.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import "BqLoadMoreButton.h"
#import "UIView+BqStyle.h"

@interface BqLoadMoreButton ()

/// 菊花视图
@property (nonatomic, weak) UIActivityIndicatorView *chrysanthemumView;


@end

@implementation BqLoadMoreButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 普通状态
        NSString *titleNormal = @"点击加载更多" ;
        [self setTitle:titleNormal forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];

        
        // 选中状态
        NSString *titleSelected = @"拼命加载中";
        [self setTitle:titleSelected forState:UIControlStateSelected];
        [self setTitleColor:[UIColor lightGrayColor] forState:UIControlStateSelected];
        
        UIActivityIndicatorView *chrysanthemumView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        [self addSubview:chrysanthemumView];
        self.chrysanthemumView = chrysanthemumView;
        
        
        [self addTarget:self action:@selector(loadMoreButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}





/// 设置子控件位置
- (void)layoutSubviews{
    [super layoutSubviews];

    if (self.isSelected) {
        self.chrysanthemumView.hidden = NO;
        self.chrysanthemumView.x = self.titleLabel.x - self.chrysanthemumView.width - 5;
        self.chrysanthemumView.centerY = self.titleLabel.centerY;
        [self.chrysanthemumView startAnimating];
    }else{
        self.chrysanthemumView.hidden = YES;
    }
}

- (void)loadMoreButtonDidClick:(UIButton *)btn{
    self.selected = YES;
    // 通知代理：调用代理方法
    if ([self.delegate respondsToSelector:@selector(loadMoreButtonDidClick:)]) {
        BqLog(@"loading");
        [self.delegate loadMoreButtonDidClick:self];
        self.selected = NO;
    }
}

@end
