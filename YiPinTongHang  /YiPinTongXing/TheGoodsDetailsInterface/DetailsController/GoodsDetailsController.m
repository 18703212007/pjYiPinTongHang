
//  GoodsDetailsController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/10.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "GoodsDetailsController.h"
#import "GoodsDetailsHeaderView.h"
#import "GoodsDetailsModel.h"
#import "GoodsDetailsTableViewCell.h"
#import "BottomView.h"
#import "HomeCollectionViewCell.h"
#import "DiscussViewController.h"
#import "ChooseView.h"
#import "SKUChooseView.h"
#import "MyStoreViewController.h"
#import "StoreListViewController.h"
#import "StoreCouponView.h"
#import "PersonalCouponModel.h"
#import "BuyCountView.h"
@interface GoodsDetailsController ()<SDCycleScrollViewDelegate,UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FourthPingLunCelldelegate,FifthCellDelegate,StoreConponViewDelegate>


{
    //    NSArray          *_imgArr;  //图片数组
    //    NSArray          *_sizeArray;//型号
    //    NSArray          *_colorArray;//颜色
    //    NSDictionary     *_stockDic;//商品库存数量
    //    int              goodsStock;//库存
    NSMutableArray   *_btnArray;///盛放用(WebBtn)的数组
    
    
}

///型号数组
@property(nonatomic,strong)NSArray *sizeArray;
///颜色数组
@property(nonatomic,strong)NSArray *colorArray;
///商品库存数量
@property(nonatomic,strong)NSDictionary *stockDic;
///店铺的ID
@property(nonatomic,strong)NSString *shopID;




///导航View
@property(nonatomic,strong)UIView      *navView;
///tableView
@property(nonatomic,strong)UITableView *tableView;




///轮播图用到的View
@property(nonatomic,strong)UIView      *headView;
///轮播图用到的ScrollView
@property(nonatomic,strong)UIScrollView *scrollView;
///轮播图
@property(nonatomic,strong)SDCycleScrollView *sdCycleScro;
///轮播图的数组
@property(nonatomic,strong)NSArray *imgArray;


///存放数据的模型
@property(nonatomic,strong)GoodsDetailsModel *model;
///2条评论的数组
@property(nonatomic,strong)NSArray           *pinglunArray;
/**
 *  评论的数据模型
 */
@property(nonatomic,strong)PingLunModel *pingLunmodel;


///WebView的字段所用字典
@property(nonatomic,strong)NSDictionary *dic;
///(图文详情   参数)Btn
@property(nonatomic,strong)NSArray *BtnArray;
///包含WebView和2个Btn的View
@property(nonatomic,strong)UIView *ContentBottomView;
///图文详情的Btn
@property(nonatomic,strong)UIButton  *bt_detailsImgae_text;
///参数Btn
@property(nonatomic,strong)UIButton  *bt_detailParameter;
///WebView详情
@property(nonatomic,strong)UIWebView   *detailWebView;
///底部的View
@property(nonatomic,strong)UIView *bottomView;
///底部的View(包含客服 店铺 收藏 购物车,立即购买)
@property(nonatomic,strong)BottomView *bottom;
///盛放评论上图片的collectionView
@property(nonatomic,strong)UICollectionView *collectionView;
///

///SKU库存管理
@property(nonatomic,strong)SKUChooseView *skuChooseView;

@property(nonatomic,strong)ChooseView *chooseView;

@property(nonatomic,getter=isSKU) BOOL  SKU;
/**
 *  店铺优惠券
 */
@property(nonatomic,strong)StoreCouponView  *couponView;

@property(nonatomic,strong)NSArray         *couponArray;







@end

@implementation GoodsDetailsController


-(NSString *)shopID{
    if (_shopID == nil) {
        _shopID = _model.sId;
    }
    return _shopID;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    

    self.BtnArray = @[@"图文详情",@"产品参数"];
    self.SKU = NO;
    [self checkLog];
    self.dic = @{
                 @"goodsid":
                   self.goodsID,
                 @"uid":UserID
                 };
    
    [self getData];
    
    [self CostomNav];

    
}

/**
 登录检测
 */
-(void)checkLog{
    
    if (!LoginStatus) {
        [k_defaults setObject:@"" forKey:k_UserID];
        [k_defaults setBool:NO forKey:k_LoginStatus];
        [k_defaults synchronize];
        
    }else{
    }
    
}


/**
 *  设置tableView
 *
 *  @return 
 */

#pragma mark - 设置TableView -
-(void)setTabView{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
        
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[FristCell class] forCellReuseIdentifier:@"FristCell"];
    [self.tableView registerClass:[SecondCell class] forCellReuseIdentifier:@"SecondCell"];
    [self.tableView registerClass:[ThirdCell class] forCellReuseIdentifier:@"ThirdCell"];
    [self.tableView registerClass:[FourthPingLunCell class] forCellReuseIdentifier:@"FourthPingLunCell"];
    [self.tableView registerClass:[FifthCell class] forCellReuseIdentifier:@"FifthCell"];
    ///header
    [self.tableView registerClass:[GoodsDetailsHeaderView class] forHeaderFooterViewReuseIdentifier:@"GoodsDetailsHeaderView"];
    ///footer
    [self.tableView registerClass:[GoodsDetailsFooterView class] forHeaderFooterViewReuseIdentifier:@"GoodsDetailsFooterView"];
    
    [self setBottomView];
    [self setWebView];
    
}
#pragma mark - 设置底部按钮的View -

