//
//  PersonalCouponModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/31.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PersonalCouponModel.h"

@implementation PersonalCouponModel



-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}


-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@",self.couid,self.shopid,self.shopname,self.jprice,self.mprice,self.sytime,self.st];
}


@end
