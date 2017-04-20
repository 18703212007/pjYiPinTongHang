//
//  UIViewController+NavBarHidden.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/11.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "UIViewController+NavBarHidden.h"
#import "GoodsDetailsView.h"
#import <objc/runtime.h>

@interface UIViewController ()

@property(nonatomic,strong)UIImage *navBarBackgroundImage;

@end

@implementation UIViewController (NavBarHidden)


#pragma mark - 通过运行时动态的添加存储属性 -
//定义关联的Key
static const char *key = "keyScrollView";
-(UIScrollView *)keyScrollView{
    return objc_getAssociatedObject(self, key);
}

-(void)setKeyScrollView:(UIScrollView *)keyScrollView{
    
    objc_setAssociatedObject(self, key, keyScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//定义关联的key
static const char *isLeftAlphaKey = "isLeftAlpha";
-(BOOL)isLeftAlpha{
    return [objc_getAssociatedObject(self, isLeftAlphaKey) boolValue];
}
-(void)setIsLeftAlpha:(BOOL)isLeftAlpha{
    objc_setAssociatedObject(self, isLeftAlphaKey, @(isLeftAlpha), OBJC_ASSOCIATION_ASSIGN);
}

//定义关联的key
static const char *isTitleAlphaKey = "isTitleAlpha";
-(BOOL)isTitleAlpha{
    return [objc_getAssociatedObject(self, isTitleAlphaKey) boolValue];
}
-(void)setIsTitleAlpha:(BOOL)isTilteAlpha{
    objc_setAssociatedObject(self, isTitleAlphaKey, @(isTilteAlpha), OBJC_ASSOCIATION_ASSIGN);
}

//定义关联的key
static const char *isRightAlphaKey = "isRightAlpha";
-(BOOL)isRightAlpha{
    return [objc_getAssociatedObject(self, isRightAlphaKey) boolValue];
}
-(void)setIsRightAlpha:(BOOL)isRightAlpha{
    objc_setAssociatedObject(self, isRightAlphaKey, @(isRightAlpha), OBJC_ASSOCIATION_ASSIGN);
}

/** 偏移offsetY的距离后 导航栏的Alpha值为1 */
static CGFloat alpha = 0;
-(void)scrollControlByOffsetY:(CGFloat)offsetY{
   
    
    if ([self getScrollerView]) {
        UIScrollView *scrollView = [self getScrollerView];
        alpha =scrollView.contentOffset.y/offsetY;
    }else{
        return;
    }
    alpha = (alpha <= 0)?0:alpha;
    alpha = (alpha >= 1)?1:alpha;
    
    self.navigationItem.leftBarButtonItem.customView.alpha = self.isLeftAlpha?alpha:1;
    self.navigationItem.titleView.alpha = self.isTitleAlpha?alpha:1;
    self.navigationItem.rightBarButtonItem.customView.alpha = self.isRightAlpha?alpha:1;
    
    [[[ self.navigationController.navigationBar subviews]objectAtIndex:0]setAlpha:alpha];
}



/** 清除默认导航栏的背景设置 */
-(void)setInViewWillAppear{
   
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
//        self.navBarBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    });
    
    //设置背景图
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:0];
    [self getScrollerView].contentOffset = CGPointMake(0, self.keyScrollView.contentOffset.y - 1);
    [self getScrollerView].contentOffset = CGPointMake(0, self.keyScrollView.contentOffset.y + 1);
    
    
}
-(void)setInViewWillDisappear{
    
    [[[self.navigationController.navigationBar subviews]objectAtIndex:0]setAlpha:1];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
    
    
    
}

-(UIScrollView *)getScrollerView{
    
    if ([self isKindOfClass:[UITableViewController class]]) {
        return (UIScrollView*)self.view;
    }else if([self isKindOfClass:[UICollectionViewController class]]){
        return (UIScrollView*)self.view;
    }else{
        for (UIView *view in self.view.subviews) {
            if ([view isEqual:self.keyScrollView]&[view isKindOfClass:[UIScrollView class]]||[view isEqual:self.keyScrollView] & [view isKindOfClass:[GoodsDetailsView class]]) {
                
                return (UIScrollView*)view;
            }
        }
    }
    return nil;
    
    
}


@end
