//
//  BottomView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "BottomView.h"

@implementation BottomView

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
    
    
    self.btn_service = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_service setBackgroundImage:[UIImage imageNamed:@"service.png"] forState:UIControlStateNormal];
    [self addSubview:self.btn_service];
    self.btn_service.contentMode = UIViewContentModeScaleAspectFit;
    [self.btn_service mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.width.mas_equalTo(51);
        make.height.mas_equalTo(50);

    }];
    

    
    self.btn_shop = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_shop setBackgroundImage:[UIImage imageNamed:@"shop.png"] forState:UIControlStateNormal];
    [self addSubview:self.btn_shop];
    self.btn_shop.contentMode = UIViewContentModeScaleAspectFit;

    [self.btn_shop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.btn_service.mas_right).with.offset(0);
        make.width.mas_equalTo(51);
        make.height.mas_equalTo(50);
        
    }];

    
    self.btn_collection = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_collection setBackgroundImage:[UIImage imageNamed:@"collection.png"] forState:UIControlStateNormal];
    [self.btn_collection setBackgroundImage:[UIImage imageNamed:@"collected.png"] forState:UIControlStateSelected];
    self.btn_collection.contentMode = UIViewContentModeScaleAspectFit;

    [self addSubview:self.btn_collection];
    [self.btn_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.btn_shop.mas_right).with.offset(-1);
        make.width.mas_equalTo(51);
        make.height.mas_equalTo(50);
        
    }];
    
    self.btn_addBasket = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_addBasket.backgroundColor = [UIColor colorWithHexString:@"#ffb129"];
    self.btn_addBasket.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self.btn_addBasket setTitle:@"加入购物车" forState:UIControlStateNormal];
    [self addSubview:self.btn_addBasket];
    [self.btn_addBasket mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.btn_collection.mas_right).with.offset(0);
//        make.width.mas_equalTo((screen_width-150)/2.0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(50);
        
    }];
    
    
    
    self.btn_buyNow = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_buyNow setTitle:@"立即购买" forState:UIControlStateNormal];
    self.btn_buyNow.titleLabel.font = [UIFont systemFontOfSize:15.0];

    self.btn_buyNow.backgroundColor = [UIColor colorWithHexString:@"cf292e"];

    
//    [self addSubview:self.btn_buyNow];
//    [self.btn_buyNow mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).with.offset(0);
//        make.right.equalTo(self.mas_right).with.offset(0);
//        make.width.mas_equalTo((screen_width-150)/2.0);
//        make.height.mas_equalTo(50);
//        
//    }];
    
    
    
}




@end
