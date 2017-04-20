//
//  ImageWebView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ImageWebView.h"

@interface ImageWebView()<UIWebViewDelegate>


@end

@implementation ImageWebView

-(instancetype)initWithFrame:(CGRect)frame WebArr:(NSArray *)webArr{
    if (self = [super initWithFrame:frame]) {
        
        NSArray *titleArray = @[@"图文详情",@"产品参数",@"店铺推荐"];
        
        for (NSInteger i = 0; i< titleArray.count; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.frame = rect(i*self.width/3.0, 0, self.width/3.0, 50);
            btn.backgroundColor = [UIColor whiteColor];
            btn.tag = 10+i;
            [btn setTitle:titleArray[i] forState:UIControlStateNormal];
            [btn addTarget:self action:@selector(chooseBtn:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
            [self addSubview:btn];
            
            if (i == 0) {
                btn.selected = YES;
                UILabel *line = [UILabel new];
                line.frame = rect(0, 50, self.width/3.0, 1);
                line.tag = 15;
                line.backgroundColor = [UIColor redColor];
                [self addSubview:line];
            }else{
                btn.selected  = NO;
                
            }
        }
        
        
        self.webView = [[UIWebView alloc]initWithFrame:rect(0, 51, self.width, self.height-51)];
        [self addSubview:self.webView];
        
        self.webArray = webArr;
        self.webView.delegate = self;
        self.webView.scalesPageToFit = YES;
        self.webView.dataDetectorTypes = UIDataDetectorTypeAll;
        NSURL *url = [NSURL URLWithString:[webArr objectAtIndex:0]];
        
        NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
        
        [self.webView loadRequest:request];
        
        
    }
    return self;
}





-(void)chooseBtn:(UIButton*)sender{
    
    _selecttIndex = sender.tag - 10;
    
    sender.selected = YES;
    NSURL *url = [NSURL URLWithString:[self.webArray objectAtIndex:_selecttIndex]];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    for (NSInteger i = 0; i< 3; i++) {
        UIButton *btn = (UIButton*)[self viewWithTag:10+i];
        if (i == _selecttIndex) {
            btn.selected = YES;
            UILabel *label = (UILabel*)[self viewWithTag:15];
            CGRect frame = label.frame;
            frame.origin.x = btn.frame.origin.x;
            [UIView animateWithDuration:0.15 animations:^{
                label.frame = rect(self.width/3.0*_selecttIndex, 50, self.width/3.0, 1);
            } completion:nil];
        }else{
            btn.selected = NO;
        }
        
    }
    
}


#pragma mark - webViewDelegate -
///将要加载完成
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
///加载失败
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}



@end
