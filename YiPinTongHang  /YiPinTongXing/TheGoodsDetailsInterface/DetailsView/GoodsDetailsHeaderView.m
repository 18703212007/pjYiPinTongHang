//
//  GoodsDetailsHeaderView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "GoodsDetailsHeaderView.h"

@interface GoodsDetailsHeaderView()<SDCycleScrollViewDelegate>

@end


@implementation GoodsDetailsHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
    }
    return self;
}



-(void)setImgArray:(NSArray *)imgArray
{
    _imgArray = imgArray;
    self.sdCycleScro.imageURLStringsGroup = imgArray;
}

-(void)setUI{
    
    [self setTopScro];
}


-(void)setTopScro{
    
    self.headView = [UIView new];
    [self addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(screen_width);
    }];
    self.scrollView = [UIScrollView new];
    self.scrollView.contentSize = self.headView.size;
    [self.headView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    
    self.sdCycleScro = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    
    
    self.sdCycleScro.delegate = self;
    self.sdCycleScro.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.sdCycleScro.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.sdCycleScro.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    //    self.sdCycleScro.imageURLStringsGroup = self.imgArray;
    self.sdCycleScro.currentPageDotColor = [UIColor whiteColor];
    
    [self.scrollView addSubview:self.sdCycleScro];
    [self.sdCycleScro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headView);
    }];
    
}



-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
    if ([_delegate respondsToSelector:@selector(goodsDetailsHeaderView:Selectindex:)]) {
        [_delegate goodsDetailsHeaderView:self Selectindex:index];
    }
}




@end


@implementation GoodsDetailsCostomHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIView *view = [UIView new];
        [self addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.height.mas_equalTo(self.high);
            
        }];
        
    }
    return self;
}


@end




@implementation GoodsDetailsFooterView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

@end
