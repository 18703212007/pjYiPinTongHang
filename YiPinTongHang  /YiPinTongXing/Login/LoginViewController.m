//
//  LoginViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginView.h"
#import "PJView.h"
#import "AppDelegate.h"
@interface LoginViewController ()
@property(nonatomic,strong)LoginView *loginView;

@property(nonatomic,strong)UILabel  *navLabel;


@end

@implementation LoginViewController



-(void)loadView{
    self.loginView = [[LoginView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.loginView;
    
    self.loginView.phoneNum.textField.text = @"18703212007";
    self.loginView.securityCode.textField.text = @"757751";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(KeyBarodPush:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    self.loginView.LoginBtn.enabled = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginBtnDidClicked) name:UITextFieldTextDidChangeNotification object:nil];
    
    
    
    
    
    [self CostomNav];
    
    
#pragma mark - Target Action
    
    [self.loginView.securityBtn addTarget:self action:@selector(securityBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.loginView.LoginBtn addTarget:self action:@selector(LoginBtnDidClicked:) forControlEvents:UIControlEventTouchUpInside];
    
#pragma mark -- User
    self.loginView.QQLogin.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *QQTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(QQLogin:)];
    [self.loginView.QQLogin addGestureRecognizer:QQTap];
    
    
    self.loginView.SinaLogin.userInteractionEnabled = YES;
    UITapGestureRecognizer *SinaTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(SinaLogin:)];
    [self.loginView.SinaLogin addGestureRecognizer:SinaTap];
    
    
    self.loginView.WeiChatLogin.userInteractionEnabled = YES;
    UITapGestureRecognizer *WeiChatTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(WeiChatLogin:)];
    [self.loginView.WeiChatLogin addGestureRecognizer:WeiChatTap];
    
    
    
    
    
    
    
    // Do any additional setup after loading the view.
}




#pragma mark -- SecurityCodeSend
-(void)securityBtnDidClicked:(UIButton*)sender{
    
    
    NSString *urlstring = @"m=Customer&c=Code&a=codeFind";
    
    if ([self.loginView.phoneNum.textField.text isEqualToString:@""]||[self.loginView.phoneNum.textField.text isEqualToString:@" "]||self.loginView.phoneNum.textField.text == nil) {
        [self alertWithMassage:@"手机号码不能为空"];
    }else{
        [self checkTelNumber:self.loginView.phoneNum.textField.text];
    
        [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:@{@"phone":self.loginView.phoneNum.textField.text} PrepareExecute:^{
            
        } Success:^(NSURLSessionDataTask *task, id responseObject) {
            
            
            
            
        } Failure:^(NSURLSessionDataTask *task, NSError *error) {
            
        }];
        
        
    }
    
    
    
    
    
}
#pragma mark - LoginIn
-(void)LoginBtnDidClicked{
//    [self alertWithMassage:@"登录"];

    if (self.loginView.phoneNum.textField.text.length >=11&&self.loginView.securityCode.textField.text.length >= 6) {
        self.loginView.LoginBtn.enabled = YES;
    }else{
        self.loginView.LoginBtn.enabled = NO;
    }
    
    
  /**           757751         */
    
}

-(void)LoginBtnDidClicked:(UIButton*)sender{
    
    if (self.loginView.LoginBtn.enabled) {
        [self loginMessageGet];
    }
    
}



-(void)loginMessageGet{

        NSString *urlstring = @"m=Customer&c=Users&a=register";
                       
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:@{@"phone":self.loginView.phoneNum.textField.text,@"code":self.loginView.securityCode.textField.text} PrepareExecute:^{
    
        } Success:^(NSURLSessionDataTask *task, id responseObject) {
    
            NSString *userID;
            NSInteger code;
            NSString *message;
            NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil]);
            
            userID = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"data"];
                
            code = [[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"code"] integerValue];
            message =[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil] objectForKey:@"message"];
    
            if (code == 200) {
                [self alertWithMassage:message];
                
                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                [defaults setObject:userID forKey:k_UserID];
                [defaults setBool:YES forKey:k_LoginStatus];
                [defaults synchronize];
                k_defaults = defaults;
                [self dismissViewControllerAnimated:YES completion:^{
                    
                }];
                
            }else {
                
                
                [self alertWithMassage:message];
            }
    
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
        [self alertWithMassage:@"登录失败请重试"];
        
    }];


}


/**
 *  QQ登录
 *
 *  @return nil
 */
