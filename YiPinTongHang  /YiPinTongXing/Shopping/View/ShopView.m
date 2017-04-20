
//
//  ShopView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/9.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ShopView.h"

@interface ShopView()

@property(nonatomic,strong)UIView *bgView;

@property(nonatomic,strong)UILabel *textLabel;
@end

@implementation ShopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
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
    
    [self addSubview:self.bgView];
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
    
    
    [self.bgView addSubview:self.textLabel];
    self.textLabel.textColor = [UIColor blackColor];
    self.textLabel.font = [UIFont systemFontOfSize:14.0];
    self.textLabel.text = @"购物车是空的,快去选购心爱的商品吧!";
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.bgView);
    }];
    
    
    [self addSubview:self.imgView];
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    self.imgView.image = [UIImage imageNamed:@"shop_box.png"];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.textLabel.mas_top).with.offset(-20);
        make.centerX.equalTo(self.bgView);
        make.height.mas_equalTo(68);
        make.width.mas_equalTo(68);
    }];
    [self.bgView addSubview:self.goShopBtn];
    
    [self.goShopBtn setTitle:@"去逛逛" forState:UIControlStateNormal];
//    self.goShopBtn.backgroundColor = [UIColor yellowColor];
    self.goShopBtn.clipsToBounds = YES;
    self.goShopBtn.cornerRadius = 5;
    [self.goShopBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.goShopBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
    self.goShopBtn.borderWidth = 1.0;
    self.goShopBtn.borderColor = [UIColor redColor];
    [self.goShopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLabel.mas_bottom).with.offset(15);
        make.centerX.equalTo(self.bgView);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(68);
    }];
    

}

-(UIView *)navView{
    if (_navView == nil) {
        _navView = [UIView new];
    }
    return _navView;
}

-(UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [UIView new];
        _bgView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    }
    return _bgView;
}

-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}
-(UIButton *)goShopBtn{
    if (_goShopBtn == nil) {
        _goShopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _goShopBtn;
}
-(UILabel *)textLabel{
    if (_textLabel == nil) {
        _textLabel = [UILabel new];
    }
    return _textLabel;
}


@end
