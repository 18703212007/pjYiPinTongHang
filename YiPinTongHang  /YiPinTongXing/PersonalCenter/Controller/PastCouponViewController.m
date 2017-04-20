//
//  PastCouponViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/31.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PastCouponViewController.h"
#import "PersonalTableViewCell.h"
#import "PersonalCouponModel.h"
@interface PastCouponViewController ()<UITableViewDelegate,UITableViewDataSource>


@property(nonatomic,strong)UIView      *navView;
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSArray *couponArray;

@end

@implementation PastCouponViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
    [self getDataWithDictionary:@{@"uid":UserID,@"type":@"1"}];
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
    [self.tableView registerClass:[CouponTableViewCell class] forCellReuseIdentifier:@"CouponHisTableViewCell"];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return self.couponArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CouponTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CouponHisTableViewCell"];
    if (!cell) {
        cell = [[CouponTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CouponHosTableViewCell"];
        
        
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




-(void)getDataWithDictionary:(NSDictionary*)dic{
    
    NSString *urlstring = @"m=Customer&c=Coupon&a=couponList";
    
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
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
    title.text = @"优惠券";
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
