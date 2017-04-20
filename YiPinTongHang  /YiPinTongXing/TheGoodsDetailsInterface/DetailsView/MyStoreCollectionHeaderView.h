//
//  MyStoreCollectionHeaderView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyStoreCollectionHeaderView;

@protocol MyStoreHeaderViewDelegate <NSObject>

-(void)myStoreHeaderView:(MyStoreCollectionHeaderView*)view Index:(NSInteger)index Dictionary:(NSDictionary*)dic;

-(void)btnCollectionSelected:(BOOL)selected Btn:(UIButton*)btn myStoreHeaderView:(MyStoreCollectionHeaderView*)view;

-(void)CouponCollectWithCouID:(NSString*)couID myStoreHeaderView:(MyStoreCollectionHeaderView*)view;


@end

typedef void(^ReturnBlock)(NSDictionary *dic);


@interface MyStoreCollectionHeaderView : UICollectionReusableView


@property(nonatomic,strong)NSString *shopID;

@property(nonatomic,strong)NSDictionary *data;

@property(nonatomic,strong)NSArray *counponsArray;

@property(nonatomic,assign)CGFloat colHeight;

@property(nonatomic,assign)id<MyStoreHeaderViewDelegate>delegate;

@property(nonatomic,copy) ReturnBlock block;

-(void)returnDic:(ReturnBlock)block;

@end

@class StoreListHeaderView;
@protocol StoreListHeaderViewDelegate <NSObject>


/**
 商铺的Header的代理方法

 @param storeHeaderView delegate
 @param allID 全部ID
 @param title title
 */
-(void)storeHeaderView:(StoreListHeaderView *)storeHeaderView AllID:(NSDictionary*)allID :(NSString*)title;

@end


@interface StoreListHeaderView : UICollectionReusableView

@property(nonatomic,assign)id<StoreListHeaderViewDelegate> delegate;

@property(nonatomic,strong)UILabel *lb_name;

@property(nonatomic,strong)UILabel *lb_allgoods;

@property(nonatomic,strong)UIImageView *img_img;

@property(nonatomic,strong)NSString *shopID;

@property(nonatomic,strong)NSString *catsID;

@end

@interface StoreListFooterView : UICollectionReusableView



@end



@class StoreDetailsListHeaderView;
@protocol StoreDetailsListHeaderViewDelegate <NSObject>


/**
 商铺详情的代理方法

 @param storeHeaderView delegate本身
 @param flag 传递的参数
 */
-(void)storeListHeaderView:(StoreDetailsListHeaderView *)storeHeaderView :(NSDictionary*)flag ;

@end


@interface StoreDetailsListHeaderView : UICollectionReusableView

@property(nonatomic,assign)id<StoreDetailsListHeaderViewDelegate> delegate;

@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UICollectionView *btnCollectionView;

@property(nonatomic,strong)UIView *sortView;

@property(nonatomic,strong)UIButton *backBtn;

@property(nonatomic,strong)UILabel *lb_title;

@property(nonatomic,strong)NSString *catsID;

@property(nonatomic,strong)NSString *shopID;;

@end










