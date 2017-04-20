//
//  ListView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/9.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ListView.h"


@interface ListView()

@end

@implementation ListView

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
    self.navView = [UIView new];
    [self addSubview: self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(screen_width, 74));
    }];
}



-(void)allViews{
    
    
    self.leftTableView = [UITableView new];
    self.leftTableView.bounces = NO;
    self.leftTableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.leftTableView.tableFooterView = [UIView new];
    [self addSubview:self.leftTableView];
    [self.leftTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.height.mas_equalTo(screen_height -49 -74);
        
        make.width.mas_equalTo(screen_width*0.25);
    }];
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.rightCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    self.rightCollectionView.backgroundColor = [UIColor whiteColor];
    [self addSubview: self.rightCollectionView];
    self.rightCollectionView.bounces = NO;
    [self.rightCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.leftTableView.mas_right).with.offset(0);
        make.height.mas_equalTo(screen_height-74-49);
        make.width.mas_equalTo(screen_width*0.75);
    }];
    
}








-(UITableView *)leftTableView
{
    if (!_leftTableView) {
        _leftTableView = [UITableView new];
        _leftTableView.rowHeight = 30;
        _leftTableView.showsVerticalScrollIndicator = NO;
        
        
    }
    return _leftTableView;
}

-(UICollectionView *)rightCollectionView
{
    if (!_rightCollectionView) {
        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
        
        [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
        //左右间距
        layout.minimumInteritemSpacing = 4;
        //上下间距
        layout.minimumLineSpacing = 4;
        _rightCollectionView = [[UICollectionView alloc]initWithFrame:rect(screen_width*0.25, 0, screen_width*0.75, screen_height-74-49) collectionViewLayout:layout];
        _rightCollectionView.showsVerticalScrollIndicator = NO;
        _rightCollectionView.showsHorizontalScrollIndicator = NO;
        [_rightCollectionView setBackgroundColor:[UIColor clearColor]];
        
    }
    return _rightCollectionView;
}


@end

#pragma mark -  -

#import "PJHeaderFlowLayout.h"
@interface ListSecoundView()
@property(nonatomic,strong)UIView *colView;

@end

@implementation ListSecoundView

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
    self.collectionView = [[UICollectionView alloc]initWithFrame:rect(0, 0, 0, 0) collectionViewLayout:layout];
    layout.navHeight = 53.0;
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


