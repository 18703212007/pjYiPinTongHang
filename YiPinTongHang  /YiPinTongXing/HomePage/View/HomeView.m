//
//  HomeView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/14.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "HomeView.h"

@interface HomeView()<UIScrollViewDelegate>




@end

@implementation HomeView

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBgView];
        [self allViews];
    }
    return self;
}


-(void)setBgView{
    
    __weak typeof(self) weakself = self;
    /**
     导航View
     */
    self.navView = [UIView new];
    self.navView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).with.offset(0);
        make.left.equalTo(weakself.mas_left).with.offset(0);
        make.right.equalTo(weakself.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    /**
     其他View
     */
    self.otherView = [UIView new];
    [self addSubview:self.otherView];
    self.otherView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];;
    
    [self.otherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.navView.mas_bottom).with.offset(0);
        make.left.equalTo(weakself.mas_left).with.offset(0);
        make.right.equalTo(weakself.mas_right).with.offset(0);
        make.bottom.equalTo(weakself.mas_bottom).with.offset(-49);
    }];
    
    
}
#pragma mark - 布局其他View -
-(void)allViews{
    __weak typeof(self) weakself = self;
    
    self.bgScrollView = [UIScrollView new];
    
    
#pragma mark -- contentSize --
#warning 问题
    self.bgScrollView.contentSize = CGSizeMake(0, 1429+(screen_width-30)/2.0);//1630
    self.bgScrollView.showsVerticalScrollIndicator = NO;
    self.bgScrollView.showsHorizontalScrollIndicator = NO;
    self.bgScrollView.delegate = self;
    self.bgScrollView.tag = 1989;
    self.bgScrollView.bounces = NO;
    
    [self.otherView addSubview:self.bgScrollView];
    [self.bgScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(weakself.otherView);
    }];
    self.topAdsView = [UIView new];
    [self.bgScrollView addSubview:self.topAdsView];
    [self.topAdsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.otherView.mas_topMargin).with.offset(-10);
        make.left.equalTo(weakself.otherView.mas_left).with.offset(0);
        make.right.equalTo(weakself.otherView.mas_right).with.offset(0);
        make.height.mas_equalTo(@180);
    }];
    
    self.listView = [UIView new];
    [self.bgScrollView addSubview:self.listView];
    [self.listView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.topAdsView.mas_bottom).with.offset(0);
        make.left.equalTo(weakself.otherView.mas_left).with.offset(0);
        make.right.equalTo(weakself.otherView.mas_right).with.offset(0);
        make.height.mas_equalTo(@180);
    }];
    /*
     
     **/
    [self setList];
    
    
    
    self.bottomAdsView = [UIView new];
    [self.bgScrollView addSubview:self.bottomAdsView];
    [self.bottomAdsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.listView.mas_bottom).with.offset(10);
        make.left.equalTo(weakself.otherView.mas_left).with.offset(0);
        make.right.equalTo(weakself.otherView.mas_right).with.offset(0);
        make.height.mas_equalTo(@167);
    }];
    self.hotHeadView = [UIImageView new];
    
    [self.bgScrollView addSubview:self.hotHeadView];
    [self.hotHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.bottomAdsView.mas_bottom).with.offset(10);
        make.left.equalTo(weakself.otherView.mas_left).with.offset(0);
        make.right.equalTo(weakself.otherView.mas_right).with.offset(0);
        make.height.mas_equalTo(@50);
    }];
    self.hotImg = [UIImageView new];
    self.hotImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.hotHeadView addSubview:self.hotImg];
    [self.hotImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (screen_width>=414) {
            make.centerX.equalTo(weakself.hotHeadView);
            make.top.equalTo(weakself.hotHeadView.mas_top).with.offset(10);
            make.bottom.equalTo(weakself.hotHeadView.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(100);
        }else{
            make.center.equalTo(weakself.hotHeadView);
        }
        
        
        
    }];
    
    
    
    self.hotView = [UIView new];
    [self.bgScrollView addSubview:self.hotView];
    [self.hotView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.hotHeadView.mas_bottom).with.offset(0);
        make.left.equalTo(weakself.otherView.mas_left).with.offset(0);
        make.right.equalTo(weakself.otherView.mas_right).with.offset(0);
        make.height.mas_equalTo((screen_width-30)/2);
    }];
    /**
     
     */
    [self setHot];
    
    
    self.popularHeadView  = [UIImageView new];
    self.popularHeadView.backgroundColor = [UIColor colorWithHexString:@"f0f0f0"];;
    
    [self.bgScrollView addSubview:self.popularHeadView];
    [self.popularHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.hotView.mas_bottom).with.offset(0);
        make.left.equalTo(weakself.otherView.mas_left).with.offset(0);
        make.right.equalTo(weakself.otherView.mas_right).with.offset(0);
        make.height.mas_equalTo(@50);
    }];
    self.popularImg = [UIImageView new];
    self.popularImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.popularHeadView addSubview:self.popularImg];
    [self.popularImg mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (screen_width>=414) {
            make.centerX.equalTo(weakself.popularHeadView);
            make.top.equalTo(weakself.popularHeadView.mas_top).with.offset(10);
            make.bottom.equalTo(weakself.popularHeadView.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(100);
        }else{
            make.center.equalTo(weakself.popularHeadView);
            
        }
    }];
    
    
    self.popularityView = [UIView new];
    [self.bgScrollView addSubview:self.popularityView];
    [self.popularityView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.popularHeadView.mas_bottom).with.offset(0);
        make.left.equalTo(weakself.otherView.mas_left).with.offset(0);
        make.right.equalTo(weakself.otherView.mas_right).with.offset(0);
        make.height.mas_equalTo(@782);
    }];
    [self setPopular];
    
}

