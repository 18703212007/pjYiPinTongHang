//
//  GoodsDetailsTableViewCell.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoodsDetailsModel.h"
#import "PJStarsEvaluationView.h"
@interface GoodsDetailsTableViewCell : UITableViewCell

@end


@interface FristCell  : UITableViewCell
///是否有促销活动 默认NO
@property(nonatomic,getter=isActitity) BOOL actitity;
///是否有原价 默认NO
@property(nonatomic,getter=isHaveOldPrice) BOOL haveOldPrice;
///分享按钮
@property(nonatomic,strong)UIButton     *bt_share;
///产品名称
@property(nonatomic,strong)UILabel      *lb_title;
///实际价格
@property(nonatomic,strong)UILabel      *lb_price;
///原价
@property(nonatomic,strong)UILabel      *lb_oldPrice;
///促销活动的文字说明
@property(nonatomic,strong)UILabel      *lb_actitity;
///销量
@property(nonatomic,strong)UILabel      *lb_sales;
///快递
@property(nonatomic,strong)UILabel      *lb_expressDelivery;
///地址
@property(nonatomic,strong)UILabel      *lb_address;


-(void)setCellDataWithModel:(GoodsDetailsModel*)model;

@end

@interface SecondCell : UITableViewCell
///小图
@property(nonatomic,strong)UIImageView  *img_img;
///text文字
@property(nonatomic,strong)UILabel      *lb_text;

@end

@interface ThirdCell : UITableViewCell
///单纯的文字
@property(nonatomic,strong)UILabel      *lb_text;

-(void)addLeftText;
-(void)addCenterText;
-(void)addCenterAddText;

@end
@class FourthPingLunCell;
@protocol  FourthPingLunCelldelegate <NSObject>

-(void)fourthCell:(FourthPingLunCell*)cell Withimg:(UIImageView*)img;

@end


@interface FourthPingLunCell : UITableViewCell
///用户头像
@property(nonatomic,strong)UIImageView  *img_imgHeader;
///用户昵称
@property(nonatomic,strong)UILabel      *lb_nickName;
///评价的时间
@property(nonatomic,strong)UILabel      *lb_date;
///评价内容
@property(nonatomic,strong)UILabel      *lb_contentText;
///尺寸 参数
@property(nonatomic,strong)UILabel      *lb_attName;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)PingLunModel *model;

@property(nonatomic,assign)id<FourthPingLunCelldelegate>delegate;

//-(void)addNoImgStyleCell;
-(void)setCellWithModel:(PingLunModel*)model;
-(void)addNOPinlunCell;




@end

@class FifthCell;

@protocol FifthCellDelegate <NSObject>


-(void)goToShop:(FifthCell*)cell;
@end


@interface FifthCell  : UITableViewCell
///店铺ID
@property(nonatomic,strong)NSString               *stringID;
///店铺名称
@property(nonatomic,strong)UILabel                *lb_shopname;
///店铺的Logo
@property(nonatomic,strong)UIImageView            *img_shopLogo;
///店铺星级评分(星星✨)
@property(nonatomic,strong)PJStarsEvaluationView  *pj_stars;
///店铺商品评分
@property(nonatomic,strong)UILabel                *lb_shangpin;
///店铺服务评分
@property(nonatomic,strong)UILabel                *lb_fuwu;
///店铺质量评分
@property(nonatomic,strong)UILabel                *lb_zhiliang;
///进入店铺按钮
@property(nonatomic,strong)UIButton               *bt_goShop;
///全部商品按钮
@property(nonatomic,strong)UIButton               *bt_allGoods;

@property(nonatomic,assign)id<FifthCellDelegate>   delegate;

-(void)setCellDataWithModel:(GoodsDetailsModel*)model;


@end

@interface ShopsCell : UITableViewCell
///
@property(nonatomic,strong)UIImageView *img_shopLogo;
///
@property(nonatomic,strong)UIImageView *img_bgImg;
///
@property(nonatomic,strong)UILabel     *lb_shopName;
///
@property(nonatomic,strong)UILabel     *lb_favorites;
///
//@property(nonatomic,strong)UIImageView *img_imgLittle;
///
@property(nonatomic,strong)UIButton    *btn_collection;

@end


