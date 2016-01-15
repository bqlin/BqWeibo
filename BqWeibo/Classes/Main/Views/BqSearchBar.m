//
//  BqSearchBar.m
//  BqWeibo
//
//  Created by LinBq on 15/12/31.
//  Copyright © 2015年 Bq. All rights reserved.
//

#import "BqSearchBar.h"
#import "UIImage+BqImage.h"

@interface BqSearchBar ()

/// 搜索框图标
@property (nonatomic, strong) UIImageView *searchIcon;

/// 图标宽度
@property (nonatomic, assign) CGFloat searchIconWidth;




@end

@implementation BqSearchBar

// 初始化
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // 使用 text filed 自定义搜索框
        self.font = [UIFont systemFontOfSize:15];
        self.placeholder = @"搜神马";
        self.background = [UIImage stretchableImage:[UIImage imageNamed:@"searchbar_textfield_background"]];
        UIImage *searchIconImage = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        UIImageView *searchIcon = [[UIImageView alloc] initWithImage:searchIconImage];
        self.searchIcon = searchIcon;

        // 设置居中
        searchIcon.contentMode = UIViewContentModeCenter;
        
        // [searchBar addSubview:searchIcon];
        // 不使用 addSubview 的方式添加搜索栏图标，而通过设置 leftView 与 leftViewMode 来实现
        self.leftView = searchIcon;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}



+ (instancetype)searchBar{
    return [[self alloc] init];
}


/// 设置 searchIcon 大小
- (void)setSearchIconWidth:(CGFloat)searchIconWidth{
    _searchIconWidth = searchIconWidth;
    self.searchIcon.frame = CGRectMake(0, 0, searchIconWidth, searchIconWidth);
    
}


/// 该方法只在自身的 bounds 发生变化时调用
- (void)layoutSubviews{
    [super layoutSubviews];
    self.searchIconWidth = self.frame.size.height;
}


@end
