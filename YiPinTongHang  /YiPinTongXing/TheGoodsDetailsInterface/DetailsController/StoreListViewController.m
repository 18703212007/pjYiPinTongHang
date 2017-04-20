//
//  StoreListViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/23.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "StoreListViewController.h"
#import "GoodDetailsCollectionViewCell.h"
#import "MyStoreCollectionHeaderView.h"
#import "ListModel.h"
#import "StoreDetailsListViewController.h"
@interface StoreListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,StoreListHeaderViewDelegate>

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)NSArray *namecolArray;
@property(nonatomic,strong)NSArray *listArray;


@end

@implementation StoreListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
    [self CostomNav];
    [self getData];
}


-(void)setCollection{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.collectionView];
    [self.collectionView registerClass:[StoreListCollViewCell class] forCellWithReuseIdentifier:@"StoreListCollViewCell"];
    [self.collectionView registerClass:[StoreListCollectionViewCell class] forCellWithReuseIdentifier:@"StoreListCollectionViewCell"];
    [self.collectionView registerClass:[StoreListHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"StoreListHeaderView"];
    [self.collectionView registerClass:[StoreListFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"StoreListFooterView"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(screen_width);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
        
    }];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
}



-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.namecolArray.count+1;
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 1;
    }else{
        return [self.listArray[section-1] count];
    }
    
    return 10;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        StoreListCollViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreListCollViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[StoreListCollViewCell alloc]init];
        }
        cell.lb_name.text = @"全部商品";
        return cell;
    }else{
        
        
        StoreListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreListCollectionViewCell" forIndexPath:indexPath];
        
        if (cell == nil) {
            cell = [[StoreListCollectionViewCell alloc]init];
        }
        ListModel *model = self.listArray[indexPath.section-1][indexPath.row];
        
        [cell setDataWithModel:model];
        
        return cell;
    }
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        StoreListHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"StoreListHeaderView" forIndexPath:indexPath];
        if (indexPath.section == 0) {
            header.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        }else{
            CollectionModel *model = self.namecolArray[indexPath.section-1];
            header.lb_name.text = model.catsName;
            header.img_img.image = [UIImage imageNamed:@"personal_enter.png"];
            header.shopID = self.shopID;
            header.catsID = model.catsId;
            header.delegate = self;
            header.lb_allgoods.text = @"全部商品";
        }
        
        return header;
    }else{
        StoreListFooterView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"StoreListFooterView" forIndexPath:indexPath];
        
        return footer;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(screen_width, 50);
    }else{
        
        return CGSizeMake((screen_width-4)/2.0, 50);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(screen_width, 10);
    }else{
        
        return CGSizeMake(screen_width, 50);
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeMake(screen_width, 10);
    }else{
        return CGSizeMake(0, 0);
    }
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 2;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    StoreDetailsListViewController *storeVC = [StoreDetailsListViewController new];
    if (indexPath.section == 0) {
        StoreListCollViewCell *cell = (StoreListCollViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        
        storeVC.shopID = self.shopID;
        storeVC.dic = @{@"shopid":self.shopID
                        };
        storeVC.titleStr = cell.lb_name.text;
        
        
        
    }else{
        StoreListCollectionViewCell *cell = (StoreListCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        
        storeVC.shopID = self.shopID;
        storeVC.catsID = cell.catsID;
        storeVC.dic = @{@"shopid":self.shopID,
                        @"catsid":cell.catsID
                        };
        storeVC.titleStr = cell.lb_name.text;
    }
    storeVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    storeVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:storeVC animated:YES completion:^{
        
    }];
    
    
}









#pragma mark - 自定义NV -
-(void)CostomNav{
    
    __weak typeof(self) weakself = self;
    self.navView = [UIView new];
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top).with.offset(0);
        make.left.equalTo(weakself.view.mas_left).with.offset(0);
        make.right.equalTo(weakself.view.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.navView.mas_top).with.offset(0);
        make.left.equalTo(weakself.navView.mas_left).with.offset(0);
        make.right.equalTo(weakself.navView.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    
    UILabel *title = [UILabel new];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"宝贝分类";
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(view);
        make.height.mas_equalTo(@26);
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:(@"sign_in_return.png")] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(8);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
}
-(void)backBtn:(UIButton*)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



-(void)getData{
    
    NSString *urlstring = @"m=Customer&c=ShopsCats&a=shopCats";
    
    NSDictionary *dic = @{@"shopid":self.shopID};//self.shopID
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSMutableArray *namecolArray =[NSMutableArray array];;
        
        NSMutableArray *listArray = [NSMutableArray array];
        for (NSDictionary *dict in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            CollectionModel *model = [CollectionModel new];
            [model setValuesForKeysWithDictionary:dict];
            [namecolArray addObject:model];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in [dict objectForKey:@"cats2"]) {
                ListModel *mode = [ListModel new];
                [mode setValuesForKeysWithDictionary:dic];
                [arr addObject:mode];
                
            }
            [listArray addObject:arr];
        }
        self.namecolArray = [NSArray arrayWithArray:namecolArray];
        self.listArray = [NSArray arrayWithArray:listArray];
        [self setCollection];
        [self.collectionView reloadData];
        
        
        
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
}
#pragma mark - headerViewDelegate -
-(void)storeHeaderView:(StoreListHeaderView *)storeHeaderView AllID:(NSDictionary *)allID :(NSString*)title
{
    StoreDetailsListViewController *storeVC = [StoreDetailsListViewController new];
    
    
    storeVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    storeVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    storeVC.dic = allID;
    storeVC.shopID = [allID objectForKey:@"shopid"];
    storeVC.catsID = [allID objectForKey:@"catsid"];
    storeVC.titleStr = title;
    
    [self presentViewController:storeVC animated:YES completion:^{
        
    }];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
