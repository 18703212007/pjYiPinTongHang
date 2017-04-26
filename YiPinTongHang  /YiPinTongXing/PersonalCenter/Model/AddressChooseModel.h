//
//  AddressChooseModel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/27.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddressChooseModel : NSObject

@property(nonatomic,strong)NSString * provinceName;
@property(nonatomic,strong)NSString * provinceID;

@property(nonatomic,strong)NSString * cityName;
@property(nonatomic,strong)NSString * cityID;

@property(nonatomic,strong)NSString * areaName;
@property(nonatomic,strong)NSString * areaID;


@end


@interface AddressGetModel : NSObject

///收货地址id
@property(nonatomic,strong)NSString * arid;
///收货人姓名
@property(nonatomic,strong)NSString * uname;
///收货人电话
@property(nonatomic,strong)NSString * utel;
///邮政编码
@property(nonatomic,strong)NSString * code;
///省市区
@property(nonatomic,strong)NSString * ar;
///详细地址
@property(nonatomic,strong)NSString * artwo;


///省级id
@property(nonatomic,strong)NSString * provinceID;
@property(nonatomic,strong)NSString * provinceName;
///城市id
@property(nonatomic,strong)NSString * cityID;
@property(nonatomic,strong)NSString * cityName;

///区县id
@property(nonatomic,strong)NSString * areaID;
@property(nonatomic,strong)NSString * areaName;


///条件（1是默认，0是非默认）
@property(nonatomic,strong)NSString * isstate;


@end
