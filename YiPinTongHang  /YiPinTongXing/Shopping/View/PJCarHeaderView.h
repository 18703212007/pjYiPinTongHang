//
//  PJCarHeaderView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJCarHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) UIButton *selectStoreGoodsButton;
@property (nonatomic, strong) UIButton *storeNameButton;
@property (nonatomic, strong) NSString *shopID;
+ (CGFloat)getCartHeaderHeight;

@end