/**
 底部的View
 */
-(void)setBottomView{
    
    self.bottomView = [UIView new];
    self.bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(@50);
    }];
    self.bottom = [BottomView new];
    [self.bottomView addSubview:self.bottom];
    [self.bottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    if ([self.model.isFavorites isEqualToString:@"1"]) {
        
        self.bottom.btn_collection.selected = YES;
    }else{
        self.bottom.btn_collection.selected = NO;

    }
    
    
    [self.bottom.btn_shop addTarget:self action:@selector(btn_shop:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom.btn_service addTarget:self action:@selector(btn_service:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottom.btn_collection addTarget:self action:@selector(btn_collection:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.bottom.btn_buyNow addTarget:self action:@selector(btn_buyNow:) forControlEvents:UIControlEventTouchUpInside];
    [self.bottom.btn_addBasket addTarget:self action:@selector(btn_addBasket:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    
}
#pragma mark - 设置webView -

/**
 webView
 */
-(void)setWebView{
    
    self.ContentBottomView  = [UIView new];
    [self.view addSubview:self.ContentBottomView];
    [self.ContentBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView.mas_bottom).with.offset(74);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(screen_height-74);
    }];
    
    
    /*****************************     *******************************/
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.tag = 20170315;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self.collectionView registerClass:[BtnCollectionViewCell class] forCellWithReuseIdentifier:@"btnImg_text"];
    [self.ContentBottomView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ContentBottomView.mas_top).with.offset(0);
        make.left.equalTo(self.ContentBottomView.mas_left).with.offset(0);
        make.right.equalTo(self.ContentBottomView.mas_right).with.offset(0);
        make.height.mas_equalTo(50);
        
    }];
    
    
    self.detailWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
    [self.ContentBottomView addSubview:self.detailWebView];
    [self.detailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(50, 0, 0, 0));
        
    }];
    self.detailWebView.delegate = self;
    self.detailWebView.scalesPageToFit = YES;
    self.detailWebView.scrollView.delegate = self;
    self.detailWebView.dataDetectorTypes = UIDataDetectorTypeAll;
    [self LoadDetailsImgae_text];
    
    
    
}

#pragma mark - 设置轮播图 -

/**
 顶部轮播图
 */
-(void)setTopScro{
    
    self.headView = [UIView new];
    [self.view addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(screen_width);
    }];
    self.scrollView = [UIScrollView new];
    self.scrollView.contentSize = self.headView.size;
    [self.headView addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    
    self.sdCycleScro = [SDCycleScrollView cycleScrollViewWithFrame:rect(0, 0, 0, 0) delegate:self placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    
    
    self.sdCycleScro.delegate = self;
    self.sdCycleScro.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.sdCycleScro.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    self.sdCycleScro.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.sdCycleScro.imageURLStringsGroup = self.imgArray;
    self.sdCycleScro.currentPageDotColor = [UIColor whiteColor];
//    self.sdCycleScro.autoScroll = NO;
//    self.sdCycleScro.autoScrollTimeInterval = 3.0;
    [self.scrollView addSubview:self.sdCycleScro];
    [self.sdCycleScro mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.headView);
    }];
    
}
#pragma mark - sections的个数 -

/**
 section的个数

 @param tableView tableview
 @return section的个数
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return 8;
    return 7;
}
#pragma mark - 每个section的Row的个数 -

/**
 每个section的Row的个数

 @param   tableView tableview
 @param   section section
 @return  每个section的Row的个数
 */
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:{
            return 1;
            break;
        }case 1:{
            return 1;
            break;
        }
            
//        case 2:{
//            return 1;
//            break;
//          }
    
        case 2:{
            return 1;
            break;
        }case 3:{//评论条数
            if (self.pinglunArray.count == 0||self.pinglunArray.count == 1) {
                return 1;
            }else{
                return 2;
            }
            break;
        }case 4:{
            return 1;
            break;
        }case 5:{
            return 1;
            break;
        }case 6:{
            return 1;
            break;
        }
            
        default:
            return 1;
            break;
    }
    
}
/**
 *  tableView的必要方法
 *
 *  @param UITableViewCell 返回的Cell以及Cell类型的设计
 *
 *  @return cell
 */
