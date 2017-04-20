//
//  HomeModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/17.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "HomeModel.h"


@implementation ShufflingModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@",self.adsId,self.adsName,self.adsUrl,self.adsFile];
}


@end


#pragma mark - ** 分类 **  -
@implementation HomeModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@,%@,%@",self.price,self.gName,self.picurl,self.gId,self.orderNum];
}

@end









#pragma mark - ** 热门 ** 横向滑动的collectionView -
@implementation HorCollectModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@",self.gName,self.picurl,self.gId];
}

@end









#pragma mark - ** 人气 ** 横向滑动的collectionView -
@implementation ListCollectModel

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@,%@,%@",self.catsName,self.picArr,self.catsId];
}


@end





