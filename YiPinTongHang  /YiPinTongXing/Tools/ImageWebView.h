//
//  ImageWebView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageWebView : UIView

@property(nonatomic,strong)UIWebView *webView;
@property(nonatomic,assign)NSInteger selecttIndex;
@property(nonatomic,strong)NSArray *webArray;

-(instancetype)initWithFrame:(CGRect)frame WebArr:(NSArray*)webArr;

@end
