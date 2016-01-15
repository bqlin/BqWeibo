//
//  BqNewFeatureController.m
//  BqWeibo
//
//  Created by LinBq on 16/1/4.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import "BqNewFeatureController.h"
#import "UIView+BqStyle.h"
#import "UIColor+BqColor.h"
#import "BqTabBarController.h"

#import "UIWindow+Extension.h"

/// 新特性图片张数
#define BqNewFeatureCount 4

// 遵守 scrollView 的代理协议
@interface BqNewFeatureController ()<UIScrollViewDelegate>

@property (nonatomic, weak) UIPageControl *pageControl;
@property (nonatomic, weak) UIScrollView *scrollView;

@end

@implementation BqNewFeatureController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 1. 创建一个用于显示新特性图片 scroll view
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    
    // 2. 设置 scrollView
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(BqNewFeatureCount * scrollView.width, 0);   // 哪个方向不滚动，那个方向设为0
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.delegate = self;
    
    // 3. 添加图片到 scrollView 中，最后一张图片做特殊处理
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    for (int i = 0; i < BqNewFeatureCount; i ++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"new_feature_%d", i + 1]]];
        [scrollView addSubview:imageView];
        imageView.width = scrollW;
        imageView.height = scrollH;
        imageView.y = 0;
        imageView.x = i * scrollW;
        
        // 如果是最后一个 imageView 则调用方法设置里面的内容
        if (i == BqNewFeatureCount - 1) {
//            BqLog(@"最后一张啦！ i = %d", i);
            [self setupLastImageView:imageView];
        }
    }
    
    // 4. 在 scrollView 的上一层添加 pageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    pageControl.numberOfPages = BqNewFeatureCount;
    pageControl.currentPageIndicatorTintColor = [UIColor colorInR:253 G:98 B:42];
    pageControl.pageIndicatorTintColor = [UIColor colorInR:189 G:189 B:189];
    pageControl.centerX = scrollW / 2;
    pageControl.centerY = scrollH - 50;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/// 处理最后一张图片
- (void)setupLastImageView:(UIImageView *)imageView{
//    NSLog(@"imageView.frame: %@", NSStringFromCGRect(imageView.frame));
    // 开启交互
    imageView.userInteractionEnabled = YES;
    
    // 分享按钮
    UIButton *shareBtn = [[UIButton alloc] init];
    [imageView addSubview:shareBtn];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    shareBtn.width = 300;
    shareBtn.height = 30;
    shareBtn.centerX = imageView.width / 2;
    shareBtn.centerY = imageView.height * 0.65;
    shareBtn.contentMode = UIViewContentModeCenter;
    
    [shareBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    // 开始微博按钮
    UIButton *startBtn = [[UIButton alloc] init];
    [imageView addSubview:startBtn];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState: UIControlStateNormal];
    [startBtn sizeToFit];
    //startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageView.height * 0.75;
    [startBtn addTarget:self action:@selector(startWeibo) forControlEvents:UIControlEventTouchUpInside];
    
    
//    BqLog(@"the last iamgeView: %@", imageView.subviews);
}

#pragma mark - 点击事件
/// 实现 checkBox
- (void)shareBtnClick:(UIButton *)shareBtn{
    // 状态取反
    shareBtn.selected = !shareBtn.isSelected;
}

/// 开始微博
- (void)startWeibo{
//    // 切换到 tab bar controller，使用切换 window 的根控制器方式
//    [UIApplication sharedApplication].keyWindow.rootViewController = [[BqTabBarController alloc] init];
    
    // #切换根控制器#
    [[UIApplication sharedApplication].keyWindow switchRootViewController];
}

#pragma mark - scrollView 代理方法
/// 滚动时设置 pageControl
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double page = scrollView.contentOffset.x / scrollView.width;
    self.pageControl.currentPage = (NSInteger)(page + 0.5);
}

#pragma mark - 看看新特性界面是否已经销毁
- (void)dealloc{
    BqLog(@"new feature controller is dead.");
}


@end
