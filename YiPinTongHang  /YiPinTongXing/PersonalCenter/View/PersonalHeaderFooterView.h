//
//  PersonalHeaderFooterView.h
//  YiPinTongXing
//
//  Created by dhz on 2017/3/24.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PersonalHeaderFooterView;

@protocol PersonalHeaderViewDelegate <NSObject>
#pragma mark - 全部订单代理
-(void)OnderPersonalHeaderView:(PersonalHeaderFooterView*)view;

#pragma mark - 5中状态的代理
-(void)PersonalHeaderView:(PersonalHeaderFooterView*)view index:(NSInteger)index;

#pragma mark - 头像代理
-(void)HeaderImgPersonalHeaderView:(PersonalHeaderFooterView*)view;

#pragma mark - 设置按钮的代理
-(void)ExitsBtnPersonalHeaderView:(PersonalHeaderFooterView*)view btn:(UIButton*)btn;

#pragma mark - 消息按钮的代理
-(void)MessageBtnPersonalHeaderView:(PersonalHeaderFooterView*)view;



@end



@interface PersonalHeaderFooterView : UITableViewHeaderFooterView

@property(nonatomic,strong)UIImageView *img_header;

@property(nonatomic,strong)UIButton *btn_setUp;

@property(nonatomic,strong)UIButton *btn_message;

@property(nonatomic,assign)id<PersonalHeaderViewDelegate>delegate;

@end

@class CollectionTableHeaderView;

@protocol CollectionTableHeaderViewDelegate <NSObject>

-(void)CollectionTableHeaderView:(CollectionTableHeaderView*)view index:(NSInteger)index;

@end




@interface CollectionTableHeaderView : UITableViewHeaderFooterView
@property(nonatomic,assign)id<CollectionTableHeaderViewDelegate>delegate;

@end


@class CollectionCouponTableHeaderView;

@protocol CollectionCouponTableHeaderViewDelegate <NSObject>

-(void)CollectionCouponTableHeaderView:(CollectionCouponTableHeaderView*)view index:(NSInteger)index;

@end




@interface CollectionCouponTableHeaderView : UITableViewHeaderFooterView
@property(nonatomic,assign)id<CollectionCouponTableHeaderViewDelegate>delegate;

@end





@class OrderTableHeaderView;

@protocol OrderTableHeaderViewDelegate <NSObject>

-(void)OrderTableHeaderView:(OrderTableHeaderView*)view index:(NSInteger)index;

@end

@interface OrderTableHeaderView : UITableViewHeaderFooterView

@property(nonatomic,assign)id<OrderTableHeaderViewDelegate>delegate;

@property(nonatomic,assign)NSInteger index;


@end






