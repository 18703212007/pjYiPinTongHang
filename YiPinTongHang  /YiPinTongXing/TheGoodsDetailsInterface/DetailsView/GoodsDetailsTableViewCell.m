//
//  GoodsDetailsTableViewCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "GoodsDetailsTableViewCell.h"

@implementation GoodsDetailsTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
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



#pragma mark - FristCell(包含标题 价格 销量等)-
@implementation FristCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.haveOldPrice = NO;
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.bt_share = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bt_share setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.bt_share];
    [self.bt_share mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@40);
        make.width.mas_equalTo(@58);
    }];
    self.lb_title = [UILabel new];
    self.lb_title.font = [UIFont systemFontOfSize:18.0];
    self.lb_title.numberOfLines = 2;
    [self.contentView addSubview:self.lb_title];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.right.equalTo(self.bt_share.mas_left).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.height.mas_equalTo(@45);
    }];
    self.lb_price = [UILabel new];
    [self.contentView addSubview:self.lb_price];
    self.lb_price.textColor = [UIColor redColor];
    self.lb_price.font = [UIFont systemFontOfSize:22.0];
    [self.lb_price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_title.mas_bottom).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.mas_equalTo(@140);
        make.height.mas_equalTo(@40);
    }];
    
    self.lb_oldPrice = [UILabel new];
    [self.contentView addSubview:self.lb_oldPrice];
    self.lb_oldPrice.textColor = [UIColor lightGrayColor];
    self.lb_oldPrice.font = [UIFont systemFontOfSize:14.0];
    [self.lb_oldPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_title.mas_bottom).with.offset(17);
        make.left.equalTo(self.lb_price.mas_right).with.offset(0);
        //        make.centerX.equalTo(self);
        make.width.mas_equalTo(@80);
        make.height.mas_equalTo(@16);
    }];
    
    
    
    
    ///
    self.lb_sales = [UILabel new];
    self.lb_sales.font = [UIFont systemFontOfSize:14.0];
    self.lb_sales.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.lb_sales];
    [self.lb_sales mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(_lb_price.mas_bottom).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.mas_equalTo(@90);
        make.height.mas_equalTo(@20);
    }];
    ///快递
    self.lb_expressDelivery = [UILabel new];
    self.lb_expressDelivery.textColor = [UIColor lightGrayColor];
    self.lb_expressDelivery.textAlignment = NSTextAlignmentCenter;
    self.lb_expressDelivery.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.lb_expressDelivery];
    [self.lb_expressDelivery mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.lb_price.mas_bottom).with.offset(5);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@20);
        
    }];
    self.lb_address = [UILabel new];
    self.lb_address.font = [UIFont systemFontOfSize:14.0];
    self.lb_address.textColor = [UIColor lightGrayColor];
    self.lb_address.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.lb_address];
    [self.lb_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_price.mas_bottom).with.offset(5);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(20);
    }];
    
}

-(void)setCellDataWithModel:(GoodsDetailsModel *)model
{
    self.lb_title.text = model.gName;
    self.lb_price.text = [NSString stringWithFormat:@"¥:%@",model.price];
    self.lb_oldPrice.text = [NSString stringWithFormat:@"¥:%@",model.marPrice];
    self.lb_sales.text = [NSString stringWithFormat:@"销量:%@",model.orderNum];
    self.lb_expressDelivery.text = [NSString stringWithFormat:@"快递:%@",model.postAge];
    if (self.lb_oldPrice.text !=nil) {
        self.haveOldPrice = YES;
    }else{
        self.haveOldPrice = NO;
    }
    if (self.haveOldPrice) {
        UIView *view = [UIView new];
        view.backgroundColor = [UIColor lightGrayColor];
        [self.lb_oldPrice addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.lb_oldPrice);
            make.left.equalTo(self.lb_oldPrice.mas_left).with.offset(0);
            make.width.equalTo(self.lb_oldPrice);
            make.height.mas_equalTo(1);
        }];
        
    }
    //    if (self.actitity) {
    //        self.lb_actitity = [UILabel new];
    //        self.lb_actitity.backgroundColor = [UIColor redColor];
    //        self.lb_actitity.font = [UIFont systemFontOfSize:12.0];
    //        self.lb_actitity.textAlignment = NSTextAlignmentCenter;
    //        [self.contentView addSubview:self.lb_actitity];
    //        [self.lb_actitity mas_makeConstraints:^(MASConstraintMaker *make) {
    //            make.top.equalTo(self.lb_title.mas_bottom).with.offset(22);
    //            make.left.equalTo(_lb_price.mas_right).with.offset(80);
    //            make.width.mas_equalTo(@80);
    //            make.height.mas_equalTo(@16);
    //        }];
    //
    //    }
    
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

#pragma mark - SecondCell(有图的普通Cell)-

