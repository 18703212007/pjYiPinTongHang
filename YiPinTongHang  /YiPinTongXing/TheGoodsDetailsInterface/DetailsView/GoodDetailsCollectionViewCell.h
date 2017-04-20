//
//  GoodDetailsCollectionViewCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/18.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"
#import "ListModel.h"
@interface GoodDetailsCollectionViewCell : UICollectionViewCell


@property(nonatomic,strong)UIImageView *img_img;

@end


@interface ShopDetailsCollcetionViewCell : UICollectionViewCell



@property(nonatomic,strong)UIImageView *img_imgCoupons;
///条件
@property(nonatomic,strong)UILabel *lb_mprice;
///金额
@property(nonatomic,strong)UILabel *lb_jprice;
///优惠券ID
@property(nonatomic,strong)NSString *couponsID;


-(void)setCellDataWithModel:(CouponModel*)model;

@end

@interface BaseCollectionViewCell : UICollectionViewCell


@property(nonatomic,strong)UICollectionView *collectionView;


@end


@interface StoreListCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UILabel   *lb_name;

@property(nonatomic,strong)UIImageView *img_img;

@property(nonatomic,strong)NSString  *catsID;

-(void)setDataWithModel:(ListModel *)model;

@end
@interface StoreListCollViewCell : UICollectionViewCell

@property(nonatomic,strong)UILabel   *lb_name;

@property(nonatomic,strong)UIImageView *img_img;


@end
