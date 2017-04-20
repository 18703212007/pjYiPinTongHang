//
//  HomeView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/14.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeView : UIView
///
@property(nonatomic,strong)UIView *navView;
///
@property(nonatomic,strong)UIView *otherView;
///
@property(nonatomic,strong)UIScrollView *bgScrollView;
///
@property(nonatomic,strong)UIView *topAdsView;
///
@property(nonatomic,strong)UIView *listView;
///
@property(nonatomic,strong)UICollectionView *listCollectionView;
///
@property(nonatomic,strong)UIView *bottomAdsView;


#pragma mark - hot -
///
@property(nonatomic,strong)UIView *hotHeadView;
///
@property(nonatomic,strong)UIImageView *hotImg;
///
@property(nonatomic,strong)UIView *hotView;
///
@property(nonatomic,strong)UICollectionView *hotCollectionView;
#pragma mark - popular-
///popular
@property(nonatomic,strong)UIView *popularHeadView;
///
@property(nonatomic,strong)UIImageView *popularImg;
///
@property(nonatomic,strong)UIView *popularityView;
///
@property(nonatomic,strong)UICollectionView *popularCollectionView;

@property(nonatomic,strong)UIPageControl *pageControl;

@end




