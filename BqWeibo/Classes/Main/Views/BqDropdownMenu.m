//
//  BqDropdownMenu.m
//  BqWeibo
//
//  Created by LinBq on 16/1/2.
//  Copyright © 2016年 Bq. All rights reserved.
//

#import "BqDropdownMenu.h"
#import "UIView+BqStyle.h"
#import "UIImage+BqImage.h"

@interface BqDropdownMenu ()

/// 带背景图的容器
@property (nonatomic, weak) UIImageView *containerView;

/// 内容 table view
//@property (nonatomic, strong) UITableView *contentView;

@end

@implementation BqDropdownMenu

/// 懒加载 containerView
- (UIImageView *)containerView{
    if (!_containerView) {
        // 添加下拉菜单背景
        // 下拉菜单要保证它在顶层
        UIImageView *containerView = [[UIImageView alloc] initWithImage:[UIImage stretchableImage:[UIImage imageNamed:@"popover_background"]]];
        self.containerView = containerView;
        // 直接添加到遮盖层上（便于封装）
        [self addSubview:containerView];
        
        // 开启用户交互
        containerView.userInteractionEnabled = YES;
    }
    return _containerView;

}


- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // self 就是蒙版
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

+(instancetype)menu{
    return [[self alloc] init];
}


/// 设置显示内容：View
- (void)setContentView:(UIView *)contentView{
    _contentView = contentView;
    
    // 调整内容的位置
    contentView.x = 10;
    contentView.y = 15;
    
    // 根据传递进来的 contentView 调整容器的高度
    self.containerView.height = CGRectGetMaxY(contentView.frame) + contentView.y - 4;
    self.containerView.width = CGRectGetMaxX(contentView.frame) + contentView.x;
    [self.containerView addSubview:contentView];
}

/// 设置显示内容：view controller 中的 view
-(void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    self.contentView = contentController.view;
}

/// 显示
- (void)showFrom:(UIView *)targetView{
    // 1. 获取最顶层窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    // 2. 添加自身到窗口上
    [window addSubview:self];
    
    // 3. 设置尺寸
    self.frame = window.bounds;

    
    // 4.其他
    // 设置下拉菜单的位置
//    self.containerView.x = (window.bounds.size.width - self.containerView.width) / 2;
//    self.containerView.y = 64 - 10;
//    self.containerView.height = 100;
    // 转换坐标系
    CGRect newRect = [targetView convertRect:targetView.bounds toView:window];
    self.containerView.centerX = CGRectGetMidX(newRect);
    self.containerView.y = CGRectGetMaxY(newRect);
    
    // 通知代理：调用代理方法
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidShow:)]) {
        [self.delegate dropdownMenuDidShow:self];
    }
   
}

/// 销毁
-(void)dismiss{
    [self removeFromSuperview];

    // 通知代理：调用代理方法
    if ([self.delegate respondsToSelector:@selector(dropdownMenuDidDismiss:)]) {
        [self.delegate dropdownMenuDidDismiss:self];
    }
    
}

/// 点击 view 则进行销毁
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

@end
