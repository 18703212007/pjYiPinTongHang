//
//  DataManager.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "DataManager.h"

static DataManager *manager = nil;

@implementation DataManager

+(instancetype)shareInstance{
    
    return [[self alloc]init];
    
}
+(instancetype)allocWithZone:(struct _NSZone *)zone
{
//    static dispatch_once_t onceToken;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (manager == nil) {
            manager = [super allocWithZone:zone];
        }
    });
    return manager;
}




-(NSUserDefaults *)defaults{
    if (_defaults == nil) {
        _defaults = [NSUserDefaults standardUserDefaults];
       
    }
    return _defaults;
}



@end
