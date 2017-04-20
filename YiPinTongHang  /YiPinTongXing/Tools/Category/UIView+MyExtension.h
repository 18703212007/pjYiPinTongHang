//
//  UIView+MyExtension.h
//  DingDong
//
//  Created by Apple on 16/6/14.
//  Copyright © 2016年 刘鹏杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (MyExtension)

@property (nonatomic, assign)CGFloat x;

@property (nonatomic, assign)CGFloat y;

@property (nonatomic, assign)CGFloat width;

@property (nonatomic, assign)CGFloat height;

@property (nonatomic, assign)CGFloat centerX;

@property (nonatomic, assign)CGFloat centerY;

@property (nonatomic, assign)CGSize size;

@property(nonatomic, assign) IBInspectable CGFloat borderWidth;

@property(nonatomic, assign) IBInspectable UIColor *borderColor;

@property(nonatomic, assign) IBInspectable CGFloat cornerRadius;

/**
 *  水平居中
 */
- (void)alignHorizontal;
/**
 *  垂直居中
 */
- (void)alignVertical;
/**
 *  判断是否显示在主窗口上面
 *
 *  @return 是否
 */
- (BOOL)isShowOnWindow;

- (UIViewController *)parentController;

@end
