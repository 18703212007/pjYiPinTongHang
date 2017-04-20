//
//  PJButton.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJButton : UIButton

@property(nonatomic,strong)UILabel *headLabel;


@property(nonatomic,strong)UIImageView *img;

@property(nonatomic,strong)UILabel     *line;

-(instancetype)initWithFrame:(CGRect)frame Image:(UIImage*)img Message:(NSString*)msg;


@end
