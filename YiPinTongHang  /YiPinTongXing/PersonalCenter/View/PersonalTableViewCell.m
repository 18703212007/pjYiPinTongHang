//
//  PersonalTableViewCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/11.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PersonalTableViewCell.h"

@implementation PersonalTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layout];
    }
    return self;
}


-(void)layout{
    
    
    __weak typeof(self) weakself = self;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.img = [[UIImageView alloc]init];
    self.img.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:self.img];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.contentView.mas_top).with.offset(10);
        make.left.equalTo(weakself.contentView.mas_left).with.offset(15);
        make.height.mas_equalTo(@26);
        make.width.mas_equalTo(@23);
    }];
    self.showLabel = [[UILabel alloc]init];
    self.showLabel.font = [UIFont systemFontOfSize:15.0];
    [self.contentView addSubview:self.showLabel];
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.contentView.mas_top).with.offset(12.5);
        make.left.equalTo(weakself.img.mas_right).with.offset(15);
        make.height.mas_equalTo(@20);
        make.width.mas_equalTo(@80);
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



@implementation PreMessageHeaderTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layout];
    }
    return self;
}


-(void)layout{
    
    [self.contentView addSubview:self.imgHeader];
    [self.imgHeader sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"head.png"]];
    self.imgHeader.cornerRadius = 30;
    self.imgHeader.clipsToBounds = YES;
    self.imgHeader.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(60, 60));
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



-(UIImageView *)imgHeader{
    if (_imgHeader == nil) {
        _imgHeader = [UIImageView new];
    }
    return _imgHeader;
}

@end



@implementation PreMessageTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self =  [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layout];
    }
    return self;
}


-(void)layout{
    self.showLabel.textAlignment = NSTextAlignmentRight;
    
    [self.contentView addSubview:self.showLabel];
    //    self.showLabel.backgroundColor = [UIColor redColor];
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(180, 30));
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



-(UILabel *)showLabel{
    if (_showLabel == nil) {
        _showLabel = [UILabel new];
    }
    return _showLabel;
}

@end


@implementation PersonalHeaderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}


-(void)setUI{
    
    self.img_bgImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_background.png"]];
    self.img_bgImg.userInteractionEnabled = YES;
    [self.contentView addSubview:self.img_bgImg];
    [self.img_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
    
    self.img_headerImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"personal_head_portrait.png"]];
    self.img_headerImg.userInteractionEnabled = YES;
    self.img_headerImg.cornerRadius = 34;
    self.img_headerImg.clipsToBounds = YES;
    [self.img_bgImg addSubview:self.img_headerImg];
    [self.img_headerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_bgImg.mas_top).with.offset(47);
        make.left.equalTo(self.img_bgImg.mas_left).with.offset(15);
        make.height.mas_equalTo(@68);
        make.width.mas_equalTo(@68);
    }];
    self.lb_nickName = [[UILabel alloc]init];
    self.lb_nickName.text = @"想要和你一起吹吹风";
    self.lb_nickName.textColor = [UIColor colorWithHexString:@"#ffffff"];
    self.lb_nickName.font= [UIFont fontWithName:@"Arial-BoldMT"size:17.0];
    [self.img_bgImg addSubview:self.lb_nickName];
    [self.lb_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_bgImg.mas_top).with.offset(68);
        make.left.equalTo(self.img_headerImg.mas_right).with.offset(12);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@200);
    }];
    
    
    self.btn_message = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_message setImage:[UIImage imageNamed:@"personal_message.png"] forState:UIControlStateNormal];
    [self.img_bgImg addSubview:self.btn_message];
    [self.btn_message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.img_bgImg.mas_right).with.offset(-10);
        make.top.equalTo(self.img_bgImg.mas_top).with.offset(32);
        make.height.mas_equalTo(@22);
        make.width.mas_equalTo(@22);
    }];
    
    self.btn_exits = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_exits setImage:[UIImage imageNamed:@"exit.png"] forState:UIControlStateNormal];
    [self.btn_exits setImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateSelected];
//    [self.btn_exits setTitle:@"注销" forState:UIControlStateNormal];
//    [self.btn_exits setTitle:@"登录" forState:UIControlStateSelected];
    
    [self.img_bgImg addSubview:self.btn_exits];
    [self.btn_exits mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.btn_message.mas_left).with.offset(-15);
        make.top.equalTo(self.img_bgImg.mas_top).with.offset(32);
        make.height.mas_equalTo(@22);
        make.width.mas_equalTo(@22);
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


#import "PJButton.h"
@implementation AddressTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}


