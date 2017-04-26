//
//  AddAddressViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/25.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "AddAddressViewController.h"
#import "AddaddressView.h"
#import "PersonalModel.h"
#import "Pro_city_areaViewController.h"
#import "AddressChooseModel.h"
#import "CostomView.h"
#import "PJTextView.h"
@interface AddAddressViewController ()

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)AddaddressView *addressView;

@property(nonatomic,strong)UIButton *btn_save;

@property(nonatomic,strong)NSArray *allArray;

@property(nonatomic,strong)NSArray *proArray;

@property(nonatomic,strong)NSArray *cityArray;

@property(nonatomic,strong)NSArray *areaArray;

@property(nonatomic,strong)NSDictionary *updateDic;

@property(nonatomic,strong)AddressGetModel *addModel;

@property(nonatomic,strong)NSString *userID;


@end

@implementation AddAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self CostomNav];
    [self setView];
    
    
    
}


-(void)returnBlock:(ReturnBlock)block
{
    _block = block;
}

-(void)setView{
    
    self.addressView = [[AddaddressView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.addressView];
    
    
    self.addressView.consigneeView.tf_name.text = self.name;
    self.addressView.phoneNumView.tf_name.text = self.phoneNum;
    self.addressView.lb_pro_city_area.text = self.areaString;
    self.addressView.detailsTxetView.text = self.detailsString;
    
    
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [self.addressView.lb_pro_city_area addGestureRecognizer:tap];
    [self.addressView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
    
    
    
}

-(void)tap:(UITapGestureRecognizer*)sender{
    
    UILabel *lb = (UILabel*)sender.view;
    Pro_city_areaViewController *chooseAreaVC = [Pro_city_areaViewController new];
    //    chooseAreaVC.block = ^(NSString *string, AddressChooseModel *chooseAddress){
    //        lb.text = string;
    //        self.addModel = chooseAddress;
    //    };
    [chooseAreaVC getMessageWithBlock:^(NSString *string, AddressGetModel *chooseAddress) {
        lb.text = string;
        self.addModel = chooseAddress;
    }];
    chooseAreaVC.provinceArray = self.proArray;
    chooseAreaVC.cityArray = self.cityArray;
    chooseAreaVC.areaArray = self.areaArray;
    
    [self presentViewController:chooseAreaVC animated:YES completion:^{
        
    }];
    
}




-(void)getContent{
    
    self.userID = UserID;
    self.updateDic = [NSDictionary dictionary];
    
#warning 修改地址有问题(修改)
    
    if (self.arid) {
        
        _updateDic = @{@"arid":self.arid,
                       @"uid":UserID,
                       @"uname":self.addressView.consigneeView.tf_name.text == nil?self.name:self.addressView.consigneeView.tf_name.text,
                       @"utel":self.addressView.phoneNumView.tf_name.text == nil?self.phoneNum:self.addressView.phoneNumView.tf_name.text,
                       @"province":self.addModel.provinceID?self.addModel.provinceID:self.provinceID,
                       @"city":self.addModel.cityID?self.addModel.cityID:self.cityID,
                       @"area":self.addModel.areaID?self.addModel.areaID:self.areaID,
                       @"ar":self.addressView.detailsTxetView.text == nil? self.detailsString:self.addressView.detailsTxetView.text,
                       };
        
    
    }else{
               _updateDic = @{
                       @"uid":UserID,
                       @"uname":self.addressView.consigneeView.tf_name.text,
                       @"utel":self.addressView.phoneNumView.tf_name.text,
                       @"province":self.addModel.provinceID,
                       @"city":self.addModel.cityID,
                       @"area":self.addModel.areaID,
                       @"ar":self.addressView.detailsTxetView.text,
                       };
    }
    
    NSLog(@"%@",_updateDic);
    [self uploadDataWithDictionary:_updateDic];
    
    
}

#pragma mark - 上传数据 -
-(void)uploadDataWithDictionary:(NSDictionary*)dic{
    
    NSString *pjUrlString = @"m=Customer&c=UserAddress&a=arSave";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
    }];
    
}


