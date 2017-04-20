//
//  AboutOursViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/1.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "AboutOursViewController.h"

@interface AboutOursViewController ()


@property(nonatomic,strong)UIView *navView;


@property(nonatomic,strong)UILabel *lb_aboutOurs;

@end

@implementation AboutOursViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self CostomNav];
    [self setLabelContextWithHeight:[self heighForText:_content]];
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}



-(void)setLabelContextWithHeight:(CGFloat)height{
    UIView *view = [UIView new];
    [self.view addSubview:view];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(-10);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
    self.lb_aboutOurs = [UILabel new];
//    self.lb_aboutOurs.borderColor = RGBA(180, 180, 180, 0.2);
    self.lb_aboutOurs.text = self.content;
    self.lb_aboutOurs.textAlignment = NSTextAlignmentLeft;
    self.lb_aboutOurs.font = [UIFont fontWithName:@"Arial" size:17.0];
    self.lb_aboutOurs.textColor = [UIColor blackColor];
//    self.lb_aboutOurs.borderWidth = 0.5;
    [view addSubview:self.lb_aboutOurs];
    self.lb_aboutOurs.numberOfLines = 0;
    [self.lb_aboutOurs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(10);
        make.left.equalTo(self.view.mas_left).with.offset(10);
        make.right.equalTo(self.view.mas_right).with.offset(-10);
        make.height.mas_equalTo(height);
        
    }];

}



- (CGFloat)heighForText:(NSString *)string{
    

    // 计算文字占据的高度
    CGSize size = [string boundingRectWithSize:CGSizeMake(screen_width-40.0, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:17.0]} context:nil].size;
    return size.height;
    
    
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
    title.text = @"关于我们";
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
