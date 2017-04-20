//
//  SearchViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/23.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate>
@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)NSArray *searchArray;

@property(nonatomic,strong)UISearchController *searchVC;

@property(nonatomic,strong)UITableView *tableView;


@property(nonatomic,strong)NSArray *hotIdeasArray;


//@property(nonatomic,strong)UISearchBar *searchBar;

@property(nonatomic,strong)UIButton *backBtn;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.definesPresentationContext = YES;
    self.view.backgroundColor = [UIColor whiteColor];

    // Do any additional setup after loading the view.
    self.dataArray = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"12",@"45",@"98",@"13123"];
    [self getHotSearchIdeas];
    [self setSearch]; [self CostomNav];  [self setTab];
    
    
    
    
    
}



-(void)setTab{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"tableViewcell"];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
    self.tableView.tableFooterView = [UIView new];
    
}


-(void)setSearch{
    
    self.searchVC = [[UISearchController alloc]initWithSearchResultsController:nil];
    [self.searchVC.searchBar sizeToFit];
    self.searchVC.dimsBackgroundDuringPresentation = NO;
    self.searchVC.hidesNavigationBarDuringPresentation = NO;
    //    self.tableView.tableHeaderView = self.searchVC.searchBar;
    self.searchVC.delegate  = self;
    self.searchVC.searchResultsUpdater = self;
    
}

-(void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
    
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[C] %@",self.searchVC.searchBar.text];
    self.searchArray = [[self.dataArray filteredArrayUsingPredicate:searchPredicate] mutableCopy];
    [self.tableView reloadData];
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (!self.searchVC.active) {
        //        return self.dataArray.count;
        return _hotIdeasArray.count;
        
    }else{
        return self.searchArray.count;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tableViewcell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"tableViewcell"];
    }
    if (!self.searchVC.active) {
        //        cell.textLabel.text = self.dataArray[indexPath.row];
        cell.textLabel.text = self.hotIdeasArray[indexPath.row];
        
        
    }else{
        cell.textLabel.text = self.searchArray[indexPath.row];
    }
    
    return cell;
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
    
    //    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBar.translucent = YES;
    
    //    UIView *view = [UIView new];
    self.navView.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];
    //    [self.navView addSubview:view];
    //    [view mas_makeConstraints:^(MASConstraintMaker *make) {
    //
    //        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    //    }];
    
    //    self.lb_title = [UILabel new];
    //    self.lb_title.textAlignment = NSTextAlignmentCenter;
    //    self.lb_title.textColor = [UIColor whiteColor];
    ////    self.lb_title.text = @"商品详情";
    //    [view addSubview:self.lb_title];
    //    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerX.equalTo(view);
    //        make.top.equalTo(view.mas_top).with.offset(37);
    //        make.width.mas_equalTo(view);
    //        make.height.mas_equalTo(@26);
    //    }];
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:[UIImage imageNamed:(@"sign_in_return.png")] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.navView.mas_left).with.offset(8);
        make.top.equalTo(self.navView.mas_top).with.offset(37);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    //
    //
    //    UIButton *bt_more = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [bt_more setImage:[UIImage imageNamed:(@"more.png")] forState:UIControlStateNormal];
    //    [bt_more addTarget:self action:@selector(bt_more:) forControlEvents:UIControlEventTouchUpInside];
    //    ;
    //    [view addSubview:bt_more];
    //    [bt_more mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(view.mas_right).with.offset(-2);
    //        make.top.equalTo(view.mas_top).with.offset(33);
    //        make.width.mas_equalTo(@33);
    //        make.height.mas_equalTo(@33);
    //    }];
    //
    //    UIButton *bt_allList = [UIButton buttonWithType:UIButtonTypeCustom];
    //
    //    [bt_allList setImage:[UIImage imageNamed:(@"classification")] forState:UIControlStateNormal];
    //    [bt_allList addTarget:self action:@selector(bt_allList:) forControlEvents:UIControlEventTouchUpInside];
    //    ;
    //    [view addSubview:bt_allList];
    //    [bt_allList mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(bt_more.mas_left).with.offset(0);
    //        make.top.equalTo(view.mas_top).with.offset(32);
    //        make.width.mas_equalTo(@33);
    //        make.height.mas_equalTo(@33);
    //    }];
    
    
    
    
    
    //    self.searchBar = [[UISearchBar alloc]init];
    //    self.searchBar.placeholder = @"请输入搜索内容";
    //    self.searchBar.backgroundColor = [UIColor clearColor];
    //    self.searchBar.backgroundImage = [UIImage new];
    //    self.searchBar.searchBarStyle = UISearchBarStyleProminent;
    //    /*
    //     typedef NS_ENUM(NSUInteger, UISearchBarStyle) {
    //     UISearchBarStyleDefault,    // currently UISearchBarStyleProminent
    //     UISearchBarStyleProminent,  // used my Mail, Messages and Contacts
    //     UISearchBarStyleMinimal     // used by Calendar, Notes and Music
    //     } NS_ENUM_AVAILABLE_IOS(7_0);
    //
    //     */
    //    [view addSubview:self.searchBar];
    //    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.top.equalTo(view.mas_top).with.offset(32);
    //        make.left.equalTo(backBtn.mas_right).with.offset(10);
    //        make.right.equalTo(view.mas_right).with.offset(-10);
    //        make.height.mas_equalTo(@33);
    //    }];
    
    [self.navView addSubview:self.searchVC.searchBar];
    self.searchVC.searchBar.placeholder = @"请输入搜索内容";
    self.searchVC.searchBar.backgroundColor = [UIColor clearColor];
    self.searchVC.searchBar.backgroundImage = [UIImage new];
    self.searchVC.searchBar.searchBarStyle = UISearchBarStyleProminent;
    
    [self.searchVC.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView.mas_top).with.offset(32);
        make.left.equalTo(self.backBtn.mas_right).with.offset(10);
        make.right.equalTo(self.navView.mas_right).with.offset(-10);
        make.height.mas_equalTo(@33);
        
    }];
    
    
    
    
    
    
    
    
    
    
    
    
    UITextField *searchField = [self.searchVC.searchBar valueForKey:@"_searchField"];
    searchField.borderStyle = UITextBorderStyleNone;
    searchField.backgroundColor = [UIColor clearColor];
    searchField.layer.cornerRadius = 4.0;
    searchField.leftViewMode=UITextFieldViewModeNever;
    searchField.textColor=[UIColor whiteColor];
    //改变placeholder的颜色
    
    [searchField setValue:[UIColor grayColor]forKeyPath:@"_placeholderLabel.textColor"];
    
    
    
    UILabel *line = [UILabel new];
    line.backgroundColor = [UIColor whiteColor];
    [self.navView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.searchVC.searchBar.mas_bottom).with.offset(-0.5);
        make.left.equalTo(self.searchVC.searchBar.mas_left).with.offset(0);
        make.width.equalTo(self.searchVC.searchBar);
        make.height.mas_equalTo(@0.5);
    }];
    
    //
    
    
    
    
    
    
}

-(void)backBtn:(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}




-(void)getHotSearchIdeas{
    
    NSString *urlstring = @"m=Customer&c=Search&a=hotSearch";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:nil PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"%@",[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]objectForKey:@"data"]);
        _hotIdeasArray =[[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]objectForKey:@"data"] objectForKey:@"key"];
//        NSLog(@"%@",_hotIdeasArray);
        [self.tableView reloadData];
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
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
