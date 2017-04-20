//
//  HomeTableViewCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/27.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeListModel.h"


@interface ReclassifyViewCell : UITableViewCell

@end

@interface CollectionGoodsTableCell : UITableViewCell



@property(nonatomic,strong)NSString  *goodsID;

@property(nonatomic,strong)UIImageView *imgPicurl;

@property(nonatomic,strong)UILabel *goodstitle;

@property(nonatomic,strong)UILabel *orderNum;

@property(nonatomic,strong)UILabel *price;

@property(nonatomic,strong)UILabel *ispostage;
@property(nonatomic,strong)UILabel *warstock;

@property(nonatomic,strong)NSString *fid;



-(void)setCellDataWithModel:(CollectionGoodsModel*)model;



@end


@interface CollectionStroeTableCell : UITableViewCell



@property(nonatomic,strong)NSString  *shopsID;

@property(nonatomic,strong)UIImageView *shoplogo;

@property(nonatomic,strong)UILabel *title;

@property(nonatomic,strong)UILabel *favoritesnum;

@property(nonatomic,strong)NSString *fid;



-(void)setCellDataWithModel:(CollectionStoreModel*)model;



@end




