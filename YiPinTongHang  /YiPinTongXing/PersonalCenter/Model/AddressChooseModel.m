//
//  AddressChooseModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/27.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "AddressChooseModel.h"

@implementation AddressChooseModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

-(NSString *)description{
    return  [NSString stringWithFormat:@"provinceName:%@,provinceID:%@,\ncityName:%@,cityID:%@,\nareaName:%@,areaID:%@",self.provinceName,self.provinceID,self.cityName,self.cityID,self.areaName,self.areaID];
}

@end



@implementation AddressGetModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}



-(NSString *)description{
    
    return  [NSString stringWithFormat:@"provinceID:%@,cityID:%@,areaID:%@,%@,%@,%@,%@,%@,%@,%@",self.provinceID,self.cityID,self.areaID,self.arid,self.uname,self.utel,self.code,self.ar,self.artwo,self.isstate];
}

@end
