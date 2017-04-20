//
//  PJImgaeBrowser.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/16.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PJImgaeBrowser : NSObject

#
/**
 *  @brief  浏览头像
 *  使用的时候 给对于的图片添加Tap手势,然后调用类方法即可
 *
 *  @param  avatarImageView 头像所在的imageView
 */
+(void)showImage:(UIImageView*)avatarImageView;

@end
