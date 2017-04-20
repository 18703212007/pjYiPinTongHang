//
//  HomeListModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/28.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "HomeListModel.h"

@implementation HomeListModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@",self.catsId,self.catsName,self.catsPic];
    
    
}

@end


#pragma mark - 二级菜单推荐 -
@implementation CollectionGoodsModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@",self.gId,self.gName,self.picurl,self.orderNum,self.price,self.warstock,self.isPostage];
    
    
}

@end



@implementation LDetailedCollectionModel


-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@",self.catsName,self.catsId,self.catsPic];
    
    
}

@end


@implementation CollectionStoreModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@",self.favoritesnum,self.ordernum,self.shoplogo,self.shopname,self.shopid];
    
    
}

@end