#pragma mark - tabkeViewCell -
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    switch (indexPath.section) {
        case 0:{
            FristCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FristCell"];
            if (!cell) {
                cell = [[FristCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FristCell"];
            }
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.bt_share addTarget:self action:@selector(bt_share:) forControlEvents:UIControlEventTouchUpInside];
            [cell setCellDataWithModel:self.model];
            return cell;
            break;
        }case 1:{
            SecondCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SecondCell"];
            if (!cell) {
                cell = [[SecondCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SecondCell"];
            }
            
            return cell;
            
            break;
        }
 /*
        case 2:{
#pragma mark - 商品属性选择的Cell -
            ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdCell"];
            if (!cell) {
                cell = [[ThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdCell"];
  
            }
            [cell addLeftText];
            if (!_SKU) {
               cell.lb_text.text = @"请选择商品属性";
            }
            
            cell.tag = 100100;
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            return cell;
            break;
        }
*/
        case 2:{
#pragma mark - 总评论的条数 -
            ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
            if (!cell) {
                cell = [[ThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            }
            [cell addLeftText];
            NSString *str = [self.model.goodsAppraisesNum objectForKey:@"num"];
            tableView.separatorStyle = UITableViewCellAccessoryNone;
            cell.lb_text.text = [NSString stringWithFormat:@"评论(%@)",str];
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
            return cell;
            break;
        }case 3:{
#pragma mark - 2条评论的Cell -
            FourthPingLunCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FourthPingLunCell"];
            if (!cell) {
                cell = [[FourthPingLunCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FourthPingLunCell"];
                
            }
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            
            if (self.pinglunArray.count == 0) {
                [cell addNOPinlunCell];
            }else{
                self.pingLunmodel = self.pinglunArray[indexPath.row];
                cell.model = self.pingLunmodel;
                cell.delegate = self;
                
                if (self.pingLunmodel.picarr.count != 0) {
                    cell.collectionView.hidden = NO;
                }else{
                    cell.collectionView.hidden = YES;
                }
                
                [cell setCellWithModel:self.pingLunmodel];
                [cell.collectionView reloadData];
                
            }
            
            return cell;
            
            break;
        }case 4:{
#pragma mark - 全部评论的Cell -
            ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirdPinglunCell"];
            if (!cell) {
                cell = [[ThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirdPinglunCell"];
            }
            
            cell.tag = 20170318;
            [cell addCenterText];
            return cell;
            break;
        }case 5:{
#pragma mark - 店铺的Cell -
            FifthCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FifthCell"];
            if (!cell) {
                cell = [[FifthCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FifthCell"];
            }
            cell.delegate = self;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell.bt_goShop addTarget:self action:@selector(btn_shop:) forControlEvents:UIControlEventTouchUpInside];
            [cell.bt_allGoods addTarget:self action:@selector(bt_allGoods:) forControlEvents:UIControlEventTouchUpInside];
            [cell setCellDataWithModel:self.model];
            
            return cell;
            break;
        }case 6:{
#pragma mark - 上拉加载详情的cell -
            ThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThirCenterAddCell"];
            if (!cell) {
                cell = [[ThirdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThirCenterAddCell"];
            }
            cell.selectionStyle =UITableViewCellSelectionStyleNone;
            [cell addCenterAddText];
            return cell;
            break;
        }
        default:
            
            
            return [[UITableViewCell alloc] init];
            
            
            break;
    }
    
    
    
}
/**
 *  tableView的自定义HeaderView的设置方法
 *
 *  @param UIView 队员的HeaderView
 *
 *  @return 返回每个对应的HeaderView
 */
#pragma mark - headerView -
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    switch (section) {
        case 0:{
            GoodsDetailsHeaderView *headerView = [[GoodsDetailsHeaderView alloc]init];
            //            headerView.delegate = self;
            headerView.imgArray = self.imgArray;
            self.tableView.tableHeaderView = headerView;
            
            return headerView;
            
            break;
        }case 1:{
            
            break;
        }case 2:{
//            UIView *view = [[UIView alloc]initWithFrame:rect(0, 0, screen_width, 10)];
//            return view;
            break;
        }case 3:{
            UIView *view = [[UIView alloc]initWithFrame:rect(0, 0, screen_width, 10)];
            return view;
            break;
        }case 4:{
            
            break;
        }case 5:{
            
            break;
        }case 6:{
            UIView *view = [[UIView alloc]initWithFrame:rect(0, 0, screen_width, 10)];
            return view;
            break;
        }case 7:{
            //            UIView *view = [[UIView alloc]initWithFrame:rect(0, 0, screen_width, 10)];
            //            return view;
            break;
        }
        default:
            break;
    }
    
    
    return nil;
}
/**
 *  tableView的Cell的高度设置
 *
 *  @param CGFloat 每个cell的高度
 *
 *  @return CGFoat
 */
#pragma mark -RowHeight -
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    /***     */
    screen_width + 135+ 40 + 40 + 30 + 320;
    switch (indexPath.section) {
        case 0:{
            return 135;
            break;
        }case 1:{
            return 40;
            break;
        }
        
//        case 2:{
//            return 40;
//            break;
//        }
        
        case 2:{
            return 30;
            break;
        }case 3:{//评论的高度
            if (self.pinglunArray.count == 0) {
                return 40;
            }else{
                if (self.pingLunmodel.picarr) {
                    return 160;
                }else{
                    return 110;
                }
            }
            break;
        }case 4:{// 全部评论
            
            return 40;
            break;
        }case 5:{ //店铺
            
            return 175;
            break;
        }
        case 6:{//-- --
            
            return 50;
            break;
        }
            
        default:
            return 150;
            break;
    }
    
    
}

/**
 *  tableView的headerView的高度设置
 *
 *  @param CGFloat 返回headerView的高度
 *
 *  @return CGFloat
 */

#pragma mark -headerHeight -

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:{//轮播图
            return screen_width;
            break;
        }case 1:{
            return 0.5;
            break;
        }
//        case 2:{
//            return 0;
//            break;
//        }
        case 2:{
            return 10;
            break;
        }case 3:{
            return 0;
            break;
        }case 4:{
            return 0;
            break;
        }case 5:{
            return 10;
            break;
        }case 6:{
            return 0;
            break;
        }
        default:
            return 0;
            break;
    }
    
}
/**
 *  tableView的点击事件
 *
 *  @return
 */
#pragma mark - 点击TableView的事件 -
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //    [self alertWithMassage:[NSString stringWithFormat:@"%ld-%ld",indexPath.section,indexPath.row]];
    
    switch (indexPath.section) {
        case 0:{
            switch (indexPath.row) {
                case 0:{// 0-0
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }case 1:{
#pragma mark - 优惠券 -
            switch (indexPath.row) {
                case 0:{// 1-0 优惠券
                    [self couponAlert];
                    break;
                }
                default:
                    break;
            }
            break;
        }
//        case 2:{
//#pragma mark - 商品属性 -
//            switch (indexPath.row) {
//                case 0:{// 2-0 商品属性
//                    
//                    [self alert];
//                    
//                    break;
//                }
//                default:
//                    break;
//            }
//            break;
//        }
        case 2:{
            switch (indexPath.row) {
                case 0:{// 3-0
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }case 3:{
            switch (indexPath.row) {
                case 0:{//  4-0 评论1
                    
                    break;
                }case 1:{// 4-1  评论2
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }case 4:{
#pragma mark - 全部评论 -
            switch (indexPath.row) {
                case 0:{// 5-0 全部评论
                    ThirdCell *cell = [self.view viewWithTag:20170318];
                    
                    
                    if ([[self.model.goodsAppraisesNum objectForKey:@"num"] integerValue] != 0) {
                        DiscussViewController *discuss = [DiscussViewController new];
                        discuss.goodsID = self.goodsID;
                        [self presentViewController:discuss animated:YES completion:^{
                            
                        }];
                        
                    }else{
                        cell.userInteractionEnabled = NO;
                        [self alertWithMassage:@"当前商品还没有评论哦"];
                    }
                    
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }case 5:{
#pragma mark - 店铺 -
            switch (indexPath.row) {
                case 0:{// 6-0 店铺信息 2个Btn的事件回调
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }case 6:{
            switch (indexPath.row) {
                case 0:{// 0-0
                    
                    break;
                }
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
}


#pragma mark - collectionView section的个数 -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
#pragma mark - Item的个数 -
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}
#pragma mark - cell的处理 -
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BtnCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier:@"btnImg_text" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BtnCollectionViewCell alloc]init];
        
    }
    cell.title.text = self.BtnArray[indexPath.item];
    
    if (_btnArray.count == 0) {
        if (indexPath.item == 0) {
            cell.title.textColor = [UIColor redColor];
            cell.line.hidden = NO;
        }else{
            cell.title.textColor = [UIColor blackColor];
            cell.line.hidden = YES;
        }
    }else{
        if ([_btnArray containsObject:self.BtnArray[indexPath.item]]) {
            cell.title.textColor = [UIColor redColor];
            cell.line.hidden = NO;
        }else{
            cell.title.textColor = [UIColor blackColor];
            cell.line.hidden = YES;
        }
    }
    return cell;
    
    
}


#pragma mark - collection的点击事件 -
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    _btnArray = [NSMutableArray arrayWithObject:self.BtnArray[indexPath.item]];
    
    
    if (indexPath.item == 0) {
        
        [self LoadDetailsImgae_text];
        
    }else{
        
        [self loadDetailParameter];
    }
    
    [self.collectionView reloadData];
}



/**
 *  webView加载产品图文简介的界面
 *
 *  @return
 */
#pragma mark - 图文详情调用 -
-(void)LoadDetailsImgae_text{
    
    NSString *pjUrlString = @"m=Customer&c=Goods&a=goodsImgText";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString]];
    
    NSString *body = [NSString stringWithFormat:@"goodsid=%@",self.goodsID];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [self.detailWebView loadRequest:request];
    
    
    
    
}
/**
 *  webView加载产品详细参数的界面
 *
 *  @return
 */
#pragma mark - 加载详细参数的调用 -
-(void)loadDetailParameter{
    
    NSString *pjUrlString = @"m=Customer&c=Goods&a=goodsAttr";
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString]];
    NSString *body = [NSString stringWithFormat:@"goodsid=%@&shopid=%@",self.goodsID,self.model.sid];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    [self.detailWebView loadRequest: request];
}

#pragma mark - item的大小 -
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((screen_width)/2, 50);
}
#pragma mark - 间距 -
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
#pragma mark - 间距 -
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}




#pragma mark - bottomView的Btn的Target - Action事件 -

/**
 *  客服按钮的点击事件
 *
 *  @return
 */

#pragma mark - 客服按钮 -
-(void)btn_service:(UIButton*)sender{
    [self alertWithMassage:@"客服"];
    
}
/**
 *  进入店铺按钮
 *
 *  @return
 */
#pragma mark - 进入店铺 -
-(void)btn_shop:(UIButton*)sender{
    [self gotoshop];
}

/**
 *  进入店铺的方法
 *
 *  @return
 */

#pragma mark- gotoShop -
-(void)gotoshop{
    MyStoreViewController *storeVC = [MyStoreViewController new];
    _shopID = self.model.sId;
    storeVC.shopID = _shopID;
    storeVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    storeVC.modalPresentationStyle = UIModalPresentationFullScreen;
    
    [self presentViewController:storeVC animated:YES completion:^{
        
    }];
}




/**
 *  收藏按钮的处理
 *
 *  @return
 */

#pragma mark - 收藏按钮 -
-(void)btn_collection:(UIButton*)sender{
    
    if ([k_defaults boolForKey:k_LoginStatus]) {
        
        NSDictionary *dic = @{@"id":self.goodsID,@"type":@"goods",@"uid":UserID};
        [self setSelectedWithDictionary:dic];
        if (sender.selected) {
            [self alertWithMassage:@"取消收藏"];
        }else{
            [self alertWithMassage:@"已收藏"];
        }
        sender.selected = !sender.selected;
    }else{
        LoginViewController *login = [LoginViewController new];
        [self presentViewController:login animated:YES completion:^{
            sender.selected = !sender.selected;

        }];
            
    }
    
    
}

/**
 *  收藏并上传服务器
 *
 *  @return
 */
#pragma mark - 收藏 上传服务器 -
-(void)setSelectedWithDictionary:(NSDictionary*)dic{
    
    NSString *pjUrlString = @"m=Customer&c=Favorites&a=favoritesAdd";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {

        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}






/**
 *  底部的购物车按钮
 *
 *  @return
 */
#pragma mark - 底部购物车按钮 -
-(void)btn_addBasket:(UIButton*)sender{
    
    [self checkLogin];

    [self alert];
}
/**
 *  暂时去掉了
 *
 *  @return
 */
#pragma mark - 立即购买 -
-(void)btn_buyNow:(UIButton*)sender{
    
    [self checkLogin];
    
}

/**
 *  分享按钮的点击事件
 *
 *  @return
 */
#pragma mark - 分享 -
-(void)bt_share:(UIButton*)sender{
    
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"APP.png"]];
    //（注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"这是来着一品同行的分享"//可以传空值
                                         images:imageArray
                                            url:[NSURL URLWithString:[NSString stringWithFormat:@"%@",URLSTRING]]
                                          title:@"一品同行"
                                           type:SSDKContentTypeAuto];
        //有的平台要客户端分享需要加此方法，例如微博
        [shareParams SSDKEnableUseClientShare];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}


}

/**
 *  店铺Cell的全部商品的按钮事件
 *
 *  @return
 */
#pragma mark - 全部商品页面 -
-(void)bt_allGoods:(UIButton*)sender{
    StoreListViewController *store = [StoreListViewController new];
    store.shopID = self.shopID;
    store.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    
    store.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:store animated:YES completion:^{
        
    }];
    
}






#pragma mark -暂时未用到的Animation  -
-(void)shakeToShow:(UIView*)view{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [view.layer addAnimation:animation forKey:nil];
}



/**
 *  详情界面的数据解析所在
 *
 *  @return 返回所有的数据模型
 */


#pragma mark - 解析 -
-(void)getData{
    
    NSString *pjUrlString = @"m=Customer&c=Goods&a=goodsContent";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:self.dic PrepareExecute:^{
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSDictionary *dictionary =[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"];
        
        NSMutableArray *a = [NSMutableArray array];
        
        self.model = [GoodsDetailsModel mj_objectWithKeyValues:dictionary];

        
        /************** 注释掉了2017/03/19 **************/
        /*        NSMutableArray *ar = [NSMutableArray array];
         //        [ar addObject:self.model];
         //        self.tabArray = [NSArray arrayWithArray:ar];
         */
        if (self.model.picList == nil || self.model.picList == NULL || self.model.picList.count == 0) {
            
        }else{
            for (NSString *str in self.model.picList) {
                [a addObject:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,str]];
            }
            self.imgArray = [NSArray arrayWithArray:a];
        }
        
        
        /**
         ///MJextension
         self.pinglunArray = [PingLunModel mj_keyValuesArrayWithObjectArray:self.model.appraisesList];
         */
        
        NSMutableArray *pinglunArr = [NSMutableArray array];
        for (NSDictionary *d in self.model.appraisesList) {
            
            PingLunModel *model = [PingLunModel new];
            [model setValuesForKeysWithDictionary:d];
            [pinglunArr addObject:model];
        }
        self.pinglunArray = [NSArray arrayWithArray:pinglunArr];
        
        NSMutableArray *couponArr = [NSMutableArray array];
        for (NSDictionary *diction in self.model.couponList) {
            PersonalCouponModel *model = [PersonalCouponModel new];
            [model setValuesForKeysWithDictionary:diction];
            [couponArr addObject:model];

        }
        self.couponArray = [NSArray arrayWithArray:couponArr];

        
        
        
        [self setTabView];
        [self initWithChooseView];
        [self setSKUView];
        [self initWithStoreCouponView];
        [self.tableView reloadData];
        
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
#pragma mark -店铺Logo的代理方法 -
/**
 *  进入店铺的方法
 *
 *  @param cell 对应的布局Cel
 */
-(void)goToShop:(FifthCell *)cell
{
    [self gotoshop];
}
/**
 *  评论图片的代理方法,点击放大
 *
 *  @return
 */
#pragma mark - 评论图片的代理方法 -
-(void)fourthCell:(FourthPingLunCell *)cell Withimg:(UIImageView *)img
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    [img addGestureRecognizer:tap];
}

-(void)tap:(UITapGestureRecognizer*)sender{
    
    UIImageView *img = (UIImageView*)sender.view;
    
    [PJImgaeBrowser showImage:img];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

/**
 *  自定义的Nav
 *
 *  @return
 */

#pragma mark - 自定义Nav -
-(void)CostomNav{
    __weak typeof(self) weakself = self;
    
    self.navView = [UIView new];
    //    self.navView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top).with.offset(0);
        make.left.equalTo(weakself.view.mas_left).with.offset(0);
        make.right.equalTo(weakself.view.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    
    //    self.navigationController.navigationBar.hidden = YES;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    UILabel *title = [UILabel new];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"商品详情";
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(view);
        make.height.mas_equalTo(@26);
    }];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setImage:[UIImage imageNamed:(@"sign_in_return.png")] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(8);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navRightBtn setImage:[UIImage imageNamed:(@"details_basket.png")] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(basket:) forControlEvents:UIControlEventTouchUpInside];
    ;
    [view addSubview:navRightBtn];
    [navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-10);
        make.top.equalTo(view.mas_top).with.offset(32);
        make.width.mas_equalTo(@33);
        make.height.mas_equalTo(@33);
    }];
    
    
}
/**
 *  返回按钮
 *
 *  @return
 */
#pragma mark - 返回按钮 -
-(void)backBtn:(UIButton*)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
/**
 *  nav栏的购物车按钮
 *
 *  @param Nav购物车按钮 Nav购物车按钮 description
 *
 *  @return return value description
 */
#pragma mark - 购物车(Nav购物车按钮) -
-(void)basket:(UIButton*)sender{
    [self alertWithMassage:@"购物车"];
}
/**
 *  webView加载完成调用
 *
 */
#pragma mark - webView加载完毕调用 -
-(void)webViewDidFinishLoad:(UIWebView *)webView{
    
}
/**
 *  webView加载失败调用
 *
 */
#pragma mark - webView加载失败调用 -
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
}

