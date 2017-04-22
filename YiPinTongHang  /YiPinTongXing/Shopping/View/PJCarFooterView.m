//
//  PJCarFooterView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJCarFooterView.h"
#import "PJCarModel.h"
@interface PJCarFooterView ()

@property (nonatomic, retain) UILabel *priceLabel;

@end

@implementation PJCarFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        [self initCartFooterView];
    }
    return self;
}

- (void)initCartFooterView{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    _priceLabel = [[UILabel alloc] init];
    _priceLabel.textAlignment = NSTextAlignmentRight;
    _priceLabel.text = @"小记:￥15.80";
    _priceLabel.textColor = [UIColor redColor];
    
    [self addSubview:_priceLabel];
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    _priceLabel.frame = CGRectMake(10, 0.5, screen_width-20, 30);
    
}

- (void)setShopGoodsArray:(NSMutableArray *)shopGoodsArray{
    
    _shopGoodsArray = shopGoodsArray;
    
    NSArray *pricesArray = [[[_shopGoodsArray rac_sequence] map:^id(PJCarModel *model) {
        
        return @(model.goodsCnt *model.shopPrice);
        
    }] array];
    
    float shopPrice = 0;
    for (NSNumber *prices in pricesArray) {
        shopPrice += prices.floatValue;
    }
    _priceLabel.text = [NSString stringWithFormat:@"小记:￥%.2f",shopPrice];
}


+ (CGFloat)getCartFooterHeight{
    
    return 30;
}

@end
