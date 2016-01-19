//
//  BqWeiboStatusFrame.m
//  BqWeibo
//
//  Created by LinBq on 16/1/19.
//  Copyright (c) 2016年 LinBq. All rights reserved.
//

#import "BqWeiboStatusFrame.h"
#import "BqWeiboStatus.h"



@implementation BqWeiboStatusFrame

/// 重写数据模型的 setter 方法，并以此设置其他属性的值
- (void)setStatus:(BqWeiboStatus *)status{
    _status = status;
    
    // 间距
    CGFloat margin = 10;
    // 头像
    CGFloat profileImageW = 30;
    CGFloat profileImageH = profileImageW;
    CGFloat profileImageX = margin;
    CGFloat profileImageY = margin;
    _profileImageFrame = (CGRect){{profileImageX, profileImageY}, {profileImageW, profileImageH}};
    
    // 昵称
    CGSize screenNameMaxSize = CGSizeMake(MAXFLOAT, MAXFLOAT);
    // 直接调用方法计算标签大小太臃肿，因此将其写成方法
    CGSize screenNameSize = [self sizeOfText:status.user.screen_name maxSize:screenNameMaxSize fontSize:BqScreenNameFontSize];
    CGFloat screenNameX = CGRectGetMaxX(_profileImageFrame) + margin;
    CGFloat screenNameY = profileImageY + (profileImageH - screenNameSize.height) / 2;
    _screenNameFrame = (CGRect){{screenNameX, screenNameY}, screenNameSize};
    

    
    // 微博文字内容
    CGSize textSize =  [self sizeOfText:status.text maxSize:CGSizeMake(300, MAXFLOAT) fontSize:BqTextFontSize];
    CGFloat textX = margin;
    CGFloat textY = CGRectGetMaxY(_profileImageFrame) + margin;
    _textFrame = (CGRect){{textX, textY}, textSize};
    
    // 微博配图
    if (self.status.thumbnail_pic){
//        CGSize picSize = [UIImage imageNamed:self.weibo.pic].size;
        CGFloat picMaxH = 100;
        CGFloat picMaxW = 300;
//        CGFloat picH, picW;
//        if (picSize.height <= picMaxH && picSize.width <= picMaxW) {
//            picH = picSize.height;
//            picW = picSize.width;
//        } else{
//            if (picSize.width > picMaxW){
//                picW = picMaxW;
//                picH = picSize.height / picSize.width * picMaxW;
//            }
//            if (picSize.height > picMaxH){
//                picH = picMaxH;
//                picW = picSize.width / picSize.height * picMaxH;
//            }
//        }
        
        CGFloat picX = margin;
        CGFloat picY = CGRectGetMaxY(_textFrame) + margin;
        _picFrame = CGRectMake(picX, picY, picMaxW, picMaxW);
        _rowHeight = CGRectGetMaxY(_picFrame) + margin;
    }else{
        _rowHeight = CGRectGetMaxY(_textFrame) + margin;
    }
    
    
    
}

// 计算标签大小
-(CGSize)sizeOfText:(NSString *)text maxSize:(CGSize)maxSize fontSize:(CGFloat)fontSize{
    CGSize size = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size; // 此处仅仅只是计算而已，并不是设置 label 的属性
    return size;
}
@end
