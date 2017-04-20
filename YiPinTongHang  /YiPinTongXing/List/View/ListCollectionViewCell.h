//
//  ListCollectionViewCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
@interface ListCollectionViewCell : UICollectionViewCell

@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)UILabel *nameCollection;

@property(nonatomic,strong)NSString *catsID;

-(void)setDataWithModel:(ListModel*)model;
@end
