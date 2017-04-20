//
//  SetUpViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/11.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "SetUpViewController.h"
#import "SetUpView.h"
@interface SetUpViewController ()
@property(nonatomic,strong)SetUpView *setupView;
@end

@implementation SetUpViewController


-(void)loadView{
    self.setupView = [[SetUpView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.setupView.backgroundColor = [UIColor whiteColor];
    self.view =self.setupView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self CostomNav];
    // Do any additional setup after loading the view.

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
    [self.setupView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.setupView.mas_top).with.offset(0);
        make.left.equalTo(weakself.setupView.mas_left).with.offset(0);
        make.right.equalTo(weakself.setupView.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
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
#pragma mark - 返回按钮 -
-(void)backBtn:(UIButton*)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
