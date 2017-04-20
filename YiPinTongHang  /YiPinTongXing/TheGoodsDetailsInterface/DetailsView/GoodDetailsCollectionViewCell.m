//
//  GoodDetailsCollectionViewCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/18.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "GoodDetailsCollectionViewCell.h"

@implementation GoodDetailsCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.img_img  = [UIImageView new];
        self.img_img.contentMode = UIViewContentModeScaleAspectFit;
        self.img_img.userInteractionEnabled = YES;
        
        [self.contentView addSubview: self.img_img];
        [self.img_img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).with.offset(2);
            make.left.equalTo(self.contentView.mas_left).with.offset(0);
            make.right.equalTo(self.contentView.mas_right).with.offset(0);
            make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        }];
    }
    return self;
}


@end

@interface ShopDetailsCollcetionViewCell ()



@end


@implementation ShopDetailsCollcetionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}
-(void)setUI{
    
    
    self.img_imgCoupons  = [UIImageView new];
    self.img_imgCoupons.contentMode = UIViewContentModeScaleAspectFit;
    self.img_imgCoupons.userInteractionEnabled = YES;
    self.img_imgCoupons.image = [UIImage imageNamed:@"shop_coupons"];
    [self.contentView addSubview: self.img_imgCoupons];
    [self.img_imgCoupons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(4);
        make.left.equalTo(self.mas_left).with.offset(2);
        make.right.equalTo(self.mas_right).with.offset(-2);
        make.bottom.equalTo(self.mas_bottom).with.offset(-4);
    }];
    
    
    self.lb_jprice = [UILabel new];
    self.lb_jprice.textAlignment = NSTextAlignmentCenter;
    
    self.lb_jprice.font = [UIFont systemFontOfSize:14.0];
    self.lb_jprice.textColor = [UIColor lightTextColor];
    [self.img_imgCoupons addSubview:self.lb_jprice];
    [self.lb_jprice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.img_imgCoupons);
        make.top.equalTo(self.img_imgCoupons.mas_top).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(80, 14));
    }];
    
    self.lb_mprice = [UILabel new];
    self.lb_mprice.textAlignment = NSTextAlignmentLeft;
    self.lb_mprice.font = [UIFont systemFontOfSize:13.0];
    //    self.lb_mprice.numberOfLines = 0;
    self.lb_mprice.adjustsFontSizeToFitWidth = YES;
    self.lb_mprice.textColor = [UIColor lightTextColor];
    [self.img_imgCoupons addSubview:self.lb_mprice];
    [self.lb_mprice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img_imgCoupons.mas_left).with.offset(3);
        make.top.equalTo(self.lb_jprice.mas_bottom).with.offset(0);
        make.right.equalTo(self.img_imgCoupons.mas_right).with.offset(-3);
        make.height.mas_equalTo(40);
    }];
    
    
}

-(void)setCellDataWithModel:(CouponModel *)model
{
    self.lb_jprice.text = [NSString stringWithFormat:@"¥:%@",model.jprice];
    self.lb_mprice.text = model.mprice;
    self.couponsID = model.couid;
}

@end



@implementation BaseCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}



-(void)setUI{
    
    
    
}
@end


@implementation StoreListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        
        self.alpha = 0.5f;
        
        [self setUI];
    }
    return self;
}



-(void)setUI{
    self.lb_name = [UILabel new];
    
    self.lb_name.textAlignment = NSTextAlignmentLeft;
    
    [self.contentView addSubview:self.lb_name];
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.height.mas_equalTo(@50);
        
    }];
    
    
    
}

-(void)setDataWithModel:(ListModel *)model{
    
    self.lb_name.text = model.catsName;
    
    self.catsID = model.catsId;
    
    
}


@end

@implementation StoreListCollViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self setUI];
    }
    return self;
}



-(void)setUI{
    self.lb_name = [UILabel new];
    
    self.lb_name.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.lb_name];
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(200, 50));
        
    }];
    //
    self.img_img = [UIImageView new];
    self.img_img.contentMode = UIViewContentModeScaleAspectFit;
    self.img_img.image = [UIImage imageNamed:@"personal_enter.png"];
    [self.contentView addSubview:self.img_img];
    [self.img_img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.size.mas_equalTo(CGSizeMake(9, 15));
    }];
    
    
}
@end


