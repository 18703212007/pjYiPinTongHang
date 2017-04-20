//
//  MyStoreViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "MyStoreViewController.h"
#import "HomeViewController.h"
#import "MyStoreCollectionHeaderView.h"
#import "PJHeaderFlowLayout.h"
#import "GoodsDetailsModel.h"
#import "GoodDetailsCollectionViewCell.h"
#import "HomeCollectionViewCell.h"
#import "GoodsDetailsController.h"
#import "MyStoreNavView.h"
#import "PJButton.h"
#import "StoreIntroductionViewController.h"
#import "StoreListViewController.h"
#import "SearchViewController.h"
@interface MyStoreViewController ()<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource,MyStoreHeaderViewDelegate
>

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UILabel *lb_title;

@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)MyStoreCollectionHeaderView *headerView;

@property(nonatomic,strong)ShopModel *shopModel;
@property(nonatomic,strong)PJHeaderFlowLayout *layout;

@property(nonatomic,strong)UICollectionView  *collectionView;

@property(nonatomic,strong)NSArray  *couponArray;

@property(nonatomic,strong)NSArray *contantArray;

@property(nonatomic,strong)NSDictionary *dic;

@property(nonatomic,strong)MyStoreNavView   *moreView;

@property(nonatomic,assign)CGFloat height;


@end

@implementation MyStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self CostomNav];
    [self getData];
    [self moreViewAdd];
    
       
    
    
    
    
}


-(void)moreViewAdd{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapRemove:)];
    [self.moreView addGestureRecognizer:tap];
    
    [self.moreView.bt_storeIntroduction addTarget:self action:@selector(bt_storeIntroduction:) forControlEvents:UIControlEventTouchUpInside];
    [self.moreView.bt_share addTarget:self action:@selector(bt_share:) forControlEvents:UIControlEventTouchUpInside];
    [self.moreView.bt_homePage addTarget:self action:@selector(bt_homePage:) forControlEvents:UIControlEventTouchUpInside];
    [self.moreView.bt_message addTarget:self action:@selector(bt_message:) forControlEvents:UIControlEventTouchUpInside];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(PJHeaderFlowLayout *)layout{
    if (_layout == nil) {
        _layout = [[PJHeaderFlowLayout alloc]init];
    }
    return _layout;
}

-(MyStoreNavView *)moreView{
    if(_moreView == nil){
        _moreView = [[MyStoreNavView alloc]init];
    }
    return _moreView;
    
    
}
-(void)setCollectionView{
    
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.layout.navHeight = 200;
    [self.layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.width.mas_equalTo(screen_width);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
        
        
    }];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    [self.collectionView registerClass:[LDetailedColViewCell class] forCellWithReuseIdentifier:@"ShopDetailsCOLLECTIONVIEWCell"];
    [self.collectionView registerClass:[MyStoreCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MyStoreCollectionHeaderView"];
    
}




-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    //    switch (section) {
    //        case 0:{///优惠券
    //            return 1;
    //            break;
    //        }
    //        case 1:{//内容
    //            return 10;
    //            break;
    //        }
    //        default:
    //            return 0;
    //            break;
    //    }
    return self.contantArray.count;
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return 1;
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LDetailedColViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopDetailsCOLLECTIONVIEWCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[LDetailedColViewCell alloc]init];
    }
    //    cell.backgroundColor  = [UIColor colorWithHexString:@"#f0f0f0"];
    CollectionGoodsModel *model = self.contantArray[indexPath.item];
    [cell setDataWithModel:model];
    return cell;
    
}


-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    static NSString *reusesidertifer;
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusesidertifer = @"MyStoreCollectionHeaderView";
        MyStoreCollectionHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"MyStoreCollectionHeaderView" forIndexPath:indexPath];
        header.delegate = self;
        header.shopID = self.shopID;
        self.height = header.colHeight;
        header.data = self.shopModel.shops;
        
        header.counponsArray = self.couponArray;
        //        [header returnDic:^(NSDictionary *dic) {
        //        }];
        return header;
        
    }else{
        return [[UICollectionReusableView alloc] init];
    }
    
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        if (self.couponArray.count == 0) {
            return CGSizeMake(screen_width, 175+0);
  
        }else{
        return CGSizeMake(screen_width, 175+80);
        }
    }else{
        return CGSizeMake(0, 0);
    }
    
}




-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((screen_width-12)/2.0, (screen_width-12)/2+53);
    
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    LDetailedColViewCell *cell = (LDetailedColViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    GoodsDetailsController *goods = [GoodsDetailsController new];
    goods.goodsID = cell.goodsID;
    goods.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    goods.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:goods animated:YES completion:^{
        
    }];
    
    
}

//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
//    return 4;
//}
//-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
//{
//    return 2;
//}



/*
 m=Customer&c=Shops&a=shopGoodsList
 */
