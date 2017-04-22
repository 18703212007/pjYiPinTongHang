//
//  PJCarViewModel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/21.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJCarViewModel.h"
#import "PJCarModel.h"
@interface PJCarViewModel (){
    /**
     *  店铺的数量
     */
    NSArray *_allDataArray;
    /**
     *  店铺商品数量
     */
    NSArray *_shopGoodsCount;
    /**
     *  图片组
     */
    NSArray *_goodsPicArray;
    /**
     *  价格组
     */
    NSArray *_goodsPriceArray;
    /**
     *  商品描述组
     */
    NSArray *_goodsAttrsArray;
    /**
     *  <#Description#>
     */
    NSArray *_goodsCountArray;
    
}
//随机获取店铺下商品数
@property (nonatomic, assign) NSInteger random;
@end

@implementation PJCarViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        //6
        _shopGoodsCount      = @[@(1),@(8),@(5),@(2),@(4),@(4)];
        _goodsAttrsArray     = @[@"蓝色",@"白色",@"黑色",@"天蓝色",@"藏青色",@"卡其色"];
        _goodsPicArray       = @[@"http://pic.5tu.cn/uploads/allimg/1606/pic_5tu_big_2016052901023305535.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1605/pic_5tu_big_2016052901023303745.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1605/pic_5tu_big_201605291711245481.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1605/pic_5tu_big_2016052901023285762.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1506/091630516760.jpg",
                            @"http://pic.5tu.cn/uploads/allimg/1506/091630516760.jpg"];
        _goodsPriceArray = @[@(30.45),@(120.09),@(7.8),@(11.11),@(56.1),@(12)];
        _goodsCountArray = @[@(12),@(21),@(1),@(10),@(3),@(5)];
        [self getDataWithID:@{@"uid":UserID}];

    }
    return self;
}

- (NSInteger)random{
    
    NSInteger from = 0;
    NSInteger to   = 5;
    
    return (NSInteger)(from + (arc4random() % (to - from + 1)));
    
}

#pragma mark - make data

- (void)getData{
    //数据个数
    NSInteger allCount = 20;
    NSInteger allGoodsCount = 0;
    NSMutableArray *storeArray = [NSMutableArray arrayWithCapacity:allCount];
    NSMutableArray *shopSelectAarry = [NSMutableArray arrayWithCapacity:allCount];
    //创造店铺数据
    for (int i = 0; i<allCount; i++) {
        //创造店铺下商品数据
        NSInteger goodsCount = [_shopGoodsCount[self.random] intValue];
        NSMutableArray *goodsArray = [NSMutableArray arrayWithCapacity:goodsCount];
        for (int x = 0; x<goodsCount; x++) {
            PJCarModel *carModel  = [[PJCarModel alloc] init];
            carModel.goodsId         = @"122115465400";
//            carModel.shopName       = @"1234ergdvsf";
            carModel.shopPrice        = [_goodsPriceArray[self.random] floatValue];
            carModel.marketPrice      = [_goodsPriceArray[self.random] floatValue]+10;
            carModel.goodsName        = [NSString stringWithFormat:@"%@这是一个很长很长的名字呀呀呀呀呀呀",@(x)];
            carModel.goodsStock       = 22;
            carModel.goodsImg   = _goodsPicArray[self.random];
            carModel.goodsCnt   = [_goodsCountArray[self.random] integerValue];
            carModel.goodsVal   = _goodsAttrsArray[self.random];
            
            [goodsArray addObject:carModel];
            allGoodsCount++;
        }
        [storeArray addObject:goodsArray];
        [shopSelectAarry addObject:@(NO)];
    }
    self.cartData = storeArray;
    self.shopSelectArray = shopSelectAarry;
    self.cartGoodsCount = allGoodsCount;
    NSLog(@"self.cartGoodsCount:%ld",self.cartGoodsCount);
}

- (float)getAllPrices{
    
    __block float allPrices   = 0;
    NSInteger shopCount       = self.cartData.count;
    NSInteger shopSelectCount = self.shopSelectArray.count;
    if (shopSelectCount == shopCount && shopCount!=0) {
        self.isSelectAll = YES;
    }
    NSArray *pricesArray = [[[self.cartData rac_sequence] map:^id(NSMutableArray *value) {
        return [[[value rac_sequence] filter:^BOOL(PJCarModel *model) {
            if (!model.isSelect) {
                self.isSelectAll = NO;
            }
            return model.isSelect;
        }] map:^id(PJCarModel *model) {
            return @(model.goodsCnt*model.shopPrice);
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
                allPrices += model.goodsCnt*model.shopPrice;
            }
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
    
    [model setValue:@(quantity) forKey:@"p_quantity"];
    
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
    self.cartGoodsCount-=1;
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
    
    NSString *urlstring = @"m=Customer&c=Cart&a=cartList";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:userIDDic PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSLog(@"%@",[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"] );
        _allDataArray =[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"];
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

@end