@implementation SecondCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
        
    }
    return self;
}

-(void)setUI{
    self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.img_img = [UIImageView new];
    self.img_img.image = [UIImage imageNamed:@"details_coupon.png"];
    [self.contentView addSubview:self.img_img];
    self.img_img.contentMode = UIViewContentModeScaleAspectFit;
    [self.img_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    self.lb_text = [UILabel new];
    self.lb_text.textColor = [UIColor lightGrayColor];
    self.lb_text.textAlignment = NSTextAlignmentLeft;
    self.lb_text.text = @"点击领取优惠券";
    self.lb_text.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.lb_text];
    [self.lb_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.img_img.mas_right).with.offset(8);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(100);
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

#pragma mark - ThirdCell(无图的普通Cell)-
@implementation ThirdCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //        [self setUI];
    }
    return self;
}

//-(void)setUI{
//    self.lb_text = [UILabel new];
//    self.lb_text.textColor = [UIColor lightGrayColor];
//    self.lb_text.textAlignment = NSTextAlignmentLeft;
//    self.lb_text.font = [UIFont systemFontOfSize:14.0];
//    [self.contentView addSubview:self.lb_text];
//    [self.lb_text mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self);
//        make.left.equalTo(self.mas_left).with.offset(10);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(@200);
//    }];
//}

-(void)addLeftText{
    self.lb_text = [UILabel new];
    self.lb_text.textAlignment = NSTextAlignmentLeft;
    self.lb_text.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.lb_text];
    [self.lb_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(screen_width - 60);
    }];
}

-(void)addCenterText{
    self.lb_text = [UILabel new];
    self.lb_text.textColor = [UIColor colorWithHexString:@"#cf292e"];
    self.lb_text.textAlignment = NSTextAlignmentCenter;
    self.lb_text.font = [UIFont systemFontOfSize:17.0];
    self.lb_text.text = @"查看全部评论 >";
    
    [self.contentView addSubview:self.lb_text];
    [self.lb_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.mas_right).with.offset(-10);
        //        make.size.mas_equalTo(CGSizeMake(screen_width, 20));
    }];
}

-(void)addCenterAddText{
    self.lb_text = [UILabel new];
    //    self.lb_text.textColor = [UIColor lightGrayColor];
    self.lb_text.textAlignment = NSTextAlignmentCenter;
    self.lb_text.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.lb_text];
    self.lb_text.text = @"------------继续拖动查看图文详情------------";
    [self.lb_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.mas_right).with.offset(0);
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


#pragma mark - FourthCell 评论-
#import "GoodDetailsCollectionViewCell.h"
@interface FourthPingLunCell ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation FourthPingLunCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    self.img_imgHeader = [UIImageView new];
    self.img_imgHeader.contentMode = UIViewContentModeScaleAspectFit;
    self.img_imgHeader.cornerRadius = 11;
    self.img_imgHeader.clipsToBounds = YES;
    [self.contentView addSubview:self.img_imgHeader];
    [self.img_imgHeader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.height.mas_equalTo(@22);
        make.width.mas_equalTo(@22);
    }];
    self.lb_nickName = [UILabel new];
    self.lb_nickName.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:self.lb_nickName];
    [self.lb_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.img_imgHeader.mas_right).with.offset(5);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
    self.lb_date = [UILabel new];
    
    self.lb_date.font = [UIFont systemFontOfSize:14.0];
    self.lb_date.textColor = [UIColor lightGrayColor];
    self.lb_date.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.lb_date];
    [self.lb_date mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(200);
    }];
    
    self.lb_contentText = [UILabel new];
    self.lb_contentText.font = [UIFont systemFontOfSize:14.0];
    self.lb_contentText.numberOfLines = 0;
    [self.contentView addSubview:self.lb_contentText];
    [self.lb_contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_date.mas_bottom).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.height.mas_equalTo(50);
        
    }];
    self.lb_attName = [UILabel new];
    self.lb_attName.font = [UIFont systemFontOfSize:12.0];
    self.lb_attName.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:self.lb_attName];
    [self.lb_attName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.lb_contentText.mas_bottom).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.height.mas_equalTo(20);
        
    }];
    
#pragma mark - 代码优化成 collectionView -
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.scrollEnabled = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[GoodDetailsCollectionViewCell class] forCellWithReuseIdentifier:@"GoodDetailsCollectionViewCell"];
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_attName.mas_bottom).with.offset(5);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.height.mas_equalTo(@40);
        
    }];
    
    
}

#pragma mark -    UITapGestureRecognizer -
-(void)tapAction:(UITapGestureRecognizer*)sender{
    
    UIImageView *img = (UIImageView *)sender.view;
    
    
    [PJImgaeBrowser showImage:img];
    
    
}

