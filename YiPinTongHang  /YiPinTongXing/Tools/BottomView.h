//
//  BottomView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomView : UIView

///客服
@property(nonatomic,strong)UIButton *btn_service;
///店铺
@property(nonatomic,strong)UIButton *btn_shop;
///收藏
@property(nonatomic,strong)UIButton *btn_collection;
///加入购物车
@property(nonatomic,strong)UIButton *btn_addBasket;
///立即购买
@property(nonatomic,strong)UIButton *btn_buyNow;

@end
