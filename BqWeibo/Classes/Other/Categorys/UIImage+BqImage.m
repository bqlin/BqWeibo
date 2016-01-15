//
//  UIImage+BqImage.m
//  Bq 微博
//
//  Created by LinBq on 15/12/11.
//  Copyright (c) 2015年 Bq. All rights reserved.
//

#import "UIImage+BqImage.h"

@implementation UIImage (BqImage)

/// 创建使用 Original Image 的 UIImage（没有渲染的图片）
+ (instancetype)imageInOriginalWithName:(NSString *)imageName{
    UIImage *image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return image;
}


/// 创建可局部拉伸的图片
+ (instancetype)stretchableImage:(UIImage *)image{
    return [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:image.size.height * 0.5];
}


/// 横向拉伸图片
+ (instancetype)horizontalStretchImage:(UIImage *)image mode:(UIImageResizingMode)mode{
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width / 2, 0, image.size.width / 2) resizingMode:mode];
}


///
@end
