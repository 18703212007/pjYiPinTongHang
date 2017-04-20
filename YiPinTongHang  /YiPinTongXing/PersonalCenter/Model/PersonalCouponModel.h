//
//  PersonalCouponModel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/31.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonalCouponModel : NSObject


///优惠券id
@property(nonatomic,strong)NSString *couid;
///商铺id
@property(nonatomic,strong)NSString *shopid;
///商铺名字
@property(nonatomic,strong)NSString *shopname;
///价格
@property(nonatomic,strong)NSString *jprice;
///条件
@property(nonatomic,strong)NSString *mprice;
///使用时间
@property(nonatomic,strong)NSString *sytime;
///状态
@property(nonatomic,strong)NSString *st;


@end
