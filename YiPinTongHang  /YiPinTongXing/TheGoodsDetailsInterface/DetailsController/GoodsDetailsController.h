//
//  GoodsDetailsController.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#pragma mark - 详情页的VC -
@interface GoodsDetailsController : UIViewController
///商品ID
@property(nonatomic,strong)NSString *goodsID;


@property(nonatomic,strong)NSMutableArray *SKUResult;

@end


