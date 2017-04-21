//
//  PJCarFooterView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJCarFooterView : UITableViewHeaderFooterView

@property (nonatomic, strong) NSMutableArray *shopGoodsArray;

+ (CGFloat)getCartFooterHeight;

@end
