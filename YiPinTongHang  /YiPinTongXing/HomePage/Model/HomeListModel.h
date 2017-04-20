//
//  HomeListModel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/28.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>
/***********************************2级跳转********************************************/
@interface HomeListModel : NSObject

@property(nonatomic,strong)NSString  *catsId;

@property(nonatomic,strong)NSString *catsPic;

@property(nonatomic,strong)NSString *catsName;

@end



@interface CollectionGoodsModel : NSObject


@property(nonatomic,strong)NSString  *gId;

@property(nonatomic,strong)NSString *picurl;

@property(nonatomic,strong)NSString *gName;

@property(nonatomic,strong)NSString *orderNum;

@property(nonatomic,strong)NSString *price;

@property(nonatomic,strong)NSString *warstock;

@property(nonatomic,strong)NSString *isPostage;

@property(nonatomic,strong)NSString *fid;




@end


@interface CollectionStoreModel : NSObject

@property(nonatomic,strong)NSString *favoritesnum;
@property(nonatomic,strong)NSString *ordernum;
@property(nonatomic,strong)NSString *shopid;
@property(nonatomic,strong)NSString *shoplogo;
@property(nonatomic,strong)NSString *shopname;
@property(nonatomic,strong)NSString *fid;

@end







/*************************************************************************/

@interface LDetailedCollectionModel : NSObject

@property(nonatomic,strong)NSString *catsId;

@property(nonatomic,strong)NSString *catsName;

@property(nonatomic,strong)NSString *catsPic;



@end



