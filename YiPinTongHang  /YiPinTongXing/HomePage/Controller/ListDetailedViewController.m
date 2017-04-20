//
//  ListDetailedViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ListDetailedViewController.h"
#import "ListView.h"
#import "HomeCollectionViewCell.h"
#import "ListCollectionViewHeaderView.h"
#import "GoodsDetailsController.h"




@interface ListDetailedViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,listDetailedColHeaderViewDelegate>

@property(nonatomic,strong)ListSecoundView *baseView;

@property(nonatomic,strong)NSArray *contentArray;

@property(nonatomic,strong)UIImageView *bgImg;


@end

@implementation ListDetailedViewController


-(void)loadView{
    self.baseView = [[ListSecoundView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.baseView;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self CostomNav];
    [self setCollection];
    NSDictionary *dic = @{@"catsid":self.catsID};
    [self getDataWithDictionary:dic];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setCollection{
    
    self.baseView.collectionView.delegate = self;
    self.baseView.collectionView.dataSource = self;
    [self.baseView.collectionView registerClass:[LDetailedColViewCell class] forCellWithReuseIdentifier:@"ListDetailedColViewCell"];
    [self.baseView.collectionView registerClass:[listDetailedColHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"listDetailedColHeaderView"];
    
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
    
    LDetailedColViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"ListDetailedColViewCell" forIndexPath:indexPath];
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
    
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    LDetailedColViewCell *cell = (LDetailedColViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    GoodsDetailsController *goods = [GoodsDetailsController new];
    self.titleStr = cell.title.text;
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
        reusesidertifer = @"listDetailedColHeaderView";
        listDetailedColHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:reusesidertifer forIndexPath:indexPath];
        
        header.delegate   = self;
        header.catsID   = self.catsID;
        header.lb_title.text = self.titleStr;
        
        
        
        [header.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        return header;
        
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
    return CGSizeMake(screen_width, 125);
}






-(void)getDataWithDictionary:(NSDictionary*)dic{
    
    NSString *str = @"m=Customer&c=Goods&a=goodsList";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,str] Method:HTTPRequestPost Paramenters:dic PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *arr = [NSMutableArray array];
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            CollectionGoodsModel *model = [CollectionGoodsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [arr addObject:model];
        }
        self.contentArray = [NSArray arrayWithArray:arr];
        [self setCollection];
        [self.baseView.collectionView reloadData];
        
        //        [SVProgressHUD dismiss];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}


#pragma mark - 代理方法 -

-(void)listHeaderView:(listDetailedColHeaderView *)listThirdView Flag:(NSDictionary *)flag{
    
    NSString *str = @"m=Customer&c=Goods&a=goodsList";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,str] Method:HTTPRequestPost Paramenters:flag PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            CollectionGoodsModel *model = [CollectionGoodsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.contentArray  = [NSArray arrayWithArray:array];
        
        [self.baseView .collectionView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}



#pragma mark - 自定义NVa -
-(void)CostomNav{
    
    self.navigationController.navigationBar.hidden = YES;
    //
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];
    [self.baseView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.baseView.mas_top).with.offset(0);
        make.left.equalTo(self.baseView.mas_left).with.offset(0);
        make.right.equalTo(self.baseView.mas_right).with.offset(0);
        make.height.mas_equalTo(@23);
        
    }];
    
    
}



-(void)backBtn:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