/**
 *  一个弹框提示
 *
 *  @return ,一个弹框提示
 */
#pragma mark -- 提示弹框 --
-(void)alertWithMassage:(NSString*)massage{
    
    
    CGFloat version = [[[UIDevice currentDevice]systemVersion] floatValue];
    
    if (version >= 8.0) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"提示" message:massage preferredStyle:UIAlertControllerStyleAlert];
        [self presentViewController:alertVC animated:YES completion:^{
            
        }];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        });
        
    }
    
}



/**
 *  scroll 切换视图的方法,需要重写
 *
 *  @return nil
 */
#pragma mark - ScrollViewDelegate -
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;

    
    
    if ([scrollView isKindOfClass:[UITableView class]]) {
        
        CGFloat valueNum = self.tableView.contentSize.height - screen_height;

        if ((offsetY - valueNum) >= 124 ) {
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self goToDetailAnimataon];
            });
            
            
        }
    }else{
        if (offsetY<= 0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self backToFirstPageAnimataon];
            });
            
            
        }
    }
    
    
    
    
    
    
}

/**
 *  GoToWebView
 */
-(void)goToDetailAnimataon{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        [self.ContentBottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(74);
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.right.equalTo(self.view.mas_right).with.offset(0);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        }];
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(-1170.5);
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.right.equalTo(self.view.mas_right).with.offset(0);
            make.bottom.equalTo(self.view.mas_top).with.offset(0);
        }];
    } completion:^(BOOL finished) {
        
    }];
}

