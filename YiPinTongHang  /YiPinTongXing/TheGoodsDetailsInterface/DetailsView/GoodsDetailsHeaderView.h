//
//  GoodsDetailsHeaderView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoodsDetailsHeaderView;
@protocol goodsDetailsHeaderDelegate <NSObject>

-(void)goodsDetailsHeaderView:(GoodsDetailsHeaderView*)headerView Selectindex:(NSInteger)index;

@end


@interface GoodsDetailsHeaderView : UITableViewHeaderFooterView


@property(nonatomic,strong)UIView      *headView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)SDCycleScrollView *sdCycleScro;

@property(nonatomic,strong)NSArray *imgArray;

@property(nonatomic,assign)id<goodsDetailsHeaderDelegate> delegate;


@end

@interface GoodsDetailsFooterView :UITableViewHeaderFooterView

@end
@interface GoodsDetailsCostomHeaderView :UITableViewHeaderFooterView

@property(nonatomic,assign)CGFloat  high;

@end

