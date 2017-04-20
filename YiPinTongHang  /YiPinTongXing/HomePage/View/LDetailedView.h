//
//  LDetailedView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/27.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>



#pragma mark - 2级分类 -
#import "HearderViewForTableView.h"
@interface ReclassifyView : UIView
@property(nonatomic,strong)HearderViewForTableView *headerView;
///
@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UIView  *topView;
///
@property(nonatomic,strong)UIImageView *img;
@property(nonatomic,strong)UIView *picView;
///
@property(nonatomic,strong)UIScrollView *scrollView;
///
@property(nonatomic,strong)UICollectionView *collectionView;
///
@property(nonatomic,strong)UITableView *tableView;


@end



@interface LDetailedView : UIView

///
@property(nonatomic,strong)UICollectionView *collectionView;


@end









