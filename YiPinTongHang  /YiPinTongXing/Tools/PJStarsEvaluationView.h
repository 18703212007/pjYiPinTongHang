//
//  PJStarsEvaluationView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DidChangeStarDelegate <NSObject>

-(void)didChangeStar;

@end



@interface PJStarsEvaluationView : UIView

///满分
@property(nonatomic,assign)CGFloat    fullScore;
///实际评价数值 默认为1
@property(nonatomic,assign)CGFloat    actualScore;
///是否允许半星评价  默认为NO
@property(nonatomic,getter=isContrainsHalfStar) BOOL contrainsHalfStar;

@property(nonatomic,assign)id<DidChangeStarDelegate> delegate;
#pragma mark 

/**
 
 @param frame frame
 @param numberOfStars 总星数
 @param isVariable  是否可以修改星级
 
 */

-(instancetype)initWithFrame:(CGRect)frame  numberOfStars:(NSInteger)numberOfStars isVariable:(BOOL)isVariable;

@end