/*
 
 */
-(void)addNOPinlunCell{
    self.lb_contentText = [UILabel new];
    self.lb_contentText.text = @"当前商品还没有评论!";
    self.lb_contentText.textAlignment = NSTextAlignmentCenter;
    self.lb_contentText.font = [UIFont systemFontOfSize:14.0];
    self.collectionView.hidden = YES;
    [self.contentView addSubview:self.lb_contentText];
    [self.lb_contentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.height.mas_equalTo(20);
        
    }];
}


-(void)setCellWithModel:(PingLunModel *)model{
    
    [self.img_imgHeader sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.uLogo]]];
    self.lb_nickName.text = model.uName;
    self.lb_date.text = model.pubtime;
    self.lb_attName.text = model.attrName;
    self.lb_contentText.text = model.description1;
    
    
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodDetailsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GoodDetailsCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[GoodDetailsCollectionViewCell alloc]init];
    }
    [cell.img_img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,self.model.picarr[indexPath.item]]]];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.model.picarr.count;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(40, 40);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodDetailsCollectionViewCell *cell = (GoodDetailsCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [_delegate respondsToSelector:@selector(fourthCell:Withimg:)];
    [_delegate fourthCell:self Withimg:cell.img_img];
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



#pragma mark - FifthCell 店铺相关-

@implementation FifthCell



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    ///店铺的Logo*img_shopLogo;
    self.img_shopLogo = [UIImageView new];
    self.img_shopLogo.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.img_shopLogo addGestureRecognizer:tap];
    self.img_shopLogo.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.img_shopLogo];
    [self.img_shopLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(10);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        
    }];
    ///店铺名称*ib_shopname
    self.lb_shopname = [UILabel new];
    [self.contentView addSubview:self.lb_shopname];
    [self.lb_shopname mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(12);
        make.left.equalTo(self.img_shopLogo.mas_right).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(200, 20));
        
    }];
    ///店铺星级评分(星星✨)*pj_stars;
    self.pj_stars = [[PJStarsEvaluationView alloc]initWithFrame:rect(70, 34, 110, 20) numberOfStars:5 isVariable:NO];
    self.pj_stars.fullScore = 5;
    [self.contentView addSubview:self.pj_stars];
    
    
    
    
    
    ///店铺商品评分*lb_shangpin;
    UILabel *lb_shangpin = [UILabel new];
    lb_shangpin.text = @"商品";
    lb_shangpin.textColor = [UIColor lightGrayColor];
    lb_shangpin.font = [UIFont systemFontOfSize:17.0*(screen_width/375.0)];
    [self.contentView addSubview:lb_shangpin];
    [lb_shangpin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_shopLogo.mas_bottom).with.offset(20);
        make.left.equalTo(self.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    CGFloat distance = (screen_width-200)/2;
    self.lb_shangpin = [UILabel new];
    self.lb_shangpin.textColor = [UIColor colorWithHexString:@"#cf292e"];
    self.lb_shangpin.font = [UIFont systemFontOfSize:17.0*(screen_width/375.0)];
    [self.contentView addSubview:self.lb_shangpin];
    [self.lb_shangpin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_shopLogo.mas_bottom).with.offset(20);
        make.left.equalTo(lb_shangpin.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    
    
    
    
    ///店铺服务评分*lb_fuwu;
    UILabel *lb_fuwu = [UILabel new];
    lb_fuwu.text = @"服务";
    lb_fuwu.textColor = [UIColor lightGrayColor];
    lb_fuwu.font = [UIFont systemFontOfSize:17.0*(screen_width/375.0)];
    [self.contentView addSubview:lb_fuwu];
    [lb_fuwu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_shopLogo.mas_bottom).with.offset(20);
        make.left.equalTo(lb_shangpin.mas_right).with.offset(distance);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    
    self.lb_fuwu = [UILabel new];
    self.lb_fuwu.textColor = [UIColor colorWithHexString:@"#cf292e"];
    self.lb_fuwu.font = [UIFont systemFontOfSize:17.0*(screen_width/375.0)];
    [self.contentView addSubview:self.lb_fuwu];
    [self.lb_fuwu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_shopLogo.mas_bottom).with.offset(20);
        make.left.equalTo(lb_fuwu.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    
    ///店铺质量评分*lb_zhiliang;
    UILabel *lb_zhiliang = [UILabel new];
    lb_zhiliang.text = @"质量";
    lb_zhiliang.textColor = [UIColor lightGrayColor];
    lb_zhiliang.font = [UIFont systemFontOfSize:17.0*(screen_width/375.0)];
    [self.contentView addSubview:lb_zhiliang];
    [lb_zhiliang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_shopLogo.mas_bottom).with.offset(20);
        make.left.equalTo(lb_fuwu.mas_right).with.offset(distance);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
    
    self.lb_zhiliang = [UILabel new];
    self.lb_zhiliang.textColor = [UIColor colorWithHexString:@"#cf292e"];
    self.lb_zhiliang.font = [UIFont systemFontOfSize:17.0*(screen_width/375.0)];
    [self.contentView addSubview:self.lb_zhiliang];
    [self.lb_zhiliang mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.img_shopLogo.mas_bottom).with.offset(20);
        make.left.equalTo(lb_zhiliang.mas_right).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 20));
    }];
    
    ///进入店铺按钮*bt_goShop;
    self.bt_goShop = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bt_goShop setBackgroundImage:[UIImage imageNamed:@"enter_shop.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.bt_goShop];
    [self.bt_goShop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_shangpin.mas_bottom).with.offset(30);
        make.left.equalTo(self.mas_left).with.offset(35);
        make.size.mas_equalTo(CGSizeMake(103, 30));
    }];
    ///全部商品按钮*bt_allGoods;
    self.bt_allGoods = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bt_allGoods setBackgroundImage:[UIImage imageNamed:@"allgoods.png"] forState:UIControlStateNormal];
    [self.contentView addSubview:self.bt_allGoods];
    [self.bt_allGoods mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_shangpin.mas_bottom).with.offset(30);
        make.right.equalTo(self.mas_right).with.offset(-35);
        make.size.mas_equalTo(CGSizeMake(103, 30));
        
    }];
    
    
}

