//
//  ListTableViewCell.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ListTableViewCell.h"

@interface ListTableViewCell()

@property(nonatomic,strong)UIView *redView;
@end

@implementation ListTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self layout];
    }
    return self;
}

-(void)layout{
    self.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.nameTab = [UILabel new];
    [self.contentView addSubview:self.nameTab];
    self.nameTab.font = [UIFont systemFontOfSize:17.0*(screen_width/375.0)];
    self.nameTab.highlightedTextColor = [UIColor colorWithHexString:@"#cf292e"];
    [self.nameTab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    self.redView = [UIView new];
    
//    self.redView.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];
//    [self.contentView addSubview:self.redView];
//    [self.redView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.mas_top).with.offset(5);
//        make.bottom.equalTo(self.mas_bottom).with.offset(-5);
//        make.left.equalTo(self.mas_left).with.offset(0.5);
//        make.width.mas_equalTo(@5);
//    }];
}

-(void)setDataWithModel:(TableModel*)model{
    self.nameTab.text = model.catsName;
    self.catsID = model.catsId;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    self.contentView.backgroundColor = selected?[UIColor whiteColor]:[UIColor colorWithWhite:0.9 alpha:0.8];
    self.highlighted = selected;
    self.nameTab.highlighted = selected;
    self.redView.hidden = !selected;
    
    
    
}

@end
