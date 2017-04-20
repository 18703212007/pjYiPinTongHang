//
//  PersonalHeaderFooterView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/24.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "PersonalHeaderFooterView.h"
#import "PersonalCollectionViewCell.h"
#import "PersonalTableViewCell.h"
@interface PersonalHeaderFooterView ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
{
    NSArray *_array;
}
@property(nonatomic,strong)UITableView * tableView;

@property(nonatomic,strong)UICollectionView * collectionView;




@end
@implementation PersonalHeaderFooterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _array = @[@"personal_pending_payment",@"personal_waiting_for_delivery",@"personal_receiving_goods",@"personal_pending_evaluation",@"personal_customer_service"];
        [self setUI];
        
    }
    return self;
}

-(void)setUI{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@192);
        
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[PersonalTableViewCell class] forCellReuseIdentifier:@"PersonalCell"];
    [self.tableView registerClass:[PersonalHeaderCell class] forCellReuseIdentifier:@"PersonalHeaderCell"];
    
    [self setCollection];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        PersonalHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalHeaderCell"];
        if (!cell) {
            cell = [[PersonalHeaderCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalHeaderCell"];
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
        [cell.lb_nickName addGestureRecognizer:tap1];
        [cell.img_headerImg addGestureRecognizer:tap];
        
        
        [cell.btn_message addTarget:self action:@selector(btn_msg:) forControlEvents:UIControlEventTouchUpInside];
        
        
        
        [cell.btn_exits addTarget:self action:@selector(btn_exits:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }else{
        PersonalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonalCell"];
        if (!cell) {
            cell = [[PersonalTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PersonalCell"];
        }
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.img.image = [UIImage imageNamed:@"personal_order.png"];
        cell.showLabel.text = @"我的订单";
        return cell;
    }
    
    
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return nil;
    }else{
        UIView *view = [[UIView alloc]initWithFrame:rect(0, 0, screen_width, 10)];
        view.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        return view;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 135.5;
    }else{
        return 46;
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }else{
        return 10;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 1) {
        if ([_delegate respondsToSelector:@selector(OnderPersonalHeaderView:)]) {
            
            [_delegate OnderPersonalHeaderView:self];
        }
    }
    
    
}

-(void)tap:(UITapGestureRecognizer*)sender{
    if ([_delegate respondsToSelector:@selector(HeaderImgPersonalHeaderView:)]) {
        
        [_delegate HeaderImgPersonalHeaderView:self];
    }
}


-(void)btn_exits:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(ExitsBtnPersonalHeaderView:btn:)]) {
        
        [_delegate ExitsBtnPersonalHeaderView:self btn:sender];
    }
}

-(void)btn_msg:(UIButton*)sender{
    if ([_delegate respondsToSelector:@selector(MessageBtnPersonalHeaderView:)]) {
        [_delegate MessageBtnPersonalHeaderView:self];
    }
}


-(void)setCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.scrollEnabled = NO;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tableView.mas_bottom).with.offset(0.5);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@68);
    }];
    
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[PersonalCollectionViewCell class] forCellWithReuseIdentifier:@"PersonalCollectionViewCell"];
    
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath

{
    PersonalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PersonalCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell  = [[PersonalCollectionViewCell alloc]init];
    }
    //    cell.backgroundColor = [UIColor cyanColor]
    cell.img_img.image = [UIImage imageNamed:_array[indexPath.item]];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screen_width/5.0, 68);
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
    
    
    if ([_delegate respondsToSelector:@selector(PersonalHeaderView:index:)]) {
        [_delegate PersonalHeaderView:self index:indexPath.item];
    }
    
    
}

@end




#import "HomeCollectionViewCell.h"

@interface CollectionTableHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_array;
    
}
@property(nonatomic,strong)UICollectionView *collectionView;

@end

static  NSArray *_contantArray;
@implementation CollectionTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _array = @[@"商品收藏",@"店铺收藏"];
        [self setUI];
    }
    return self;
}
-(void)setUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.mas_top).with.offset(0);
        //        make.left.equalTo(self.mas_left).with.offset(0);
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[BtnCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BtnCollectionViewCell alloc]init];
    }
    cell.title.text = _array[indexPath.item];
    
    if (_contantArray.count == 0) {
        if (indexPath.item == 0) {
            cell.title.textColor = [UIColor redColor];
            cell.line.hidden = NO;
        }else{
            cell.title.textColor = [UIColor blackColor];
            cell.line.hidden = YES;
        }
    }else{
        if([_contantArray containsObject:_array[indexPath.item]]){
            cell.title.textColor = [UIColor redColor];
            cell.line.hidden = NO;
        }else{
            cell.title.textColor = [UIColor blackColor];
            cell.line.hidden = YES;
            
        }
    }
    
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _contantArray = [NSMutableArray arrayWithObject:_array[indexPath.item]];
    
    
    if ([_delegate respondsToSelector:@selector(CollectionTableHeaderView:index:)]) {
        [_delegate CollectionTableHeaderView:self index:indexPath.item];
    }
    [self.collectionView reloadData];
    
}





