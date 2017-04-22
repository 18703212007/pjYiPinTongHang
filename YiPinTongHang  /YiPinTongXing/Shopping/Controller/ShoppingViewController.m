//
//  ShoppingViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ShoppingViewController.h"
#import "ShopView.h"
#import "PJCarUIService.h"
#import "PJCarViewModel.h"
#import "PJCarBar.h"
@interface ShoppingViewController ()
{
    BOOL _isIdit;
}
@property (nonatomic,strong)ShopView        *shopView;

@property (nonatomic,strong) PJCarUIService *service;

@property (nonatomic,strong) PJCarViewModel *viewModel;

@property (nonatomic,strong) UITableView    *cartTableView;

@property (nonatomic,strong) PJCarBar       *carBar;

@property (nonatomic,strong) UILabel        *lb_title;


@end

@implementation ShoppingViewController



-(void)loadView{
    self.shopView = [[ShopView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view =self.shopView;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    [self getNewData];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self checkLogin];
    [self CostomNav];
    
    [self.shopView.goShopBtn addTarget:self action:@selector(goShopBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.automaticallyAdjustsScrollViewInsets = YES;
    _isIdit = NO;
    
    /*add view*/
    [self.view addSubview:self.cartTableView];
    [self.view addSubview:self.carBar];
    
    /* RAC  */
    //全选
    [[self.carBar.selectAllButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        x.selected = !x.selected;
        [self.viewModel selectAll:x.selected];
    }];
    //删除
    [[self.carBar.deleteButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        [self.viewModel deleteGoodsBySelect];
    }];
    //结算
    [[self.carBar.balanceButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(UIButton *x) {
        
    }];
    /* 观察价格属性 */
    WEAK
    [RACObserve(self.viewModel, allPrices) subscribeNext:^(NSNumber *x) {
        STRONG
        self.carBar.money = x.floatValue;
    }];
    
    /* 全选 状态 */
    RAC(self.carBar.selectAllButton,selected) = RACObserve(self.viewModel, isSelectAll);
    
    /* 购物车数量 */
    [RACObserve(self.viewModel, cartGoodsCount) subscribeNext:^(NSNumber *x) {
        STRONG
        if(x.integerValue == 0){
            self.lb_title.text = [NSString stringWithFormat:@"购物车"];
        } else {
            self.lb_title.text = [NSString stringWithFormat:@"购物车(%@)",x];
        }
        
    }];
    
    
    
    

    
    // Do any additional setup after loading the view.
}

#pragma mark - lazy load

- (PJCarViewModel *)viewModel{
    
    if (!_viewModel) {
        _viewModel = [[PJCarViewModel alloc] init];
        _viewModel.cartVC = self;
        _viewModel.cartTableView  = self.cartTableView;
    }
    return _viewModel;
}


- (PJCarUIService *)service{
    
    if (!_service) {
        _service = [[PJCarUIService alloc] init];
        _service.viewModel = self.viewModel;
    }
    return _service;
}


- (UITableView *)cartTableView{
    
    if (!_cartTableView) {
        
        _cartTableView = [[UITableView alloc] initWithFrame:rect(0, 74, screen_width, screen_height-74 -49-50)
                                                      style:UITableViewStyleGrouped];
        [_cartTableView registerNib:[UINib nibWithNibName:@"PJCarTableViewCell" bundle:nil]
             forCellReuseIdentifier:@"PJCarTableViewCell"];
        [_cartTableView registerClass:NSClassFromString(@"PJCarFooterView") forHeaderFooterViewReuseIdentifier:@"PJCarFooterView"];
        [_cartTableView registerClass:NSClassFromString(@"PJCarHeaderView") forHeaderFooterViewReuseIdentifier:@"PJCarHeaderView"];
        _cartTableView.dataSource = self.service;
        _cartTableView.delegate   = self.service;
        _cartTableView.backgroundColor = RGBA(240, 240, 240, 1);
        _cartTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 50)];
    }
    return _cartTableView;
}

- (PJCarBar *)carBar{
    
    if (!_carBar) {
        _carBar = [[PJCarBar alloc] initWithFrame:CGRectMake(0, screen_height-50-49, screen_width, 50)];
        _carBar.isNormalState = YES;
    }
    return _carBar;
}

#pragma mark - method

- (void)getNewData{
    /**
     *  获取数据
     */
    [self.viewModel getData];
    [self.cartTableView reloadData];
}


- (void)makeNewData:(UIBarButtonItem *)item{
    
    [self getNewData];
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
    
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.rightBtn1 setImage:[UIImage imageNamed:@"personal_message.png"] forState:UIControlStateNormal];
     editBtn.titleLabel.font = [UIFont systemFontOfSize:17.0];
    [editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [editBtn setTitle:@"完成" forState:UIControlStateSelected];
    [editBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
    
    self.lb_title = [UILabel new];
    self.lb_title.textAlignment = NSTextAlignmentCenter;
    self.lb_title.textColor = [UIColor whiteColor];
    [view addSubview:self.lb_title];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(view);
        make.height.mas_equalTo(@26);
    }];
}


-(void)goShopBtnDidClicked:(UIButton*)sender{
    
    
    
}
-(void)editBtnClicked:(UIButton*)sender{
    
    _isIdit = !_isIdit;
    
    self.carBar.isNormalState = !_isIdit;
    sender.selected = !sender.selected;
    
}


@end
