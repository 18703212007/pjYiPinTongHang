//
//  CollectionViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/24.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "CollectionViewController.h"
#import "HomeTableViewCell.h"
#import "PersonalHeaderFooterView.h"
#import "GoodsDetailsController.h"//商品
#import "MyStoreViewController.h"//店铺
@interface CollectionViewController ()<UITableViewDelegate,UITableViewDataSource,CollectionTableHeaderViewDelegate>

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *collectionGoodsArray;

@property(nonatomic,strong)NSMutableArray *collectionStoreArray;

@property(nonatomic,strong)UIImageView    *img;

@property(nonatomic,getter=isShop)BOOL shop;

@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self CostomNav];
    [self getData];
    
}

-(BOOL)isShop
{
    return _shop;
}

-(void)setTable{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[CollectionGoodsTableCell class] forCellReuseIdentifier:@"CollectionCollectionGoodsTableCell"];
    
    [self.tableView registerClass:[CollectionStroeTableCell class] forCellReuseIdentifier:@"CollectionCollectionStroeTableCell"];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (!_shop) {
        return self.collectionGoodsArray.count;
    }else{
        return self.collectionStoreArray.count;
        
    }
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.shop) {
        CollectionGoodsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCollectionGoodsTableCell"];
        if (!cell) {
            cell = [[CollectionGoodsTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionCollectionGoodsTableCell"];
        }
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        CollectionGoodsModel *model = self.collectionGoodsArray[indexPath.row];
        
        [cell setCellDataWithModel:model];
        
        
        return cell;
    }else{
        CollectionStroeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CollectionCollectionStroeTableCell"];
        if (!cell) {
            cell = [[CollectionStroeTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CollectionCollectionStroeTableCell"];
        }
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        
        
        CollectionStoreModel *model = self.collectionStoreArray[indexPath.row];
        
        [cell setCellDataWithModel:model];
        
        return cell;
    }
    
    
    
}



-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

#pragma mark  - 设置编辑风格
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return UITableViewCellEditingStyleDelete;
    
    
}


-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"BtnClick_%zd",indexPath.row);
    
    
    
    if (!self.shop) {
        CollectionGoodsTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            [_collectionGoodsArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            
            [self deleteCollectionWithDictionary:@{@"type":@"goods",@"id":cell.fid}];
        }
    }else{
        CollectionStroeTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            
            [_collectionStoreArray removeObjectAtIndex:indexPath.row];
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
            [self deleteCollectionWithDictionary:@{@"type":@"shops",@"id":cell.fid}];
            
        }
    }
    
    
}








-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (!self.shop) {
        
        return 140;
        
    }else{
        
        return 100;
    }
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CollectionTableHeaderView *header = [[CollectionTableHeaderView alloc]init];
    header.delegate = self;
    
    return header;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!self.shop) {
        CollectionGoodsTableCell  *cell = [tableView cellForRowAtIndexPath:indexPath];
        GoodsDetailsController *goods = [GoodsDetailsController new];
       
        goods.goodsID = cell.goodsID;
        
        goods.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        goods.modalPresentationStyle = UIModalPresentationFullScreen;
        
        
        [self presentViewController:goods animated:YES completion:^{
            
        }];
        
        
    }else{
        CollectionStroeTableCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        MyStoreViewController *storeVC = [MyStoreViewController new];
        
        storeVC.shopID = cell.shopsID;
        
        storeVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        storeVC.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:storeVC animated:YES completion:^{
            
        }];
        
    }
    
    
}



-(void)getData{
    NSString *pjUrlString = @"m=Customer&c=Favorites&a=favoritesList";
    
    NSDictionary *dic = @{@"uid":UserID,@"type":@"goods"};
    
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            CollectionGoodsModel *model = [CollectionGoodsModel new];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.collectionGoodsArray = [NSMutableArray arrayWithArray:array];
        [self setTable];
        if (self.collectionGoodsArray.count == 0) {
            [self setBgImgWithView:self.tableView];
        }
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}



-(void)setBgImgWithView:(UIView*)view{
    
    self.img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wushuju"]];
    self.img.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:self.img];
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(50, 0, 0, 0));
    }];
    
}


-(void)requestDataWithDictionary:(NSDictionary*)dic{
    
    
    NSString *pjUrlString = @"m=Customer&c=Favorites&a=favoritesList";
    
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSMutableArray *goodsArray = [NSMutableArray array];
        NSMutableArray *storeArray = [NSMutableArray array];
        
        
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            
            if (!self.shop) {
                CollectionGoodsModel *model = [CollectionGoodsModel new];
                [model setValuesForKeysWithDictionary:dic];
                [goodsArray addObject:model];
            }else{
                CollectionStoreModel *model = [CollectionStoreModel new];
                [model setValuesForKeysWithDictionary:dic];
                [storeArray addObject:model];
            }
            
        }
        self.collectionGoodsArray = [NSMutableArray arrayWithArray:goodsArray];
        
        self.collectionStoreArray = [NSMutableArray arrayWithArray:storeArray];
        if (!self.shop) {
            if (self.collectionGoodsArray.count == 0) {
                [self setBgImgWithView:self.tableView];
            }else{
                if (!self.img.hidden) {
                    self.img.hidden = YES;
                }
            }
            
        }else{
            if (self.collectionStoreArray.count == 0) {
                [self setBgImgWithView:self.tableView];
            }else{
                if (!self.img.hidden) {
                    self.img.hidden = YES;
                }
                
            }
        }
        
        
        
        
        [self.tableView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}



-(void)CollectionTableHeaderView:(CollectionTableHeaderView*)view index:(NSInteger)index{
    
    if (index == 0) {
        //uid
        self.shop = NO;
        NSDictionary *dic = @{@"uid":UserID,@"type":@"goods"};
        [self requestDataWithDictionary:dic];
    }else{
        self.shop = YES;
        NSDictionary *dic = @{@"uid":UserID,@"type":@"shops"};
        [self requestDataWithDictionary:dic];
    }
    
}




#pragma mark - 取消收藏 -


-(void)deleteCollectionWithDictionary:(NSDictionary*)dic{
    
    NSString *pjUrlString = @"m=Customer&c=Favorites&a=favoritesDel";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
//        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
        [self.tableView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
    view.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];
    [self.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UILabel *title = [UILabel new];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"收藏";
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
