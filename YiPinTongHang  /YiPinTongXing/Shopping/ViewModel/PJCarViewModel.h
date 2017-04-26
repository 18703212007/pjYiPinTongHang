//
//  PJCarViewModel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/21.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShoppingViewController;
@class PJCarViewModel;
@protocol ViewModelDelegate <NSObject>

-(void)selectedAll:(BOOL)isSelect :(PJCarViewModel*)viewModel;
// 17050154330
@end

@interface PJCarViewModel : NSObject

@property (nonatomic, weak  ) ShoppingViewController *cartVC;
@property (nonatomic, strong) NSMutableArray         *cartData;
@property (nonatomic, strong) NSMutableArray         *shopsNameData;
@property (nonatomic, strong) NSMutableArray         *shopsIDData;

@property (nonatomic, weak  ) UITableView            *cartTableView;
/**
 *  存放店铺选中
 */
@property (nonatomic, strong) NSMutableArray         *shopSelectArray;
/**
 *  carbar 观察的属性变化
 */
@property (nonatomic, assign) float                  allPrices;
/**
 *  carbar 全选的状态
 */
@property (nonatomic, assign) BOOL                   isSelectAll;
/**
 *  购物车商品数量
 */
@property (nonatomic, assign) NSInteger              cartGoodsCount;
/**
 *  当前所选商品数量
 */
@property (nonatomic, assign) NSInteger              currentSelectCartGoodsCount;

@property (nonatomic, assign)id<ViewModelDelegate> delegate;
//获取数据
- (void)getData;

//全选
- (void)selectAll:(BOOL)isSelect;

//row select
- (void)rowSelect:(BOOL)isSelect
        IndexPath:(NSIndexPath *)indexPath;

//row change quantity
- (void)rowChangeQuantity:(NSInteger)quantity
                indexPath:(NSIndexPath *)indexPath;

//获取价格
- (float)getAllPrices;

//左滑删除商品
- (void)deleteGoodsBySingleSlide:(NSIndexPath *)path;

//选中删除
- (void)deleteGoodsBySelect;
/**
 *  数据
 */
-(void)getDataWithID:(NSDictionary*)userIDDic;

@end

