//
//  PJTextView.m
//  InviteJK
//
//  Created by Apple on 16/9/3.
//  Copyright © 2016年 刘鹏杰. All rights reserved.
//

#import "PJTextView.h"

@interface PJTextView()

@property(nonatomic,strong)UILabel *placeholderLabel;


@end



@implementation PJTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        UILabel *placeholderLabel =[[UILabel alloc]init];
        placeholderLabel.backgroundColor = [UIColor clearColor];
        
        placeholderLabel.numberOfLines = 0;
        [self addSubview:placeholderLabel];
        self.placeholderLabel = placeholderLabel;
        self.myPlacehloderColor = [UIColor lightGrayColor];
        self.font = [UIFont systemFontOfSize:14.0];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}











-(void)textDidChange{
    self.placeholderLabel.hidden = self.hasText;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    self.placeholderLabel.y = 8;
    self.placeholderLabel.x = 5;
    
    self.placeholderLabel.width = self.width-self.placeholderLabel.x*2.0;
    
    //根据文字计算高度
    
    CGSize maxSize =CGSizeMake(self.placeholderLabel.width,MAXFLOAT);
    
    self.placeholderLabel.height= [self.myPlacehloder boundingRectWithSize:maxSize options:NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : self.placeholderLabel.font} context:nil].size.height;
    
    
    
   
}







-(void)setMyPlacehloder:(NSString *)myPlacehloder{
    _myPlacehloder = [myPlacehloder copy];
    
    self.placeholderLabel.text = myPlacehloder;
    
    [self setNeedsLayout];
}


-(void)setMyPlacehloderColor:(UIColor *)myPlacehloderColor{
    _myPlacehloderColor = myPlacehloderColor;
    
    
    self.placeholderLabel.textColor = myPlacehloderColor;
    
}



-(void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
    [self setNeedsLayout];
}



-(void)setText:(NSString *)text{
    [super setText:text];
    
    [self textDidChange];
}




-(void)setAttributedText:(NSAttributedString *)attributedText
{
    [super setAttributedText:attributedText];
    [self textDidChange];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:UITextViewTextDidChangeNotification];
}




@end
