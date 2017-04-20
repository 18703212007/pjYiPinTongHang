//
//  MyStoreNavView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/22.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "MyStoreNavView.h"
#import "PJButton.h"
@implementation MyStoreNavView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0;
        self.baseView = [UIView new];
        self.baseView.backgroundColor = RGBA(100, 50, 36, 0.4);
        self.baseView.layer.cornerRadius = 5.0;
        [self addSubview:self.baseView];
        [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.width.mas_equalTo(@110);
            make.height.mas_equalTo(@168);
            
        }];
        
        
        
        //        70 0 110  168
        
        
        self.bt_message = [[PJButton alloc]initWithFrame:CGRectZero Image:[UIImage imageNamed:@"more_news"] Message:@"消息"];
        [self.baseView addSubview:self.bt_message];
        //    self.bt_message.frame = rect(0, 0, 110, 42);
        [self.bt_message mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.baseView.mas_top).with.offset(0);
            make.left.equalTo(self.baseView.mas_left).with.offset(0);
            make.right.equalTo(self.baseView.mas_right).with.offset(0);
            make.height.mas_equalTo(@42);
            
        }];
        
        self.bt_homePage = [[PJButton alloc]initWithFrame:CGRectZero Image:[UIImage imageNamed:@"more_home_page"] Message:@"首页"];
        [self.baseView addSubview:self.bt_homePage];
        //        self.bt_homePage.frame = rect(0, 42, 110, 42);
        
        [self.bt_homePage mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.bt_message.mas_bottom).with.offset(0);
            make.left.equalTo(self.baseView.mas_left).with.offset(0);
            make.right.equalTo(self.baseView.mas_right).with.offset(0);
            make.height.mas_equalTo(@42);
            
        }];
        
        self.bt_share = [[PJButton alloc]initWithFrame:CGRectZero Image:[UIImage imageNamed:@"more_share"] Message:@"分享"];
        [self.baseView addSubview:self.bt_share];
        //        self.bt_share.frame = rect(0, 84, 110, 42);
        
        [self.bt_share mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.bt_homePage.mas_bottom).with.offset(0);
            make.left.equalTo(self.baseView.mas_left).with.offset(0);
            make.right.equalTo(self.baseView.mas_right).with.offset(0);
            make.height.mas_equalTo(@42);
            
        }];
        
        self.bt_storeIntroduction = [[PJButton alloc]initWithFrame:CGRectZero Image:[UIImage imageNamed:@"more_shop"] Message:@"店铺简介"];
        [self.baseView addSubview:self.bt_storeIntroduction];
        self.bt_storeIntroduction.line.hidden = YES;
        //        self.bt_storeIntroduction.frame = rect(0, 126, 110, 32);
        
        [self.bt_storeIntroduction mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.bt_share.mas_bottom).with.offset(0);
            make.left.equalTo(self.baseView.mas_left).with.offset(0);
            make.right.equalTo(self.baseView.mas_right).with.offset(0);
            make.height.mas_equalTo(@42);
            
        }];
        
    }
    return self;
}



@end
