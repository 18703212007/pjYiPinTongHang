//
//  ShoppingViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ShoppingViewController.h"
#import "ShopView.h"
@interface ShoppingViewController ()
@property(nonatomic,strong)ShopView *shopView;

///
@property(nonatomic,strong)UIButton *rightBtn1;
///
@property(nonatomic,strong)UIButton *rightBtn2;

@end

@implementation ShoppingViewController



-(void)loadView{
    self.shopView = [[ShopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view =self.shopView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self checkLogin];
    [self CostomNav];
    
    [self.shopView.goShopBtn addTarget:self action:@selector(goShopBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}

-(void)checkLogin{
    
    if (![k_defaults boolForKey:k_LoginStatus]) {
        
        LoginViewController *login = [LoginViewController new];
        [self presentViewController:login animated:YES completion:^{
        }];
        
    }else{
        
    }
    
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
#pragma mark - 自定义NV -
-(void)CostomNav{
    
    __weak typeof(self) weakself = self;
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.shopView.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.shopView.mas_top).with.offset(0);
        make.left.equalTo(weakself.shopView.mas_left).with.offset(0);
        make.right.equalTo(weakself.shopView.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    
    self.rightBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.rightBtn1 setImage:[UIImage imageNamed:@"personal_message.png"] forState:UIControlStateNormal];
    self.rightBtn1.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [self.rightBtn1 setTitle:@"编辑" forState:UIControlStateNormal];
    [self.rightBtn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.rightBtn1 addTarget:self action:@selector(rightBtn1DidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.rightBtn1];
    [self.rightBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-10);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.height.mas_equalTo(@26);
        make.width.mas_equalTo(@37);
    }];
//    self.rightBtn1 = self.navigationController.editButtonItem;
    
//    self.rightBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.rightBtn2 setImage:[UIImage imageNamed:@"personal_set_up.png"] forState:UIControlStateNormal];
//    
//    [view addSubview:self.rightBtn2];
//    [self.rightBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(weakself.rightBtn1.mas_left).with.offset(-20);
//        make.top.equalTo(view.mas_top).with.offset(37);
//        make.height.mas_equalTo(@22);
//        make.width.mas_equalTo(@22);
//    }];
    
    UILabel *title = [UILabel new];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"购物车";
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(view);
        make.height.mas_equalTo(@26);
    }];
}


-(void)goShopBtnDidClicked:(UIButton*)sender{
    
    
    
}
-(void)rightBtn1DidClicked:(UIButton*)sender{
    
    
    
}


@end
