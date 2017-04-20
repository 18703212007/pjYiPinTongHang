//
//  LDetailedView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/27.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "LDetailedView.h"
#import "PJHeaderFlowLayout.h"
@interface LDetailedView()
@property(nonatomic,strong)UIView *colView;

@end


@implementation LDetailedView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
        [self allViews];
    }
    return self;
}


-(void)layout{
    
    /**
     collectionView
     */
    self.colView = [UIView new];
    [self addSubview:self.colView];
    [self.colView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom).with.offset(0);
    }];
    
}


-(void)allViews{
    
    /**
     collectionView
     */
    
    PJHeaderFlowLayout *layout = [[PJHeaderFlowLayout alloc]init];
    layout.navHeight  = 103.0;
    self.collectionView = [[UICollectionView alloc]initWithFrame:rect(0, 0, 0, 0) collectionViewLayout:layout];
    [layout  setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.collectionView.scrollEnabled = YES;
    self.collectionView.bounces = NO;
    
    self.collectionView.showsVerticalScrollIndicator = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.colView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}


#pragma mark - 懒加载 -


-(UIView *)colView{
    if (_colView == nil) {
        _colView = [UIView new];
    }
    return _colView;
}





@end









#import "LDetailedView.h"

#pragma mark - 2级分类 -

@interface ReclassifyView()



@end


@implementation ReclassifyView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self layout];
    }
    return self;
}

-(void)layout{
    
    
    self.tableView = [[UITableView alloc]initWithFrame:rect(0,0,0,0) style:UITableViewStylePlain];
    [self addSubview: self.tableView];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(UIEdgeInsetsMake(74, 0, 0, 0));
    }];
    
    
}

@end


