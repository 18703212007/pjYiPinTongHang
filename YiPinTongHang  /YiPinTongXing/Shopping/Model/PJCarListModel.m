//
//  PJCarListModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJCarListModel.h"

@implementation PJCarListModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"shopId:%@ shopName:%@",self.shopId,self.shopName];
}


@end
