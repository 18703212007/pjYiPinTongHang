//
//  LoginView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "LoginView.h"
#import "PJView.h"
@interface LoginView()
@property(nonatomic,strong)UIView *subView;

@end

@implementation LoginView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBgView];
        [self layoutSubViews];
    }
    return self;
}

-(void)setBgView{
    
    __weak typeof(self) weakself = self;
    /**
     导航View
     */
    self.navView = [UIView new];
    self.navView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).with.offset(0);
        make.left.equalTo(weakself.mas_left).with.offset(0);
        make.right.equalTo(weakself.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    /**
     其他View
     */
    self.otherView = [UIView new];
    [self addSubview:self.otherView];
    self.otherView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];;
    
    [self.otherView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.navView.mas_bottom).with.offset(0);
        make.left.equalTo(weakself.mas_left).with.offset(0);
        make.right.equalTo(weakself.mas_right).with.offset(0);
        make.bottom.equalTo(weakself.mas_bottom).with.offset(0);
    }];
    
    
}


-(void)layoutSubViews{
    __weak typeof(self) weakself = self;
    
    self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    
    
    
#pragma mark - logo
    self.logoImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_in_logo.png"]];
    
    [self.otherView addSubview:self.logoImg];
    [self.logoImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.otherView);
        make.top.equalTo(weakself.otherView.mas_top).with.offset(42);
        make.width.mas_equalTo(@85);
        make.height.mas_equalTo(@85);
    }];

#pragma mark - 登录和验证
    self.subView = [[UIView alloc]init];
    
   self.subView.backgroundColor = [UIColor colorWithHexString:@"#ffffff"];
     self.subView.cornerRadius = 5;
     self.subView.clipsToBounds = YES;
    [self.otherView addSubview: self.subView];
    
    [ self.subView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.logoImg.mas_bottom).with.offset(37);
        make.left.equalTo(weakself.otherView.mas_left).with.offset(15);
        make.height.mas_equalTo(@109);
        make.right.equalTo(weakself.otherView.mas_right).with.offset(-15);
    }];
    
    UIView *verticalView = [[UIView alloc]init];
    verticalView.backgroundColor = [UIColor colorWithHexString:@"#d3d3d3"];
    
    [ self.subView addSubview:verticalView];
    
    [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.subView.mas_top).with.offset(55);
        make.left.equalTo(weakself.subView.mas_left).with.offset(15);
        make.right.equalTo(weakself.subView.mas_right).with.offset(-15);
        make.height.mas_equalTo(@1);
    }];
    

    
    
    
    
    
    self.phoneNum = [[PJView alloc]init];
    self.phoneNum.imgView.image = IMAGE(@"sign_in_phone.png");
    self.phoneNum.textField.placeholder = @"请输入手机号码";
    self.phoneNum.textField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneNum.textField.font = [UIFont systemFontOfSize:14.0];
    [self.subView addSubview:self.phoneNum];
    [self.phoneNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.subView.mas_top).with.offset(0);
        make.left.equalTo(weakself.subView.mas_left).with.offset(0);
        make.right.equalTo(weakself.subView.mas_right).with.offset(0);
        make.height.mas_equalTo(@54);
    }];
    
    self.securityCode = [[PJView alloc]init];
    self.securityCode.imgView.image = IMAGE(@"sign_in_password.png");
    self.securityCode.textField.font = [UIFont systemFontOfSize:14.0];
    self.securityCode.textField.keyboardType = UIKeyboardTypeNumberPad;

    self.securityCode.textField.placeholder = @"请输入验证码";
    [self.subView addSubview:self.securityCode];
    [self.securityCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.phoneNum.mas_bottom).with.offset(2);
        make.left.equalTo(weakself.subView.mas_left).with.offset(0);
        make.right.equalTo(weakself.subView.mas_right).with.offset(0);
        make.height.mas_equalTo(@54);
    }];
    
    self.securityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.securityBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
    self.securityBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.securityBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.securityBtn.clipsToBounds = YES;
    self.securityBtn.cornerRadius = 3;
    self.securityBtn.backgroundColor  = [UIColor colorWithHexString:@"#e8e8e8"];
    [self.securityCode addSubview:self.securityBtn];
    
    [self.securityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.securityCode.mas_top).with.offset(13.5);
        make.right.equalTo(weakself.securityCode.mas_right).with.offset(-15);
        make.width.mas_equalTo(@75);
        make.height.mas_equalTo(@27);
    }];
    
    
#pragma mark - 登录按钮
    
    self.LoginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.LoginBtn.clipsToBounds = YES;
    self.LoginBtn.cornerRadius = 5;
    [self.LoginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [self.LoginBtn setTitleColor:[UIColor lightTextColor] forState:UIControlStateNormal];
    self.LoginBtn.backgroundColor = [UIColor lightGrayColor];
//    self.LoginBtn.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];//#cf292e
    [self addSubview:self.LoginBtn];
    [self.LoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.subView.mas_bottom).with.offset(49);
        make.left.equalTo(weakself.otherView.mas_left).with.offset(15);
        make.right.equalTo(weakself.otherView.mas_right).with.offset(-15);
        make.height.mas_equalTo(@48);
    }];
    
#pragma mark - QQ登录
    self.QQLogin = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_in_qq.png"]];
    self.QQLogin.userInteractionEnabled = YES;
    [self addSubview:self.QQLogin];
    
    [self.QQLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.otherView.mas_bottom).with.offset(-20);
        make.centerX.equalTo(weakself.otherView);
        make.width.mas_equalTo(@52);
        make.height.mas_equalTo(@52);
    }];
#pragma mark - 新浪登录
    self.SinaLogin = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_in_micro_blog.png"]];
    [self addSubview:self.SinaLogin];
    
    [self.SinaLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.otherView.mas_bottom).with.offset(-20);
        make.left.equalTo(weakself.otherView.mas_left).with.offset(30);
        make.width.mas_equalTo(@52);
        make.height.mas_equalTo(@52);
    }];
    
#pragma mark - 微信登录    
    self.WeiChatLogin = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"sign_in_wechat.png"]];
    [self addSubview:self.WeiChatLogin];
    
    [self.WeiChatLogin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.otherView.mas_bottom).with.offset(-20);
        make.right.equalTo(weakself.otherView.mas_right).with.offset(-30);
        make.width.mas_equalTo(@52);
        make.height.mas_equalTo(@52);
    }];
    
    
    self.textLabel = [[UILabel alloc]init];
    self.textLabel.text = @"· 其他方式登陆 ·";
    self.textLabel.textColor = [UIColor blackColor];
    [self addSubview:self.textLabel];
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakself.QQLogin.mas_top).with.offset(-10);
        make.centerX.equalTo(weakself.otherView);
        make.height.mas_equalTo(35);
        make.width.mas_equalTo(123);
        
    }];
    
    
    
    
}


    
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/







@end
