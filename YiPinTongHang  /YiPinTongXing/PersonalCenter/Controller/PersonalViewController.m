//
//  PersonalViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PersonalViewController.h"
#import "PersonalView.h"
#import "PersonalTableViewCell.h"
#import "SetUpViewController.h"
#import "PerMessageViewController.h"
#import "PersonalHeaderFooterView.h"
#import "CollectionViewController.h"
#import "AddressViewController.h"
#import "CouponViewController.h"
#import "OrderViewController.h"
#import "AboutOursViewController.h"
@interface PersonalViewController ()<UITableViewDelegate,UITableViewDataSource,PersonalHeaderViewDelegate>
{
    NSArray  *_nameArray;
    NSArray  *_imgArray;
    NSString *_userID;
}
@property(nonatomic,strong)NSString     *userID;
@property(nonatomic,strong)UITableView  *tableview;
@property(nonatomic,assign)CGFloat       memorySize;
@property(nonatomic,strong)NSString     *phoneNumber;
@property(nonatomic,strong)NSString     *aboutOurs;
@property(nonatomic,strong)OrderViewController *order;


@end

@implementation PersonalViewController





- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    

    _nameArray = @[@[@"我的收藏",@"我的优惠券",@"我的地址",@"清除缓存"],@[@"意见反馈",@"咨询客服",@"关于我们"],@[@"分享有礼"]];
    _imgArray = @[@[@"personal_collection",@"personal_coupon",@"personal_address",@"personal_clear"],@[@"personal_opinion",@"personal_service",@"personal_we"],@[@"personal_share"]];
    
    [self checkLogin];
    
    self.navigationController.navigationBar.hidden = YES;
    
    [self setTable];
    
}


-(void)checkLogin{
    
    if (![k_defaults boolForKey:k_LoginStatus]) {
        
        LoginViewController *login = [LoginViewController new];
        [self presentViewController:login animated:YES completion:^{
        }];
        
    }else{
       
    }
    
}







