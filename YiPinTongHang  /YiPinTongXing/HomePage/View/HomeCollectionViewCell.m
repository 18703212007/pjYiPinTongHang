//
//  HomeCollectionViewCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/17.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "HomeCollectionViewCell.h"
#import "HomeModel.h"

#pragma mark - ** 人气 ** 纵向滑动的collectionView -
@implementation PopularCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}


-(void)allViews{
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake((screen_width-6)/2, (screen_width-6)/2));
    }];
    self.textLab.font = [UIFont systemFontOfSize:13.0];
    self.textLab.textColor = [UIColor blackColor];
    self.textLab.numberOfLines = 0;
    self.textLab.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.textLab];
    
    [self.textLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(6);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo((screen_width-30)/2);
    }];
    self.priceLabel.textColor = [UIColor redColor];
    self.priceLabel.textAlignment = NSTextAlignmentLeft;
    self.priceLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:self.priceLabel];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLab.mas_bottom).with.offset(-3);
        make.left.equalTo(self.contentView.mas_left).with.offset(6);
        make.width.mas_equalTo(120);
        make.height.mas_equalTo(20);
    }];
    
    self.orderNum = [UILabel new];
    self.orderNum.textAlignment = NSTextAlignmentRight;
    self.orderNum.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:self.orderNum];
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.textLab.mas_bottom).with.offset(-3);
        make.right.equalTo(self.contentView.mas_right).with.offset(-6);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
}

-(void)setDataViewModel:(HomeModel*)model{
    NSString *url = k_Yptx_URL;
    //
    self.orderNum.text =[NSString stringWithFormat:@"%@人付款",model.orderNum];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,model.picurl]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    self.textLab.text = model.gName;
    self.priceLabel.text =[NSString stringWithFormat:@"¥ %@",model.price];
    self.goodsID = model.gId;
}

#pragma mark - 懒加载 -
-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}

-(UILabel *)priceLabel{
    if (_priceLabel == nil) {
        _priceLabel =[UILabel new];
    }
    return _priceLabel;
}

-(UILabel *)textLab{
    if (_textLab == nil) {
        _textLab = [UILabel new];
    }
    return _textLab;
}

@end









#pragma mark - ** 热门 ** 横向滑动的collectionView -
@implementation HorizontalCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}





-(void)allViews{
    
    [self.contentView addSubview:self.labHorCollect];
    self.imgHorCollect.userInteractionEnabled = YES;
    //    self.imgHorCollect.backgroundColor = [UIColor redColor];
    self.imgHorCollect.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imgHorCollect];
    
    [self.imgHorCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}

-(void)setDataViewModel:(HorCollectModel*)model{
    
    NSString *url = k_Yptx_URL;
    [self.imgHorCollect sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,model.picurl]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    self.labHorCollect.text = model.gName;
    self.goodsID = model.gId;
}

#pragma mark - 懒加载 -
-(UILabel *)labHorCollect{
    if (_labHorCollect == nil) {
        _labHorCollect = [UILabel new];
    }
    return _labHorCollect;
}
-(UIImageView *)imgHorCollect{
    if (_imgHorCollect == nil) {
        _imgHorCollect = [UIImageView new];
    }
    return _imgHorCollect;
}

@end









#pragma mark - ** 分类 **  -
@implementation ListCVCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}


-(void)allViews{
    //    self.imgView.backgroundColor = [UIColor purpleColor];
    //    self.imgView.userInteractionEnabled = YES;
    self.imgView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        //        make.left.equalTo(self.contentView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerX.equalTo(self.contentView);
        
    }];
    
    //    self.nameLabel.backgroundColor = [UIColor cyanColor];
    self.nameLabel.font = [UIFont systemFontOfSize:13.0];
    self.nameLabel.textColor = [UIColor blackColor];
    //    self.nameLabel.numberOfLines = 0;
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(self.contentView);
    }];
    
    
}

-(void)setDataViewModel:(ListCollectModel*)model{
    NSString *url = k_Yptx_URL;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,model.picArr]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    self.nameLabel.text = model.catsName;
    self.catsID = model.catsId;
}

