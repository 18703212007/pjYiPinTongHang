//
//  PJLookImgView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/16.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJLookImgView.h"

@interface PJLookImgView ()<UIScrollViewDelegate>


@property(nonatomic,assign)CGRect currentRect;

@property(nonatomic,strong)UIView *baseView;

@property(nonatomic,strong)UIScrollView  *scrollView;

@property(nonatomic,assign)NSInteger  currentIndex;

@property(nonatomic,strong)UILabel   *indexLabel;



@property(nonatomic,strong)UIImageView *leftImageView;

@property(nonatomic,strong)UIImageView *centerImageView;

@property(nonatomic,strong)UIImageView *rightImageView;


@end

@implementation PJLookImgView

-(void)willMoveToSuperview:(UIView *)newSuperview{
    
}

-(void)setupScrollView{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.frame = self.bounds;
    [self addSubview:scrollView];
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(screen_width * 3, screen_height);
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    [scrollView setContentOffset:CGPointMake(screen_width, 0) animated:NO];
    scrollView.delegate = self;
    // 给scrollView添加手势，点击scrollView，大图缩小
    UITapGestureRecognizer *scrollViewGest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDidClick)];
    [scrollView addGestureRecognizer:scrollViewGest];
    _scrollView = scrollView;
    
    // 设置初始图片
    UIImage *centerImage = nil;
    UIImage *leftImage = nil;
    UIImage *rightImage = nil;
    // 如果点击的是第一张
    if (self.index == 0) {
        centerImage = [UIImage imageNamed:_iconArray[0]];
        leftImage = [UIImage imageNamed:_iconArray[_iconArray.count - 1]];
        rightImage = [UIImage imageNamed:_iconArray[1]];
    } else if (self.index == _iconArray.count - 1) {   // 如果点击的是最后一张
        centerImage = [UIImage imageNamed:_iconArray[_iconArray.count - 1]];
        leftImage = [UIImage imageNamed:_iconArray[_iconArray.count - 2]];
        rightImage = [UIImage imageNamed:_iconArray[0]];
    } else {
        centerImage = [UIImage imageNamed:_iconArray[self.index]];
        leftImage = [UIImage imageNamed:_iconArray[self.index - 1]];
        rightImage = [UIImage imageNamed:_iconArray[self.index + 1]];
    }
    self.currentIndex = self.index;
    self.currentRect = CGRectFromString(self.rectArray[self.index]);
    self.indexLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.currentIndex+1, _iconArray.count];
    // 添加三个imageView，设置初始图片
    UIImageView *leftImageView = [[UIImageView alloc] init];
    CGFloat leftHeight = screen_width / leftImage.size.width * leftImage.size.height;
    leftImageView.frame = CGRectMake(0, (screen_height-leftHeight)*0.5, screen_width, leftHeight);
    leftImageView.image = leftImage;
    [scrollView addSubview:leftImageView];
    _leftImageView = leftImageView;
    
    UIImageView *centerImageView = [[UIImageView alloc] init];
    CGFloat centerHeight = screen_width / centerImage.size.width * centerImage.size.height;
    centerImageView.frame = CGRectMake(screen_width, (screen_height-centerHeight)*0.5, screen_width, centerHeight);
    centerImageView.image = centerImage;
    [scrollView addSubview:centerImageView];
    _centerImageView = centerImageView;
    
    UIImageView *rightImageView = [[UIImageView alloc] init];
    rightImageView.image = rightImage;
    CGFloat rightHeight = screen_width / rightImage.size.width * rightImage.size.height;
    rightImageView.frame = CGRectMake(screen_width*2, (screen_height-rightHeight)*0.5, screen_width, rightHeight);
    [scrollView addSubview:rightImageView];
    _rightImageView = rightImageView;
    
}

#pragma mark - 设置上边的图片下标指示器
- (void)setupIndicator {
    // 上边的图片序号指示器
    UILabel *indexLabel = [[UILabel alloc] init];
    [self addSubview:indexLabel];
    __weak typeof(self) weakSelf = self;
    [indexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(weakSelf.centerX);
        make.top.mas_equalTo(30);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    indexLabel.textColor = [UIColor whiteColor];
    indexLabel.textAlignment = NSTextAlignmentCenter;
    _indexLabel = indexLabel;
    indexLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.currentIndex+1, _iconArray.count];
}

