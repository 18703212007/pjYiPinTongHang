//
//  PersonalViewController.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalViewController : UIViewController
@property(nonatomic,strong)UIImage *img;

-(void)requestDataForPhone;
-(void)requestDataForAboutOurs;
@end
