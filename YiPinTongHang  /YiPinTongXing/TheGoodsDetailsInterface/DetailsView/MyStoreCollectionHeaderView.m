//
//  MyStoreCollectionHeaderView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "MyStoreCollectionHeaderView.h"
#import "GoodsDetailsModel.h"
#import "GoodsDetailsTableViewCell.h"
#import "HomeCollectionViewCell.h"
#import "GoodDetailsCollectionViewCell.h"
@interface MyStoreCollectionHeaderView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_shopArray;
    NSMutableArray *_conArray;
}


@property(nonatomic,strong)UIView           *tabView;
@property(nonatomic,strong)UITableView      *tableView;


@property(nonatomic,strong)UIView           *couponsView;
@property(nonatomic,strong)UICollectionView *couponsCollection;


@property(nonatomic,strong)UIView           *colView;
@property(nonatomic,strong)UICollectionView *collectionView;




@end

@implementation MyStoreCollectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _shopArray = @[@"店铺首页",@"全部商品",@"新品上架",@"店铺热销"];
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        
    }
    return self;
}

-(void)setData:(NSDictionary *)data
{
    _data = data;
    
   
}


-(void)setCounponsArray:(NSArray *)counponsArray
{
    _counponsArray = counponsArray;
    [self setUI];
}

-(void)setUI{
    
    self.tabView = [UIView new];
    [self addSubview:self.tabView];
    [self.tabView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(120);
    }];
    
 
    
    self.couponsView = [UIView new];
    [self addSubview:self.couponsView];
    [self.couponsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tabView.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        if (self.counponsArray.count == 0) {
            make.height.mas_equalTo(0);
        }else{
            make.height.mas_equalTo(80);
  
        }
    }];
    
    
    self.colView = [UIView new];
    [self addSubview:self.colView];
    [self.colView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.couponsView.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(50);
        
    }];
    
    [self setTableView];
    [self setCouponsView];
    [self setCollectionView];

}


-(void)setTableView{
    
    
    
    
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    //    self.tableView.backgroundColor = [UIColor purpleColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.scrollEnabled = NO;
    [self.tabView addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    [self.tableView registerClass:[ShopsCell class] forCellReuseIdentifier:@"ShopsCell"];
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ShopsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ShopsCell"];
    if (!cell) {
        cell = [[ShopsCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ShopsCell"];
    }
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [cell.img_bgImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,[_data objectForKey:@"shopbanner"]]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    
    [cell.img_shopLogo sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,[_data objectForKey:@"shoplogo"]]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    
    cell.lb_shopName.text = [_data objectForKey:@"shopname"];
    [cell.btn_collection addTarget:self action:@selector(btn_collection:) forControlEvents:UIControlEventTouchUpInside];
    
    
    if ([[_data objectForKey:@"isFavorites"] isEqualToString:@"1"]) {
        cell.btn_collection.selected = YES;
    }else{
        cell.btn_collection.selected = NO;
    }
    
    
    cell.lb_favorites.text =[NSString stringWithFormat:@"%@ %@",[_data objectForKey:@"favoritesnum"],[_data objectForKey:@"ordernum"]];
    
    
    
    return cell;
}



-(void)btn_collection:(UIButton*)sender{
    
    if ([_delegate respondsToSelector:@selector(btnCollectionSelected:Btn:myStoreHeaderView:)]) {
        [_delegate btnCollectionSelected:sender.selected Btn:sender myStoreHeaderView:self];
    }
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
///优惠券
-(void)setCouponsView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.couponsCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.couponsCollection.showsHorizontalScrollIndicator = NO;
    self.couponsCollection.showsVerticalScrollIndicator = NO;
    self.couponsCollection.scrollEnabled = YES;
    self.couponsCollection.backgroundColor = [UIColor whiteColor];
    [self.couponsView addSubview:self.couponsCollection];
    [self.couponsCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    self.couponsCollection.delegate = self;
    self.couponsCollection.dataSource = self;
    [self.couponsCollection registerClass:[ShopDetailsCollcetionViewCell class] forCellWithReuseIdentifier:@"ShopDetailsCollcetionViewCell"];
    
    
}



///
-(void)setCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.colView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[BtnCollectionViewCell class] forCellWithReuseIdentifier:@"shopCollectionViewCell"];
    
    
}




-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    if (collectionView == self.couponsCollection) {
        return 1;
    }else{
        
        return 1;
    }
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.couponsCollection) {
        return self.counponsArray.count;
    }else{
        
        return 4;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.couponsCollection) {
        ShopDetailsCollcetionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ShopDetailsCollcetionViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[ShopDetailsCollcetionViewCell alloc]init];
        }
        CouponModel *model = self.counponsArray[indexPath.item];
        
        [cell setCellDataWithModel:model];
        
        return cell;
        
        
    }else{
        
        BtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopCollectionViewCell" forIndexPath:indexPath];
        if (cell == nil) {
            cell = [[BtnCollectionViewCell alloc]init];
            
        }
        cell.title.text =_shopArray[indexPath.item];
        
        if (_conArray.count == 0) {
            if (indexPath.item == 0) {
                cell.title.textColor = [UIColor redColor];
                cell.line.hidden = NO;
            }else{
                cell.title.textColor = [UIColor blackColor];
                cell.line.hidden = YES;
            }
        }else{
            if([_conArray containsObject:_shopArray[indexPath.item]]){
                cell.title.textColor = [UIColor redColor];
                cell.line.hidden = NO;
            }else{
                cell.title.textColor = [UIColor blackColor];
                cell.line.hidden = YES;
            }
        }
        return cell;
    }
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView == self.couponsCollection) {
        return CGSizeMake(screen_width/3.1, 80);
    }else{
        return CGSizeMake(screen_width/4, 50);
        
    }
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (collectionView == self.couponsCollection) {//优惠券
        ShopDetailsCollcetionViewCell *cell = (ShopDetailsCollcetionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        
        if ([_delegate respondsToSelector:@selector(CouponCollectWithCouID:myStoreHeaderView:)]) {
            [_delegate CouponCollectWithCouID:cell.couponsID myStoreHeaderView:self];
        }
        
//        
        
        
    }else if(collectionView == self.collectionView){
        _conArray = [NSMutableArray arrayWithObject:_shopArray[indexPath.item]];
        
        //        BtnCollectionViewCell *cell = (BtnCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        
        switch (indexPath.item) {
            case 0:{
                
                if ([_delegate respondsToSelector:@selector(myStoreHeaderView:Index:Dictionary:)]) {
                    [_delegate myStoreHeaderView:self Index:indexPath.item Dictionary:@{@"shopid":self.shopID}];
                }
                
                
                break;
            }case 1:{
                
                if ([_delegate respondsToSelector:@selector(myStoreHeaderView:Index:Dictionary:)]) {
                    [_delegate myStoreHeaderView:self Index:indexPath.item Dictionary:@{@"shopid":self.shopID}];
                }
                
                
                break;
            }case 2:{
                
                if ([_delegate respondsToSelector:@selector(myStoreHeaderView:Index:Dictionary:)]) {
                    [_delegate myStoreHeaderView:self Index:indexPath.item Dictionary:@{@"shopid":self.shopID,@"flag":@"new"}];
                }
                
                break;
            }case 3:{
                
                if ([_delegate respondsToSelector:@selector(myStoreHeaderView:Index:Dictionary:)]) {
                    [_delegate myStoreHeaderView:self Index:indexPath.item Dictionary:@{@"shopid":self.shopID,@"flag":@"hot"}];
                }
                
                
                break;
            }
            default:
                break;
        }
        [self.collectionView reloadData];
        
    }
    
}



