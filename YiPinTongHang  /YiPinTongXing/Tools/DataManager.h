//
//  DataManager.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RETURNBLOCK)();

@interface DataManager : NSObject


@property(nonatomic,strong)NSUserDefaults *defaults;


+(instancetype)shareInstance;









@end
