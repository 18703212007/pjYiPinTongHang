//
//  HomeTableViewCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/27.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "HomeTableViewCell.h"


@implementation ReclassifyViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self allViews];
    }
    return self;
    
}

-(void)allViews{
    
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

@implementation CollectionGoodsTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self allViews];
    }
    return self;
    
}

-(void)allViews{
    
    self.imgPicurl = [UIImageView new];
    
    [self.contentView addSubview:self.imgPicurl];
    self.imgPicurl.contentMode = UIViewContentModeScaleAspectFit;
    [self.imgPicurl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(0);
        make.top.equalTo(self.mas_top).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        make.width.mas_equalTo(140);
    }];
    
    self.goodstitle = [UILabel new];
    [self.contentView addSubview:self.goodstitle];
    self.goodstitle.textAlignment = NSTextAlignmentLeft;
    self.goodstitle.numberOfLines = 0;
    [self.goodstitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgPicurl.mas_right).with.offset(8);
        make.top.equalTo(self.mas_top).with.offset(10);
        make.height.mas_equalTo(45);
        make.right.equalTo(self.mas_right).with.offset(-8);
        
    }];
    self.price = [UILabel new];
    [self.contentView addSubview:self.price];
    self.price.textColor = [UIColor redColor];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgPicurl.mas_right).with.offset(8);
        make.top.equalTo(self.goodstitle.mas_bottom).with.offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
    }];
    self.ispostage = [UILabel new];
    
    [self.contentView addSubview:self.ispostage];
    [self.ispostage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgPicurl.mas_right).with.offset(8);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
    }];
    self.orderNum = [UILabel new];
    
    [self.contentView addSubview:self.orderNum];
    self.orderNum.textAlignment = NSTextAlignmentLeft;
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.ispostage.mas_right).with.offset(8);
        make.bottom.equalTo(self.mas_bottom).with.offset(-10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.height.mas_equalTo(20);
    }];
    
}

-(void)setCellDataWithModel:(CollectionGoodsModel *)model{
    NSString *url = k_Yptx_URL;
    
    if (model.orderNum == nil) {
        model.orderNum = @"0";
    }
    if (model.isPostage == nil) {
        model.isPostage = @"不包邮费";
    }
    
    self.orderNum.text =[NSString stringWithFormat:@"%@人付款",model.orderNum];
    self.price.text = [NSString stringWithFormat:@"¥ %@",model.price];
    self.ispostage.text = model.isPostage;
    self.goodstitle.text = model.gName;
    [self.imgPicurl sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,model.picurl]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder.png"]];
    self.goodsID = model.gId;
    self.fid = model.fid;
    
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

//
@end

@implementation CollectionStroeTableCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self allViews];
    }
    return self;
    
}

-(void)allViews{
    
    self.shoplogo = [UIImageView new];
    [self.contentView addSubview:self.shoplogo];
    self.shoplogo.contentMode = UIViewContentModeScaleAspectFit;
    [self.shoplogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(20);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    
    self.title = [UILabel new];
    [self.contentView addSubview:self.title];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.numberOfLines = 0;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shoplogo.mas_right).with.offset(8);
        make.top.equalTo(self.shoplogo.mas_top).with.offset(5);
        make.height.mas_equalTo(25);
        make.right.equalTo(self.mas_right).with.offset(-8);
        
    }];
    
    
    self.favoritesnum = [UILabel new];
    
    [self.contentView addSubview:self.favoritesnum];
    self.favoritesnum.textAlignment = NSTextAlignmentLeft;
    [self.favoritesnum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shoplogo.mas_right).with.offset(8);
        make.top.equalTo(self.title.mas_bottom).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.height.mas_equalTo(25);
    }];
    
}

-(void)setCellDataWithModel:(CollectionStoreModel *)model{
    
    self.favoritesnum.text =[NSString stringWithFormat:@"%@|%@",model.favoritesnum,model.ordernum];
    
    self.title.text = model.shopname;
    [self.shoplogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.shoplogo]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder.png"]];
    self.shopsID = model.shopid;
    self.fid = model.fid;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}








//
@end



