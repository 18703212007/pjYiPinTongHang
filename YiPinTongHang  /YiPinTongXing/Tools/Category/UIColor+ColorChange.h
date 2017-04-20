//
//  UIColor+ColorChange.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ColorChange)
#pragma mark - 颜色的16进制转换
+(UIColor *)colorWithHexString:(NSString *)color;

@end