-(void)returnDic:(ReturnBlock)block
{
    _block = block;
}

@end



@implementation StoreListHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.lb_name = [UILabel new];
        self.lb_name.font = [UIFont systemFontOfSize:17.0];
        self.lb_name.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.lb_name];
        [self.lb_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).with.offset(5);
            make.width.mas_equalTo(150);
            make.height.mas_equalTo(50);
            
        }];
        self.img_img = [UIImageView new];
        self.img_img.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.img_img];
        [self.img_img mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right).with.offset(-5);
            make.size.mas_equalTo(CGSizeMake(9, 15));
        }];
        
        self.lb_allgoods = [UILabel new];
        self.lb_allgoods.textColor = [UIColor lightGrayColor];
        self.lb_allgoods.font = [UIFont systemFontOfSize:14.0];
        self.lb_allgoods.textAlignment = NSTextAlignmentRight;
        [self addSubview:self.lb_allgoods];
        [self.lb_allgoods mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.width.mas_equalTo(150);
            make.right.equalTo(self.img_img.mas_left).with.offset(-5);
            make.height.mas_equalTo(50);
            
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [self addGestureRecognizer:tap];
        
        
    }
    return self;
}

-(void)tap:(UITapGestureRecognizer*)sender{
    
    if ([_delegate respondsToSelector:@selector(storeHeaderView:AllID::)]) {
        [_delegate storeHeaderView:self AllID:@{@"shopid":self.shopID,@"catsid":self.catsID}:self.lb_name.text];
        
        
    }
}


@end


@implementation StoreListFooterView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        
    }
    return self;
}


@end




#import "HomeListModel.h"
#import "HomeCollectionViewCell.h"
@interface StoreDetailsListHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


{
    
    
    NSMutableArray *_btnArr;
    
}
@property(nonatomic,getter=isClick)BOOL click;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)NSArray *BtnArray;
@property(nonatomic,strong)UILabel  *titl;


@end

@implementation StoreDetailsListHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.click = NO;
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        self.BtnArray = @[@"综合",@"销量",@"新品",@"价格"];
        [self setUI];
    }
    return self;
}
-(void)setUI{
    self.navView = [UIView new];
    [self addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    [self CostomNav];
    
    self.sortView = [UIView new];
    self.sortView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.sortView];
    [self.sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@50);
    }];
    
    [self setBtnCol];
    
    
}