-(void)setUI{
    
    self.lb_nickName = [UILabel new];
    self.lb_nickName.textColor = [UIColor redColor];
    [self.contentView addSubview:self.lb_nickName];
    
    [self.lb_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@100);
        
    }];
    self.lb_phoneNum = [UILabel new];
    [self.contentView addSubview:self.lb_phoneNum];
    
    [self.lb_phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.lb_nickName.mas_right).with.offset(0);
        make.height.mas_equalTo(@30);
        make.right.equalTo(self.mas_right).with.offset(-30);
        
    }];
    
    UILabel *lb_address = [UILabel new];
    lb_address.text = @"收货地址:";
    [self.contentView addSubview:lb_address];
    
    [lb_address mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_nickName.mas_bottom).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
        
    }];
    
    
    self.lb_addressDetails = [UILabel new];
    self.lb_addressDetails.numberOfLines = 0;
    [self.contentView addSubview:self.lb_addressDetails];
    
    [self.lb_addressDetails mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_nickName.mas_bottom).with.offset(10);
        make.left.equalTo(lb_address.mas_right).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.height.mas_equalTo(@50);
        
        
    }];
    
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor lightGrayColor];
    line.alpha = 0.4;
    [self.contentView addSubview:line];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_addressDetails.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@1);
        
    }];
    
    self.btn_dafault = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_dafault setImage:[UIImage imageNamed:@"address_unclecked"] forState:UIControlStateNormal];
    [self.btn_dafault setImage:[UIImage imageNamed:@"address_selected"] forState:UIControlStateSelected];
    
    
    
    [self.contentView addSubview:self.btn_dafault];
    [self.btn_dafault mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];
    self.lb_dafault = [UILabel new];
    self.lb_dafault.font = [UIFont systemFontOfSize:14.0];
    self.lb_dafault.text = @"默认";
    [self.contentView addSubview:self.lb_dafault];
    [self.lb_dafault mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(self.btn_dafault);
        make.left.equalTo(self.btn_dafault.mas_right).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
    }];
    
    self.btn_delete = [[PJButton alloc]initWithFrame:CGRectZero Image:[UIImage imageNamed:@"address_delete"] Message:@"删除"];
    self.btn_delete. line.hidden = YES;
    
    [self.contentView addSubview:self.btn_delete];
    [self.btn_delete mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_bottom).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(screen_width/4.0, 42));
    }];
    self.btn_editing = [[PJButton alloc]initWithFrame:CGRectZero Image:[UIImage imageNamed:@"address_edit"] Message:@"编辑"];
    self.btn_editing.line.hidden = YES;
    
    [self.contentView addSubview:self.btn_editing];
    [self.btn_editing mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(line.mas_bottom).with.offset(5);
        make.right.equalTo(self.btn_delete.mas_left).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(screen_width/4.0, 42));
    }];
    
    [self.btn_delete addTarget:self action:@selector(btn_delete:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setModel:(AddressGetModel *)model
{
    _arid = model.arid;
    _lb_nickName.text = model.uname;
    _lb_phoneNum.text = model.utel;
    _ar = model.ar;
    _artwo = model.artwo;
    
    
    _lb_addressDetails.text = [NSString stringWithFormat:@"%@ %@",model.ar,model.artwo];
    _btn_dafault.tag = [[NSString stringWithFormat:@"%@", model.arid] integerValue];
    _btn_editing.tag =[[NSString stringWithFormat:@"%@", model.arid] integerValue];
    _btn_delete.tag =[[NSString stringWithFormat:@"%@", model.arid] integerValue];
    
    if ([model.isstate isEqualToString:@"0"]) {
        _btn_dafault.selected = NO;
    }else {
        //        [_btn_dafault setImage:[UIImage imageNamed:@"address_selected.png"] forState:UIControlStateSelected];
        _btn_dafault.selected = YES;
    }
}


-(void)btn_delete:(UIButton*)sender{
    
    if (_block) {
        _block(self);
    }
    
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
#import "PersonalCouponModel.h"
@interface CouponTableViewCell ()



@end


@implementation CouponTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
   
    self.img_bgImg = [UIImageView new];
//    self.img_bgImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.img_bgImg];
    [self.img_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(self.mas_top).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.height.mas_equalTo(160);
        
    }];
    
    self.lb_shopName = [UILabel new];
    self.lb_shopName.textColor = [UIColor whiteColor];
    self.lb_shopName.font =[UIFont systemFontOfSize:17.0];
    [self.img_bgImg addSubview:self.lb_shopName];
    [self.lb_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.img_bgImg.mas_top).with.offset(13);
        make.left.equalTo(self.img_bgImg.mas_left).with.offset(10);
        make.width.mas_equalTo(@200);
        make.height.mas_equalTo(30);
        
    }];
    
    
    self.lb_jPrice = [UILabel new];
    self.lb_jPrice.textColor = [UIColor whiteColor];
    self.lb_jPrice.font =[UIFont systemFontOfSize:24.0];
    [self.img_bgImg addSubview:self.lb_jPrice];
    [self.lb_jPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_shopName.mas_bottom).with.offset(30);
        make.left.equalTo(self.img_bgImg.mas_left).with.offset(10);
        make.width.mas_equalTo(@140);
        make.height.mas_equalTo(30);
        
    }];
    
    self.lb_mPrice = [UILabel new];
    
    self.lb_mPrice.textColor = [UIColor whiteColor];
    self.lb_mPrice.font =[UIFont systemFontOfSize:17.0];
    [self.img_bgImg addSubview:self.lb_mPrice];
    [self.lb_mPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_jPrice.mas_top).with.offset(4);
        make.left.equalTo(self.lb_jPrice.mas_right).with.offset(0);
        make.width.mas_equalTo(@140);
        make.height.mas_equalTo(30);
        
    }];
    
    self.lb_date = [UILabel new];
    self.lb_date.textColor = [UIColor whiteColor];
    self.lb_date.font =[UIFont systemFontOfSize:15.0];
    [self.img_bgImg addSubview:self.lb_date];
    [self.lb_date mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_jPrice.mas_bottom).with.offset(20);
        make.left.equalTo(self.img_bgImg.mas_left).with.offset(10);
        make.right.equalTo(self.img_bgImg.mas_right).with.offset(-10);
        make.height.mas_equalTo(30);
        
    }];
    
    
    
}



