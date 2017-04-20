//
//  AddressViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/24.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "AddressViewController.h"
#import "AddAddressViewController.h"
#import "PersonalTableViewCell.h"
#import "PJButton.h"
#import "AddressChooseModel.h"
@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIView *navView;
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *btn_add;

@property(nonatomic,strong)NSArray *addressArray;

@property(nonatomic,assign)BOOL  isDelete;

@end

@implementation AddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor colorWithHexString:@"#f0f0f0"];
    // Do any additional setup after loading the view.
    [self CostomNav];
    [self setTableView];
    
    
    
}



-(void)setTableView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.bounces = NO;
    self.tableView.tableFooterView = [UIView new];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
    [self.tableView registerClass:[AddressTableViewCell class] forCellReuseIdentifier:@"AddressTableViewCell"];
    
    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _addressArray.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    if (!cell) {
        cell = [[AddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AddressTableViewCell"];
    }
    cell.backgroundColor = [UIColor whiteColor];
    tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);;
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    [cell.btn_dafault addTarget:self action:@selector(btn_dafault:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btn_editing addTarget:self action:@selector(btn_editing:) forControlEvents:UIControlEventTouchUpInside];
    
    if (!cell.block) {
        __weak typeof(tableView) weakTableView = tableView;
        
        cell.block = ^(AddressTableViewCell *cell){
            NSInteger row =[weakTableView indexPathForCell:cell].row;
            __strong typeof(tableView) strongTableView = weakTableView;
            [strongTableView beginUpdates];
            [strongTableView deleteRowsAtIndexPaths:@[[self removeDataAtIndex:row]] withRowAnimation:UITableViewRowAnimationAutomatic];
            [strongTableView endUpdates];
            
            [self deleteCellWithDictinoary:@{@"arid":cell.arid}];
            
            
        };
    }
    [cell setLayoutMargins:UIEdgeInsetsZero];
    [cell setSeparatorInset:UIEdgeInsetsZero];
    
    AddressGetModel *model = self.addressArray[indexPath.row];
    
    [cell setModel:model];
    
    return  cell;
}


- (NSIndexPath *)removeDataAtIndex:(NSInteger)row{
    
    NSMutableArray *copyArray = [NSMutableArray  arrayWithArray:_addressArray];
    [copyArray removeObjectAtIndex:row];
    _addressArray = [NSArray arrayWithArray:copyArray];
    NSIndexPath * path = [NSIndexPath indexPathForRow:row inSection:0];
    
    return path;
    
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AddressTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    
    AddAddressViewController *addAddress = [AddAddressViewController new];
    
    
    addAddress.name = cell.lb_nickName.text;
    addAddress.phoneNum = cell.lb_phoneNum.text;
    addAddress.areaString = cell.ar;
    addAddress.detailsString = cell.artwo;
    addAddress.arid = cell.arid;
    
    
    addAddress.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    addAddress.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:addAddress animated:YES completion:^{
        
    }];
    
    
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}


//
//#pragma mark  - 设置编辑风格
//-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//        return UITableViewCellEditingStyleDelete;
//
//
//}


#pragma mark  -删除和插入数据和cell
//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//
//
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        NSMutableArray *array = [NSMutableArray arrayWithArray:self.addressArray];
//        if (array.count >1) {
//
//            [array removeObjectAtIndex:indexPath.row];
//            [self.addressArray replaceObjectAtIndex:indexPath.row withObject:array];
//            [tableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//        }else{
//            [self.addressArray removeObjectAtIndex:indexPath.section];
//
//        }
//    }
//
//    [self.tableView reloadData];





//}


//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
////    NSLog(@"BtnClick_%zd",indexPath.row);
//    AddressTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
//
//
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//
//
//
//        [_addressArray removeObjectAtIndex:indexPath.row];
//        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
////        [_addressArray replaceObjectAtIndex:indexPath.section withObject:_addressArray];
//        [self deleteCellWithDictinoary:@{@"arid":cell.arid}];
//        [self requestDataWithDictionary:@{@"uid":UserID}];
//    }
//
//
//
//
//}
//
//
//-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
//
//
//    return _isDelete;
//
//
//}

//-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
//
//    UITableViewRowAction *action1 = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"删除" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
//        [tableView setEditing:NO animated:YES];
//        //这里删除对应的Cell代码，刷新tableview
//    }];
//    //UITableViewRowAction在IOS8以后系统提供的，所以不用自定义，可设置多个按钮
//
//    return @[action1];
//}






-(void)deleteCellWithDictinoary:(NSDictionary *)dic{
    
    NSString *pjUrlString = @"m=Customer&c=UserAddress&a=arDelete";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
//        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
        
        [self.tableView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}



-(void)requestDataWithDictionary:(NSDictionary*)dic{
    
    
    NSString *pjUrlString = @"m=Customer&c=UserAddress&a=addressList";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        self.addressArray = [AddressGetModel mj_objectArrayWithKeyValuesArray:[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]];
        
        
        [self.tableView reloadData];
        //        [MBProgressHUD ];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}



-(void)btn_dafault:(UIButton*)sender{
    
    sender.selected = !sender.selected;
    NSLog(@"%ld",(long)sender.tag);
    //    [self updateDefaultAddressWithDictionary:@{@"uid":UserID,@"arid":@""}];
}
#warning 还没有写完呢
#pragma mark - 修改默认地址 -
-(void)updateDefaultAddressWithDictionary:(NSDictionary*)dic{
    
    NSString *pjUrlString = @"m=Customer&c=UserAddress&a=isState";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}


-(void)btn_editing:(UIButton*)sender{
    
    
    
    
    
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
    title.text = @"收货地址";
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
    
    
    self.btn_add = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_add.titleLabel.textColor = [UIColor whiteColor];
    [self.btn_add setTitle:@"增加" forState:UIControlStateNormal];
    [view addSubview:self.btn_add];
    [self.btn_add addTarget:self action:@selector(btn_add:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_add mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-10);
        make.top.equalTo(view.mas_top).with.offset(35);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@50);
    }];
    
    
}

-(void)backBtn:(UIButton*)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}




-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self requestDataWithDictionary:@{@"uid":UserID}];
}






-(void)btn_add:(UIButton*)sender{
    
    AddAddressViewController *addAddress = [AddAddressViewController new];
    
    
    addAddress.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    addAddress.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:addAddress animated:YES completion:^{
        
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