/**
 *  WebView 回到详情页面
 */
-(void)backToFirstPageAnimataon{
    [UIView animateWithDuration:0.5 delay:0.0 options:UIViewAnimationOptionLayoutSubviews animations:^{
        //        self.detailWebView.frame = rect(0, self.tableView.bounds.size.height , screen_width, screen_height - 50);
        
        [self.ContentBottomView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).with.offset(0);
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.right.equalTo(self.view.mas_right).with.offset(0);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(1170.5);
        }];
        
        
        
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(74);
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.right.equalTo(self.view.mas_right).with.offset(0);
            make.bottom.equalTo(self.view.mas_bottom).with.offset(-50);
        }];
        [self.tableView reloadData];
    } completion:^(BOOL finished) {
        
    }];
}




/*
-(void)setSKUData{
    

 */
    
/*----------------------------------------------------------------------------*/
    

/*----------------------------------------------------------------------------*/
/*

    NSLog(@"我是分割线_________________________________________________________");


    NSLog(@"我是分割线_________________________________________________________");
  
}
*/

/**
 *  SKU页面的布局,适应更多的变化
 */
#pragma mark - SKU页面的布局,适应更多的变化 -
-(void)setSKUView{
    NSDictionary *dictionary = @{@"attrIosList":self.model.attrIosList};
    
    NSLog(@"%@",self.model);
    
    self.skuChooseView = [[SKUChooseView alloc]init];
    self.skuChooseView.dictionary =[NSDictionary dictionaryWithDictionary:dictionary];

    [self.skuChooseView.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,[self.model.attrIosList objectForKey:@"picurl"]]] placeholderImage:[UIImage imageNamed:@"star_gray.png"]];
    [self.view addSubview:self.skuChooseView];
    [self.skuChooseView.bt_cancle addTarget:self action:@selector(closeTheWindow) forControlEvents:UIControlEventTouchUpInside];
    [self.skuChooseView.bt_sure addTarget:self action:@selector(bt_sure) forControlEvents:UIControlEventTouchUpInside];

    self.skuChooseView.lb_stock.text =[NSString stringWithFormat:@"库存量:%@",[self.model.attrIosList objectForKey:@"zstock"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeTheWindow)];
    self.skuChooseView.lb_detail.text = @"请选择商品属性";
    [self.skuChooseView.alphaView addGestureRecognizer:tap];
    [self.skuChooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(screen_height);
        
    }];
    

    
    
}