-(void)setBtnCol{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.btnCollectionView = [[UICollectionView alloc]initWithFrame:rect(0, 0, 0, 0) collectionViewLayout:layout];
    self.btnCollectionView.delegate = self;
    self.btnCollectionView.dataSource = self;
    //    layout.minimumInteritemSpacing = 0;
    self.btnCollectionView.tag = 10010;
    self.btnCollectionView.scrollEnabled = NO;
    self.btnCollectionView.showsHorizontalScrollIndicator = NO;
    self.btnCollectionView.backgroundColor = [UIColor whiteColor];
    [self.btnCollectionView registerClass:[BtnCollectionViewCell class] forCellWithReuseIdentifier:@"BtnStoreDetailsCollectionViewCell"];
    [self.sortView addSubview:self.btnCollectionView];
    [self.btnCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}






#pragma mark - 自定义NVa -
-(void)CostomNav{
    
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_top).with.offset(0);
        make.left.equalTo(self.navView.mas_left).with.offset(0);
        make.right.equalTo(self.navView.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
        
    }];
    
    self.lb_title = [UILabel new];
    self.lb_title.textAlignment = NSTextAlignmentCenter;
    self.lb_title.textColor = [UIColor whiteColor];
    //    self.lb_title.text = @"";
    [view addSubview:self.lb_title];
    [self.lb_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(@100);
        make.height.mas_equalTo(@26);
    }];
    
    
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setImage:[UIImage imageNamed:(@"sign_in_return.png")] forState:UIControlStateNormal];
    
    [view addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).with.offset(8);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    
}



-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 4;
    
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    BtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BtnStoreDetailsCollectionViewCell" forIndexPath:indexPath];
    if (collectionView.tag == 10010) {
        
        if (!cell) {
            cell = [[BtnCollectionViewCell alloc]init];
        }
        cell.title.text = self.BtnArray[indexPath.item];
        
        if (_btnArr.count == 0) {
            if (indexPath.item == 0) {
                cell.title.textColor = [UIColor redColor];
                cell.line.hidden = NO;
            }else{
                cell.title.textColor = [UIColor blackColor];
                cell.line.hidden = YES;
            }
        }else{
            if([_btnArr containsObject:self.BtnArray[indexPath.item]]){
                cell.title.textColor = [UIColor redColor];
                cell.line.hidden = NO;
            }else{
                cell.title.textColor = [UIColor blackColor];
                cell.line.hidden = YES;
            }
        }
    }
    return cell;
    
    
    
}


#pragma mark -  -
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    _btnArr = [NSMutableArray arrayWithObject:self.BtnArray[indexPath.item]];
    [self.btnCollectionView reloadData];
    
    
    switch (indexPath.item) {
        case 0:{
            
            if ([_delegate respondsToSelector:@selector(storeListHeaderView::)]) {
                [_delegate storeListHeaderView:self :@{@"shopid":self.shopID}];
            }
            
            break;
        }
        case 1:{
            if ([_delegate respondsToSelector:@selector(storeListHeaderView::)]) {
                if (self.catsID == nil) {
                    [_delegate storeListHeaderView:self :@{@"shopid":self.shopID,@"flag":@"warnStock"}];
                }else{
                    [_delegate storeListHeaderView:self :@{@"shopid":self.shopID,@"catsid":self.catsID,@"flag":@"warnStock"}];
                }
                //                [_delegate storeListHeaderView:self :@{@"shopid":self.shopID,@"catsid":self.catsID,@"flag":@"warnStock"}];
            }
            break;
        }case 2:{
            if ([_delegate respondsToSelector:@selector(storeListHeaderView::)]) {
                if (self.catsID == nil) {
                    [_delegate storeListHeaderView:self :@{@"shopid":self.shopID,@"flag":@"time"}];
                    
                }else{
                    [_delegate storeListHeaderView:self :@{@"shopid":self.shopID,@"catsid":self.catsID,@"flag":@"time"}];
                }
            }
            break;
        }case 3:{
            if (!self.click) {//高价 NO
                if ([_delegate respondsToSelector:@selector(storeListHeaderView::)]) {
                    if (self.catsID == nil) {
                        [_delegate storeListHeaderView:self :@{@"shopid":self.shopID,@"flag":@"highPrice"}];
                        
                    }else{
                        [_delegate storeListHeaderView:self :@{@"shopid":self.shopID,@"catsid":self.catsID,@"flag":@"highPrice"}];
                    }
                }
                
            }else{// 低价 YES
                if ([_delegate respondsToSelector:@selector(storeListHeaderView::)]) {
                    if (self.catsID == nil) {
                        [_delegate storeListHeaderView:self :@{@"shopid":self.shopID,@"flag":@"lowPrice"}];
                    }else{
                        [_delegate storeListHeaderView:self :@{@"shopid":self.shopID,@"catsid":self.catsID,@"flag":@"lowPrice"}];
                    }
                }
            }
            
            self.click = !self.click;
            break;
        }
        default:
            break;
    }
    
    
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}



-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((screen_width)/4, 50);
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
}
/*
 
 
 
 */




@end


