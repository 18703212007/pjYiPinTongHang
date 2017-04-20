//
//  StoreDetailsView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/23.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "StoreDetailsView.h"
#import "PJHeaderFlowLayout.h"
@implementation StoreDetailsView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    
    PJHeaderFlowLayout *layout = [[PJHeaderFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:rect(0, 0, 0, 0) collectionViewLayout:layout];
    layout.navHeight = 53.0;
    [layout  setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.collectionView.scrollEnabled = YES;
    self.collectionView.bounces = YES;
    
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}

@end
