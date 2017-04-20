//
//  PJImgaeBrowser.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/16.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJImgaeBrowser.h"

static CGRect oldframe;
@implementation PJImgaeBrowser

+(void)showImage:(UIImageView *)avatarImageView{
     
     UIImage *image=avatarImageView.image;
    
     UIWindow *window=[UIApplication sharedApplication].keyWindow;
 UIView *backgroundView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
     
     oldframe=[avatarImageView convertRect:avatarImageView.bounds toView:window];
     
     backgroundView.backgroundColor=[UIColor blackColor];
    
     backgroundView.alpha = 0;
     
     UIImageView *imageView = [[UIImageView alloc]initWithFrame:oldframe];
     
     imageView.image = image;
     
     imageView.tag = 20170316;
    
     [backgroundView addSubview:imageView];
     
     [window addSubview:backgroundView];
 
 UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideImage:)];
     
    [backgroundView addGestureRecognizer: tap];
 
 [UIView animateWithDuration:0.3 animations:^{
     
     imageView.frame = CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
//     [imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
//         make.left.equalTo(backgroundView.mas_left).with.offset(0);
//         make.top.equalTo(backgroundView.mas_top).with.offset(screen_height-);
//     }];
     
     backgroundView.alpha = 1;
     
 } completion:^(BOOL finished) {
 
 }];
 }
 
+(void)hideImage:(UITapGestureRecognizer*)tap{
     
     UIView *backgroundView=tap.view;
     
     UIImageView *imageView=(UIImageView*)[tap.view viewWithTag:20170316];
     
     [UIView animateWithDuration:0.3 animations:^{
         imageView.frame=oldframe;
         
         backgroundView.alpha=0;
         
    } completion:^(BOOL finished) {
        
        [backgroundView removeFromSuperview];
    }];
}
 
 

@end
