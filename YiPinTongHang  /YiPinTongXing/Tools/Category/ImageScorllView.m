//
//  ImageScorllView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ImageScorllView.h"


@interface ImageScorllView()<UIScrollViewDelegate>

@end

@implementation ImageScorllView


-(instancetype)initWithFrame:(CGRect)frame ImageArray:(NSArray *)imageArr
{
    self = [super initWithFrame:frame];
    if (self) {
        self.scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        self.scrollView.contentSize = CGSizeMake(self.width*imageArr.count, self.height);
        self.scrollView.delegate = self;
        self.scrollView.showsHorizontalScrollIndicator =NO;
        self.scrollView.pagingEnabled = YES;
        
        for (NSInteger i = 0; i< imageArr.count; i++) {
            UIImageView *img = [UIImageView new];
            img.image = [UIImage imageNamed:[imageArr objectAtIndex:i]];
            img.frame = rect(i*self.width, 0, self.width, self.height);
            [self.scrollView addSubview:img];
        }
        
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectZero];
        self.pageControl.numberOfPages = imageArr.count;
        self.pageControl.currentPage = 0;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"gray" ofType:@"png"];
        self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:path]];
        path = [[NSBundle mainBundle] pathForResource:@"white" ofType:@"png"];
        self.pageControl.pageIndicatorTintColor = [UIColor colorWithPatternImage:[UIImage imageWithContentsOfFile:path]];
        [self addSubview:self.pageControl];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_bottom).with.offset(-10);
            make.width.mas_equalTo(@150);
            make.height.mas_equalTo(@10);
        }];
        
        
    }
    return self;
}



-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat offSetX = scrollView.contentOffset.x;
    CGFloat width = scrollView.width;
    CGFloat index = offSetX/width;
    self.pageControl.currentPage = index;
    
    
    
    
}


@end