-(void)btn_save:(UIButton*)sender{
    
    
    if ([self.addressView.consigneeView.tf_name.text isEqualToString:@""]||self.addressView.consigneeView.tf_name.text == nil) {
        
        [self alertWithMassage:@"姓名不能为空"];
    }else if ([self.addressView.phoneNumView.tf_name.text isEqualToString:@""]||self.addressView.phoneNumView.tf_name.text == nil){
        [self alertWithMassage:@"联系电话不能为空"];
    }else if(self.addressView.lb_pro_city_area.text == nil||[self.addressView.lb_pro_city_area.text isEqualToString:@""]){
        [self alertWithMassage:@"地址不能为空"];
    }else{
        [self getContent];
        
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)getData{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"DataCode" ofType:@"json"];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    self.allArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    [self getProvince];
    [self getCity];
    [self getArea];
    
}

-(void)getProvince{
#pragma mark - 省份 -
    NSMutableArray *proArr = [NSMutableArray array];
    for (NSDictionary *dictionary in self.allArray) {
        PersonalModel *model = [PersonalModel new];
        [model setValuesForKeysWithDictionary:dictionary];
        /* 在全部数据里面取出pid为0的 所有数据, 即根类数据 */
        if ([model.pid isEqualToString:@"0"]) {
            [proArr addObject:model];
        }
    }
    ///省份
    self.proArray = [NSArray arrayWithArray:proArr];
}

-(void)getCity{
#pragma mark - 市区 -
    NSMutableArray *cityArray = [NSMutableArray array];
    for (PersonalModel *m in self.proArray) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in self.allArray) {
            PersonalModel *mo = [PersonalModel new];
            [mo setValuesForKeysWithDictionary:dic];
            if ([mo.pid isEqualToString:m.aid]) {
                [array addObject:mo];
            }
        }
        [cityArray addObject:array];
    }
    //市
    self.cityArray = [NSArray arrayWithArray:cityArray];
    
}


-(void)getArea{
    
    NSMutableArray *areaArray = [NSMutableArray array];
    for (NSArray *cityArr in self.cityArray) {
        
        NSMutableArray *a1 = [NSMutableArray array];
        /* 取出上一级的aid 去匹配全局的pid */
        for (PersonalModel *mode in cityArr) {// aid
            
            NSMutableArray *a2 = [NSMutableArray array];
            /* 全部数据 用上面的aid匹配这里的pid */
            for (NSDictionary *dic in self.allArray) {
                PersonalModel *mo = [PersonalModel new];
                [mo setValuesForKeysWithDictionary:dic];
                //匹配
                if ([mode.aid isEqualToString:mo.pid]) {
                    [a2 addObject:mo];
                    
                }
            }
            [a1 addObject:a2];
            
        }
        [areaArray addObject:a1];
        
    }
    self.areaArray = [NSArray arrayWithArray:areaArray];
    
    
    
}


#pragma mark -  -
-(void)viewDidAppear:(BOOL)animated
{
    
    [self getData];
    
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
    title.text = @"新增收货地址";
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
    
    
    self.btn_save = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn_save.titleLabel.textColor = [UIColor whiteColor];
    [self.btn_save setTitle:@"保存" forState:UIControlStateNormal];
    [view addSubview:self.btn_save];
    [self.btn_save addTarget:self action:@selector(btn_save:) forControlEvents:UIControlEventTouchUpInside];
    [self.btn_save mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-10);
        make.top.equalTo(view.mas_top).with.offset(35);
        make.height.mas_equalTo(@30);
        make.width.mas_equalTo(@50);
    }];
    
    
}
#pragma mark - 返回按钮 -
-(void)backBtn:(UIButton*)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}



#pragma mark -- 提示弹框 --
-(void)alertWithMassage:(NSString*)massage{
    
    
    CGFloat version = [[[UIDevice currentDevice]systemVersion] floatValue];
    
    if (version >= 8.0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:massage preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
        
    }
    
}






@end
