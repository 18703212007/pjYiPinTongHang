//
//  PersonalCollectionReusableView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/24.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PersonalCollectionReusableView.h"
#import "HomeCollectionViewCell.h"
@interface PersonalCollectionReusableView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_array;
    NSArray *_contantArray;
}
@property(nonatomic,strong)UICollectionView *collectionView;

@end
@implementation PersonalCollectionReusableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _array = @[@"商品收藏",@"店铺收藏"];
        [self setUI];
    }
    return self;
}
-(void)setUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[BtnCollectionViewCell class] forCellWithReuseIdentifier:@"CouponcollectionCell"];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CouponcollectionCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BtnCollectionViewCell alloc]init];
    }
    cell.title.text = _array[indexPath.item];
    
    
    if (_contantArray.count == 0) {
        if (indexPath.item == 0) {
            cell.title.textColor = [UIColor redColor];
            cell.line.hidden = NO;
        }else{
            cell.title.textColor = [UIColor blackColor];
            cell.line.hidden = YES;
        }
    }else{
        if([_contantArray containsObject:_array[indexPath.item]]){
            
            cell.title.textColor = [UIColor redColor];
            cell.line.hidden = NO;
        }else{
            cell.title.textColor = [UIColor blackColor];
            cell.line.hidden = YES;
        }
        
    }
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _contantArray = [NSMutableArray arrayWithObject:_array[indexPath.item]];
    [self.collectionView reloadData];
    
    
    if ([_delegate respondsToSelector:@selector(PersonalCollectionReusableView:index:)]) {
        [_delegate PersonalCollectionReusableView:self index:indexPath.item];
    }
    
}





-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screen_width/2.0, 50);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}



@end





