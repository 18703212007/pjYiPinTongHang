//
//  UINavigationBar+Alpha.m
//  Nav
//
//  Created by dhz on 2017/2/8.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "UINavigationBar+Alpha.h"
#import <objc/runtime.h>
static char overlayKey;
@implementation UINavigationBar (Alpha)

-(UIView*)overlay{
    
    return objc_getAssociatedObject(self, &overlayKey);
}


-(void)setOverlay:(UIView*)overlay{
    
    objc_setAssociatedObject(self, &overlayKey, overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


-(void)lt_setBackgroundColor:(UIColor *)backgroundColor{
    if (!self.overlay) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        
        self.overlay = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen  mainScreen].bounds.size.width, CGRectGetHeight(self.bounds)+20)];
        
        self.overlay.userInteractionEnabled = NO;
        
        self.overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlay atIndex:0];
        
    }
    self.overlay.backgroundColor = backgroundColor;
}




-(void)lt_setTranslationY:(CGFloat)translationY{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}






- (void)lt_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    
//    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        <#code#>
//    }]
    
    
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
}



-(void)lt_reset{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlay removeFromSuperview];
    self.overlay = nil;
}
















@end
