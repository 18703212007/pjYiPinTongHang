//
//  CouponViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/24.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "CouponViewController.h"
#import "PersonalHeaderFooterView.h"
#import "PersonalTableViewCell.h"
#import "PersonalCouponModel.h"
#import "PastCouponViewController.h"
#import "MyStoreViewController.h"
#import "RootViewController.h"
@interface CouponViewController ()<UITableViewDelegate,UITableViewDataSource,CollectionCouponTableHeaderViewDelegate>

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UITableView *tableView;


@property(nonatomic,strong)NSArray *couponArray;

@property(nonatomic,getter=isShop)BOOL shop;

@end

@implementation CouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    [self getDataWithDictionary:@{@"uid":UserID,@"flag":@"1"}];
}

-(BOOL)isShop
{
    return _shop;
}

-(void)setTable{
    
    [self CostomNav];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView registerClass:[CouponTableViewCell class] forCellReuseIdentifier:@"CouponTableViewCell"];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
        return self.couponArray.count;
        
 
    
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponTableViewCell"];
    if (!cell) {
        cell =[[CouponTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CouponTableViewCell"];
    }
    
   cell.selectionStyle =UITableViewCellSelectionStyleNone;
    PersonalCouponModel *model = self.couponArray[indexPath.row];
   
    [cell setModel:model];
    return cell;
    
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        return 170;
}


-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CollectionCouponTableHeaderView *header = [[CollectionCouponTableHeaderView alloc]init];
    self.tableView.tableHeaderView = header;
    header.delegate = self;
    
    return header;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (!_shop) {
//        [self alertWithMassage:@"此类优惠券适用全部商品"];
        [self AlertTheCouponMsg];
         }else{
        CouponTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        
        MyStoreViewController *storeVC = [MyStoreViewController new];
        storeVC.shopID = cell.shopID;
        storeVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        storeVC.modalPresentationStyle = UIModalPresentationFullScreen;
        
        [self presentViewController:storeVC animated:YES completion:^{
            
        }];
    }
    
    
}



-(void)getDataWithDictionary:(NSDictionary*)dic{
    NSString *pjUrlString = @"m=Customer&c=Coupon&a=couponList";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        NSMutableArray *couponArray = [NSMutableArray array];
        
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            PersonalCouponModel *model = [PersonalCouponModel new];
            [model setValuesForKeysWithDictionary:dic];
            [couponArray addObject:model];
            
            
        }
        self.couponArray = [NSArray arrayWithArray:couponArray];
        [self setTable];
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}



-(void)requestDataWithDictionary:(NSDictionary*)dic{
    
    
    NSString *pjUrlString = @"m=Customer&c=Coupon&a=couponList";
    
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
       
        NSMutableArray *couponArray = [NSMutableArray array];
        
        
        for (NSDictionary *dic in [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]) {
            PersonalCouponModel *model = [PersonalCouponModel new];
            [model setValuesForKeysWithDictionary:dic];
            [couponArray addObject:model];
            
            
        }
        self.couponArray = [NSArray arrayWithArray:couponArray];
        
        [self.tableView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}

#pragma mark - 代理方法 -

-(void)CollectionCouponTableHeaderView:(CollectionCouponTableHeaderView *)view index:(NSInteger)index{
    if (index == 0) {
        self.shop = NO;
        NSDictionary *dic = @{@"uid":UserID,@"flag":@"1"};
        [self requestDataWithDictionary:dic];
    }else{
        self.shop = YES;
        NSDictionary *dic = @{@"uid":UserID};
        [self requestDataWithDictionary:dic];
    }
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    title.text = @"优惠券中心";
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
    
    
    UIButton *btn_his = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn_his setTitle:@"查看历史" forState:UIControlStateNormal];
    [btn_his addTarget:self action:@selector(btn_his:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn_his];
    [btn_his mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-10);
        make.top.equalTo(view.mas_top).with.offset(35);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@80);
    }];
    
    
    
}

-(void)backBtn:(UIButton*)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)btn_his:(UIButton*)sender{
    
    PastCouponViewController *pastCouponVC = [PastCouponViewController new];
    
    
    pastCouponVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    pastCouponVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:pastCouponVC animated:YES completion:^{
   
    }];
    
}





-(void)AlertTheCouponMsg{
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"温馨提示提示" message:@"此类优惠券使用本平台一切商品哦!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"朕知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertVC addAction:ensureAction];
    
    [self presentViewController:alertVC animated:YES completion:^{
        
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

@end