-(void)setTable{
    self.tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self.view addSubview:self.tableview];
    self.tableview.bounces = NO;
    self.tableview.showsVerticalScrollIndicator = NO;
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(-20, 0, 0, 0));
        
    }];
    self.tableview.tableFooterView = [UIView new];
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[PersonalTableViewCell class] forCellReuseIdentifier:@"PersonalTableViewCelll"];
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    if (section == 0) {
        return 4;
    }else if (section == 1){
        return 3;
    }else{
        return 1;
    }
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalTableViewCelll"];
    if (!cell) {
        cell = [[PersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalTableViewCelll"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.showLabel.text = _nameArray[indexPath.section][indexPath.row];
    cell.img.image =[UIImage imageNamed:_imgArray[indexPath.section][indexPath.row]];
    
    return cell;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        PersonalHeaderFooterView *header = [[PersonalHeaderFooterView alloc]init];
        header.delegate = self;
        header.contentView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        self.tableview.tableHeaderView = header;
        //
        return header;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:rect(0, 0, screen_width, 10)]
        ;
        view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        return view;
    }
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 270;
    }else{
        return 10;
    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section ) {
        case 0:{
            switch (indexPath.row) {
#pragma mark - 我的收藏 -
                case 0:{//我的收藏
                    
                    CollectionViewController *collcetion = [CollectionViewController new];
                    collcetion.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    
                    collcetion.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:collcetion animated:YES completion:^{
                        
                    }];
                    break;
#pragma mark - 我的优惠券 -
                    
                }case 1:{//我的优惠券
                    
                    CouponViewController *couponVC = [CouponViewController new];
                    couponVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    
                    couponVC.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:couponVC animated:YES completion:^{
                        
                    }];
                    
                    
                    break;
#pragma mark - 地址管理 -
                    
                }case 2:{//我的地址
                    //                   [self alertWithMassage:[NSString stringWithFormat: @"%lu-%ld",(long)indexPath.section,(long)indexPath.row]];
                    AddressViewController *addVC = [AddressViewController new];
                    
                    /*这里应该传userID*/
                    addVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    
                    addVC.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:addVC animated:YES completion:^{
                        
                    }];
                    
                    break;
#pragma mark - 清理缓存 -
                    
                }case 3:{//清除缓存
                    [self clearTheMemory];
                    break;
                }
                default:
                    break;
            }
            
            
            
            break;
        }case 1:{
            switch (indexPath.row) {
#pragma mark - 意见反馈 -
                    
                case 0:{//意见反馈
                    [self alertWithMassage:[NSString stringWithFormat: @"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
                    break;
#pragma mark - 咨询服务 -
                    
                }case 1:{//咨询客服
                    //                 [self alertWithMassage:[NSString stringWithFormat: @"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
                    UIWebView *webView = [[UIWebView alloc]init];
                    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",_phoneNumber]]]];
                    [self.view addSubview:webView];
                    
                    
                    break;
#pragma mark - 关于我们 -
                    
                }case 2:{//关于我们

                    AboutOursViewController *aboutVC = [AboutOursViewController new];
                    aboutVC.content = _aboutOurs;
                    aboutVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                    
                    aboutVC.modalPresentationStyle = UIModalPresentationFullScreen;
                    [self presentViewController:aboutVC animated:YES completion:^{
                        
                    }];
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }case 2:{
            switch (indexPath.row) {
#pragma mark - 分享有礼 -
                case 0:{//分享有礼
                    [self alertWithMassage:[NSString stringWithFormat: @"%ld-%ld",(long)indexPath.section,(long)indexPath.row]];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}

#pragma mark - 全部订单代理
-(void)OnderPersonalHeaderView:(PersonalHeaderFooterView*)view{
   
//    [self alertWithMassage:@"全部订单"];
    self.order = [OrderViewController new];
    self.order.index = 0;
    [self presentViewController:self.order animated:YES completion:^{
        
    }];
    
    
    
}

#pragma mark - 5中状态的代理
-(void)PersonalHeaderView:(PersonalHeaderFooterView*)view index:(NSInteger)index{
    switch (index) {
        case 0:{
//            [self alertWithMassage:@"待付款订单"];
            self.order = [OrderViewController new];
            _order.index = index+1;
            [self presentViewController:self.order animated:YES completion:^{
                
            }];
            
            break;
        }case 1:{
            self.order = [OrderViewController new];
            _order.index = index+1;
            [self presentViewController:self.order animated:YES completion:^{
                
            }];
//            [self alertWithMassage:@"待发货订单"];
            break;
        }case 2:{
            self.order = [OrderViewController new];
            _order.index = index+1;
            [self presentViewController:self.order animated:YES completion:^{
                
            }];
//            [self alertWithMassage:@"待收货订单"];
            break;
        }case 3:{
//            [self alertWithMassage:@"待评价订单"];
            self.order = [OrderViewController new];
            _order.index = index+1;
            [self presentViewController:self.order animated:YES completion:^{
                
            }];
            break;
        }case 4:{
            [self alertWithMassage:@"退换/售后订单"];
//            self.order = [OrderViewController new];
//            _order.index = index;
//            [self presentViewController:self.order animated:YES completion:^{
//                
//            }];
            break;
        }
        default:
            break;
    }
}

#pragma mark - 头像代理
-(void)HeaderImgPersonalHeaderView:(PersonalHeaderFooterView*)view{
    PerMessageViewController *per = [[PerMessageViewController alloc]init];
    per.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    per.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:per animated:YES completion:^{
        
    }];
}
#pragma mark - 设置按钮的代理 (退出登录)
-(void)ExitsBtnPersonalHeaderView:(PersonalHeaderFooterView*)view btn:(UIButton *)btn{

    if (!btn.selected) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"您确定要退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }];

        
        UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"朕要走了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
#pragma mark - 退出登录 -
            [k_defaults removeObjectForKey:k_LoginStatus];
            [k_defaults removeObjectForKey:k_UserID];
            [k_defaults synchronize];
             btn.selected = YES;
            if (![k_defaults boolForKey:k_LoginStatus]) {
                
                LoginViewController *login = [LoginViewController new];
                [self presentViewController:login animated:YES completion:^{
                    btn.selected = NO;
                }];
            }
        
        }];
        
        [alert addAction:cancel];
        [alert addAction:ensure];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
    }else{
        LoginViewController *login = [LoginViewController new];
        [self presentViewController:login animated:YES completion:^{
            btn.selected = NO;
        }];
        
    }
    
    
    
    
    
}

#pragma mark - 消息按钮的代理
-(void)MessageBtnPersonalHeaderView:(PersonalHeaderFooterView*)view{
    [self alertWithMassage:@"消息"];
}






#pragma mark - 清除缓存 -


-(void)clearTheMemory{
    
    NSString *message = [NSString stringWithFormat:@"缓存大小为%.2fM,确定需要清理缓存吗?",self.memorySize];
    if (iOS8) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"先不清理" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        
        UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"马上清理" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self dataFromSDWebImageCache];
        }];
        
        [alert addAction:cancel];
        [alert addAction:ensure];
        [self presentViewController:alert animated:YES completion:^{
            
        }];
        
    }
    
    
}

