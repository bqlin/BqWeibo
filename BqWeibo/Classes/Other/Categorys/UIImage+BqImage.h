//
//  UIImage+BqImage.h
//  Bq 微博
//
//  Created by LinBq on 15/12/11.
//  Copyright (c) 2015年 Bq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (BqImage)

/// 创建使用 Original Image 的 UIImage（没有渲染的图片）
+ (instancetype)imageInOriginalWithName:(NSString *)imageName;

/// 创建可局部拉伸的图片
+ (instancetype)stretchableImage:(UIImage *)image;

/// 横向拉伸图片
+ (instancetype)horizontalStretchImage:(UIImage *)image mode:(UIImageResizingMode)mode;
@end
