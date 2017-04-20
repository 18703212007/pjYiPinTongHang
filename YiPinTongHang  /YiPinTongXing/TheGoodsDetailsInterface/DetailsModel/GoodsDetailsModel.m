//
//  GoodsDetailsModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "GoodsDetailsModel.h"

@implementation GoodsDetailsModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    //    if ([key isEqualToString:@"description"]) {
    //        self.description1 = value;
    //    }
}



-(NSString*)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,\n%@,%@,%@,\n\n%@,%@,%@,%@,%@,%@,%@,\n\n轮播图数组:%@,\n\n最新的2条评论:%@,\n\n商品评论总数:%@,%@,优惠券:%@,SKU(库存量管理):%@,",self.gId,self.gName,self.marPrice,self.price,self.warstock,self.sId,self.orderNum,self.postAge,self.sid,self.shopname,self.shoplogo,self.shopStar,self.goodsNum,self.serviceNum,self.timeNum,self.picList,self.appraisesList,self.goodsAppraisesNum,self.isFavorites,self.couponList,self.attrIosList];
}

@end


@implementation PingLunModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"description"]) {
        self.description1 = value;
    }
}



-(NSString*)description{
    return [NSString stringWithFormat:@"oid:%@,uid:%@,评论内容:%@,\n评论图片:%@,-----------------------------评论时间:%@,尺寸:%@,nickName:%@,logo:%@",self.oid,self.uid,self.description1,self.picarr,self.pubtime,self.attrName,self.uName,self.uLogo];
}

@end


@implementation ALLPingLunModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString*)description{
    return [NSString stringWithFormat:@"全部评论:%@,好评:%@,中评:%@,差评:%@,有图评论:%@,评论的全部内容:%@",self.num,self.hnum,self.znum,self.cnum,self.stnum,self.appraisesList];
}

@end



@implementation ShopModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


-(NSString*)description{
    
    return [NSString stringWithFormat:@"店铺信息:%@\n优惠券::%@\n精品推荐:%@",self.shops,self.couponList,self.Best];
    
}

@end

//couid


@implementation CouponModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


-(NSString*)description{
    
    return [NSString stringWithFormat:@"优惠券id%@\n条件:%@\n价格:%@",self.couid,self.mprice,self.jprice];
    
}

@end

