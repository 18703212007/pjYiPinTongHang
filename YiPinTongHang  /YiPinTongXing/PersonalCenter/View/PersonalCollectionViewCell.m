//
//  PersonalCollectionViewCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/24.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PersonalCollectionViewCell.h"

@implementation PersonalCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.img_img = [UIImageView new];
    self.img_img.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.img_img];
    [self.img_img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(53, 43.5));
        //        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    
    
}

@end