-(void)getData{
    
    NSString *str = @"m=Customer&c=Shops&a=index";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,str] Method:HTTPRequestPost Paramenters:@{@"shopid":self.shopID,@"uid":UserID} PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        self.shopModel = [ShopModel mj_objectWithKeyValues:[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]];
        
        self.couponArray = [CouponModel mj_objectArrayWithKeyValuesArray:self.shopModel.couponList];
        
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in self.shopModel.Best) {
            CollectionGoodsModel *model = [CollectionGoodsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.contantArray = [NSArray arrayWithArray:array];
        
        [self setCollectionView];
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
/*
 
 
 
 */


-(void)myStoreHeaderView:(MyStoreCollectionHeaderView *)view Index:(NSInteger)index Dictionary:(NSDictionary *)dic
{
    NSString *urlstring;
    if (index == 0) {
        urlstring =@"m=Customer&c=Shops&a=index";
        
        [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:@{@"shopid":self.shopID,@"uid":UserID} PrepareExecute:^{
            
        } Success:^(NSURLSessionDataTask *task, id responseObject) {
            
            
            
            self.shopModel = [ShopModel mj_objectWithKeyValues:[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]];
            
            
            
            
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in self.shopModel.Best) {
                CollectionGoodsModel *model = [CollectionGoodsModel new];
                [model setValuesForKeysWithDictionary:dic];
                [array addObject:model];
            }
            self.contantArray = [NSArray arrayWithArray:array];
            
            [self.collectionView reloadData];
            
        } Failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        
    }else{
        urlstring =@"m=Customer&c=Shops&a=shopGoodsList";
        [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
            
        } Success:^(NSURLSessionDataTask *task, id responseObject) {
            
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
                
                CollectionGoodsModel *model = [CollectionGoodsModel new];
                
                [model setValuesForKeysWithDictionary:dic];
                [array addObject:model];
            }
            self.contantArray = [NSArray arrayWithArray:array];
            
            
            [self.collectionView reloadData];
        } Failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
    }
    
    
}

-(void)btnCollectionSelected:(BOOL)selected Btn:(UIButton *)btn myStoreHeaderView:(MyStoreCollectionHeaderView *)view{
    
    if ([k_defaults boolForKey:k_LoginStatus]) {
        NSDictionary *dic = @{@"id":self.shopID,@"type":@"shops",@"uid":UserID};
        [self setSelectedWithDictionary:dic];

        if (btn.selected) {
            [self alertWithMassage:@"取消收藏"];
        
        }else{
            [self alertWithMassage:@"已收藏"];
        }
        btn.selected = !btn.selected;
        
    }else{
        LoginViewController *login = [LoginViewController new];
        [self presentViewController:login animated:YES completion:^{
            btn.selected = !btn.selected;
            
        }];

    }
    

    
    
    
    /*  店铺Btn的点击事件啊 */
    
}


-(void)setSelectedWithDictionary:(NSDictionary*)dic{
    
    
    NSString *urlstring = @"m=Customer&c=Favorites&a=favoritesAdd";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}


#pragma mark -- 提示弹框 --
-(void)alertWithMassage:(NSString*)massage{
    
    
    CGFloat version = [[[UIDevice currentDevice]systemVersion] floatValue];
    
    if (version >= 8.0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:massage preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
        
    }
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

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
    view.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];
    [self.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    //    self.lb_title = [UILabel new];
    //    self.lb_title.textAlignment = NSTextAlignmentCenter;
    //    self.lb_title.textColor = [UIColor whiteColor];
    ////    self.lb_title.text = @"商品详情";
    //    [view addSubview:self.lb_title];
    //    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(view);
    //        make.top.equalTo(view.mas_top).with.offset(37);
    //        make.width.mas_equalTo(view);
    //        make.height.mas_equalTo(@26);
    //    }];
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
    
    
    UIButton *bt_more = [UIButton buttonWithType:UIButtonTypeCustom];
    [bt_more setImage:[UIImage imageNamed:(@"more.png")] forState:UIControlStateNormal];
    bt_more.tag = 20170326;
    [bt_more addTarget:self action:@selector(bt_more:) forControlEvents:UIControlEventTouchUpInside];
    ;
    [view addSubview:bt_more];
    [bt_more mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-2);
        make.top.equalTo(view.mas_top).with.offset(33);
        make.width.mas_equalTo(@33);
        make.height.mas_equalTo(@33);
    }];
    
    UIButton *bt_allList = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [bt_allList setImage:[UIImage imageNamed:(@"classification")] forState:UIControlStateNormal];
    [bt_allList addTarget:self action:@selector(bt_allList:) forControlEvents:UIControlEventTouchUpInside];
    ;
    [view addSubview:bt_allList];
    [bt_allList mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(bt_more.mas_left).with.offset(0);
        make.top.equalTo(view.mas_top).with.offset(32);
        make.width.mas_equalTo(@33);
        make.height.mas_equalTo(@33);
    }];
    
    
    
    
    
    self.searchBar = [[UISearchBar alloc]init];
    self.searchBar.placeholder = @"请输入搜索内容";
    self.searchBar.backgroundColor = [UIColor clearColor];
    self.searchBar.backgroundImage = [UIImage new];
    self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    /*
     typedef NS_ENUM(NSUInteger, UISearchBarStyle) {
     UISearchBarStyleDefault,    // currently UISearchBarStyleProminent
     UISearchBarStyleProminent,  // used my Mail, Messages and Contacts
     UISearchBarStyleMinimal     // used by Calendar, Notes and Music
     } NS_ENUM_AVAILABLE_IOS(7_0);
     
     */
    [view addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).with.offset(32);
        make.left.equalTo(backBtn.mas_right).with.offset(10);
        make.right.equalTo(bt_allList.mas_left).with.offset(-10);
        make.height.mas_equalTo(@33);
    }];
    UITextField *searchField = [_searchBar valueForKey:@"_searchField"];
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.backgroundColor = [UIColor clearColor];
    searchField.layer.cornerRadius = 4.0;
    searchField.leftViewMode=UITextFieldViewModeNever;
    searchField.textColor=[UIColor whiteColor];
    //改变placeholder的颜色
    
    [searchField setValue:[UIColor grayColor]forKeyPath:@"_placeholderLabel.textColor"];
    UIButton *btn_search = [UIButton buttonWithType:UIButtonTypeCustom];
    btn_search.backgroundColor = [UIColor clearColor];
    [self.searchBar addSubview:btn_search];
    [btn_search mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    [btn_search addTarget:self action:@selector(btn_search:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor whiteColor];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchBar.mas_bottom).with.offset(-0.5);
        make.left.equalTo(self.searchBar.mas_left).with.offset(0);
        make.width.equalTo(self.searchBar);
        make.height.mas_equalTo(@0.5);
    }];
    
    
    
    
    
    
    
}


