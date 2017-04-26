//
//  PJCarUIService.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/21.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PJCarViewModel;
@interface PJCarUIService : NSObject<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) PJCarViewModel *viewModel;
@property (nonatomic, strong) NSString       *shopID;


@end
