//
//  PJCarViewModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/21.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJCarViewModel.h"
#import "PJCarModel.h"
#import "PJCarListModel.h"
@interface PJCarViewModel (){
    /**
     *  店铺的数量
     */
    NSArray *_allDataArray;
        
}
//随机获取店铺下商品数
@property (nonatomic, assign) NSInteger random;
@end

@implementation PJCarViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}



#pragma mark - make data

- (void)getData{
    //数据个数
  
    NSString *urlstring = @"m=Customer&c=Cart&a=cartList";

    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:@{@"uid":UserID} PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSInteger allGoodsCount = 0;

        _allDataArray =[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"];
        NSMutableArray *storeArray = [NSMutableArray array];
        NSMutableArray *shopSelectAarry = [NSMutableArray array];
        NSMutableArray *shopsName = [NSMutableArray array];
        NSMutableArray *shopsID = [NSMutableArray array];

        for (NSDictionary *dictionary in _allDataArray) {
            /**
             *  店铺的名字和ID
             */
            NSMutableArray *array = [NSMutableArray array];
            PJCarListModel *mod = [PJCarListModel new];
            [mod setValuesForKeysWithDictionary:dictionary];
            NSString *shopName = [dictionary objectForKey:@"shopName"];
            NSString *shopID = [dictionary objectForKey:@"shopId"];

            [shopsName addObject:shopName];
            [shopsID   addObject:shopID];
            /**
             *  商品信息
             */
            for (NSDictionary *d in [dictionary objectForKey:@"list"]) {
                allGoodsCount++;
                PJCarModel *model = [PJCarModel new];
                [model setValuesForKeysWithDictionary:d];
                [array addObject:model];
                
            }
            [storeArray addObject:array];
            [shopSelectAarry addObject:@(NO)];
        }

        self.cartData = [NSMutableArray arrayWithArray:storeArray];
        self.shopsNameData = [NSMutableArray arrayWithArray:shopsName];
        self.shopsIDData = [NSMutableArray arrayWithArray:shopsID];
        self.shopSelectArray = shopSelectAarry;
        self.cartGoodsCount = allGoodsCount;
        NSLog(@"%@",_cartData);
        [self.cartTableView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    

}

- (float)getAllPrices{
    
    __block float allPrices   = 0;
    NSInteger shopCount       = self.cartData.count;
    NSInteger shopSelectCount = self.shopSelectArray.count;
    if (shopSelectCount == shopCount && shopCount != 0) {
        self.isSelectAll = YES;
    }
    NSArray *pricesArray = [[[self.cartData rac_sequence] map:^id(NSMutableArray *value) {
        return [[[value rac_sequence] filter:^BOOL(PJCarModel *model) {
            if (!model.isSelect) {
                self.isSelectAll = NO;
            }
            return model.isSelect;
        }] map:^id(PJCarModel *model) {
            return @([model.goodsCnt integerValue]*[model.shopPrice floatValue]);
        }];
    }] array];
    for (NSArray *priceA in pricesArray) {
        for (NSNumber *price in priceA) {
            allPrices += price.floatValue;
        }
    }
    return allPrices;
}

- (void)selectAll:(BOOL)isSelect{
    
    __block float allPrices = 0;
    
    self.shopSelectArray = [[[[self.shopSelectArray rac_sequence] map:^id(NSNumber *value) {
        return @(isSelect);
    }] array] mutableCopy];
    self.cartData = [[[[self.cartData rac_sequence] map:^id(NSMutableArray *value) {
        return  [[[[value rac_sequence] map:^id(PJCarModel *model) {
            [model setValue:@(isSelect) forKey:@"isSelect"];
            if (model.isSelect) {
                allPrices += [model.goodsCnt integerValue]*[model.shopPrice floatValue];
                
            }
#warning 底部全选在这里
            /**
             *  底部全选在这
             */
            NSLog(@"%@",model);
            return model;
        }] array] mutableCopy];
    }] array] mutableCopy];
    self.allPrices = allPrices;
    [self.cartTableView reloadData];

}

- (void)rowSelect:(BOOL)isSelect IndexPath:(NSIndexPath *)indexPath{
    
    NSInteger section          = indexPath.section;
    NSInteger row              = indexPath.row;
    
    NSMutableArray *goodsArray = self.cartData[section];
    
    NSInteger shopCount        = goodsArray.count;
    
    PJCarModel *model          = goodsArray[row];
    
    [model setValue:@(isSelect) forKey:@"isSelect"];
    //判断是都到达足够数量
    NSInteger isSelectShopCount = 0;
    for (PJCarModel *model in goodsArray) {
        if (model.isSelect) {
            isSelectShopCount++;
#warning 单个选取商品的方法在这里
            /**
             *  单个选取的在这里,
             */
            NSLog(@"%@",model);
        }
    }
    [self.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelectShopCount==shopCount?YES:NO)];
    [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}
/**
 *  改变数量
 *
 *  @param quantity  数量
 *  @param indexPath indexPath
 */
- (void)rowChangeQuantity:(NSInteger)quantity indexPath:(NSIndexPath *)indexPath{
    
    NSInteger section  = indexPath.section;
    NSInteger row      = indexPath.row;
    PJCarModel *model = self.cartData[section][row];
    [model setValue:[NSString stringWithFormat:@"%ld",quantity] forKey:@"goodsCnt"];
    
    [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}

//左滑删除商品
- (void)deleteGoodsBySingleSlide:(NSIndexPath *)path{
    
    NSInteger section = path.section;
    NSInteger row     = path.row;
    
    NSMutableArray *shopArray = self.cartData[section];
    [shopArray removeObjectAtIndex:row];
    if (shopArray.count == 0) {
        /*1 删除数据*/
        [self.cartData removeObjectAtIndex:section];
        /*2 删除 shopSelectArray*/
        [self.shopSelectArray removeObjectAtIndex:section];
        [self.cartTableView reloadData];
    } else {
        //判断是都到达足够数量
        NSInteger isSelectShopCount = 0;
        NSInteger shopCount        = shopArray.count;
        for (PJCarModel *model in shopArray) {
            if (model.isSelect) {
                isSelectShopCount++;
            }
        }
        [self.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelectShopCount==shopCount?YES:NO)];
        [self.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
    }
    self.cartGoodsCount-= 1;
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}

//选中删除
- (void)deleteGoodsBySelect{
    
    /*1 删除数据*/
    NSInteger index1 = -1;
    NSMutableIndexSet *shopSelectIndex = [NSMutableIndexSet indexSet];
    for (NSMutableArray *shopArray in self.cartData) {
        index1++;
        
        NSInteger index2 = -1;
        NSMutableIndexSet *selectIndexSet = [NSMutableIndexSet indexSet];
        for (PJCarModel *model in shopArray) {
            index2++;
            if (model.isSelect) {
                [selectIndexSet addIndex:index2];
            }
        }
        NSInteger shopCount = shopArray.count;
        NSInteger selectCount = selectIndexSet.count;
        if (selectCount == shopCount) {
            [shopSelectIndex addIndex:index1];
            self.cartGoodsCount-=selectCount;
        }
        [shopArray removeObjectsAtIndexes:selectIndexSet];
    }
    [self.cartData removeObjectsAtIndexes:shopSelectIndex];
    /*2 删除 shopSelectArray*/
    [self.shopSelectArray removeObjectsAtIndexes:shopSelectIndex];
    [self.cartTableView reloadData];
    /*3 carbar 恢复默认*/
    self.allPrices = 0;
    /*重新计算价格*/
    self.allPrices = [self getAllPrices];
}



-(void)getDataWithID:(NSDictionary*)userIDDic{
    
}

@end
