//
//  GoodsDetailsModel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GoodsDetailsModel : NSObject
///商品Id
@property(nonatomic,strong)NSString *gId;
///商品的名称
@property(nonatomic,strong)NSString *gName;
///市场价格
@property(nonatomic,strong)NSString *marPrice;
///店铺价格
@property(nonatomic,strong)NSString *price;
///库存
@property(nonatomic,strong)NSString *warstock;
///店铺Id(用于关联店铺数据)
@property(nonatomic,strong)NSString *sId;
///商品销量
@property(nonatomic,strong)NSString *orderNum;
///快递状态
@property(nonatomic,strong)NSString *postAge;
///店铺id
@property(nonatomic,strong)NSString *sid;
///店铺名称
@property(nonatomic,strong)NSString *shopname;
///店铺的Logo
@property(nonatomic,strong)NSString *shoplogo;
///店铺等级
@property(nonatomic,strong)NSString *shopStar;
///店铺评级分数
@property(nonatomic,strong)NSString *goodsNum;
///服务态度分数
@property(nonatomic,strong)NSString *serviceNum;
///商品质量分数
@property(nonatomic,strong)NSString *timeNum;
///是否已经收藏
@property(nonatomic,strong)NSString *isFavorites;


///评论相关
@property(nonatomic,strong)NSDictionary *goodsAppraisesNum;
///最新的两条评论
@property(nonatomic,strong)NSArray *appraisesList;
///轮播图组
@property(nonatomic,strong)NSArray *picList;

///优惠券
@property(nonatomic,strong)NSArray *couponList;
///SKU(库存量管理)
@property(nonatomic,strong)NSDictionary *attrIosList;


@end

@interface PingLunModel : NSObject

#pragma mark - 评论部分的数据 -
///订单id 用于关联数据
@property(nonatomic,strong)NSString *oid;
///评论用户id
@property(nonatomic,strong)NSString *uid;
///商品评价描述
@property(nonatomic,strong)NSString *description1;
///评论图片数组
@property(nonatomic,strong)NSArray *picarr;
///追加评论
@property(nonatomic,strong)NSString *description2;
///追加评论图片
@property(nonatomic,strong)NSArray *picarr2;
///评论时间
@property(nonatomic,strong)NSString *pubtime;
///商品属性
@property(nonatomic,strong)NSString *attrName;
///评论人名称
@property(nonatomic,strong)NSString *uName;
///评论人头像
@property(nonatomic,strong)NSString *uLogo;

@end

//@property (copy, nonatomic) NSString *name;
//@property (assign, nonatomic) double price;
//@property (copy, nonatomic) NSString *ID;
//@property (copy, nonatomic) NSString *otherName;
//@property (copy, nonatomic) NSString *nowName;
//@property (copy, nonatomic) NSString *oldName;
//@property (copy, nonatomic) NSString *nameChangedTime;
//@property (copy, nonatomic) NSString *desc;
//@property (strong, nonatomic) NSArray *books;


@interface ALLPingLunModel : NSObject
///
@property(nonatomic,strong)NSString *num;
///
@property(nonatomic,strong)NSString *hnum;
///
@property(nonatomic,strong)NSString *znum;
///
@property(nonatomic,strong)NSString *cnum;
///
@property(nonatomic,strong)NSString *stnum;

@property(nonatomic,strong)NSArray *appraisesList;

@end

@interface ShopModel : NSObject
///店铺信息
@property(nonatomic,strong)NSDictionary *shops;
///优惠券
@property(nonatomic,strong)NSArray  *couponList;
///精品推荐
@property(nonatomic,strong)NSArray  *Best;
@end

@interface CouponModel : NSObject

@property(nonatomic,strong)NSString *couid;

@property(nonatomic,strong)NSString *jprice;

@property(nonatomic,strong)NSString *mprice;



@end

