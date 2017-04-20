//
//  PersonalModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/26.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PersonalModel.h"

@implementation PersonalModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    
    return [NSString stringWithFormat:@"aid:%@,aname:%@,pid:%@",self.aid,self.aname,self.pid];
}

@end
