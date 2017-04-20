//
//  HomeWebViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/15.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "HomeWebViewController.h"

@interface HomeWebViewController ()<UIWebViewDelegate>

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)UISwipeGestureRecognizer *leftSwipeGestureRecognizer;

@property(nonatomic,strong)UIButton *backBtn;

@end

@implementation HomeWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self CostomNav];
    self.webView =[UIWebView new];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(74, 0, 0, 0));
    }];
    self.webView.delegate = self;
    
    [self loadWebView];
    
    self.leftSwipeGestureRecognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipesAction:)];
    self.leftSwipeGestureRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    
    
    
}



#pragma mark - 加载WebView -
-(void)loadWebView{
    self.webView.scalesPageToFit = YES;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.urlString];
    [self.webView loadRequest:request];
}


-(void)CostomNav{
    
    __weak typeof(self) weakself = self;
    self.navigationController.navigationBar.hidden = YES;
    //
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(weakself.view.mas_top).with.offset(0);
        make.left.equalTo(weakself.view.mas_left).with.offset(0);
        make.right.equalTo(weakself.view.mas_right).with.offset(0);
        make.height.mas_equalTo(74);
    }];
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:[UIImage imageNamed:(@"sign_in_return.png")] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backItem) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(8);
        make.top.equalTo(view.mas_top).with.offset(32);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    
}



-(void)handleSwipesAction:(UISwipeGestureRecognizer*)sender{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)backItem{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)dealloc{
    self.webView.delegate = nil;
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
