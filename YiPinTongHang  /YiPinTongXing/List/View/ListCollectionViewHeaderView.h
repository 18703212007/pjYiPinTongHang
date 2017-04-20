//
//  ListCollectionViewHeaderView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListCollectionViewHeaderView : UICollectionReusableView


@property(nonatomic,strong) UILabel *title;

@end

@class ListThirdCollectionHeaderView;
@protocol listThirdHeaderViewDelegate <NSObject>

-(void)listThirdHeaderView:(ListThirdCollectionHeaderView*)listThirdHeaderView Dictionary:(NSDictionary*)dic;

-(void)listThirdHeaderView:(ListThirdCollectionHeaderView *)listThirdHeaderView Flag:(NSDictionary *)flag;


@end

@interface ListThirdCollectionHeaderView : UICollectionReusableView

@property(nonatomic,assign)id<listThirdHeaderViewDelegate>delegate;

@property(nonatomic,strong)NSArray *topColArray;

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UIView *sortView;

@property(nonatomic,strong)UICollectionView *btnCollectionView;

@property(nonatomic,strong)UIButton *compBtn;

@property(nonatomic,strong)UIButton *salesBtn;

@property(nonatomic,strong)UIButton *newfoodsBtn;

@property(nonatomic,strong)UIButton *priceBtn;

@property(nonatomic,strong)UIButton *backBtn;

@end


@class listDetailedColHeaderView;

@protocol listDetailedColHeaderViewDelegate <NSObject>

-(void)listHeaderView:(listDetailedColHeaderView *)listThirdView Flag:(NSDictionary *)flag;



@end


@interface listDetailedColHeaderView : UICollectionReusableView

@property(nonatomic,assign)id<listDetailedColHeaderViewDelegate> delegate;

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UICollectionView *btnCollectionView;

@property(nonatomic,strong)UIView *sortView;

@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)UILabel *lb_title;

@property(nonatomic,strong)NSString *catsID;

@property(nonatomic,strong)NSString *shopID;



@end

