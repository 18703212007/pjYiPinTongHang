//
//  AppDelegate.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "GoodsDetailsModel.h"

#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>

//微信SDK头文件
#import "WXApi.h"

//新浪微博SDK头文件
#import "WeiboSDK.h"
//新浪微博SDK需要在项目Build Settings中的Other Linker Flags添加"-ObjC"

static AppDelegate  *_appDelegate;
@interface AppDelegate ()

@end

@implementation AppDelegate
/**
 
 目前设计到的ID有以下3个id
 ****
 gId 就是商品Id  对应我的goodsID
 catsID    分类ID  对于我的catsID
 type      5(好) 3(中) 1(差)  9(有图) 对于评论
 
 ****
 */

+(AppDelegate *)APPDelegate{
    return _appDelegate;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    /**
     *  设置ShareSDK的appKey，如果尚未在ShareSDK官网注册过App，请移步到http://mob.com/login 登录后台进行应用注册
     *  在将生成的AppKey传入到此方法中。
     *  方法中的第二个第三个参数为需要连接社交平台SDK时触发，
     *  在此事件中写入连接代码。第四个参数则为配置本地社交平台时触发，根据返回的平台类型来配置平台信息。
     *  如果您使用的时服务端托管平台信息时，第二、四项参数可以传入nil，第三项参数则根据服务端托管平台来决定要连接的社交SDK。
     */
    [ShareSDK registerApp:@"iosv1101"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeSinaWeibo),
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:///微信
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:///QQ
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             case SSDKPlatformTypeSinaWeibo:///微博
                 [ShareSDKConnector connectWeibo:[WeiboSDK class]];
                 break;
             
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeSinaWeibo:
                 //设置新浪微博应用信息,其中authType设置为使用SSO＋Web形式授权
                 [appInfo SSDKSetupSinaWeiboByAppKey:@"1512580960"
                                           appSecret:@"f0d2f85bf1472d9bce3850441f2c9b2d"
                                         redirectUri:@"http://www.yipintonghang.com"
                                            authType:SSDKAuthTypeBoth];

                 break;
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx6b5ccc706399265c"
                                       appSecret:@"c1389417e35225881c8bfdda8cd06745"];
                 break;
             case SSDKPlatformTypeQQ://060B0FBF
                 [appInfo SSDKSetupQQByAppId:@"101388223"
                                      appKey:@"d5bf920455fdc0083341163297215c18"
                                    authType:SSDKAuthTypeBoth];
                 break;
            default:
                 break;
         }
     }];
    
    
    NSLog(@"%@",NSHomeDirectory());
   
    
//    {   "adrId":"45",
//        "content":["李敏来咯",""],
//        "goodsNum":["3","1","1","1"],
//        "goodsPrice":["6003.0","6004.01","6880.0","5868.0"],
//        "goodsid":["256","256","257","258"],
//        "shopid":["34","35"],
//        "uid":"44",
//        "yunfei":["0","0"],
//        "zprice":["24013.010000000002","12748.0"]
//    }
    
    
    
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    
    
    [self.window makeKeyAndVisible];
    RootViewController *rootVC = [[RootViewController alloc]init];
    
    self.window.rootViewController =rootVC;
    _appDelegate = self;
    [self checkLogin];
    
    
    NSDictionary *dictionary = @{@"order":
                                     @{
                                         @"shopid"    :@[@"34"],
                                         @"goodsid"   :@[@"256"],
                                         @"goodsNum"  :@[@"2"],
                                         @"zprice"    :@[@"6003.00"],
                                         @"goodsPrice":@[@"12006.00"],
                                         @"yunfei"    :@[@"0"],
                                         @"adrId"     :@"46",
                                         @"uid"       :@"45",
                                         @"content"   :@[@""]
                                         }
                                 };
    
    
    
    
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
//    
//    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    NSLog(@"%@",dictionary);
//
//    NSString *urlstr = @"m=Customer&c=Orders&a=orderAdd";
//    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstr] Method:HTTPRequestPost Paramenters:str PrepareExecute:^{
//        
//    } Success:^(NSURLSessionDataTask *task, id responseObject) {
//        NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
//    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
//        
//    }];
    
    
    

    
    return YES;
    
    
    
   
    
}

- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace {
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
        //if ([trustedHosts containsObject:challenge.protectionSpace.host])
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]
             forAuthenticationChallenge:challenge];
    
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void)checkLogin{
    
    if (!LoginStatus) {
        [k_defaults setObject:@"" forKey:k_UserID];
        [k_defaults setBool:NO forKey:k_LoginStatus];
        [k_defaults synchronize];
        
    }else{
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    
    
    
    /*
     
     Failed to chmod /Users/dhz/Library/Developer/CoreSimulator/Devices/E14F41AE-1009-418A-B551-F4379563092E/data/Library/Caches/com.apple.containermanagerd/Bundle/Application/5E702DBF-EAAA-45BB-BF79-ACDF4107E958/YiPinTongXing.app/YiPinTongXing : No such file or directory
     
     
     */
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
#pragma mark - 版本检测问题 强制更新 -
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}





-(void)exitApplication{
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    [UIView setAnimationDuration:1.0];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.window cache:NO];
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    self.window.bounds = rect(0, 0, 0, 0);
    [UIView commitAnimations];
    
}
-(void)animationFinished:(NSString*)animationID finished:(NSNumber*)finished context:(void*)content{
    
    if ([animationID compare:@"exitApplication"] == 0) {
        exit(0);
    }
    
}


@end
