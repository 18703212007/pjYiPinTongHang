//
//  SpecLabelCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "SpecLabelCell.h"

@implementation SpecLabelCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}


-(void)setUI{
   
    self.backImage = [UIImageView new];
    self.backImage.contentMode = UIViewContentModeScaleToFill;
    [self.contentView addSubview:self.backImage];
    [self.backImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = [UIFont systemFontOfSize:14.0];
    [self.backImage addSubview:self.nameLabel];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.center.equalTo(self.backImage);
    }];
    
    
    
}

@end
