//
//  PersonalView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/8.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalView : UIView
///tableView
@property(nonatomic,strong)UITableView *personalTableView;
///头像
@property(nonatomic,strong)UIImageView *HeadImg;
///
@property(nonatomic,strong)UIButton *rightBtn1;
///
@property(nonatomic,strong)UIButton *rightBtn2;

///nickName
@property(nonatomic,strong)UILabel *nameLabel;
///
@property(nonatomic,strong)UIView *orderView;
///待付款
@property(nonatomic,strong)UIImageView *pending_payment;
///待发货
@property(nonatomic,strong)UIImageView *waiting_for_delivery;
///待收货
@property(nonatomic,strong)UIImageView *receivin_goods;
///待评价
@property(nonatomic,strong)UIImageView *pending_evauation;
///退换/售后
@property(nonatomic,strong)UIImageView *customer_service;






@end
