//
//  UIImage+Image.m
//  DingDong
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 刘鹏杰. All rights reserved.
//

#import "UIImage+Image.h"

@implementation UIImage (Image)



+(UIImage *)imageWithColor:(UIColor *)color
{
//    描述一个矩形框
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    //开启图形上下文
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    
    //获取图形上下文
    CGContextRef ctx  = UIGraphicsGetCurrentContext();
    
    
    //使用color填充上下文
    CGContextSetFillColorWithColor(ctx, [color CGColor]);
    
    //渲染上下文
    
    CGContextFillRect(ctx, rect);
    
    
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭图形上下文
    UIGraphicsEndImageContext();
    
    return image;
}
@end