// 刷新iamgeView中的图片。难点：计算左中右的下标
- (void)refreshImages{
    
    NSInteger leftImageIndex;
    NSInteger rightImageIndex;
    CGPoint offset = self.scrollView.contentOffset;
    // 向右滑动。这时候应该让currentIndex加1：即让currentIndex + 1的图片显示在屏幕上
    if (offset.x > screen_width) {
        self.currentIndex = (self.currentIndex + 1) % self.iconArray.count;
    }
    // 向左滑动。这时候应该让currentIndex减1：即让currentIndex - 1的图片显示在屏幕上
    else if (offset.x < screen_width) {
        self.currentIndex = (self.currentIndex + self.iconArray.count - 1) % self.iconArray.count;
    }
    
    leftImageIndex = (self.currentIndex + self.iconArray.count - 1) % self.iconArray.count;
    rightImageIndex = (self.currentIndex + 1) % self.iconArray.count;
    
    
    self.leftImageView.image = [UIImage imageNamed:self.iconArray[leftImageIndex]];
    self.centerImageView.image = [UIImage imageNamed:self.iconArray[self.currentIndex]];
    self.rightImageView.image = [UIImage imageNamed:self.iconArray[rightImageIndex]];
    
    CGFloat leftHeight = screen_width / self.leftImageView.image.size.width * self.leftImageView.image.size.height;
    CGFloat centerHeight = screen_width / self.centerImageView.image.size.width * self.centerImageView.image.size.height;
    CGFloat rightHeight = screen_width / self.rightImageView.image.size.width * self.rightImageView.image.size.height;
    self.leftImageView.frame = CGRectMake(0, (screen_height-leftHeight)*0.5, screen_width, leftHeight);
    self.centerImageView.frame = CGRectMake(screen_width, (screen_height-centerHeight)*0.5, screen_width, centerHeight);
    self.rightImageView.frame = CGRectMake(screen_width*2, (screen_height-rightHeight)*0.5, screen_width, rightHeight);
    
    _indexLabel.text = [NSString stringWithFormat:@"%zd/%zd", self.currentIndex+1, _iconArray.count];
    
    _currentRect = CGRectFromString(self.rectArray[self.currentIndex]);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    // 刷新imageView的图片
    [self refreshImages];
    // 把currentPageIndex立刻移到中间来
    [scrollView setContentOffset:CGPointMake(screen_width, 0) animated:NO];
}


// scrollView的手势的方法
- (void)scrollViewDidClick {
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:_centerImageView.image];
    CGFloat tempHeight = screen_width / _centerImageView.image.size.width * _centerImageView.image.size.height;
    tempImageView.frame = CGRectMake(0, (screen_height-tempHeight)*0.5, screen_width, tempHeight);
    [self addSubview:tempImageView];
    [self.scrollView removeFromSuperview];
    [self.indexLabel removeFromSuperview];
    
    CGFloat width = _currentRect.size.width;
    if (width <= 0) {  // 如果cell没出现在界面中,即_currentRect = {0,0,0,0}；
        if (self.currentIndex > self.index) {  // 说明往左滑动的，currentCell应该在屏幕下方
            //            // 第一列:如果是第一列，且在屏幕上方，则图片往左上角方向消失。
            //            if (self.currecntIndex % 4 == 0) {
            //                _currentRect = CGRectMake(0, DYScreenH, 0, 0);
            //            }
            //            // 第二列：如果是第二列，且在屏幕上方，则图片往左上角偏重的地方消失
            //            if (self.currecntIndex % 4 == 1) {
            //                _currentRect = CGRectMake(DYScreenW * 0.25, DYScreenH, 0, 0);
            //            }
            //            // 第三列
            //            if (self.currecntIndex % 4 == 2) {
            //                _currentRect = CGRectMake(DYScreenW * 0.5, DYScreenH, 0, 0);
            //            }
            //            // 第四列
            //            if (self.currecntIndex % 4 == 3) {
            //                _currentRect = CGRectMake(DYScreenW * 0.75, DYScreenH, 0, 0);
            //            }
            _currentRect = CGRectMake(screen_width * (self.currentIndex % 4) / 4, screen_height, 0, 0);
        } else if (self.currentIndex < self.index) { // 说明往右滑动的，currentCell应该在屏幕上方
            _currentRect = CGRectMake(screen_width * (self.currentIndex % 4) / 4, 0, 0, 0);
        }
    }
    [UIView animateWithDuration:1 animations:^{
        self.frame = _currentRect;
        tempImageView.frame = self.bounds;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


@end
