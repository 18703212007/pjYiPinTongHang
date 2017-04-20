//
//  CostomView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/25.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "CostomView.h"

@interface CostomView ()<UITextFieldDelegate>

@end

@implementation CostomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.lb_name = [UILabel new];
    self.lb_name.font = [UIFont systemFontOfSize:17.0];
    self.lb_name.textAlignment = 0;
    
    [self addSubview:self.lb_name];
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.mas_equalTo(@80);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
    
    
    
    self.tf_name = [UITextField new];
    self.tf_name.delegate = self;
    self.tf_name.font = [UIFont systemFontOfSize:17.0];
    [self addSubview:self.tf_name];
    
    [self.tf_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.lb_name.mas_right).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
    
    [self addLineWithView:self.tf_name];
    
}

-(void)addLineWithView:(UIView*)view
{
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = RGB(229, 229, 229);
    
    [self addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.width.mas_equalTo(kScreen.size.width);
        make.height.mas_equalTo(@0.5);
    }];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.tf_name resignFirstResponder];
    [self.tf_name endEditing:YES];
    
    
    
}

@end
