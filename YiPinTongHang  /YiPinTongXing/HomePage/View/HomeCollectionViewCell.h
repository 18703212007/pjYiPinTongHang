//
//  HomeCollectionViewCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/17.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "HomeListModel.h"
#pragma mark - ** 人气 ** 横向滑动的collectionView -

@interface PopularCollectionViewCell : UICollectionViewCell


@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)UILabel *textLab;

@property(nonatomic,strong)UILabel *priceLabel;

@property(nonatomic,strong)UILabel *orderNum;

@property(nonatomic,strong)NSString *goodsID;

-(void)setDataViewModel:(HomeModel*)model;

@end


#pragma mark - ** 热门 ** 横向滑动的collectionView -
@interface HorizontalCollectionViewCell : UICollectionViewCell


@property(nonatomic,strong)UIImageView *imgHorCollect;
@property(nonatomic,strong)UILabel  *labHorCollect;
@property(nonatomic,strong)NSString *goodsID;

-(void)setDataViewModel:(HorCollectModel*)model;

@end


#pragma mark - ** 分类 **  -
@interface ListCVCell : UICollectionViewCell


@property(nonatomic,strong)UIImageView *imgView;

@property(nonatomic,strong)UILabel *nameLabel;
///就是CatsID
@property(nonatomic,strong)NSString *catsID;
-(void)setDataViewModel:(ListCollectModel*)model;

@end


#pragma mark - ** 3级分类 **  -
@interface LDetailedCollectionViewCell : UICollectionViewCell


@property(nonatomic,strong)UILabel *title;

//@property(nonatomic,strong)UIImageView *img;


@property(nonatomic,strong)NSString *catsID;



-(void)setDataViewModel:(LDetailedCollectionModel*)model;

@end


#pragma mark  - 展示的CollectionCell -
@interface LDetailedColViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *imgPicurl;//picurl

@property(nonatomic,strong)UILabel *price;//price

@property(nonatomic,strong)UILabel *title;//gName

@property(nonatomic,strong)UILabel *orderNum;//orderNum

@property(nonatomic,strong)NSString *goodsID;//gId

@property(nonatomic,strong)UILabel *warStock;//warstock


-(void)setDataWithModel:(CollectionGoodsModel*)model;

@end



#pragma mark - ** 分类 **  -
@interface ReclassifyCollectionViewCell : UICollectionViewCell


@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)NSString *catsId;



-(void)setDataViewModel:(HomeListModel*)model;

@end


#pragma mark - 选项Cell -
@interface BtnCollectionViewCell : UICollectionViewCell



@property(nonatomic,strong)UILabel *title;

@property(nonatomic,strong)UIView *line;

@end




