//
//  ReclassifyViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/27.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ReclassifyViewController.h"
#import "LDetailedView.h"
#import "HomeTableViewCell.h"
#import "HomeCollectionViewCell.h"
#import "HomeWebViewController.h"
#import "HomeModel.h"
#import "ListDetailedController.h"
#import "HearderViewForTableView.h"
#import "GoodsDetailsController.h"
@interface ReclassifyViewController ()<UITableViewDelegate,UITableViewDataSource,headerViewForTableDelegate>


{
    NSString *_str;
}


@property(nonatomic,strong)ReclassifyView *reClassifyView;




#pragma mark - topAds范围 -

@property(nonatomic,strong)NSArray *CycleArray;



///
@property(nonatomic,strong)NSMutableArray *cats2listArray;
///
@property(nonatomic,strong)NSMutableArray *HomeListRecommendArray;

@property(nonatomic,strong)UIImageView *bgImg;

@end

@implementation ReclassifyViewController



-(void)loadView{
    
    self.reClassifyView = [[ReclassifyView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.reClassifyView.backgroundColor = [UIColor whiteColor];
    
    self.view = self.reClassifyView;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self CostomNav];
    //    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    //    [SVProgressHUD show];
    [self getData];
}


-(void)setTable{
    
    self.reClassifyView.tableView.delegate = self;
    self.reClassifyView.tableView.dataSource = self;
    [self.reClassifyView.tableView registerClass:[CollectionGoodsTableCell class] forCellReuseIdentifier:@"CollectionGoodsTableCell"];
    
    
    
}



#pragma mark - 自定义NVa -
-(void)CostomNav{
    
    self.navigationController.navigationBar.hidden = YES;
    //
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.reClassifyView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.reClassifyView.mas_left).with.offset(0);
        make.top.equalTo(self.reClassifyView.mas_top).with.offset(0);
        make.width.mas_equalTo(screen_width);
        make.height.mas_equalTo(74);
    }];
    UILabel *navLabel = [UILabel new];
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.textColor = [UIColor whiteColor];
    navLabel.text = @"";
    [view addSubview:navLabel];
    [navLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(@35);
        make.height.mas_equalTo(@22);
    }];
    UIImageView *navImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"home_page_words.png"]];
    CGFloat width1 = navImg.image.size.width;
    CGFloat height1 = navImg.image.size.height;
    [view addSubview:navImg];
    [navImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(width1);
        make.height.mas_equalTo(height1);
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


-(void)backBtn:(UIButton*)sebder{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}




#pragma mark - TableViewDelegate And DataSources -

///section
//-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//
//    return 1;
//}
///rows
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.HomeListRecommendArray.count;
}
/// cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CollectionGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionGoodsTableCell"];
    
    if (cell == nil) {
        cell = [[CollectionGoodsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionGoodsTableCell"];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    
    CollectionGoodsModel *model = self.HomeListRecommendArray[indexPath.row];
    
    [cell setCellDataWithModel:model];
    return cell;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.reClassifyView.headerView = [[HearderViewForTableView alloc]init];
    self.reClassifyView.headerView.delegate = self;
    self.reClassifyView.headerView.cycleArray = self.CycleArray;
    self.reClassifyView.tableView.tableHeaderView = self.reClassifyView.headerView;
    self.reClassifyView.headerView.colArray = self.cats2listArray;
    self.reClassifyView.headerView.ImgUrl = _str;
    
    return self.reClassifyView.headerView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 300;
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 140;
}


/// 点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    CollectionGoodsTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    GoodsDetailsController *goods = [GoodsDetailsController new];
    goods.goodsID = cell.goodsID;
    [self presentViewController:goods animated:YES completion:^{
        
    }];
    
}


#pragma mark - 数据解析 -
-(void)getData{
    NSString  *url = k_Yptx_URL;
    /**
     
     */
    NSString *shufflingStr = @"m=Customer&c=Ads&a=typeGoods2";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,shufflingStr] Method:HTTPRequestPost Paramenters:nil PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"data"]) {
            ShufflingModel *model = [ShufflingModel new];
            [model setValuesForKeysWithDictionary:dict];
            [array addObject:model];
            
        }
        self.CycleArray  = [NSArray arrayWithArray:array];
        [self.reClassifyView.tableView reloadData];
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
#pragma mark -- 列表 --
    /**
     
     */
    NSString *listStr = @"m=Customer&c=GoodsCats&a=typeList2";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,listStr] Method:HTTPRequestPost Paramenters:@{@"typeid":self.catsID} PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            HomeListModel *model = [HomeListModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.cats2listArray addObject:model];
            
        }
        
        if (self.cats2listArray.count == 0) {
            [self.view addSubview:self.bgImg];
            [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
                make.edges.mas_offset(UIEdgeInsetsMake(74, 0, 0, 0));
            }];
            self.bgImg.image = IMAGE(@"wushuju.png");
        }else{
            [self setTable];
            [self.reClassifyView.headerView.collectionView reloadData];
            [self.reClassifyView.tableView reloadData];
        }
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    /**
     推荐
     */
    NSString *str = @"m=Customer&c=Goods&a=typeGoods2";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,str] Method:HTTPRequestPost Paramenters:@{@"catsid":self.catsID} PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        _str = [NSString stringWithFormat:@"%@%@",url,[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]objectForKey:@"message"]];
        
        
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            CollectionGoodsModel *model = [CollectionGoodsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.HomeListRecommendArray addObject:model];
        }
        [self.reClassifyView.tableView reloadData];
        
        //        [SVProgressHUD dismiss];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}





#pragma mark - 跳转到WebView -
-(void)jumpToWebViewWith:(NSString*)string{
    
    NSURL *url = [NSURL URLWithString:string];
    
    HomeWebViewController *webViewVC = [HomeWebViewController new];
    webViewVC.urlString = url;
    [self presentViewController:webViewVC animated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma mark - 利用代理 -
-(void)headerView:(HearderViewForTableView *)headerView StringID:(NSString *)stringID Title:(NSString *)title URL:(NSString *)URL ImgString:(NSString *)imgString{
    [self jumpToWebViewWith:URL];
}

-(void)headerView:(HearderViewForTableView *)headerView CatsID:(NSString *)catsID{
    
    
    
    ListDetailedController *detailedVC = [ListDetailedController new];
    detailedVC.catsID = catsID;
    [self presentViewController:detailedVC animated:YES completion:^{
        
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







-(NSMutableArray *)cats2listArray{
    if (_cats2listArray == nil) {
        _cats2listArray = [NSMutableArray array];
    }
    return _cats2listArray;
}

-(NSMutableArray *)HomeListRecommendArray{
    if (_HomeListRecommendArray == nil) {
        _HomeListRecommendArray = [NSMutableArray array];
    }
    return _HomeListRecommendArray;
}
-(UIImageView *)bgImg{
    if (_bgImg == nil) {
        _bgImg = [UIImageView new];
    }
    return _bgImg;
}

-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
}
-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
}



-(void)viewDidDisappear:(BOOL)animated{
    
    [super viewDidDisappear:animated];
}




@end
