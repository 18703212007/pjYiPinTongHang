//
//  PJCarModel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PJCarListModel;
@interface PJCarModel : NSObject
/**
 *  店铺ID
 */
@property(nonatomic,strong)NSString *shopId;
/**
 *  店铺名
 */
@property(nonatomic,strong)NSString *shopName;
/**
 *  列表
 */
@property(nonatomic,strong)PJCarListModel *list;
/**
 *  商品是否被选中
 */
@property(nonatomic,assign)BOOL    isSelect;




@end
