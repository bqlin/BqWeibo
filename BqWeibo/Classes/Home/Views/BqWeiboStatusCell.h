//
//  BqWeiboStatusCell.h
//  BqWeibo
//
//  Created by LinBq on 16/1/19.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//  微博内容 cell

#import <UIKit/UIKit.h>

@class BqWeiboStatus;
@class BqWeiboStatusFrame;

@interface BqWeiboStatusCell : UITableViewCell

/// 用于设置 frame 的综合模型
@property (nonatomic, strong) BqWeiboStatusFrame *statusFrame;

/// 快速获取重用 cell
+ (instancetype)weiboStatusCellOnTableView:(UITableView *)tableView;

@end