#pragma mark -- TapGesture
///QQ
-(void)QQLogin:(UITapGestureRecognizer*)sender{
//    [self alertWithMassage:@"QQ"];
    [ShareSDK getUserInfo:SSDKPlatformTypeQQ
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             NSLog(@"%@",user);
             NSLog(@"uid=%@",user.uid);
             NSLog(@"credential:%@",user.credential);
             NSLog(@"gender:%lu",(unsigned long)user.gender);
             NSLog(@"icon:%@",user.icon);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
         }
         
         else
         {
             NSLog(@"%@",error);
         }
         
     }];
}
///Sina
-(void)SinaLogin:(UITapGestureRecognizer*)sender{
// [self alertWithMassage:@"Sina"];
    [ShareSDK getUserInfo:SSDKPlatformTypeSinaWeibo onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            NSLog(@"%@",user);
        }else{
            NSLog(@"%@",error);
        }
    }];
}
///WeiChat
-(void)WeiChatLogin:(UITapGestureRecognizer*)sender{
//    [self alertWithMassage:@"WeiChat"];
    
    
    [ShareSDK getUserInfo:SSDKPlatformTypeWechat onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            NSLog(@"%@",user);
        }else{
            NSLog(@"%@",error);
        }
    }];
}


-(void)backBtn:(UIButton*)sebder{
        [self dismissViewControllerAnimated:YES completion:nil];

//    [[AppDelegate APPDelegate] exitApplication];
    
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





#pragma mark --正则匹配手机号
- (void)checkTelNumber:(NSString*) telNumber
{
    NSString *pattern =@"^1+[34578]+\\d{9}";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [predicate evaluateWithObject:telNumber];
    if (isMatch) {
        [self openCountdown];
        
    }else{
        [self alertWithMassage:@"手机号码不匹配"];
    }
    
}






//提示弹框
-(void)alertWithMassage:(NSString*)massage{
    
    
    CGFloat version = [[[UIDevice currentDevice]systemVersion] floatValue];
    
    if (version >= 8.0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:massage preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
        
    }
    
}

// 开启倒计时效果
-(void)openCountdown{
    
    __block NSInteger time = 59; //倒计时时间
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
    dispatch_source_set_event_handler(_timer, ^{
        
        if(time <= 0){ //倒计时结束，关闭
            
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮的样式
                [self.loginView.securityBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
                [self.loginView.securityBtn setTitleColor:ColorHex(0xffffff) forState:UIControlStateNormal];
                self.loginView.securityBtn.userInteractionEnabled = YES;
            });
            
        }else{
            
            int seconds = time % 60;
            dispatch_async(dispatch_get_main_queue(), ^{
                
                //设置按钮显示读秒效果
                [self.loginView.securityBtn setTitle:[NSString stringWithFormat:@"重新发送(%.2d)", seconds] forState:UIControlStateNormal];
                [self.loginView.securityBtn setTitleColor:ColorHex(0x979797) forState:UIControlStateNormal];
                self.loginView.securityBtn.userInteractionEnabled = NO;
            });
            time--;
        }
    });
    dispatch_resume(_timer);
    
}

#pragma mark - 自定义NV -
-(void)CostomNav{
    
//        __weak typeof(self) weakself = self;
    self.navigationController.navigationBar.hidden = YES;
    //
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.loginView.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    //navLabel
    
    self.navLabel = [UILabel new];
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    self.navLabel.textColor = [UIColor whiteColor];
    self.navLabel.text = @"登录";
//    self.navLabel.backgroundColor = [UIColor purpleColor];
    [view addSubview:self.navLabel];
    [self.navLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(32);
        make.width.mas_equalTo(@35);
        make.height.mas_equalTo(@26);
    }];

    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:[UIImage imageNamed:(@"sign_in_return.png")] forState:UIControlStateNormal];
    [self.backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(8);
        make.top.equalTo(view.mas_top).with.offset(32);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];

    
    
    
    
    
    /**
     
     make.right.equalTo(weakself.BgImg.mas_right).with.offset(-20);
     make.top.equalTo(weakself.BgImg.mas_top).with.offset(32);
     make.height.mas_equalTo(@22);
     make.width.mas_equalTo(@22);
     
     */
}


/**
 *  收起键盘
 *
 *  @return
 */
#pragma mark - 键盘问题 -
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    for (UIView *view in self.view.subviews) {
        [view resignFirstResponder];
    }
}
/**
 *  键盘弹出事件
 *
 *  @param sender NSNotification
 */
-(void)KeyBarodPush:(NSNotification*)sender{
    
    NSValue *keyBoardBeginBounds = [[sender userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect beginRect = [keyBoardBeginBounds CGRectValue];
    
    
    NSValue *keyBoardEndBounds = [[sender userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect endRect = [keyBoardEndBounds CGRectValue];
    
    CGFloat y = endRect.origin.y -beginRect.origin.y;
    

    [UIView animateWithDuration:0.25f animations:^{
        [self.view setFrame:CGRectMake(self.view.x, self.view.y+y/4, self.view.width, self.view.height)];
    }];
}



@end
