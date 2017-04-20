//
//  StrikeThroughLabel.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StrikeThroughLabel : UILabel
{
    BOOL _strikeThroughEnabled;
}
@property(nonatomic,getter=isStrikeThroughEnabled) BOOL strikeThroughEnabled;

@end
