//
//  PJCarBar.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJCarBar : UIView


/**
 *  结算
 */
@property (nonatomic, strong) UIButton *balanceButton;
/**
 *  全选
 */
@property (nonatomic, strong) UIButton *selectAllButton;
/**
 *  价格
 */
@property (nonatomic, retain) UILabel *allMoneyLabel;
/**
 *  删除
 */
@property (nonatomic, strong) UIButton *deleteButton;

@property (nonatomic, assign) BOOL     isNormalState;

@property (nonatomic, assign) float    money;


@end
