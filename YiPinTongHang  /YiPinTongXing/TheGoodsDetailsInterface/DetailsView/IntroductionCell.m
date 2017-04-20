//
//  IntroductionCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/22.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "IntroductionCell.h"

@implementation IntroductionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation IntroductionTopCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    
    self.img_shopLogo = [UIImageView new];
    self.img_shopLogo.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:self.img_shopLogo];
    [self.img_shopLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    
    self.lb_shopName = [UILabel new];
    [self.contentView addSubview:self.lb_shopName];
    [self.lb_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.img_shopLogo.mas_right).with.offset(10);
        make.top.equalTo(self.img_shopLogo.mas_top).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(145, 22));
        
    }];
    
    
    
    self.lb_favorites = [UILabel new];
    self.lb_favorites.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.lb_favorites];
    [self.lb_favorites mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.img_shopLogo.mas_right).with.offset(10);
        make.top.equalTo(self.lb_shopName.mas_bottom).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(200, 22));
        
    }];
    
//    self.btn_collection = [UIButton buttonWithType:UIButtonTypeCustom];//shop_collection_unchecked
//    [self.btn_collection setImage:[UIImage imageNamed:@"shop_collection_selected"] forState:UIControlStateNormal];
//    [self.btn_collection setImage:[UIImage imageNamed:@"shop_collection_selected"] forState:UIControlStateSelected];
//    
//    [self.contentView addSubview:self.btn_collection];
//    [self.btn_collection mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.lb_shopName.mas_top).with.offset(0);
//        
//        if(screen_width == 320){
//            
//            make.right.equalTo(self.mas_right).with.offset(-20);
//            make.size.mas_equalTo(CGSizeMake(65, 28));
//        }else{
//            make.right.equalTo(self.mas_right).with.offset(-20);
//            make.size.mas_equalTo(CGSizeMake(84.5, 36.4));
//            
//        }
//    }];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end



@implementation IntroductionMidCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.lb_nameSh = [UILabel new];
    [self.contentView addSubview:self.lb_nameSh];
    [self.lb_nameSh mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(40);
        
    }];
    
    
    self.lb_shop = [UILabel new];
    self.lb_shop.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.lb_shop];
    [self.lb_shop mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.lb_nameSh.mas_right).with.offset(2);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.height.mas_equalTo(40);
        
    }];
    
    
    self.lb_nameSe = [UILabel new];
    [self.contentView addSubview:self.lb_nameSe];
    [self.lb_nameSe mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_nameSh.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(40);
        
    }];
    
    self.lb_service = [UILabel new];
    self.lb_service.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.lb_service];
    [self.lb_service mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_shop.mas_bottom).with.offset(0);
        make.left.equalTo(self.lb_nameSe.mas_right).with.offset(2);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.height.mas_equalTo(40);
        
    }];
    
    self.lb_nameQu = [UILabel new];
    [self.contentView addSubview:self.lb_nameQu];
    [self.lb_nameQu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_nameSe.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(40);
        
    }];
    
    
    self.lb_quality = [UILabel new];
    self.lb_quality.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.lb_quality];
    [self.lb_quality mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_service.mas_bottom).with.offset(0);
        make.left.equalTo(self.lb_nameQu.mas_right).with.offset(2);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.height.mas_equalTo(40);
        
    }];
    
    self.lb_shop.textColor = [UIColor redColor];
    self.lb_service.textColor = [UIColor redColor];
    self.lb_quality.textColor = [UIColor redColor];
    self.lb_nameSh.text = @"商品评价";
    self.lb_nameSe.text = @"服务态度";
    self.lb_nameQu.text = @"商品质量";
    
    
    
    
    
    
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

@implementation IntroductionBottomCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.lb_name = [UILabel new];
    [self.contentView addSubview:self.lb_name];
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(30);
        
    }];
    
    
    self.lb_subName = [UILabel new];
    self.lb_subName.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.lb_subName];
    self.lb_subName.numberOfLines = 2;
    [self.lb_subName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self.lb_name.mas_right).with.offset(2);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.height.mas_equalTo(30);
        
    }];
    
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end


@implementation IntroductionOtherCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.lb_name = [UILabel new];
    [self.contentView addSubview:self.lb_name];
    [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.width.mas_equalTo(85);
        make.height.mas_equalTo(30);
        
    }];
    
    
    self.img_rightImg = [UIImageView new];
    self.img_rightImg.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.img_rightImg];
    [self.img_rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(19, 19.5));
        
    }];
    
    
    
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