-(void)setModel:(PersonalCouponModel *)model
{
    /*   model.st   1  使用过得    2  过期的    其他     */
    if ([model.st isEqualToString:@"1"]) {
        self.img_bgImg.image = [UIImage imageNamed:@"coupon_bg_out_data"];
    }else if ([model.st isEqualToString:@"2"]){
        self.img_bgImg.image = [UIImage imageNamed:@"coupon_bg_used"];
    }else{
        self.img_bgImg.image = [UIImage imageNamed:@"coupon_bg_selected"];
    }
    
    self.lb_shopName.text = model.shopname;
    self.lb_date.text = model.sytime;
    self.lb_jPrice.text = model.jprice;
    self.lb_mPrice.text = model.mprice;
    self.shopID = model.shopid;
    self.couID = model.couid;
    
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





@implementation ShopsCouponTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.img_bgImg = [UIImageView new];
    //    self.img_bgImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.img_bgImg];
    self.img_bgImg.image = [UIImage imageNamed:@"storeCoupon.png"];
    [self.img_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        
        make.top.equalTo(self.mas_top).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-5);
        make.height.mas_equalTo(100);
        
    }];
    
    
    
    
    self.lb_jPrice = [UILabel new];
    self.lb_jPrice.textColor = [UIColor whiteColor];
    self.lb_jPrice.font =[UIFont systemFontOfSize:24.0];
    [self.img_bgImg addSubview:self.lb_jPrice];
    [self.lb_jPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.img_bgImg.mas_left).with.offset(10);
        make.width.mas_equalTo(@140);
        make.height.mas_equalTo(30);
        
    }];
    
    self.lb_mPrice = [UILabel new];
    self.lb_mPrice.textColor = [UIColor whiteColor];
    self.lb_mPrice.font =[UIFont systemFontOfSize:15.0];
    [self.img_bgImg addSubview:self.lb_mPrice];
    [self.lb_mPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_jPrice.mas_bottom).with.offset(4);
        make.left.equalTo(self.img_bgImg.mas_left).with.offset(10);
        make.width.mas_equalTo(@140);
        make.height.mas_equalTo(15);
        
    }];
    
    self.lb_date = [UILabel new];
    self.lb_date.textColor = [UIColor whiteColor];
    self.lb_date.font =[UIFont systemFontOfSize:11.0];
    [self.img_bgImg addSubview:self.lb_date];
    [self.lb_date mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_mPrice.mas_bottom).with.offset(15);
        make.left.equalTo(self.img_bgImg.mas_left).with.offset(10);
        make.width.mas_equalTo(2*screen_width/3.0 - 10);
        make.height.mas_equalTo(24);
        
    }];
    
    
    
}



-(void)setModel:(PersonalCouponModel *)model
{
    
    self.lb_date.text = model.sytime;
    self.lb_jPrice.text = [NSString stringWithFormat:@"¥ %@",model.jprice];
    self.lb_mPrice.text = model.mprice;
    self.couID = model.couid;
    
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


