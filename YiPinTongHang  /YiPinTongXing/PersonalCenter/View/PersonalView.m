//
//  PersonalView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/8.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PersonalView.h"


@interface PersonalView()
@property(nonatomic,strong)UIScrollView *scrollView;
///背景图
@property(nonatomic,strong)UIImageView *BgImg;
///<<<
@property(nonatomic,strong)UIImageView *img;
///

///
@property(nonatomic,strong)UIView *moreView;
///
@property(nonatomic,strong)UIView *otherView;

@end

@implementation PersonalView






- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    if (self) {
        [self layoutSubView];
        
    }
    return self;
}


-(void)layoutSubView{
    
    __weak typeof(self) weakself = self;
    
    self.scrollView = [[UIScrollView alloc]init];
    self.scrollView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    self.scrollView.contentSize = CGSizeMake(self.width, self.height);
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(-74, 0, 0, 0));
    }];
    
    self.BgImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_background.png"]];
    self.BgImg.userInteractionEnabled = YES;
    [self.scrollView addSubview:self.BgImg];
    self.scrollView.showsVerticalScrollIndicator = NO;
    [self.BgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).with.offset(0);
        make.left.equalTo(weakself.mas_left).with.offset(0);
        make.right.equalTo(weakself.mas_right).with.offset(0);
        make.height.mas_equalTo(@135.5);
    }];
    
    self.rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn1 setImage:[UIImage imageNamed:@"personal_message.png"] forState:UIControlStateNormal];
    [self.BgImg addSubview:self.rightBtn1];
    [self.rightBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.BgImg.mas_right).with.offset(-10);
        make.top.equalTo(weakself.BgImg.mas_top).with.offset(32);
        make.height.mas_equalTo(@22);
        make.width.mas_equalTo(@22);
    }];
    
    self.rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.rightBtn2 setImage:[UIImage imageNamed:@"personal_set_up.png"] forState:UIControlStateNormal];
    
    [self.BgImg addSubview:self.rightBtn2];
    [self.rightBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.rightBtn1.mas_left).with.offset(-15);
        make.top.equalTo(weakself.BgImg.mas_top).with.offset(32);
        make.height.mas_equalTo(@22);
        make.width.mas_equalTo(@22);
    }];
    
    self.HeadImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_head_portrait.png"]];
    self.HeadImg.userInteractionEnabled = YES;
    self.HeadImg.cornerRadius = 34;
    self.HeadImg.clipsToBounds = YES;
    [self.BgImg addSubview:self.HeadImg];
    [self.HeadImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.BgImg.mas_top).with.offset(47);
        make.left.equalTo(weakself.BgImg.mas_left).with.offset(15);
        make.height.mas_equalTo(@68);
        make.width.mas_equalTo(@68);
    }];
    self.nameLabel = [[UILabel alloc]init];
    self.nameLabel.text = @"想要和你一起吹吹风";
    self.nameLabel.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.nameLabel.font= [UIFont fontWithName:@"Arial-BoldMT"size:17.0];
    [self.BgImg addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.BgImg.mas_top).with.offset(68);
        make.left.equalTo(weakself.HeadImg.mas_right).with.offset(12);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@200);
    }];
    
    [self setOrder];
    [self setMore];
    [self setOther];
    
    
