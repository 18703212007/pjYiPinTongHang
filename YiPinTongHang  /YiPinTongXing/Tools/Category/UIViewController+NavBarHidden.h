//
//  UIViewController+NavBarHidden.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/11.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (NavBarHidden)


/** 需要监听的View */
@property(nonatomic,strong)UIScrollView *keyScrollView;

/** 设置导航栏上标签是否跟随滚动变化透明度,默认不会跟随变动变化透明度 */
@property(nonatomic,getter=isLeftAlpha) BOOL   isLeftAlpha;

@property(nonatomic,getter=isTitleAlpha) BOOL  isTitleAlpha;

@property(nonatomic,getter=isRightAlpha) BOOL  isRightAlpha;


/** 清楚默认导航栏的背景设置 */
-(void)setInViewWillAppear;
-(void)setInViewWillDisappear;


/** 偏移offsetY的距离后 导航栏的Alpha值为1 */

-(void)scrollControlByOffsetY:(CGFloat)offsetY;


@end
