//
//  PJView.m
//  DingDong
//
//  Created by Apple on 16/6/16.
//  Copyright © 2016年 刘鹏杰. All rights reserved.
//

#import "PJView.h"




@implementation PJView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self allViews];
    }
    return self;
}



-(instancetype)initWithFrame:(CGRect)frame Placeholder:(NSString *)placeholder ImgStr:(NSString *)imgString
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImageView *imgView= [UIImageView new];
        [self addSubview:imgView];
        [imgView sd_setImageWithURL:[NSURL URLWithString:imgString] placeholderImage:[UIImage imageNamed:@"Cellplaceholder.png"]];
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(18.5);
            make.left.equalTo(self.mas_left).with.offset(15);
            make.width.mas_equalTo(@20);
            make.height.mas_equalTo(@22);
        }];
        
        self.textField = [[UITextField alloc]init];
        self.textField.placeholder =placeholder;
        self.textField.textAlignment = NSTextAlignmentLeft;
        self.textField.delegate = self;
        
        ///设置placeHold字体
        NSAttributedString *att = [[NSAttributedString  alloc]initWithString:placeholder attributes:@{NSFontAttributeName:self.textField.font}];
        self.textField.attributedPlaceholder = att;
        [self addSubview:self.textField];
        
        [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_offset(UIEdgeInsetsMake(8, 50, 0, 0));
        }];

        
        
    }
    return self;

}



-(void)allViews
{

    __weak typeof(self) weakself = self;
    
    self.imgView = [[UIImageView alloc]init];
    [self addSubview:self.imgView];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.mas_top).with.offset(18.5);
        make.left.equalTo(weakself.mas_left).with.offset(15);
        make.width.mas_equalTo(@20);
        make.height.mas_equalTo(@22);
    }];
#pragma mark -- 竖线
//    UIView *overticalView = [[UIView alloc]init];
//    overticalView.backgroundColor =RGB(170, 182, 207);
//
//    [self addSubview:overticalView];
//    
//    [overticalView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakself.mas_top).with.offset(14);
//        make.left.equalTo(weakself.imgView.mas_right).with.offset(20);
//        make.width.mas_equalTo(@1);
//        make.height.mas_equalTo(self.height-30);
//    }];
//    
    
    
    
#pragma mark -- 输入框
    
    self.textField = [[UITextField alloc]init];
    self.textField.placeholder =@"";
    self.textField.textAlignment = NSTextAlignmentLeft;
    self.textField.delegate = self;
//    self.textField.clearButtonMode = UITextFieldViewModeAlways;
//    self.textField.borderStyle = UITextBorderStyleRoundedRect;
    
    ///设置placeHold字体
    NSAttributedString *att = [[NSAttributedString  alloc]initWithString:@"" attributes:@{NSFontAttributeName:self.textField.font}];
    self.textField.attributedPlaceholder = att;
    [self addSubview:self.textField];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(8, 50, 0, 0));
    }];
    
    
    
#pragma mark -- 横线
//    UIView *verticalView = [[UIView alloc]init];
//    verticalView.backgroundColor = [UIColor colorWithHexString:@"#d3d3d3"];
//    
//    [self addSubview:verticalView];
//    
//    [verticalView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(weakself.mas_top).with.offset(55);
//       make.left.equalTo(weakself.mas_left).with.offset(0);
//        make.right.equalTo(weakself.mas_right).with.offset(0);
//        make.height.mas_equalTo(@1);
//    }];
//    
    
    

    
    
    
}







- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}







/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
