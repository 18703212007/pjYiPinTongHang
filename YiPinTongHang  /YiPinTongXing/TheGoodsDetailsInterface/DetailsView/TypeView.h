//
//  TypeView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/16.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol typeSelectedDelegate <NSObject>

-(void)btnIndex:(int)tag;

@end

@interface TypeView : UIView

@property(nonatomic,assign)float height;

@property(nonatomic,assign)int   selectIndex;

@property(nonatomic,assign) id<typeSelectedDelegate> delegate;

-(instancetype)initWithFrame:(CGRect)frame andDataSources:(NSArray*)array String:(NSString*)typename;

@end
