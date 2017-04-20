//
//  ListDetailedController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/27.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ListDetailedController.h"
#import "HomeCollectionViewCell.h"
#import "HomeTableViewCell.h"
#import "LDetailedView.h"
#import "ListCollectionViewHeaderView.h"
#import "GoodsDetailsController.h"
@interface ListDetailedController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,listThirdHeaderViewDelegate,MBProgressHUDDelegate>



@property(nonatomic,strong)LDetailedView  *detailedView;

@property(nonatomic,strong)NSArray *topColArray;

@property(nonatomic,strong)NSArray *contentArray;

@property(nonatomic,strong)UIImageView *bgImg;
@end

@implementation ListDetailedController

-(void)loadView{
    
    self.detailedView = [[LDetailedView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.detailedView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self HUDShowWithView:self.view];
    [self getData];
    
}

-(void)HUDShowWithView:(UIView*)view{
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.delegate = self;
    //    hud.dimBackground = YES;
    hud.labelText = @"努力加载中…";
    hud.color = RGBA(28, 88, 66, 0.1);
    UIImage *image = [[UIImage imageNamed:@"HUD"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.toValue = @(M_PI*2);
    anima.duration = 1.5f;
    anima.repeatCount = 10;
    [imgView.layer addAnimation:anima forKey:nil];
    hud.customView = imgView;
    
    //        hud.bezelView.color = [UIColor colorWithWhite:0.0 alpha:1];
    //文字颜色
    hud.labelColor = [UIColor blackColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType = MBProgressHUDAnimationZoom;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setCollection{
    
    self.detailedView.collectionView.delegate = self;
    self.detailedView.collectionView.dataSource = self;
    [self.detailedView.collectionView registerClass:[LDetailedColViewCell class] forCellWithReuseIdentifier:@"LDetailedColViewCell"];
    [self.detailedView.collectionView registerClass:[ListThirdCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ListThirdCollectionHeaderView"];
    
}

#pragma mark - collectionViewDelegate And DataSourece -
/// Section
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
}
///Items
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return self.contentArray.count;
}

/// Cell
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LDetailedColViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"LDetailedColViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[LDetailedColViewCell alloc]init];
    }
    CollectionGoodsModel *model = self.contentArray[indexPath.item];
    [cell setDataWithModel:model];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
    
    
}

/// 点击
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    //    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    LDetailedColViewCell *cell = (LDetailedColViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    GoodsDetailsController *goods = [GoodsDetailsController new];
    goods.goodsID = cell.goodsID;
    [self presentViewController:goods animated:YES completion:^{
        
    }];
    
    
    
    
}
// Item 的Size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake((screen_width-12)/2, (screen_width-12)/2+53);
}


/// Cell 是否可以被选中
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    static NSString *reusesidertifer;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusesidertifer = @"ListThirdCollectionHeaderView";
        ListThirdCollectionHeaderView *thirdHeader = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ListThirdCollectionHeaderView" forIndexPath:indexPath];
        [thirdHeader.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        thirdHeader.delegate = self;
        thirdHeader.topColArray = self.topColArray;
        return thirdHeader;
        
    }else{
        UICollectionReusableView *footerView = [[UICollectionReusableView alloc]init];
        [_bgImg sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"wushuju"]];
        [footerView addSubview:_bgImg];
        [_bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(footerView.mas_top).with.offset(0);
            make.left.equalTo(footerView.mas_left).with.offset(0);
            make.right.equalTo(footerView.mas_right).with.offset(0);
            make.right.equalTo(footerView.mas_bottom).with.offset(0);
        }];
        
        return footerView;
    }
    
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(screen_width, 175);
}







#pragma mark - 自定义NVa -
-(void)CostomNav{
    
    self.navigationController.navigationBar.hidden = YES;
    //
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];
    [self.detailedView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.detailedView.mas_top).with.offset(0);
        make.left.equalTo(self.detailedView.mas_left).with.offset(0);
        make.right.equalTo(self.detailedView.mas_right).with.offset(0);
        make.height.mas_equalTo(@23);
        
    }];
    
    
}






-(void)backBtn:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


-(void)getData{
#pragma mark -- 列表 --
    /**
     
     */
    NSString *pjUrlString = @"m=Customer&c=GoodsCats&a=typeList2";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:@{@"typeid":self.catsID} PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            LDetailedCollectionModel *model = [LDetailedCollectionModel new];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.topColArray = [NSArray arrayWithArray:array];
        [self setCollection];
        [self CostomNav];
        
        
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    /**
     
     */
    NSString *string =@"m=Customer&c=Goods&a=goodsList";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,string] Method:HTTPRequestPost Paramenters:@{@"catsid":self.catsID} PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            CollectionGoodsModel *model = [CollectionGoodsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [arr addObject:model];
        }
        self.contentArray = [NSArray arrayWithArray:arr];
        [self.detailedView.collectionView reloadData];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}


#pragma mark - 代理实现 -

-(void)listThirdHeaderView:(ListThirdCollectionHeaderView *)listThirdHeaderView Dictionary:(NSDictionary *)dic
{
    NSString *str = @"m=Customer&c=Goods&a=goodsList";
    
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,str] Method:HTTPRequestPost Paramenters:dic PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            CollectionGoodsModel *model = [CollectionGoodsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.contentArray  = [NSArray arrayWithArray:array];
        
        [self.detailedView .collectionView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

#pragma mark - 筛选 -
-(void)listThirdHeaderView:(ListThirdCollectionHeaderView *)listThirdHeaderView Flag:(NSDictionary *)flag
{
    NSString *str = @"m=Customer&c=Goods&a=goodsList";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,str] Method:HTTPRequestPost Paramenters:flag PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            CollectionGoodsModel *model = [CollectionGoodsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.contentArray  = [NSArray arrayWithArray:array];
        
        [self.detailedView .collectionView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}











-(UIImageView *)bgImg{
    if (_bgImg == nil) {
        _bgImg = [UIImageView new];
    }
    return _bgImg;
}

@end