/**
 chooseView
 
 - returns: 布局
 */
#pragma mark - SKU相关处理 -
-(void)initWithChooseView{
    

//    NSString *sizeString = [[self.model.attrIosList objectForKey:@"attrValList"][0] objectForKey:@"attrName"];
//    NSString *colorString = [[self.model.attrIosList objectForKey:@"attrValList"][1] objectForKey:@"attrName"];
/*
    NSString *str = [[NSBundle mainBundle] pathForResource:@"stock" ofType:@"plist"];
    self.stockDic = [[NSDictionary alloc]initWithContentsOfURL:[NSURL fileURLWithPath:str]];
    NSLog(@"%@",self.stockDic);
    
    
    NSDictionary *dictionary = @{@"100*170":@{@"灰色":@"10",
                                              @"黑色":@"11",
                                              @"紫色":@"12",
                                              @"蓝色":@"13",
                                              @"白色":@"0",},
                                 @"90*140":@{@"灰色":@"20",
                                             @"黑色":@"21",
                                             @"紫色":@"22",
                                             @"蓝色":@"23",
                                             @"白色":@"5",},
                                 @"90*130":@{@"灰色":@"100",
                                             @"黑色":@"0",
                                             @"紫色":@"120",
                                             @"蓝色":@"130",
                                             @"白色":@"10",},
                                 @"80*120":@{@"灰色":@"1000",
                                             @"黑色":@"1100",
                                             @"紫色":@"1200",
                                             @"蓝色":@"1300",
                                             @"白色":@"100",},
                                 @"灰色":@{@"100*170":@"10",
                                             @"90*140":@"20",
                                             @"90*130":@"0",
                                             @"80*120":@"1000"
                                             },
                                 @"黑色":@{@"100*170":@"11",
                                         @"90*140":@"21",
                                         @"90*130":@"110",
                                         @"80*120":@"1100"
                                         },
                                 @"紫色":@{@"100*170":@"12",
                                         @"90*140":@"22",
                                         @"90*130":@"120",
                                         @"80*120":@"1200"
                                         },
                                 @"蓝色":@{@"100*170":@"13",
                                         @"90*140":@"23",
                                         @"90*130":@"130",
                                         @"80*120":@"1300"
                                         },
                                 @"白色":@{@"100*170":@"0",
                                         @"90*140":@"5",
                                         @"90*130":@"10",
                                         @"80*120":@"100"
                                         }
                                 };
    self.stockDic = [NSDictionary dictionaryWithDictionary: dictionary];
*/
    
    self.chooseView = [[ChooseView alloc]init];
    [self.chooseView.img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,[self.model.attrIosList objectForKey:@"picurl"]]] placeholderImage:[UIImage imageNamed:@"star_gray.png"]];
    self.chooseView.lb_stock.text =[NSString stringWithFormat:@"%@",[self.model.attrIosList objectForKey:@"zstock"]];
    [self.view addSubview:self.chooseView];
    [self.chooseView.bt_cancle addTarget:self action:@selector(closeTheWindow) forControlEvents:UIControlEventTouchUpInside];
    [self.chooseView.bt_sure addTarget:self action:@selector(bt_sure) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeTheWindow)];
    self.chooseView.lb_price.text = [self.model.attrIosList objectForKey:@"attrPrice"];
    self.chooseView.lb_detail.text = @"请选择商品属性";
    [self.chooseView.alphaView addGestureRecognizer:tap];
    [self.chooseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(screen_height);
        
    }];
