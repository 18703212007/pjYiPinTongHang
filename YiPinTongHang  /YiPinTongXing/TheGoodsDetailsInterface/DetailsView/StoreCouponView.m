//
//  StoreCouponView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/2.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "StoreCouponView.h"
#import "PersonalTableViewCell.h"
#import "PersonalCouponModel.h"
@interface StoreCouponView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end


@implementation StoreCouponView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.alphaView = [UIView new];
    self.alphaView.backgroundColor = [UIColor blackColor];
    self.alphaView.alpha = 0.8;
    [self addSubview:self.alphaView];
    [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(screen_width, screen_height));
        
    }];
    
    self.whiteView = [UIView new];
    
    self.whiteView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.whiteView];
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
//    [self.whiteView addGestureRecognizer:tap];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(screen_height*0.25);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(screen_width, screen_height*0.75));
    }];
    
    
    self.bt_cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.whiteView addSubview:self.bt_cancle];
    [self.bt_cancle setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [self.bt_cancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.whiteView.mas_top).with.offset(40);
        make.left.equalTo(self.whiteView.mas_right).with.offset(-40);
        make.size.mas_equalTo(CGSizeMake(30 , 30));
    }];

    UILabel *label = [UILabel new];
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    [self.whiteView addSubview:label];
    label.text = @"店铺优惠券";
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.equalTo(self.whiteView);
        make.top.equalTo(self.whiteView.mas_top).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(200, 50));
        
    }];
    
    self.bt_sure =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bt_sure setBackgroundColor:[UIColor redColor]];
    [self.bt_sure setTitle:@"确定" forState:UIControlStateNormal];
    self.bt_sure.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.whiteView addSubview:self.bt_sure];
    [self.bt_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.whiteView.mas_bottom).with.offset(0);
        make.left.equalTo(self.whiteView.mas_left).with.offset(0);
        make.right.equalTo(self.whiteView.mas_right).with.offset(0);
        make.height.mas_equalTo(@50);
    }];
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.bounces = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.whiteView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(label.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.bt_sure.mas_top).with.offset(0);
        
        
    }];
    [self.tableView registerClass:[ShopsCouponTableViewCell class] forCellReuseIdentifier:@"ShopsCouponTableViewCell"];
    
    
}
-(void)setCouponArray:(NSArray *)couponArray
{
    _couponArray = couponArray;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.couponArray.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ShopsCouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopsCouponTableViewCell"];
    
    if (!cell) {
        cell = [[ShopsCouponTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopsCouponTableViewCell"];
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    PersonalCouponModel *model = self.couponArray[indexPath.row];
    
    [cell setModel:model];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 120;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     CouponTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([_delegate respondsToSelector:@selector(StoreCouponView:Index:CouID:)]) {
        [_delegate StoreCouponView:self Index:indexPath.row CouID:cell.couID];
    }

    
    
        

    
    
    
}



@end
