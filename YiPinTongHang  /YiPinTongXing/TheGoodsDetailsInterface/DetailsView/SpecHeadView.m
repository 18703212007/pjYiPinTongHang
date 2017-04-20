//
//  SpecHeadView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "SpecHeadView.h"

@implementation SpecHeadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:17.0];
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(8);
        make.size.mas_equalTo(CGSizeMake(50, 18));
        
    }];
    self.alertLabel = [UILabel new];
    self.alertLabel.textColor = RGBA(228, 23, 71, 0.7);
    self.alertLabel.text = @"*温馨提示:每项均为必选哦。";
    self.alertLabel.font = [UIFont systemFontOfSize:10.0];
    self.alertLabel.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.alertLabel];
    
    [self.alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(150, 12));
        
    }];
    self.specInfo = [UILabel new];
    self.specInfo.font = [UIFont systemFontOfSize:10.0];
    self.specInfo.adjustsFontSizeToFitWidth = YES;
    [self addSubview:self.specInfo];
    
    [self.specInfo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.nameLabel);
        make.left.equalTo(self.nameLabel.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(150, 12));
        
    }];
    
}

@end
