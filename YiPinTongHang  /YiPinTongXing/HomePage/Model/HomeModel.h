//
//  HomeModel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/17.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ShufflingModel : NSObject


@property(nonatomic,strong)NSString  *adsName;

@property(nonatomic,strong)NSString *adsUrl;

@property(nonatomic,strong)NSString *adsId;

@property(nonatomic,strong)NSString *adsFile;


@end

#pragma mark - ** 分类 **  -

@interface HomeModel : NSObject

@property(nonatomic,strong)NSString  *gId;

@property(nonatomic,strong)NSString *picurl;

@property(nonatomic,strong)NSString *price;

@property(nonatomic,strong)NSString *gName;

@property(nonatomic,strong)NSString *orderNum;

@end



#pragma mark - ** 热门 ** 横向滑动的collectionView -
@interface HorCollectModel : NSObject

@property(nonatomic,strong)NSString  *gId;

@property(nonatomic,strong)NSString *picurl;

@property(nonatomic,strong)NSString *gName;

@end



#pragma mark - ** 人气 ** 横向滑动的collectionView -
@interface ListCollectModel : NSObject

@property(nonatomic,strong)NSString  *catsId;

@property(nonatomic,strong)NSString *picArr;

@property(nonatomic,strong)NSString *catsName;

@end