#pragma mark - 懒加载 -
-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}
-(UIImageView *)imgView{
    if (_imgView == nil) {
        _imgView = [UIImageView new];
    }
    return _imgView;
}



@end

#pragma mark - ** 分类 **  -

@implementation LDetailedCollectionViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
    }
    return self;
}

-(void)layout{
    self.title = [UILabel new];
    self.title.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        
    }];
}

-(void)setDataViewModel:(LDetailedCollectionModel *)model{
    self.title.text = model.catsName;
    self.catsID = model.catsId;
    //    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.catsPic]]];
}





@end

//LDetailedColViewCell

@implementation LDetailedColViewCell



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
    }
    return self;
}

-(void)layout{
    
    self.imgPicurl.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.contentView addSubview:self.imgPicurl];
    [self.imgPicurl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake((screen_width-12)/2, (screen_width-12)/2));
    }];
    self.title.font = [UIFont systemFontOfSize:13.0];
    self.title.textColor = [UIColor blackColor];
    self.title.numberOfLines = 0;
    self.title.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.title];
    
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgPicurl.mas_bottom).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(6);
        make.height.mas_equalTo(34);
        make.width.mas_equalTo((screen_width-30)/2);
    }];
    self.price.textColor = [UIColor redColor];
    self.price.textAlignment = NSTextAlignmentLeft;
    self.price.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:self.price];
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(-3);
        make.left.equalTo(self.contentView.mas_left).with.offset(6);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
    self.orderNum.textAlignment = NSTextAlignmentRight;
    self.orderNum.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:self.orderNum];
    [self.orderNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title.mas_bottom).with.offset(-3);
        make.right.equalTo(self.mas_right).with.offset(-6);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(20);
        
        
    }];
    //
    
    
    
    
    
}


-(void)setDataWithModel:(CollectionGoodsModel *)model{
    
    if (model.orderNum == nil ||model.orderNum == NULL) {
        model.orderNum = @"0";
    }
    self.orderNum.text =[NSString stringWithFormat:@"%@人付款",model.orderNum] ;
    
    self.price.text =[NSString stringWithFormat:@"¥ %@",model.price];
    self.title.text = model.gName;
    [self.imgPicurl sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picurl]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder.png"]];
    self.goodsID = model.gId;
}







-(UIImageView *)imgPicurl{
    if (_imgPicurl == nil) {
        _imgPicurl = [UIImageView new];
    }
    return _imgPicurl;
}


-(UILabel *)price {
    if (_price == nil) {
        _price = [UILabel new];
    }
    return _price;
}


-(UILabel *)title{
    if (_title == nil) {
        _title = [UILabel new];
    }
    return _title;
}

-(UILabel *)orderNum{
    if (_orderNum == nil) {
        _orderNum = [UILabel new];
    }
    return _orderNum;
}

@end





#pragma mark - ** 二级分类 **  -

@implementation ReclassifyCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
    }
    return self;
}

-(void)layout{
    
    [self.contentView addSubview:self.img];
    self.img.contentMode = UIViewContentModeScaleAspectFit;
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(44, 44));
        make.centerX.equalTo(self.contentView);
        
    }];
    self.nameLabel.font = [UIFont systemFontOfSize:13.0];
    self.nameLabel.textColor = [UIColor blackColor];
    self.nameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img.mas_bottom).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(self.contentView);
    }];
    
}

-(void)setDataViewModel:(HomeListModel *)model{
    NSString *url = k_Yptx_URL;
    self.nameLabel.text = model.catsName;
    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",url,model.catsPic]]];
    self.catsId = model.catsId;
    
    
    
}


-(UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [UILabel new];
    }
    return _nameLabel;
}
-(UIImageView *)img{
    if (_img == nil) {
        _img = [UIImageView new];
    }
    return _img;
}

-(NSString *)catsId{
    if (_catsId == nil) {
        _catsId = [NSString string];
    }
    return _catsId;
}

@end


@implementation BtnCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.title = [UILabel new];
        self.title.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        }];
        self.line = [UIView new];
        self.line.backgroundColor = [UIColor redColor];
        self.line.hidden = YES;
        [self.title addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(49, 0, 0, 0));
        }];
        
        
        
    }
    return self;
}

@end


