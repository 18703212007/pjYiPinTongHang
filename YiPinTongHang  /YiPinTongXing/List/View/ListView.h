//
//  ListView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/9.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListView : UIView

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UITableView *leftTableView;

@property(nonatomic,strong)UICollectionView* rightCollectionView;


@end


@interface ListSecoundView : UIView


@property(nonatomic,strong)UICollectionView *collectionView;

@end
