//
//  PJStarsEvaluationView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJStarsEvaluationView.h"

@interface PJStarsEvaluationView()
///前景View
@property(nonatomic,strong) UIView                *frontView;
///背景View
@property(nonatomic,strong) UIView                *backgroundView;
///星数
@property(nonatomic,assign) NSInteger              numberOfStarts;
///星级评价是否可操作
@property(nonatomic,getter=isVariable) BOOL        variable;

@end

@implementation PJStarsEvaluationView

-(instancetype)initWithFrame:(CGRect)frame numberOfStars:(NSInteger)numberOfStars isVariable:(BOOL)isVariable
{
    if (self = [super initWithFrame:frame]) {
        self.numberOfStarts = numberOfStars;
        [self loadView];
        if (isVariable ) {
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapClick:)];
            [self addGestureRecognizer:tap];
        }
    }
    return self;
}

-(void)tapClick:(UITapGestureRecognizer*)sender{
    
    CGPoint point = [sender locationInView:self];
    CGFloat offset = point.x;
    CGFloat offsetPercent = offset/self.bounds.size.width;
    if (self.isContrainsHalfStar != YES) {
        offsetPercent = [self changeToCompleteStar:offsetPercent];
    }
    self.actualScore = offsetPercent *self.fullScore;
    
    [self.delegate didChangeStar];
    
}


-(void)loadView{
    self.fullScore = 1;
    self.actualScore = 1;
    self.backgroundView = [self creatStarViewWithImage:@"star_gray.png"];
    self.frontView = [self creatStarViewWithImage:@"star_red.png"];
    [self addSubview:self.backgroundView];
    [self addSubview:self.frontView];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    if (self.actualScore >self.fullScore) {
        _actualScore = self.fullScore;
        
    }else if (self.actualScore < 0){
        _actualScore = 0;
 
    }else{
        _actualScore = self.actualScore;
    }
    CGFloat scorePercent = self.actualScore/self.fullScore;
    if (self.isContrainsHalfStar != YES) {
        scorePercent = [self changeToCompleteStar:scorePercent];
    }
    self.frontView.frame = rect(0, 0, self.bounds.size.width *scorePercent, self.bounds.size.height);

}




-(UIView *)creatStarViewWithImage:(NSString*)imageName{
    UIView *view = [[UIView alloc]initWithFrame:self.bounds];
    view.backgroundColor = [UIColor clearColor];
    view.clipsToBounds = YES;
    for (NSInteger i = 0; i< self.numberOfStarts; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:imageName]];
        imageView.frame = rect(i * self.bounds.size.width/self.numberOfStarts, 0, self.bounds.size.width/self.numberOfStarts, self.bounds.size.height);
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        [view addSubview:imageView];
    }
    return view;
    
    
}




-(CGFloat)changeToCompleteStar:(CGFloat)percent{
    
    if (percent <= 0.2) {
        percent = 0.2;
    }else if (percent > 0.2 && percent <= 0.4){
        percent = 0.4;
    }else if (percent > 0.4 && percent <= 0.6){
        percent = 0.6;
    }else if (percent > 0.6 && percent <= 0.8){
        percent = 0.8;
    }else{
        percent = 1.0;
    }
    return percent;
}


@end
