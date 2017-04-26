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
    return [NSString stringWithFormat:@"goodsId:%@ goodsName:%@,shopPrice:%@,shopPrice:%@,img:%@,商品数量:%@,商品库存:%ld,商品参数:%@",self.goodsId,self.goodsName,self.shopPrice,self.marketPrice,self.goodsImg,self.goodsCnt,self.stock,self.goodsVal];
}
@end
