//
//  PJButton.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJButton.h"

@implementation PJButton

-(instancetype)initWithFrame:(CGRect)frame Image:(UIImage*)img Message:(NSString *)msg 
{
    if (self = [super initWithFrame:frame]) {
        self.headLabel = [UILabel new];
        self.headLabel.backgroundColor = [UIColor clearColor];
        self.headLabel.text =msg;
        self.headLabel.textAlignment = NSTextAlignmentLeft;
        self.headLabel.font = [UIFont systemFontOfSize:15.0];
        self.headLabel.numberOfLines = 1;
        [self addSubview:self.headLabel];
        
        
        self.img = [UIImageView new];
        [self addSubview:self.img];
        self.img.image = img;
        self.img.contentMode = UIViewContentModeScaleAspectFit;
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(10);
            make.left.equalTo(self.mas_left).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(22, 22));
            
        }];
        
        [self.headLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(5);
            make.left.equalTo(self.img.mas_right).with.offset(3);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.height.mas_equalTo(32);
        }];
        self.line = [UILabel new];
        self.line.backgroundColor = [UIColor lightTextColor];
        
       
            [self addSubview:self.line];
            [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
                
                make.bottom.equalTo(self.mas_bottom).with.offset(-0.5);
                make.left.equalTo(self.mas_left).with.offset(5);
                make.right.equalTo(self.mas_right).with.offset(-3);
                make.height.mas_equalTo(@0.5);
            }];
        
        
        
        
    }
    return self;
}


   

    
    
    


@end
