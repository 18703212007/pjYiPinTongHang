//
//  HUDViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/31.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "HUDViewController.h"

@interface HUDViewController ()<MBProgressHUDDelegate>

@end

@implementation HUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


+(void)HUDShowWithView:(UIView*)view{
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = @"努力加载中…";
    hud.color = RGBA(28, 88, 66, 0.1);
    UIImage *image = [[UIImage imageNamed:@"HUD"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.toValue = @(M_PI*2);
    anima.duration = 1.5f;
    anima.repeatCount = 10;
    [imgView.layer addAnimation:anima forKey:nil];
    hud.customView = imgView;
    
    //        hud.bezelView.color = [UIColor colorWithWhite:0.0 alpha:1];
    //文字颜色
    hud.labelColor = [UIColor blackColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType = MBProgressHUDAnimationZoom;
}

+(void)dismissWithView:(UIView*)view{

[MBProgressHUD hideHUDForView:view animated:YES];

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

@end