-(void)setCellDataWithModel:(GoodsDetailsModel*)model{
    
    [self.img_shopLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.shoplogo]]];
    self.lb_shopname.text =model.shopname;
    self.pj_stars.actualScore = [model.shopStar floatValue];
    self.lb_shangpin.text = model.goodsNum;
    self.lb_zhiliang.text = model.timeNum;
    self.lb_fuwu.text = model.serviceNum;
    
}
-(void)tap:(UITapGestureRecognizer*)sender{
    [_delegate respondsToSelector:@selector(goToShop:)];
    [_delegate goToShop:self];
    
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

@interface ShopModel ()

@end


@implementation ShopsCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    
    self.img_bgImg = [UIImageView new];
    self.img_bgImg.userInteractionEnabled = YES;
    //    self.img_bgImg.backgroundColor = [UIColor redColor];
    self.img_bgImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.img_bgImg];
    [self.img_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
        
        
    }];
    
    //    UIView *view = [UIView new];
    //    view.backgroundColor = RGBA(100, 30, 16, 0.3);
    //    [self.contentView addSubview:view];
    //    [view mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    //    }];
    
    
    
    
    self.img_shopLogo = [UIImageView new];
    self.img_shopLogo.contentMode = UIViewContentModeScaleAspectFit;
    
    [_img_bgImg addSubview:self.img_shopLogo];
    [self.img_shopLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(65, 65));
    }];
    
    self.lb_shopName = [UILabel new];
    self.lb_shopName.textColor = [UIColor whiteColor];
    [_img_bgImg addSubview:self.lb_shopName];
    [self.lb_shopName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.img_shopLogo.mas_right).with.offset(10);
        make.top.equalTo(self.img_shopLogo.mas_top).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(145, 22));
        
    }];
    
    
    //    self.img_imgLittle = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shop_enter.png"]];
    //    [_img_bgImg addSubview:self.img_imgLittle];
    //    [self.img_imgLittle mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.left.equalTo(self.lb_shopName.mas_right).with.offset(0);
    //        make.top.equalTo(self.img_shopLogo.mas_top).with.offset(5);
    //        make.size.mas_equalTo(CGSizeMake(22, 22));
    //
    //    }];
    
    self.lb_favorites = [UILabel new];
    self.lb_favorites.textColor  = [UIColor whiteColor];
    self.lb_favorites.font = [UIFont systemFontOfSize:14.0];
    [_img_bgImg addSubview:self.lb_favorites];
    [self.lb_favorites mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.img_shopLogo.mas_right).with.offset(10);
        make.top.equalTo(self.lb_shopName.mas_bottom).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(100, 22));
        
    }];
    
    self.btn_collection = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.btn_collection setImage:[UIImage imageNamed:@"shop_collection_unchecked"] forState:UIControlStateNormal];
    [self.btn_collection setImage:[UIImage imageNamed:@"shop_collection_selected"] forState:UIControlStateSelected];
    self.btn_collection.tag = 74682264;
    [_img_bgImg addSubview:self.btn_collection];
    [self.btn_collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_shopName.mas_top).with.offset(15);
        
        
        if (screen_width == 320) {
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(65, 28));
        }else{
            make.right.equalTo(self.mas_right).with.offset(-20);
            make.size.mas_equalTo(CGSizeMake(84.5, 36.4));
            
        }
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