#warning !~!~!~!!!! 电话
    // 150 7615 0990 北苏镇   孙晓凤
    
}
#pragma mark - 订单 -
-(void)setOrder{
    
    
    __weak typeof(self) weakself = self;
    
    self.orderView = [[UIView alloc]init];
    self.orderView.borderWidth = 1;
    self.orderView.backgroundColor = [UIColor whiteColor];
    self.orderView.borderColor = [UIColor colorWithHexString:@"#eaeaea"];
    [self.scrollView addSubview:self.orderView];
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.BgImg.mas_bottom).with.offset(11);
        make.left.equalTo(weakself.mas_left).with.offset(0);
        make.right.equalTo(weakself.mas_right).with.offset(0);
        make.height.mas_equalTo(@46);
        
    }];
    UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_order.png"]];
    [self.orderView addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.orderView.mas_top).with.offset(10);
        make.left.equalTo(weakself.orderView.mas_left).with.offset(15);
        make.width.mas_equalTo(@23);
        make.height.mas_equalTo(@26);
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"我的订单";
    [self.orderView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img.mas_right).with.offset(17);
        make.top.equalTo(weakself.orderView.mas_top).with.offset(13);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    
    UIImageView *img1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_enter"]];
    [self.orderView addSubview:img1];
    [img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.orderView.mas_right).with.offset(-15);
        make.top.equalTo(weakself.orderView.mas_top).with.offset(15.5);
        make.width.mas_equalTo(@9);
        make.height.mas_equalTo(@15);
    }];
    UILabel *label2 = [[UILabel alloc]init];
    label2.text = @"查看我的订单";
    label2.font = [UIFont systemFontOfSize:13.0];
    label2.textColor = [UIColor colorWithHexString:@"#8c8c8c"];
    [self.orderView addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(img1.mas_left).with.offset(-11);
        make.top.equalTo(weakself.orderView.mas_top).with.offset(15.5);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@18);
    }];
    
}
#pragma mark - 选项 -
-(void)setMore{
    
    __weak typeof(self) weakself = self;
    
    self.moreView = [[UIView alloc]init];
    self.moreView.backgroundColor = [UIColor whiteColor];
    self.moreView.borderWidth = 1;
    //    self.moreView.backgroundColor = [UIColor cyanColor];
    self.moreView.borderColor = [UIColor colorWithHexString:@"#eaeaea"];
    [self.scrollView addSubview:self.moreView];
    [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.orderView.mas_bottom).with.offset(-1);
        make.left.equalTo(weakself.mas_left).with.offset(0);
        make.right.equalTo(weakself.mas_right).with.offset(0);
        make.height.mas_equalTo(@68);
    }];
    self.receivin_goods = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_receiving_goods"]];
    self.receivin_goods.userInteractionEnabled = YES;
    [self.moreView addSubview:self.receivin_goods];
    [self.receivin_goods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakself.moreView);
        make.height.mas_equalTo(@43.5);
        make.width.mas_equalTo(@53);
    }];
    
    self.pending_payment = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_pending_payment"]];
    [self.moreView addSubview:self.pending_payment];
    self.pending_payment.userInteractionEnabled = YES;
    
    [self.pending_payment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.moreView.mas_left).with.offset(4);
        make.centerY.equalTo(weakself.moreView);
        make.height.mas_equalTo(@43.5);
        make.width.mas_equalTo(@53);
    }];
    self.customer_service = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_customer_service"]];
    self.customer_service.userInteractionEnabled =YES;
    [self.moreView addSubview:self.customer_service];
    [self.customer_service mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.moreView.mas_right).with.offset(-10);
        make.centerY.equalTo(weakself.moreView);
        make.height.mas_equalTo(@43.5);
        make.width.mas_equalTo(@53);
    }];
    
    self.waiting_for_delivery = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_waiting_for_delivery"]];
    self.waiting_for_delivery.userInteractionEnabled = YES;
    
    
    [self.moreView addSubview:self.waiting_for_delivery];
    CGFloat distance = ((self.width)/4)-9.5;
    [self.waiting_for_delivery mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.moreView.mas_left).with.offset(distance-7);
        make.centerY.equalTo(weakself.moreView);
        make.height.mas_equalTo(@43.5);
        make.width.mas_equalTo(@53);
    }];
    
    self.pending_evauation = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_pending_evaluation"]];
    self.pending_evauation.userInteractionEnabled = YES;
    
    [self.moreView addSubview:self.pending_evauation];
    
    [self.pending_evauation mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakself.moreView.mas_right).with.offset(-distance);
        make.centerY.equalTo(weakself.moreView);
        make.height.mas_equalTo(@43.5);
        make.width.mas_equalTo(@53);
    }];
    
    
    
    
    
}
#pragma mark - TableView -
-(void)setOther{
    __weak typeof(self) weakself = self;
    
    self.otherView = [[UIView alloc]init];
    self.otherView.backgroundColor = [UIColor whiteColor];
    [self.scrollView addSubview:self.otherView];
    
    
    [self.otherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.moreView.mas_bottom).with.offset(0);
        make.left.equalTo(weakself.mas_left).with.offset(0);
        make.right.equalTo(weakself.mas_right).with.offset(0);
        make.bottom.equalTo(weakself.mas_bottom).with.offset(-49);
    }];
    
    
    self.personalTableView = [[UITableView alloc]initWithFrame:rect(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.otherView addSubview:self.personalTableView];
    [self.personalTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}


/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