-(void)setList{
    
    /* ----------------------------替换代码增加维护性------------------------------ */
    
    
    
    /*----------------2017年02月23日12:46:56修改的代码-------------------------*/
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    
    self.listCollectionView = [[UICollectionView alloc]initWithFrame:rect(0, 0, 0, 0) collectionViewLayout:layout];
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    //    layout.itemSize = CGSizeMake(screen_width, 180);
    self.listCollectionView.alwaysBounceHorizontal = YES;
    self.listCollectionView.tag = 7777;
    [layout  setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.listCollectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.listCollectionView.scrollEnabled = YES;
    self.listCollectionView.pagingEnabled = YES;
    self.listCollectionView.bounces = NO;
    self.listCollectionView.showsVerticalScrollIndicator = NO;
    self.listCollectionView.showsHorizontalScrollIndicator = NO;
    [self.listView addSubview:self.listCollectionView];
    [self.listCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    
    
    
    
    /* -----------------------------替换代码增加维护性-------------------------------- */
    
    
}



-(void)setHot{
    
    
#pragma mark - 在修改的代码 warning-
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    
    self.hotCollectionView = [[UICollectionView alloc]initWithFrame:rect(0, 0, 0, 0) collectionViewLayout:layout];
    layout.minimumLineSpacing = 6;
    //    layout.minimumInteritemSpacing = 2;
    self.hotCollectionView.tag = 88888;
    
    //    layout.itemSize = CGSizeMake(screen_width, 180);
    self.hotCollectionView.alwaysBounceHorizontal = YES;
    self.hotCollectionView.bounces = NO;
    [layout  setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.hotCollectionView.backgroundColor = [UIColor whiteColor];
    self.hotCollectionView.scrollEnabled = YES;
    self.hotCollectionView.showsVerticalScrollIndicator = NO;
    self.hotCollectionView.showsHorizontalScrollIndicator = NO;
    [self.hotView addSubview:self.hotCollectionView];
    [self.hotCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}

-(void)setPopular{
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    
    self.popularCollectionView = [[UICollectionView alloc]initWithFrame:rect(0, 0, 0, 0) collectionViewLayout:layout];
    layout.minimumLineSpacing = 6;
    layout.minimumInteritemSpacing = 2;
    
    //    layout.itemSize = CGSizeMake(screen_width, 180);
    self.popularCollectionView.tag = 99999;
    
    self.popularCollectionView.alwaysBounceHorizontal = YES;
    [layout  setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.popularCollectionView.backgroundColor = [UIColor whiteColor];
    self.popularCollectionView.scrollEnabled = NO;
    self.popularCollectionView.bounces = NO;
    self.popularCollectionView.showsVerticalScrollIndicator = NO;
    self.popularCollectionView.showsHorizontalScrollIndicator = NO;
    [self.popularityView addSubview:self.popularCollectionView];
    [self.popularCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}


#pragma mark - PageControl滑动 -
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    CGFloat x = scrollView.contentOffset.x;
    CGFloat y = scrollView.contentOffset.y;
    
    if (scrollView.tag == 1989) {
        
        if (y >= 800) {
            
            self.popularCollectionView.scrollEnabled = YES;
        }else{
            self.popularCollectionView.scrollEnabled = NO;
        }
    }else if(scrollView.tag == 1990) {
        CGFloat scrollViewW  = scrollView.width;
        int page = (x + scrollViewW/2)/scrollViewW;
        
        self.pageControl.currentPage = page;
    }else{
//        NSLog(@"不对么");
    }
    
    
}






@end
