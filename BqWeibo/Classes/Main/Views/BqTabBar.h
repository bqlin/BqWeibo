//
//  BqTabBar.h
//  BqWeibo
//
//  Created by LinBq on 16/1/3.
//  Copyright © 2016年 LinBq. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BqTabBar;

@protocol BqTabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(BqTabBar *)tabBar;
@end

@interface BqTabBar : UITabBar

@property (nonatomic, weak) id<BqTabBarDelegate> delegate;

@end
