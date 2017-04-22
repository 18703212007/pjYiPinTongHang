//
//  PJCarTableViewCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJCarTableViewCell.h"
#import "PJNumberCount.h"
#import "PJCarModel.h"
@interface PJCarTableViewCell ()
/**
 *  划线
 */
@property (weak, nonatomic) IBOutlet UILabel *lb_lineWithOldPrice;

@end


@implementation PJCarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setModel:(PJCarModel *)model{
    
    self.lb_goodsName.text              = model.goodsName;
    self.lb_goodsPrice.text             = [NSString stringWithFormat:@"¥%.2f",model.shopPrice];
    self.lb_goodsOldPrice.text          = [NSString stringWithFormat:@"¥%.2f",model.marketPrice];
    if (model.marketPrice) {
        self.lb_lineWithOldPrice.hidden = NO;
    }else{
        self.lb_lineWithOldPrice.hidden = YES;
    }
    self.numberCount.totalNum           = model.goodsStock;
    self.numberCount.currentCountNumber = model.goodsCnt;
//    NSLog(@"%ld",self.numberCount.totalNum);
    self.SelectShopGoodsButton.selected = model.isSelect;
    [self.img_goodsImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.goodsImg]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
}

+ (CGFloat)getCartCellHeight{
    
    return 100;
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
