//
//  NickNameView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/15.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "NickNameView.h"

@implementation NickNameView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.tf_nickName = [UITextField new];
        self.tf_nickName.placeholder = @"请输入姓名(4-8个字符)";
        self.tf_nickName.adjustsFontSizeToFitWidth = YES;
        self.tf_nickName.borderWidth = 0.3;
        self.tf_nickName.borderColor =RGBA(180, 180, 180, 0.2);
        self.tf_nickName.cornerRadius = 4;
        self.tf_nickName.clipsToBounds = YES;
        [self addSubview:self.tf_nickName];
        [self.tf_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.mas_top).with.offset(10);
            make.left.equalTo(self.mas_left).with.offset(10);
            make.right.equalTo(self.mas_right).with.offset(-10);
            make.height.mas_equalTo(80);
            
        }];
        
        
        self.bt_sure = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bt_sure setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:self.bt_sure];
        [self.bt_sure mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.tf_nickName.mas_bottom).with.offset(15);
            make.right.equalTo(self.tf_nickName);
            make.size.mas_equalTo(CGSizeMake(self.tf_nickName.width/2.0, 50));

        }];
        self.bt_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.bt_cancel setTitle:@"确定" forState:UIControlStateNormal];
        [self addSubview:self.bt_cancel];
        [self.bt_cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.tf_nickName.mas_bottom).with.offset(15);
            make.left.equalTo(self.tf_nickName);
            make.size.mas_equalTo(CGSizeMake(self.tf_nickName.width/2.0, 50));
            
        }];
        
        
    }
    return self;
}






@end
