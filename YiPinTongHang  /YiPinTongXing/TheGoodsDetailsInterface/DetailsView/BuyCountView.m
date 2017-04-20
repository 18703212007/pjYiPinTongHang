//
//  BuyCountView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/16.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "BuyCountView.h"

@implementation BuyCountView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}


-(void)setUI{
    self.lb_count = [UILabel new];
    self.lb_count.text = @"购买数量";
    self.lb_count.font = [UIFont systemFontOfSize:14.0];
    [self addSubview:self.lb_count];
    [self.lb_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@30);
    }];
    
    self.bt_add = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bt_add setBackgroundColor:[UIColor colorWithHexString:@"#f0f0f0"]];
    [self.bt_add setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.bt_add setTitle:@"+" forState:UIControlStateNormal];
    self.bt_add.titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.bt_add];
    [self.bt_add mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@30);
    }];
    self.tf_count = [UITextField new];
    self.tf_count.text = @"1";
    self.tf_count.textAlignment = NSTextAlignmentCenter;
    self.tf_count.font = [UIFont systemFontOfSize:15.0];
    self.tf_count.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self addSubview:self.tf_count];
    [self.tf_count mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(10);
        make.right.equalTo(self.self.bt_add.mas_left).with.offset(-10);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@30);
        
    }];
    
    
    
    
    self.bt_reduce = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bt_reduce setBackgroundColor:[UIColor colorWithHexString:@"#f0f0f0"]];
    [self.bt_reduce setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.bt_reduce setTitle:@"-" forState:UIControlStateNormal];
    self.bt_reduce.titleLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:self.bt_reduce];
    [self.bt_reduce mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(10);
        make.right.equalTo(self.tf_count.mas_left).with.offset(-10);
        make.width.mas_equalTo(@40);
        make.height.mas_equalTo(@30);
    }];
    UILabel *line = [UILabel new];
    line.backgroundColor  = [UIColor lightGrayColor];
    [self addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.width.mas_equalTo(screen_width);
        make.height.mas_equalTo(@0.5);
    }];
    

    
}

@end