-(void)btn_search:(UIButton*)sender{
#warning
    SearchViewController *store = [SearchViewController new];
    store.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    store.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:store animated:YES completion:^{
        
    }];
    
}


-(void)backBtn:(UIButton*)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}




-(void)bt_more:(UIButton *)sender{
    
    if (sender.selected == NO) {
        [UIView animateWithDuration:0.5f animations:^{
            
            [self.view addSubview:self.moreView];
            [self.moreView mas_makeConstraints:^(MASConstraintMaker *make) {
                
                //                make.top.equalTo(self.view.mas_top).with.offset(70);
                //                make.right.equalTo(self.view.mas_right).with.offset(0);
                //                make.width.mas_equalTo(@110);
                //                make.height.mas_equalTo(@168);
                make.edges.mas_offset(UIEdgeInsetsMake(70, 0, 0, 0));
                
            }];
            
        } completion:^(BOOL finished) {
            
        }];
    }else{
        [UIView animateWithDuration:0.5f animations:^{
            
            [self.moreView removeFromSuperview];
            
        } completion:^(BOOL finished) {
            
        }];
    }
    sender.selected  = !sender.selected;
    
}




#pragma mark - btn_share的事件处理 -
//分享
-(void)bt_share:(UIButton*)sender{
    
}
//店铺简介
-(void)bt_storeIntroduction:(UIButton*)sender{
    
    StoreIntroductionViewController *store = [StoreIntroductionViewController new];
    store.shopID = self.shopID;
    store.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    store.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:store animated:YES completion:nil];
}
//首页
-(void)bt_homePage:(UIButton*)sender{
    
    [self.presentingViewController.presentingViewController dismissViewControllerAnimated:NO completion:nil];
}
// 消息
-(void)bt_message:(UIButton*)sender{
    
    
    
    
}

-(void)tapRemove:(UITapGestureRecognizer*)sender{
    
    [self.moreView removeFromSuperview];
    UIButton *btn  = (UIButton*)[self.view viewWithTag:20170326];
    btn.selected = !btn.selected;
}



-(void)bt_allList:(UIButton *)sender{
    
    StoreListViewController *store = [StoreListViewController new];
    store.shopID = self.shopID;
    store.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    store.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:store animated:YES completion:^{
        
    }];
    
    
}



-(void)CouponCollectWithCouID:(NSString *)couID myStoreHeaderView:(MyStoreCollectionHeaderView *)view{
    
    [self getCouponToOursWithDictionary:@{@"uid":UserID,@"couponId":couID}];
    
}



-(void)getCouponToOursWithDictionary:(NSDictionary*)dic{
    
    NSString *urlString = @"m=Customer&c=Coupon&a=couponInsert";
    
    [[AFHTTPClient shareInstance ] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        [self alertWithMassage:[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"message"]];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}






@end
