//
//  SKUChooseView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/4/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BuyCountView;

@interface SKUChooseView : UIView

///
@property(nonatomic,strong)UIView        *alphaView;
///
@property(nonatomic,strong)UIView        *whiteView;
///
@property(nonatomic,strong)UIButton      *bt_sure;
///
@property(nonatomic,strong)UIButton      *bt_cancle;

@property(nonatomic,strong)UIView *topView;

@property(nonatomic,strong)UIView *midView;

@property(nonatomic,strong)UIView *botView;
@property(nonatomic,strong)UIView *sureView;

@property (nonatomic,strong)UILabel *goodsName;
@property (nonatomic,strong)UILabel *goodsPrice;
@property (nonatomic,strong)UIImageView *goodsImage;
@property (nonatomic,strong)UILabel  *lb_detail;
@property (nonatomic,strong)UILabel  *lb_stock;
@property (nonatomic,strong)BuyCountView *countView;
@property(nonatomic,strong)NSDictionary *dictionary;



@property (nonatomic,strong)UICollectionView *collectionView;
@property (nonatomic ,copy)void(^CallBackWithCloseWindow)(NSString * type,NSString * goodsId);//!<回调关闭弹窗的block(type:0取消，1确定，2立即购买)
@property (nonatomic ,strong)NSMutableArray * dataSource;//!<数据源
@property (nonatomic ,copy)void(^CallBackWithSiftSelected)(NSDictionary * dic);//!<回调规格选择的block
@property (nonatomic ,strong)NSMutableArray * skuResult;//!<可匹配规格
@property (nonatomic ,strong)NSMutableArray * seletedIndexPaths;//!<已经选中的规格数组
@property (nonatomic ,strong)NSMutableArray * seletedIdArray;//!<记录已选id
@property (nonatomic ,strong)NSMutableArray * seletedEnable;//!<不可选indexPath
@property (nonatomic ,strong)NSMutableArray * noSelectedHead;//!<未选中的标题
@property (nonatomic ,strong)NSString * goodsId;//!<商品id
@property (nonatomic ,strong)NSString * goodsprice;//!<商品价格
@property (nonatomic ,strong)NSMutableArray * alertInfo;//!<提示信息
@property (nonatomic ,strong)NSString * currentTitle;//!<当前提示信息
@property (nonatomic ,strong)NSMutableArray * SKUResult;
@property(nonatomic,assign)int  stock;
@property(nonatomic,strong)NSString *detailsString;
@property(nonatomic,strong)NSString *skuID;












@end
