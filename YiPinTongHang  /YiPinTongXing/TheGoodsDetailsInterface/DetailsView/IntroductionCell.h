//
//  IntroductionCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/22.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionCell : UITableViewCell


@end

@interface IntroductionTopCell : UITableViewCell

@property(nonatomic,strong)UIImageView *img_shopLogo;

@property(nonatomic,strong)UILabel     *lb_shopName;

@property(nonatomic,strong)UILabel     *lb_favorites;


//@property(nonatomic,strong)UIButton    *btn_collection;

@end

@interface IntroductionBottomCell : UITableViewCell

@property(nonatomic,strong)UILabel     *lb_name;

@property(nonatomic,strong)UILabel     *lb_subName;


@end
@interface IntroductionMidCell : UITableViewCell

@property(nonatomic,strong)UILabel     *lb_nameSh;
@property(nonatomic,strong)UILabel     *lb_shop;

@property(nonatomic,strong)UILabel     *lb_nameSe;
@property(nonatomic,strong)UILabel     *lb_service;

@property(nonatomic,strong)UILabel     *lb_nameQu;
@property(nonatomic,strong)UILabel     *lb_quality;

@end


@interface IntroductionOtherCell : UITableViewCell

@property(nonatomic,strong)UIImageView *img_rightImg;

@property(nonatomic,strong)UILabel     *lb_name;

@property(nonatomic,strong)UIImageView *img_codeTap;


@end
