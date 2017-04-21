//
//  PJCarListModel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PJCarListModel : NSObject
/**
 *  商品名字
 */
@property(nonatomic,strong)NSString *goodsId;
/**
 *  商品名字
 */
@property(nonatomic,strong)NSString *goodsName;
/**
 *  店铺价格
 */
@property(nonatomic,assign)CGFloat shopPrice;
/**
 *  市场价格
 */
@property(nonatomic,assign)CGFloat marketPrice;
/**
 *  商品图片
 */
@property(nonatomic,strong)UIImageView *goodsImg;
/**
 *  商品数量
 */
@property(nonatomic,assign)NSUInteger goodsCnt;
/**
 *  选择的商品属性
 */
@property(nonatomic,strong)NSString *goodsVal;

#pragma mark - 缺少库存量 -
/**
 *  商品的库存量
 */
@property(nonatomic,assign)NSInteger goodsStock;

@end