-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screen_width/2.0, 50);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


@end
















@interface CollectionCouponTableHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_array;
    
}
@property(nonatomic,strong)UICollectionView *collectionView;

@end

static  NSArray *_contantArray;
@implementation CollectionCouponTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _array = @[@"平台优惠券",@"店铺优惠券"];
        [self setUI];
    }
    return self;
}
-(void)setUI{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.mas_top).with.offset(0);
        //        make.left.equalTo(self.mas_left).with.offset(0);
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[BtnCollectionViewCell class] forCellWithReuseIdentifier:@"CouponcollectionCell"];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 2;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CouponcollectionCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BtnCollectionViewCell alloc]init];
    }
    cell.title.text = _array[indexPath.item];
    
    if (_contantArray.count == 0) {
        if (indexPath.item == 0) {
            cell.title.textColor = [UIColor redColor];
            cell.line.hidden = NO;
        }else{
            cell.title.textColor = [UIColor blackColor];
            cell.line.hidden = YES;
        }
    }else{
        if([_contantArray containsObject:_array[indexPath.item]]){
            cell.title.textColor = [UIColor redColor];
            cell.line.hidden = NO;
        }else{
            cell.title.textColor = [UIColor blackColor];
            cell.line.hidden = YES;
            
        }
    }
    
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _contantArray = [NSMutableArray arrayWithObject:_array[indexPath.item]];
    
    
    if ([_delegate respondsToSelector:@selector(CollectionCouponTableHeaderView:index:)]) {
        [_delegate CollectionCouponTableHeaderView:self index:indexPath.item];
    }
    [self.collectionView reloadData];
    
}





-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screen_width/2.0, 50);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


@end










#import "HomeCollectionViewCell.h"
@interface OrderTableHeaderView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_array;
    
}
@property(nonatomic,strong)UICollectionView *collectionView;

@end

static  NSArray *_contantArray;
@implementation OrderTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _array = @[@"全部",@"待付款",@"待发货",@"待收货",@"待评价",];
        [self setUI];
    }
    return self;
}


-(void)setIndex:(NSInteger)index{
    _index = index;
}


-(void)setUI{
    
     UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    
    self.collectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.scrollEnabled = YES;
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.mas_top).with.offset(0);
        //        make.left.equalTo(self.mas_left).with.offset(0);
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
        
    }];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[BtnCollectionViewCell class] forCellWithReuseIdentifier:@"collectionCell"];
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[BtnCollectionViewCell alloc]init];
    }
    cell.title.text = _array[indexPath.item];
    
//    if (_index == 1||_index == 2||_index == 3||_index == 4) {
//        NSLog(@"~~~~~~~~~~~~%ld",indexPath.item);
//        NSLog(@"%ld",_index);
//        _contantArray = [NSMutableArray arrayWithObject:_array[_index]];
//
//    }else{
//        NSLog(@"000000000000000000000000000000000");
//        _contantArray = [NSMutableArray arrayWithObject:_array[_index]];
//
//    }

    if (_contantArray.count == 0) {
        if (indexPath.item == 0) {
            cell.title.textColor = [UIColor redColor];
            cell.line.hidden = NO;
        }else{
            cell.title.textColor = [UIColor blackColor];
            cell.line.hidden = YES;
        }
    }else{
        if([_contantArray containsObject:_array[indexPath.item]]){
            cell.title.textColor = [UIColor redColor];
            cell.line.hidden = NO;
        }else{
            cell.title.textColor = [UIColor blackColor];
            cell.line.hidden = YES;
            
        }
    }
    
    
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _contantArray = [NSMutableArray arrayWithObject:_array[indexPath.item]];
    
    if ([_delegate respondsToSelector:@selector(OrderTableHeaderView:index:)]) {
        [_delegate OrderTableHeaderView:self index:indexPath.item];
    }
    [self.collectionView reloadData];
    
}





-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screen_width/5.0, 50);
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}


@end



