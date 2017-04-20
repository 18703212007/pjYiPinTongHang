//
//  OrderTableViewCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/31.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class StrikeThroughLabel;
@interface OrderTableViewCell : UITableViewCell

///商铺Logo
@property(nonatomic,strong)UIImageView           *img_shopLogo;
///商铺名字
@property(nonatomic,strong)UILabel               *lb_shopName;
/// 订单状态
@property(nonatomic,strong)UILabel               *lb_status;


///商品缩略图
@property(nonatomic,strong)UIImageView           *img_goodsImg;
///商品名
@property(nonatomic,strong)UILabel               *lb_goodsName;
///商品价格
@property(nonatomic,strong)UILabel               *lb_price;
///商品原价
@property(nonatomic,strong)StrikeThroughLabel    *lb_oldPrice;
///商品属性
@property(nonatomic,strong)UILabel               *lb_size_color;
///购买商品数量
@property(nonatomic,strong)UILabel               *lb_count;



///商品邮寄方式
@property(nonatomic,strong)UILabel               *lb_postStyle;
///总计
@property(nonatomic,strong)UILabel               *lb_total;
///总价
@property(nonatomic,strong)UILabel               *lb_totalPrice;



///联系卖家
@property(nonatomic,strong)UIButton              *btn_contact;
///订单
@property(nonatomic,strong)UIButton              *btn_order;
///付款
@property(nonatomic,strong)UIButton              *btn_pay;





@end
