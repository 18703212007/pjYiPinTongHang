//
//  StoreModel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/22.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreModel : NSObject




///店铺id
@property(nonatomic,strong)NSString *shopid;


///店铺logo
@property(nonatomic,strong)NSString *shoplogo;
///店铺名称
@property(nonatomic,strong)NSString *shopname;
///店铺收藏数
@property(nonatomic,strong)NSString *favoritesnum;
///店铺交易数
@property(nonatomic,strong)NSString *ordernum;


///店铺商品评价高于同行业的对比
@property(nonatomic,strong)NSString *goodsScoreNum;
///店铺服务态度高于同行业的对比
@property(nonatomic,strong)NSString *serviceScoreNum;
///店铺商品质量高于同行业的对比
@property(nonatomic,strong)NSString *timeScoreNum;

///店铺二维码
@property(nonatomic,strong)NSString *codeImg;
///店铺电话
@property(nonatomic,strong)NSString *tel;


///开店时间
@property(nonatomic,strong)NSString *ctime;
///店铺地址
@property(nonatomic,strong)NSString *area;
///店铺简介
@property(nonatomic,strong)NSString *content;




@end