-(CGFloat)memorySize{
    
    //SDWebImage缓存计算
    
    long long  tempSize = [[SDImageCache sharedImageCache] getSize];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject;
    
    NSArray *array = [manager contentsOfDirectoryAtPath:filePath error:nil];
    
    for (int i = 0; i< array.count; i++) {
        if ([manager fileExistsAtPath:filePath]) {
            
            tempSize += [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
        }
    }
    CGFloat memorySize = tempSize /1024.00 /1024.00;
    _memorySize = memorySize;
    return _memorySize;
    
}



-(void)dataFromSDWebImageCache{
    
    [[SDImageCache sharedImageCache] cleanDisk];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    [[SDWebImageManager sharedManager] cancelAll];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    NSString *filePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    NSArray *array = [manager contentsOfDirectoryAtPath:filePath error:nil];
    
    
    for (int i = 0; i< array.count; i++) {
        
        NSString *fullPath =[filePath stringByAppendingPathComponent:[array objectAtIndex:i]];
        [manager removeItemAtPath:fullPath error:nil];
    }
    
}


-(void)dealloc{
    self.memorySize = 0;
}



//-(void)alertWithLoginOrExits{
//    
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"退出登录" message:@"您确定要退出登录吗?" preferredStyle:UIAlertControllerStyleAlert];
//    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"我再想想" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        
//        [self dismissViewControllerAnimated:YES completion:^{
//            
//        }];
//        
//    }];
//    
//    UIAlertAction *ensure = [UIAlertAction actionWithTitle:@"朕要走了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        
//#pragma mark - 在这里需要处理退出登录的逻辑 -
//        [k_defaults removeObjectForKey:k_LoginStatus];
//        [k_defaults removeObjectForKey:k_UserID];
//        [k_defaults synchronize];
//        
//        [self.presentingViewController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//
//        
//    }];
//    
//    [alert addAction:cancel];
//    [alert addAction:ensure];
//    [self presentViewController:alert animated:YES completion:^{
//        
//    }];
//    
//    
//}

-(void)requestDataForPhone{
    
    
    NSString *urlstring =@"m=Customer&c=Configs&a=serviceTel";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:nil PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        _phoneNumber =[[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"] objectForKey:@"tel"];
        
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}


//

-(void)requestDataForAboutOurs{
    
    
    NSString *urlstring =@"m=Customer&c=Configs&a=about";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:nil PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        _aboutOurs =[[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"] objectForKey:@"content"];
        
        
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}








#pragma mark -- 提示弹框 --
-(void)alertWithMassage:(NSString*)massage{
    
    
    CGFloat version = [[[UIDevice currentDevice]systemVersion] floatValue];
    
    if (version >= 8.0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:massage preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
        
    }
    
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
   
    [self requestDataForAboutOurs];
}


@end
