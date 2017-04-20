//
//  PJView.h
//  DingDong
//
//  Created by Apple on 16/6/16.
//  Copyright © 2016年 刘鹏杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PJView : UIView<UITextFieldDelegate>
///图片
@property(nonatomic,strong)UIImageView *imgView;
///文字
@property(nonatomic,strong)UITextField *textField;

-(instancetype)initWithFrame:(CGRect)frame Placeholder:(NSString*)placeholder ImgStr:(NSString*)imgString;



@end
