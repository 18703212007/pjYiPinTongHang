//
//  StoreCouponView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/2.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StoreCouponView;
@protocol StoreConponViewDelegate <NSObject>

-(void)StoreCouponView:(StoreCouponView*)view Index:(NSInteger)index CouID:(NSString*)couID;

@end



@interface StoreCouponView : UIView

@property(nonatomic,strong)UIView     *alphaView;

@property(nonatomic,strong)UIView     *whiteView;

@property(nonatomic,strong)UIButton   *bt_cancle;

@property(nonatomic,strong)UIButton   *bt_sure;

@property(nonatomic,strong)NSArray    *couponArray;

@property(nonatomic,assign)id<StoreConponViewDelegate> delegate;

@end
