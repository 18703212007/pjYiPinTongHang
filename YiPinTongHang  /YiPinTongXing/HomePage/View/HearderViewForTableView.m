//
//  HearderViewForTableView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/6.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "HearderViewForTableView.h"
#import "HomeCollectionViewCell.h"
#import "HomeModel.h"
@interface HearderViewForTableView()<SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property(nonatomic,strong) SDCycleScrollView *cycleView;

@property(nonatomic,strong) NSMutableArray *shufflingIDArrray;

@property(nonatomic,strong) NSMutableArray *shufflingIMGArrray;
@property(nonatomic,strong) NSMutableArray *shufflingTitleArrray;
@property(nonatomic,strong) NSMutableArray *shufflingURLArrray;



@property(nonatomic,strong)NSMutableArray  *catsIdArray;

@property(nonatomic,strong)NSMutableArray *catsPicArray;

@property(nonatomic,strong)NSMutableArray *catsNameArray;

@property(nonatomic,strong)UIImageView *img;



@end

@implementation HearderViewForTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUI];
        
    }
    return self;
}



-(void)setCycleArray:(NSArray *)cycleArray{
    _cycleArray = cycleArray;
    self.shufflingURLArrray =   [NSMutableArray array];
    self.shufflingTitleArrray = [NSMutableArray array];
    self.shufflingIDArrray =    [NSMutableArray array];
    self.shufflingIMGArrray =   [NSMutableArray array];
    for (ShufflingModel *model in cycleArray) {
        [self.shufflingIDArrray addObject:model.adsId];
        [self.shufflingIMGArrray addObject:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.adsFile]];
        [self.shufflingURLArrray addObject:model.adsUrl];
        [self.shufflingTitleArrray addObject:model.adsName];
        
    }
    self.cycleView.imageURLStringsGroup =self.shufflingIMGArrray;
    self.cycleView.titlesGroup = self.shufflingTitleArrray;
}


-(void)setColArray:(NSArray *)colArray{
    _colArray = colArray;
    self.catsIdArray = [NSMutableArray array];
    self.catsPicArray = [NSMutableArray array];
    self.catsNameArray = [NSMutableArray array];
    for (HomeListModel *model  in colArray) {
        [self.catsNameArray addObject:model.catsName];
        [self.catsIdArray addObject:model.catsId];
        [self.catsPicArray addObject:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.catsPic]];
    }
    [self setCollection];
    
}


-(void)setImgUrl:(NSString *)ImgUrl{
    _ImgUrl = ImgUrl;
    [_img sd_setImageWithURL:[NSURL URLWithString:ImgUrl]];
}

-(void)setUI{
    
    [self setCycle];
    UIView *view = [UIView new];
    [self addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(250);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@50);
    }];
    
    self.img = [UIImageView new];
    self.img.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview: self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        if (screen_width>=414) {
            make.centerX.equalTo(view);
            make.top.equalTo(view.mas_top).with.offset(10);
            make.bottom.equalTo(view.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(100);
        }else{
            make.center.equalTo(view);
            
        }
        
    }];
    
    
}


-(void)setCycle{
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.contentSize = CGSizeMake(screen_width, 160);
    [self addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@160);
    }];
    
    self.cycleView = [[SDCycleScrollView alloc]init];
    self.cycleView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.cycleView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    self.cycleView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.cycleView.currentPageDotColor = [UIColor whiteColor];
    self.cycleView.delegate = self;
    [scrollView addSubview:self.cycleView];
    [self.cycleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@160);
        
    }];
    
}

-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if ([_delegate respondsToSelector:@selector(headerView:StringID:Title:URL:ImgString:)]) {
        [_delegate headerView:self StringID:self.shufflingIDArrray[index] Title:self.shufflingTitleArrray[index] URL:self.shufflingURLArrray[index] ImgString:self.shufflingIMGArrray[index]];
    }
    
}





-(void)setCollection{
    
    /**
     collectionView
     */
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:rect(0, 0, 0, 0) collectionViewLayout:layout];
    layout.minimumLineSpacing = 2;
    layout.minimumInteritemSpacing = 2;
    [layout  setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(160);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@90);
        
    }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[ReclassifyCollectionViewCell class] forCellWithReuseIdentifier:@"ReclassifyCollectionViewCell"];
    
    
    
}

#pragma mark - collectionViewDelegate And DataSourece -
/// Section
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
///Items
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    return self.colArray.count;
}

/// Cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ReclassifyCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"ReclassifyCollectionViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ReclassifyCollectionViewCell alloc]init];
    }
    HomeListModel *model = self.colArray[indexPath.item];
    
    [cell setDataViewModel:model];
    return cell;
    
    
}

/// 点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([_delegate  respondsToSelector:@selector(headerView:CatsID:)]) {
        [_delegate headerView:self CatsID:self.catsIdArray[indexPath.item]];
    }
    
    
    
    
    
    
    
    
}
/// Item 的Size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(80, 80);
}


/// Cell 是否可以被选中
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}





@end
