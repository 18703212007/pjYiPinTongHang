//
//  StrikeThroughLabel.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "StrikeThroughLabel.h"

@implementation StrikeThroughLabel
@synthesize strikeThroughEnabled = _strikeThroughEnabled;


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    [super drawRect:rect];
    
    NSDictionary *fontDic = [NSDictionary dictionaryWithObjectsAndKeys:[self font],NSFontAttributeName, nil];
    CGSize size = [[self text]sizeWithAttributes:fontDic];
    
    CGFloat strikeWidth = size.width;
    
    CGRect linkRect;
    
    if ([self textAlignment] == NSTextAlignmentRight) {
        linkRect = rect(rect.size.width - strikeWidth, rect.size.height/2.0, strikeWidth, 1);
    }else if ([self textAlignment] == NSTextAlignmentCenter){
        linkRect = rect(rect.size.width/2.0 - strikeWidth/2.0, rect.size.height/2.0, strikeWidth, 1);
    }else{
        linkRect = rect(0, rect.size.height/2, strikeWidth, 1);
    }
    
    
    if (_strikeThroughEnabled) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextFillRect(context, linkRect);
    }
    
    
}

-(void)setStrikeThroughEnabled:(BOOL)strikeThroughEnabled{
    _strikeThroughEnabled = strikeThroughEnabled;
    
    NSString *tempText = [self.text copy];
    self.text = @"";
    self.text = tempText;
}


@end
