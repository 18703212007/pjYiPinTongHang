//
//  SetUpView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/11.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetUpView : UIView

@end



#pragma mark - 个人信息页面 - 
@interface PersonView : UIView

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UIImageView *headImg;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton    *btn_exit;



@end



