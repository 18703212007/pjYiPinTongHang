//
//  TypeView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/16.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "TypeView.h"

@implementation TypeView

-(instancetype)initWithFrame:(CGRect)frame andDataSources:(NSArray *)array String:(NSString *)typename
{
    if (self = [super initWithFrame:frame]) {
        UILabel *lab = [UILabel new];
        lab.text = typename;
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:14.0];
        [self addSubview:lab];
//        lab.frame = rect(10, 10, 200, 20);
        [lab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(10);
            make.left.equalTo(self.mas_left).with.offset(10);
            make.width.mas_equalTo(@200);
            make.height.mas_equalTo(@20);
        }];
        
        
//        BOOL isLineReturn = NO;
        float upX = 10;
        float upY = 40;
        for (int i = 0; i<array.count; i++) {
            NSString *str = [array objectAtIndex:i];
            
            NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIFont boldSystemFontOfSize:14.0] forKey:NSFontAttributeName];
            CGSize size = [str sizeWithAttributes:dic];
            
            if (upX >(screen_width - 20 - size.width - 35)) {
//                isLineReturn = YES;
                upX = 10;
                upY += 30;
                
            }
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = rect(upX, upY, size.width +30, 25);
            [btn setBackgroundColor:[UIColor colorWithHexString:@"#f0f0f0"]];
            btn.alpha = 1.0;
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            
            btn.titleLabel.font = [UIFont systemFontOfSize:13.0];
            [btn setTitle:[array objectAtIndex:i] forState:UIControlStateNormal];
            btn.layer.cornerRadius = 8;
            btn.layer.borderColor = [UIColor clearColor].CGColor;
            btn.layer.borderWidth = 0;
            [btn.layer setMasksToBounds:YES];
            
            [self addSubview:btn];
            btn.tag = 100+i;
            [btn addTarget:self action:@selector(touchBtn:) forControlEvents:UIControlEventTouchUpInside];
            upX += size.width + 35;
        }
        upY += 30;
        UILabel *line = [[UILabel alloc] initWithFrame:rect(0, upY+10, screen_width, 0.5)];
        line.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:line];
        
        self.height = upY +11;
        self.selectIndex = -1;
        

    }
    return self;
}



-(void)touchBtn:(UIButton*)btn{
    
    if (btn.selected == NO) {
        self.selectIndex = (int)btn.tag - 100;
        btn.backgroundColor = [UIColor redColor];
    }else{
        self.selectIndex = -1;
        btn.selected = NO;
        btn.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        btn.alpha = 1.0;
    }
    [self.delegate btnIndex:(int)btn.tag - 100];
}
@end
