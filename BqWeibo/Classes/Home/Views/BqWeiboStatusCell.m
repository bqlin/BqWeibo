//
//  BqWeiboStatusCell.m
//  BqWeibo
//
//  Created by LinBq on 16/1/19.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import "BqWeiboStatusCell.h"
#import "BqWeiboStatus.h"
#import "BqWeiboStatusFrame.h"

#import "UIImageView+WebCache.h"

@interface BqWeiboStatusCell ()

/// profileImageView：头像
@property (nonatomic, weak) UIImageView *profileImageView;

/// screenNameView：昵称
@property (nonatomic, weak) UILabel *screenNameView;

/// textView：微博文字内容
@property (nonatomic, weak) UILabel *textView;

/// picView：微博配图
@property (nonatomic, weak) UIImageView *picView;


@end

@implementation BqWeiboStatusCell

/// 快速获取重用 cell
+ (instancetype)weiboStatusCellOnTableView:(UITableView *)tableView{
    static NSString *ruseID = @"weiboStatusCell";
    BqWeiboStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:ruseID];
    if (!cell) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ruseID];
    }
    return cell;
}

/// 重写构造方法
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 头像
        UIImageView *profileImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:profileImageView];
        self.profileImageView= profileImageView;
        
        // 昵称
        UILabel *screenNameView = [[UILabel alloc] init];
        [self.contentView addSubview:screenNameView];
        self.screenNameView = screenNameView;
        screenNameView.font = [UIFont systemFontOfSize:BqScreenNameFontSize];
        
        // 微博内容
        UILabel *textView = [[UILabel alloc] init];
        [self.contentView addSubview:textView];
        self.textView = textView;
        textView.font = [UIFont systemFontOfSize:BqTextFontSize];
        textView.numberOfLines = 0;
        
        
        // 微博配图
        UIImageView *picView = [[UIImageView alloc] init];
        [self.contentView addSubview:picView];
        self.picView = picView;
        picView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}


/// 重写 数据模型 的 setter 方法
- (void)setStatusFrame:(BqWeiboStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    BqWeiboStatus *status = self.statusFrame.status;

    // 设置子控件内容
    // 头像占位图
    UIImage *placehoderAvatar = [UIImage imageNamed:@"avatar_default_small"];
    [self.profileImageView sd_setImageWithURL:[NSURL URLWithString:status.user.profile_image_url] placeholderImage:placehoderAvatar];
    // 昵称
    self.screenNameView.text = status.user.screen_name;
    // 微博内容
    self.textView.text = status.text;
    // 微博配图
    // 配图占位图
    UIImage *placehoderPic = [UIImage imageNamed:@"timeline_image_placeholder"];
    [self.picView sd_setImageWithURL:[NSURL URLWithString:status.bmiddle_pic] placeholderImage:placehoderPic];
    
    // 设置子控件 frame
    self.profileImageView.frame = statusFrame.profileImageFrame;
    self.screenNameView.frame = statusFrame.screenNameFrame;
    self.textView.frame = statusFrame.textFrame;
    self.picView.frame = statusFrame.picFrame;
//    [self.picView sizeToFit];
//    CGFloat imgHeight = self.picView.image.size.height;
//    [statusFrame setValue:@(imgHeight)forKey:@"rowHeight"];
//    BqLog(@"setting cells");
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
