//
//  AddaddressView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/25.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "AddaddressView.h"
#import "CostomView.h"
#import "PJTextView.h"
@implementation AddaddressView

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
    
    self.consigneeView = [[CostomView alloc]initWithFrame:CGRectZero];
    [self addSubview:self.consigneeView];
    self.consigneeView.lb_name.text = @"收货人:";
    self.consigneeView.tf_name.placeholder = @"请输入收货人姓名";
    [self.consigneeView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@50);
        
    }];
    self.phoneNumView = [[CostomView alloc]initWithFrame:CGRectZero];
    self.phoneNumView.lb_name.text = @"手机号码:";
    self.phoneNumView.tf_name.placeholder = @"请输入收货人联系电话";
    self.phoneNumView.tf_name.keyboardType = UIKeyboardTypeNumberPad;
    [self addSubview:self.phoneNumView];
    
    [self.phoneNumView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.consigneeView.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@50);
        
    }];
    
    self.lb_area = [[UILabel alloc]initWithFrame:CGRectZero];
    self.lb_area.text = @"所在地区";
    [self addSubview:self.lb_area];
    
    [self.lb_area mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.phoneNumView.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.mas_equalTo(@85);
        make.height.mas_equalTo(@50);
        
    }];
    
    self.img_img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_enter"]];
    self.img_img.contentMode = UIViewContentModeScaleAspectFit;
    
    [self addSubview:self.img_img];
    
    [self.img_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.phoneNumView.mas_bottom).with.offset(11);
        make.right.equalTo(self.mas_right).with.offset(-8);
        make.size.mas_equalTo(CGSizeMake(19, 28));
        
    }];
    
    
    self.lb_pro_city_area = [[UILabel alloc]initWithFrame:CGRectZero];
    self.lb_pro_city_area.numberOfLines = 0;
    self.lb_pro_city_area.font = [UIFont systemFontOfSize:15.0];
    self.lb_pro_city_area.adjustsFontSizeToFitWidth  = YES;
    self.lb_pro_city_area.userInteractionEnabled = YES;
    [self addSubview:self.lb_pro_city_area];
    
    [self.lb_pro_city_area mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.phoneNumView.mas_bottom).with.offset(0);
        make.left.equalTo(self.lb_area.mas_right).with.offset(0);
        make.right.equalTo(self.img_img.mas_left).with.offset(0);
        make.height.mas_equalTo(@50);
        
    }];
    
    //    UILabel *line = [UILabel new];
    //    line.backgroundColor = RGB(229, 229, 229);
    //    [self addSubview:line];
    //     [line mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //         make.top.equalTo(self.lb_pro_city_area.mas_bottom).with.offset(0);
    //         make.left.equalTo(self.mas_left).with.offset(0);
    //         make.size.mas_equalTo(CGSizeMake(screen_width, 1));
    //
    //     }];
    
    self.detailsTxetView = [[PJTextView alloc]initWithFrame:CGRectZero];
    self.detailsTxetView.myPlacehloder = @"请填写详细地址";
    self.detailsTxetView.borderColor = RGB(229, 229, 229);
    self.detailsTxetView.borderWidth = 0.5;
    [self addSubview:self.detailsTxetView];
    [self.detailsTxetView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_pro_city_area.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(2);
        make.right.equalTo(self.mas_right).with.offset(-2);
        make.height.mas_equalTo(@100);
        
    }];
    
    
    
    
    
}

@end