//    [self.chooseView initTypeViewSizeArray:_sizeArray ColorArray:_colorArray dictionary:_stockDic sizeName:sizeString colorName:colorString Stock:[self.model.attrIosList objectForKey:@"zstock"]];
    
    
}

/**
 *  SKU页面的弹出
 */

-(void)alert{
    
    [self checkLogin];
    
    [UIView animateWithDuration:0.35 animations:^{
        
        [self.skuChooseView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(0);
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.right.equalTo(self.view.mas_right).with.offset(0);
            make.height.mas_equalTo(screen_height);
        }];
        [self.view bringSubviewToFront:self.skuChooseView];
    } completion:^(BOOL finished) {
        
    }];
    
}

/**
 *  SKU的关闭按钮和遮罩点击事件
 
 */
-(void)closeTheWindow{
    
    [UIView animateWithDuration:0.35 animations:^{
        [self.skuChooseView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_bottom).with.offset(0);
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.right.equalTo(self.view.mas_right).with.offset(0);
            make.height.mas_equalTo(screen_height);
        }];
        //        self.tableView.center = center;
        self.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.0, 1.0);
#pragma mark - 回传拼接的字符串 -
        //关闭的时候需要把选中的属性传给TableView的Cell.text显示
        //内容为 :       self.chooseView.lb_detail.text;
        
        ThirdCell *cell = (ThirdCell *)[self.view viewWithTag:100100];
        if (cell.lb_text.text != nil) {
            cell.lb_text.text = @"";
            cell.lb_text.text = self.chooseView.lb_detail.text;
            
        }else{
            cell.lb_text.text = self.chooseView.lb_detail.text;
            
        }
        _SKU = YES;
        
        
    } completion:^(BOOL finished) {
        
    }];
}
/**
 *  SKU的确认按钮
 */
