//
//  HearderViewForTableView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/6.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HearderViewForTableView;

@protocol headerViewForTableDelegate <NSObject>

-(void)headerView:(HearderViewForTableView*)headerView StringID:(NSString *)stringID Title:(NSString*)title URL:(NSString *)URL ImgString:(NSString*)imgString;

-(void)headerView:(HearderViewForTableView*)headerView CatsID:(NSString*)catsID;

@end

@interface HearderViewForTableView : UITableViewHeaderFooterView


@property(nonatomic,strong)NSArray *cycleArray;

@property(nonatomic,strong)NSString *ImgUrl;

@property(nonatomic,strong)NSArray *colArray;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,assign)id<headerViewForTableDelegate> delegate;

@end
