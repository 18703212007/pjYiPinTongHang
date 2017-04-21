//
//  PJCarModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJCarModel.h"
#import "PJCarListModel.h"
@implementation PJCarModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"shopID:%@ shopName:%@,list:%@",self.shopId,self.shopName,self.list];
}
@end
