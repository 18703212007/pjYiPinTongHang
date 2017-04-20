//
//  OrderViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/31.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "OrderViewController.h"
#import "PersonalHeaderFooterView.h"
#import "OrderTableViewCell.h"

@protocol PersonalOrderClickedDelegate<NSObject>



@end


@interface OrderViewController ()<UITableViewDelegate,UITableViewDataSource,OrderTableHeaderViewDelegate>

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)OrderTableHeaderView *header;

@end

@implementation OrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self CostomNav];
    [self setTable];
    
    [self OrderTableHeaderView:self.header index:_index];
}










-(void)setTable{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;

    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[OrderTableViewCell class] forCellReuseIdentifier:@"OrderTableViewCell"];
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  10;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    OrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OrderTableViewCell"];
    
    if (!cell) {
        cell = [[OrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OrderTableViewCell"];
    }
    return cell;
    
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.header = [[OrderTableHeaderView alloc]init];
    self.header.delegate = self;
    self.header.index = _index;
    return self.header;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
}

#pragma mark - 这是个人中心外部的订单链接 -
-(void)OrderTableHeaderView:(OrderTableHeaderView *)view index:(NSInteger)index{
    
    switch (index) {
        case 1:{
            NSLog(@"待付款");
            break;
        }case 2:{
            NSLog(@"待发货");

            break;
        }case 3:{
            NSLog(@"待收货");

            break;
        }case 4:{
            NSLog(@"待评价");

            break;
        }case 5:{
            NSLog(@"退换/售后");

            break;
        }
        default:
            break;
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
    title.text = @"我的订单";
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





//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    if (scrollView == self.tableView)
//        
//    {
//        
//        CGFloat sectionHeaderHeight = 50; //sectionHeaderHeight
//        
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            
//            scrollView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
//            
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//            
//        }
//        
//    }
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
