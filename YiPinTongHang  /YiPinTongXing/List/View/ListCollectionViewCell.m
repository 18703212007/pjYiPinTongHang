//
//  ListCollectionViewCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ListCollectionViewCell.h"
#import "ListCollectionViewHeaderView.h"
@implementation ListCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}


-(void)allViews{
    
    self.img = [UIImageView new];
    self.img.contentMode = UIViewContentModeScaleAspectFit;
    //    self.img.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(5);
        //        make.left.equalTo(self.mas_left).with.offset(4);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(self.width- 20);
        make.height.mas_equalTo(self.height- 40);
    }];
    
    self.nameCollection = [UILabel new];
    //    self.nameCollection.backgroundColor = [UIColor redColor];
    self.nameCollection.font =[UIFont systemFontOfSize:13.0];
    self.nameCollection.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.nameCollection];
    [self.nameCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.self.img.mas_bottom).with.offset(4);
        make.left.equalTo(self.mas_left).with.offset(4);
        make.width.mas_equalTo(self.width- 8);
        make.height.mas_equalTo(@24);
    }];
    
    
}


-(void)setDataWithModel:(ListModel *)model{
    
    self.nameCollection.text = model.catsName;
    
    [self.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.catsPic]]];
    self.catsID = model.catsId;
    
    
}









@end
