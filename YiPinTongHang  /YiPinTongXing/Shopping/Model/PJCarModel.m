//
//  PJCarModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJCarModel.h"
@implementation PJCarModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"goodsId:%@ goodsName:%@,shopPrice:%.2f,shopPrice:%.2f,img:%@,商品数量:%ld,商品库存:%ld,商品参数:%@",self.goodsId,self.goodsName,self.shopPrice,self.marketPrice,self.goodsImg,self.goodsCnt,self.goodsStock,self.goodsVal];
}
@end
