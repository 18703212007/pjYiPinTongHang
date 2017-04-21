//
//  PJNumberCount.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^PJNumberChangeBlock)(NSInteger count);


@interface PJNumberCount : UIView

/**
 *  总数
 */
@property (nonatomic, assign) NSInteger           totalNum;
/**
 *  当前显示价格
 */
@property (nonatomic, assign) NSInteger           currentCountNumber;
/**
 *  数量改变回调
 */
@property (nonatomic, copy  ) PJNumberChangeBlock NumberChangeBlock;


@end
