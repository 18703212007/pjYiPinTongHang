//
//  ListModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


-(NSString *)description{
    return [NSString stringWithFormat:@"catsId:%@,catsName:%@,catsPic:%@",self.catsId,self.catsName,self.catsPic];
}
@end

@implementation TableModel

-(void)setValue:(id)value forUndefinedKey:(NSString * _Nonnull)key{
    
    
}

-(NSString *)description{
    return  [NSString stringWithFormat:@"catsName:%@,catsId:%@",self.catsName,self.catsId];
}

@end

@implementation CollectionModel

-(void)setValue:(id)value forUndefinedKey:(NSString * _Nonnull)key{
    
    
}

-(NSString *)description{
    return  [NSString stringWithFormat:@"catsName:%@,%@",self.catsName,self.catsId];
}

@end
