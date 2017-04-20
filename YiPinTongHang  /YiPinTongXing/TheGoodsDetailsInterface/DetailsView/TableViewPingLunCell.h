//
//  TableViewPingLunCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/18.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"
@interface TableViewPingLunCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImg;
@property (weak, nonatomic) IBOutlet UILabel *lb_name;
@property (weak, nonatomic) IBOutlet UILabel *lb_date;
@property (weak, nonatomic) IBOutlet UILabel *lb_discuss;
@property (weak, nonatomic) IBOutlet UILabel *lb_size;
@property (weak, nonatomic) IBOutlet UIImageView *img_img1;
@property (weak, nonatomic) IBOutlet UIImageView *img_img2;
@property (weak, nonatomic) IBOutlet UIImageView *img_img3;
@property (weak, nonatomic) IBOutlet UIImageView *img_img4;
@property (weak, nonatomic) IBOutlet UIImageView *img_img5;
@property(nonatomic,strong) PingLunModel *model;
@property(nonatomic,assign)NSInteger  count;
-(void)setCellWithModel:(PingLunModel*)model WithCount:(NSInteger)count;
@end
