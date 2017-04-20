//
//  TableViewPingLunCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/18.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "TableViewPingLunCell.h"

@implementation TableViewPingLunCell




-(void)setCellWithModel:(PingLunModel*)model WithCount:(NSInteger)count{
    _count = count;
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.uLogo]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    self.lb_name.text = model.uName;
    self.lb_date.text = model.pubtime;
    self.lb_discuss.text = model.description1;
    self.lb_size.text = model.attrName;
    
    switch (count) {
        case 0:{
            self.img_img1.hidden = YES;
            self.img_img2.hidden = YES;
            self.img_img3.hidden = YES;
            self.img_img4.hidden = YES;
            self.img_img5.hidden = YES;
            break;
        }case 1:{
            [self.img_img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[0]]]];
            self.img_img2.hidden = YES;
            self.img_img3.hidden = YES;
            self.img_img4.hidden = YES;
            self.img_img5.hidden = YES;
            
            break;
        }case 2:{
            [self.img_img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[0]]]];
            [self.img_img2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[1]]]];
            self.img_img3.hidden = YES;
            self.img_img4.hidden = YES;
            self.img_img5.hidden = YES;
            break;
        }case 3:{
            [self.img_img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[0]]]];
            [self.img_img2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[1]]]];
            [self.img_img3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[2]]]];
            self.img_img4.hidden = YES;
            self.img_img5.hidden = YES;
            break;
        }case 4:{
            [self.img_img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[0]]]];
            [self.img_img2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[1]]]];
            [self.img_img3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[2]]]];
            [self.img_img4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[3]]]];
            self.img_img5.hidden = YES;
            break;
        }case 5:{
            
            [self.img_img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[0]]]];
            [self.img_img2 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[1]]]];
            [self.img_img3 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[2]]]];
            [self.img_img4 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[3]]]];
            [self.img_img5 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[4]]]];
            break;
        }
        default:
            break;
    }
    
    
    
//        [self.img_img1 sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,model.picarr[0]]] placeholderImage:[UIImage imageNamed:@""]];
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
