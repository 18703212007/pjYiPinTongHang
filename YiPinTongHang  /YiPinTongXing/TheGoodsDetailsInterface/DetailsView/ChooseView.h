//
//  ChooseView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/16.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TypeView.h"
#import "BuyCountView.h"
@interface ChooseView : UIView
///
@property(nonatomic,strong)UIView        *alphaView;
///
@property(nonatomic,strong)UIView        *whiteView;

///
@property(nonatomic,strong)UIImageView   *img;


///
@property(nonatomic,strong)UILabel       *lb_price;
///
@property(nonatomic,strong)UILabel       *lb_stock;
///
@property(nonatomic,strong)UILabel       *lb_detail;
///
@property(nonatomic,strong)UILabel       *lb_line;


///
@property(nonatomic,strong)UIScrollView  *mainscrollView;


///
@property(nonatomic,strong)TypeView      *sizeView;
///
@property(nonatomic,strong)TypeView      *colorView;
///
@property(nonatomic,strong)BuyCountView  *countView;
///
@property(nonatomic,strong)UIButton      *bt_sure;
///
@property(nonatomic,strong)UIButton      *bt_cancle;


///
@property(nonatomic,strong)NSArray       *sizeArray;
///
@property(nonatomic,strong)NSArray       *colorArray;
///
@property(nonatomic,strong)NSDictionary  *stockDic;
///
@property(nonatomic,assign)int           stock;

-(void)initTypeViewSizeArray:(NSArray*)sizeArray ColorArray:(NSArray*)colorArray dictionary:(NSDictionary*)stockDic sizeName:(NSString*)sizeName colorName:(NSString*)colorName Stock:(NSString*)stock;





@end
