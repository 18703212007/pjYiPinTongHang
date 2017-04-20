//
//  StoreIntroductionViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/22.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "StoreIntroductionViewController.h"
#import "IntroductionCell.h"
#import "StoreModel.h"
@interface StoreIntroductionViewController ()<UITableViewDelegate,UITableViewDataSource>

{
    NSArray *_storeArray1;
    
    NSArray *_storeArray2;
    NSArray *_storeImgArray2;
    
    NSArray *_storeArray3;
    
    
    
}

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)StoreModel *model;

@end

@implementation StoreIntroductionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    _storeArray1 = @[@"商品评价",@"服务态度",@"商品质量"];
    
    _storeArray2 = @[@"联系商家",@"商家电话",@"店铺二维码"];
    _storeImgArray2 = @[@"introduce_news.png",@"introduce_phone.png",@"introduce_code.png"];
    
    _storeArray3 = @[@"店铺简介",@"开店时间",@"所在地区"];
    
    
    [self CostomNav];
    [self getData];
}


-(void)setTableView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[IntroductionTopCell class] forCellReuseIdentifier:@"IntroductionTopCell"];
    [self.tableView registerClass:[IntroductionBottomCell class] forCellReuseIdentifier:@"IntroductionBottomCell"];
    [self.tableView registerClass:[IntroductionOtherCell class] forCellReuseIdentifier:@"IntroductionOtherCell"];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[IntroductionMidCell class] forCellReuseIdentifier:@"IntroductionMidCell"];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        
    }];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            return 1;
            break;
        }case 1:{
            return 1;
            break;
        }case 2:{
            return 3;
            break;
        }case 3:{
            return 3;
            break;
        }
        default:
            return 0;
            break;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    
    switch (indexPath.section) {
        case 0:{
            IntroductionTopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntroductionTopCell"];
            if (!cell) {
                cell  = [[IntroductionTopCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntroductionTopCell"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            [cell.img_shopLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,self.model.shoplogo]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
            cell.lb_shopName.text = self.model.shopname;
            cell.lb_favorites.text = [NSString stringWithFormat:@"%@|%@",self.model.favoritesnum,self.model.ordernum];
            return cell;
            
            break;
        }case 1:{
            
            IntroductionMidCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntroductionMidCell"];
            
            if (!cell) {
                cell  = [[IntroductionMidCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntroductionMidCell"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
            
            
            cell.lb_quality.text = self.model.timeScoreNum;
            cell.lb_shop.text    = self.model.goodsScoreNum;
            cell.lb_service.text = self.model.serviceScoreNum;
            
            return cell;
            break;
        }case 2:{
            
            IntroductionOtherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntroductionOtherCell"];
            
            if (!cell) {
                cell  = [[IntroductionOtherCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntroductionOtherCell"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            cell.lb_name.text = _storeArray2[indexPath.row];
            cell.img_rightImg.image = [UIImage imageNamed:_storeImgArray2[indexPath.row]];
            
            
            if (indexPath.row == 2) {
                [cell.img_rightImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,self.model.codeImg]]];
                cell.img_rightImg.userInteractionEnabled = YES;
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
                [cell.img_rightImg addGestureRecognizer:tap];
            }
            
            return cell;
            
            
            
            
            
            
            
            break;
        }case 3:{
            
            
            IntroductionBottomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"IntroductionBottomCell"];
            if (!cell) {
                cell  = [[IntroductionBottomCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"IntroductionBottomCell"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
            NSArray *arr = [NSArray arrayWithObjects:self.model.content,self.model.ctime,self.model.area, nil];
            
            cell.lb_name.text = _storeArray3[indexPath.row];
            
            cell.lb_subName.text = arr[indexPath.row];
            return cell;
            
            break;
        }
        default:
            return [[UITableViewCell alloc] init];
            break;
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            return 110;
            break;
        }case 1:{
            return 120;
            break;
        }case 2:{
            return 40;
            break;
        }case 3:{
            switch (indexPath.row) {
                case 0:{
                    return 50;
                    break;
                }
                default:
                    return 40;
                    break;
            }
            break;
        }
        default:
            return 0;
            break;
    }
    
    
}


-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    
    return [UIView new];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 0;
            break;
            
        default:
            return 30;
            break;
    }
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:{
            
            break;
        }case 1:{
            
            break;
        }case 2:{
            switch (indexPath.row) {
                case 0:{//客服
                    
                    break;
                }case 1:{
                    UIWebView *webView = [[UIWebView alloc]init];
                    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",self.model.tel]]]];
                    [self.view addSubview:webView];
                    
                    
                    break;
                }case 2:{//二维码
                    
                    
                    
                    
                    break;
                }
                default:
                    break;
            }
            
            break;
        }case 3:{
            
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
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.navView.mas_top).with.offset(0);
        make.left.equalTo(weakself.navView.mas_left).with.offset(0);
        make.right.equalTo(weakself.navView.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    
    UILabel *title = [UILabel new];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"店铺简介";
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


-(void)tap:(UITapGestureRecognizer*)sender{
    UIImageView *img = (UIImageView*)sender.view;
    [PJImgaeBrowser showImage:img];
}

-(void)getData{
    
    
    NSString *urlstring = @"m=Customer&c=shops&a=shopAbout";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:@{@"shopid":self.shopID} PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        
        
        self.model = [StoreModel mj_objectWithKeyValues:[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]];
        
        
        
        [self setTableView];
        
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
