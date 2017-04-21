//
//  PJCarTableViewCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PJCarModel,PJNumberCount;
@interface PJCarTableViewCell : UITableViewCell
/**
 *  选择的Btn
 */
@property (weak, nonatomic) IBOutlet UIButton *SelectShopGoodsButton;
/**
 *  商品图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *img_goodsImg;
/**
 *  购买的数量
 */
@property (weak, nonatomic) IBOutlet PJNumberCount *numberCount;
/**
 *  商品名字
 */
@property (weak, nonatomic) IBOutlet UILabel *lb_goodsName;
/**
 *  商品的价格
 */
@property (weak, nonatomic) IBOutlet UILabel *lb_goodsPrice;
/**
 *  商品的市场价格
 */
@property (weak, nonatomic) IBOutlet UILabel *lb_goodsOldPrice;
/**
 *  商品的属性
 */
@property (weak, nonatomic) IBOutlet UILabel *lb_goodsAttr;


@property (nonatomic, strong) PJCarModel *model;

+ (CGFloat)getCartCellHeight;
@end
