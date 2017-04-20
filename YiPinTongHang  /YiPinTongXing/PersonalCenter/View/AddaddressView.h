//
//  AddaddressView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/25.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CostomView;
@class PJTextView;
@interface AddaddressView : UIView
///收件人
@property(nonatomic,strong) CostomView *consigneeView;
///电话号码
@property(nonatomic,strong) CostomView *phoneNumView;

@property(nonatomic,strong) UILabel *lb_area;
///所在区域
@property(nonatomic,strong) UILabel *lb_pro_city_area;

@property(nonatomic,strong) UIImageView *img_img;
///详细地址
@property(nonatomic,strong) PJTextView *detailsTxetView;

@end
