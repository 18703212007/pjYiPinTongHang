//
//  PersonalCollectionReusableView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/24.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PersonalCollectionReusableView;

@protocol PersonalCollectionReusableViewDelegate <NSObject>

-(void)PersonalCollectionReusableView:(PersonalCollectionReusableView*)view index:(NSInteger)index;

@end


@interface PersonalCollectionReusableView : UICollectionReusableView

@property(nonatomic,assign)id<PersonalCollectionReusableViewDelegate>delegate;

@end


