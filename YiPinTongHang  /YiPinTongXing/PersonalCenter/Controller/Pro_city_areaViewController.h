//
//  Pro_city_areaViewController.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/26.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressChooseModel.h"
typedef void(^AddressChooseBlock)(NSString *string, AddressChooseModel *chooseAddress);

@interface Pro_city_areaViewController : UIViewController

@property(nonatomic,strong)NSArray *provinceArray;
@property(nonatomic,strong)NSArray *cityArray;
@property(nonatomic,strong)NSArray *areaArray;


@property(nonatomic,copy)AddressChooseBlock block;

-(void)getMessageWithBlock:(AddressChooseBlock)block;

@end
