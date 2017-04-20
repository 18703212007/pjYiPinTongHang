//
//  ListTableViewCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/2/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListModel.h"
@interface ListTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel *nameTab;

@property(nonatomic,strong)NSString *catsID;

-(void)setDataWithModel:(TableModel*)model;
@end
