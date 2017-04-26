//
//  PJCarUIService.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/21.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PJCarUIService.h"
#import "PJCarViewModel.h"
#import "PJCarTableViewCell.h"
#import "PJCarHeaderView.h"
#import "PJCarFooterView.h"
#import "PJCarModel.h"
#import "PJNumberCount.h"
#import "MyStoreViewController.h"

@interface PJCarUIService ()

@property(nonatomic,strong)PJCarHeaderView *headerView;
@end

@implementation PJCarUIService

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}


#pragma mark - UITableView Delegate/DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   

    return self.viewModel.cartData.count;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self.viewModel.cartData[section] count];
}

#pragma mark - header view

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return [PJCarHeaderView getCartHeaderHeight];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//     _array = @[@"1蓝色",@"2白色",@"黑3色",@"4天蓝色",@"5藏青色",@"6卡其色",@"蓝7色",@"白8色",@"9黑色",@"天10蓝色",@"11藏青色",@"12卡其色",@"蓝13色",@"白14色",@"黑15色",@"16天蓝色",@"17藏青色",@"18卡其色",@"19蓝色",@"20白色"];
    NSMutableArray *shopArray = self.viewModel.cartData[section];
    /**
     *  店铺名字 以及店铺ID
     */
    self.headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PJCarHeaderView"];

        [_headerView.storeNameButton setTitle:[NSString stringWithFormat:@"%@",self.viewModel.shopsNameData[section]]forState:UIControlStateNormal];
    
    
    
[[[_headerView.storeNameButton rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:_headerView.rac_prepareForReuseSignal] subscribeNext:^(id x) {
    x = self.viewModel.shopsIDData[section];
    _headerView.shopID = x;
    /**
     *  点击跳转店铺的地方
     */
    NSLog(@"%@",_headerView.shopID);
}];
    //店铺全选
    [[[_headerView.selectStoreGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside]takeUntil:_headerView.rac_prepareForReuseSignal] subscribeNext:^(UIButton *xx) {
        xx.selected = !xx.selected;
        BOOL isSelect = xx.selected;
        [self.viewModel.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelect)];
        for (PJCarModel *model in shopArray) {
            [model setValue:@(isSelect) forKey:@"isSelect"];
#warning warning!!!!!
            /**
             *  店铺全选在此处
             */
            NSLog(@"%@",model);
        }
        [self.viewModel.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
        
        self.viewModel.allPrices = [self.viewModel getAllPrices];
    }];
    //店铺选中状态
    _headerView.selectStoreGoodsButton.selected = [self.viewModel.shopSelectArray[section] boolValue];
    
//        [RACObserve(headerView.selectStoreGoodsButton, selected) subscribeNext:^(NSNumber *x) {
//    
//            BOOL isSelect = x.boolValue;
//    
//            [self.viewModel.shopSelectArray replaceObjectAtIndex:section withObject:@(isSelect)];
//            for (PJCarModel *model in shopArray) {
//                [model setValue:@(isSelect) forKey:@"isSelect"];
//            }
//            [self.viewModel.cartTableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationNone];
//        }];
    
    return _headerView;
}

#pragma mark - footer view

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return [PJCarFooterView getCartFooterHeight];
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    NSMutableArray *shopArray = self.viewModel.cartData[section];
    
    PJCarFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"PJCarFooterView"];
    
    footerView.shopGoodsArray = shopArray;
    
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [PJCarTableViewCell getCartCellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PJCarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PJCarTableViewCell"
                                                       forIndexPath:indexPath];
    
    [self configureCell:cell forRowAtIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(PJCarTableViewCell *)cell
    forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    NSInteger row = indexPath.row;
    
    PJCarModel *model = self.viewModel.cartData[section][row];
    /**
     *  cell 选中
     */
    WEAK
    [[[cell.SelectShopGoodsButton rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:cell.rac_prepareForReuseSignal] subscribeNext:^(UIButton *x) {
        STRONG
        x.selected = !x.selected;
        [self.viewModel rowSelect:x.selected IndexPath:indexPath];
        
    }];
    //数量改变
    cell.numberCount.NumberChangeBlock = ^(NSInteger changeCount){
        STRONG
        [self.viewModel rowChangeQuantity:changeCount indexPath:indexPath];
    };
    cell.model = model;
    
}

#pragma mark - delete
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return @"删除";
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.viewModel deleteGoodsBySingleSlide:indexPath];
    }
}
#warning 写代理方法
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PJCarTableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@,%ld,%@",cell.goodsId,(long)cell.numberCount.totalNum,cell.lb_goodsAttr);
    
}
#warning 写代理方法



@end

