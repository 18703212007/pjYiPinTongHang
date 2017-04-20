//
//  LoginView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PJView;
@interface LoginView : UIView
@property(nonatomic,strong)UIView *navView;
@property(nonatomic,strong)UIView *otherView;

///图标
@property(nonatomic,strong)UIImageView *logoImg;
///手机号
@property(nonatomic,strong)PJView *phoneNum;
///验证码
@property(nonatomic,strong)PJView *securityCode;
///发送验证码
@property(nonatomic,strong)UIButton *securityBtn;
///登录按钮
@property(nonatomic,strong)UIButton *LoginBtn;
///字样
@property(nonatomic,strong)UILabel *textLabel;
#pragma mark -第三方图标
///新浪
@property(nonatomic,strong)UIImageView *SinaLogin;
///QQ
@property(nonatomic,strong)UIImageView *QQLogin;
///WeiChat
@property(nonatomic,strong)UIImageView *WeiChatLogin;

@end
