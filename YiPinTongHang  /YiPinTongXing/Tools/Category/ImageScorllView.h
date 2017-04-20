//
//  ImageScorllView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageScorllView : UIView

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UIPageControl *pageControl;


/**
 *  轮播图
 *
 *  @param frame     frame
 *  @param imageArr  轮播图数组
 *
 *
 *
 */

 



-(instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray*)imageArr;



@end
