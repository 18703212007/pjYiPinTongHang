//
//  NickNameView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/15.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NickNameView : UIView

@property(nonatomic,copy) void(^BlockNickName)(NSString *nameString);

@property(nonatomic,strong)UITextField *tf_nickName;

@property(nonatomic,strong)UIButton    *bt_sure;
@property(nonatomic,strong)UIButton    *bt_cancel;


@end
