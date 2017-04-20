//
//  PersonalTableViewCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/11.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalTableViewCell : UITableViewCell
///
@property(nonatomic,strong)UIImageView *img;
///
@property(nonatomic,strong)UILabel *showLabel;

@end


@interface PreMessageHeaderTableViewCell : UITableViewCell
///
@property(nonatomic,strong)UIImageView *imgHeader;

@end

@interface PreMessageTableViewCell : UITableViewCell
///
@property(nonatomic,strong)UILabel *showLabel;

@end



@interface PersonalHeaderCell : UITableViewCell

@property(nonatomic,strong)UIImageView *img_bgImg;
///
@property(nonatomic,strong)UIImageView *img_headerImg;

@property(nonatomic,strong)UILabel  *lb_nickName;

@property(nonatomic,strong)UIButton *btn_exits;

@property(nonatomic,strong)UIButton  *btn_message;

@end

#import "AddressChooseModel.h"

@class AddressTableViewCell;
@class PJButton;

typedef void(^deleteBlock)(AddressTableViewCell *cell);

@interface AddressTableViewCell : UITableViewCell

@property(nonatomic,strong)NSString        *arid;

@property(nonatomic,strong)UILabel         *lb_nickName;

@property(nonatomic,strong)UILabel         *lb_phoneNum;


@property(nonatomic,strong)UILabel         *lb_addressDetails;


@property(nonatomic,strong)UIButton        *btn_dafault;
@property(nonatomic,strong)UILabel         *lb_dafault;

@property(nonatomic,strong)PJButton        *btn_editing;

@property(nonatomic,strong)PJButton        *btn_delete;

@property(nonatomic,strong)AddressGetModel *model;

@property(nonatomic,copy  )deleteBlock     block;


@property(nonatomic,strong)NSString *ar;

@property(nonatomic,strong)NSString *artwo;



@end


@class PersonalCouponModel;
@interface CouponTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *img_bgImg;

@property(nonatomic,strong)UILabel     *lb_shopName;

@property(nonatomic,strong)UILabel     *lb_jPrice;

@property(nonatomic,strong)UILabel     *lb_mPrice;

@property(nonatomic,strong)UILabel     *lb_date;

@property(nonatomic,strong)NSString    *shopID;

@property(nonatomic,strong)NSString    *couID;

@property(nonatomic,strong)PersonalCouponModel *model;


@end

@class PersonalCouponModel;
@interface ShopsCouponTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView *img_bgImg;

@property(nonatomic,strong)UILabel     *lb_jPrice;

@property(nonatomic,strong)UILabel     *lb_mPrice;

@property(nonatomic,strong)UILabel     *lb_date;

@property(nonatomic,strong)NSString    *shopID;

@property(nonatomic,strong)NSString    *couID;

@property(nonatomic,strong)PersonalCouponModel *model;


@end











