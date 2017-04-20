//
//  SetUpView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/11.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "SetUpView.h"

@implementation SetUpView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}



@end

#pragma mark - 个人信息页面 -
@implementation PersonView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(200, 200, 200, 0.3);
        [self allViews];
    }
    return self;
}


-(void)allViews{
    
    
    [self addSubview:self.navView];
    
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(screen_width, 74));
    }];
    
    UIView *view = [UIView new];
    
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.height.mas_equalTo(@385);
        make.width.mas_equalTo(screen_width);
    }];

  
    self.tableView = [[UITableView alloc]initWithFrame:rect(0, 0, 0, 0) style:UITableViewStylePlain];
    self.tableView.tableFooterView = [UIView new];

    [view addSubview: self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    self.btn_exit = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_exit.backgroundColor = [UIColor redColor];
    [self.btn_exit setTintColor:[UIColor whiteColor]];
    self.btn_exit.cornerRadius = 4;
    self.btn_exit.clipsToBounds = YES;
    [self.btn_exit setTitle:@"退出" forState:UIControlStateNormal];
    [self addSubview:self.btn_exit];
    [self.btn_exit mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(view.mas_bottom).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(15);
        make.right.equalTo(self.mas_right).with.offset(-15);
        make.height.mas_equalTo(40);
        
        
    }];
    
    
    
    
}


-(UIView *)navView{
    if (_navView == nil) {
        _navView = [UIView new];
    }
    return _navView;
}

-(UIImageView *)headImg{
    if (_headImg == nil) {
        _headImg = [UIImageView new];
    }
    return _headImg;
}



@end