-(void)bt_sure{
    [self closeTheWindow];
#pragma mark - --  需要处理的回掉 -- 
//    self.skuChooseView.
    
    NSDictionary *dic= @{@"goodsid":self.goodsID,@"uid":UserID,@"goods_attrval":self.skuChooseView.skuID,@"num":self.skuChooseView.countView.tf_count.text};
    
    [self addToBasketWithParam:dic];
    
    
    
    
    
}




/**
 *  获取商品 添加到购物车并上传服务器
 *
 *  @param dic 参数
 */
-(void)addToBasketWithParam:(NSDictionary*)dic{
   
    NSString *urlstring = @"m=Customer&c=Cart&a=cartInsetr";
    
   [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlstring] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
       
   } Success:^(NSURLSessionDataTask *task, id responseObject) {
       NSString *code = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"code"];
       
       NSLog(@"%@",[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]);
       if ([code isEqualToString:@"200"]) {
           [self alertWithMassage:@"加入购物车"];
       }else{
           [self alertWithMassage:@"加入购物车失败,请从新添加购物车"];
       }
       
       
   } Failure:^(NSURLSessionDataTask *task, NSError *error) {
       
   }];
    
}

/**
 初始化优惠券页面的布局
 
 - returns: nil
 */
#pragma mark - 优惠券 -
-(void)initWithStoreCouponView{
    
    self.couponView = [[StoreCouponView alloc]init];
    [self.view addSubview: self.couponView];
    [self.couponView.bt_cancle addTarget:self action:@selector(btn_cancle:) forControlEvents:UIControlEventTouchUpInside];
    [self.couponView.bt_sure addTarget:self action:@selector(btn_cancle:) forControlEvents:UIControlEventTouchUpInside];
    self.couponView.delegate = self;
    self.couponView.couponArray = [NSArray arrayWithArray:self.couponArray];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeCouponView)];
    [self.couponView.alphaView addGestureRecognizer:tap];
    [self.couponView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(screen_height);
    }];
    
    
    
}

/**
 *  弹出优惠券页面
 */
-(void)couponAlert{
    [UIView animateWithDuration:0.35 animations:^{
        
        [self.couponView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).with.offset(0);
            make.left.equalTo(self.view.mas_left).with.offset(0);
            make.right.equalTo(self.view.mas_right).with.offset(0);
            make.height.mas_equalTo(screen_height);
        }];
        [self.view bringSubviewToFront:self.couponView];
    } completion:^(BOOL finished) {
        
    }];
    
}



/**
 *  优惠券的关闭窗口
 */
-(void)closeCouponView{
    
    [UIView animateWithDuration:0.35 animations:^{
       [self.couponView mas_remakeConstraints:^(MASConstraintMaker *make) {
           
           make.top.equalTo(self.view.mas_bottom).with.offset(0);
           make.left.equalTo(self.view.mas_left).with.offset(0);
           make.right.equalTo(self.view.mas_right).with.offset(0);
           make.height.mas_equalTo(screen_height);
        
       }];
        
    }];
    
    
    
}
/**
 *  优惠券的取消按钮 效果同确定按钮
 *
 *
 */
-(void)btn_cancle:(UIButton*)sender{
    
    [self closeCouponView];
    
    
}

/**
 *  领取优惠券的代理方法
 *
 *  @param view  需要代理的View
 *  @param index indexPath.item
 *  @param couID 优惠券ID
 */
-(void)StoreCouponView:(StoreCouponView *)view Index:(NSInteger)index CouID:(NSString *)couID{
    

    [self getCouponToOursWithDictionary:@{@"uid":UserID,@"couponId":couID}];
    
}


/**
 *  领取优惠券 并同步到服务器
 *
 *  @param dic 参数的字典
 */
-(void)getCouponToOursWithDictionary:(NSDictionary*)dic{
    
    NSString *urlString = @"m=Customer&c=Coupon&a=couponInsert";
    
    [[AFHTTPClient shareInstance ] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,urlString] Method:HTTPRequestPost Paramenters:dic PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        [self alertWithMassage:[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"message"]];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}
/**
 *  检测是否登录了
 */
-(void)checkLogin{
    
    if (![k_defaults boolForKey:k_LoginStatus]) {
        
        LoginViewController *login = [LoginViewController new];
        [self presentViewController:login animated:YES completion:^{
        }];
        
    }else{
        
    }
    
}


/**
 *  懒加载 SKU的数据
 *
 *  @return 一个数组
 */
-(NSMutableArray*)SKUResult{
    if (_SKUResult == nil) {
        _SKUResult = [NSMutableArray array];
    }
    return _SKUResult;
}


@end
