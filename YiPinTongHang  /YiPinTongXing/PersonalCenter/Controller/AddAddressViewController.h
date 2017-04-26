//
//  AddAddressViewController.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/25.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddressChooseModel.h"
typedef void(^ReturnBlock)(AddressGetModel *model);

@interface AddAddressViewController : UIViewController
@property(nonatomic,strong)NSString *addString;
@property(nonatomic,copy)ReturnBlock block;
-(void)returnBlock:(ReturnBlock)block;



#pragma mark -  -

@property(nonatomic,strong)NSString *name;

@property(nonatomic,strong)NSString *phoneNum;

@property(nonatomic,strong)NSString *areaString;

@property(nonatomic,strong)NSString *detailsString;

@property(nonatomic,strong)NSString *arid;

@property(nonatomic,strong)NSString *provinceID;
@property(nonatomic,strong)NSString *cityID;
@property(nonatomic,strong)NSString *areaID;
@end
