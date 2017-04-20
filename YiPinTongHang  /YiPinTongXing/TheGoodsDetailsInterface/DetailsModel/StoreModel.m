//
//  StoreModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/22.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "StoreModel.h"

@implementation StoreModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,\n%@,%@,%@,\n%@,%@,\n%@,%@,%@",self.shopid,self.shoplogo,self.shopname,self.favoritesnum,self.ordernum,self.goodsScoreNum,self.serviceScoreNum,self.timeScoreNum,self.codeImg,self.tel,self.ctime,self.area,self.content];
}

@end
