//
//  ListCollectionViewHeaderView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/20.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ListCollectionViewHeaderView.h"
@implementation ListCollectionViewHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        self.title = [UILabel new];
        self.title.font = [UIFont systemFontOfSize:14.0];
        self.title.textAlignment = NSTextAlignmentLeft;
        [self addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self);
            make.left.equalTo(self.mas_left).with.offset(5);
            make.right.equalTo(self.mas_right).with.offset(0);
            make.height.mas_equalTo(30);
            
        }];
    }
    return self;
}


@end


#import "HomeListModel.h"
#import "HomeCollectionViewCell.h"
@interface ListThirdCollectionHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSMutableArray *_IDArray;
    NSMutableArray *_nameArray;
    NSMutableArray *_picArray;
    
    NSMutableArray *_ConArray;
    
    NSMutableArray *_btnArr;
    
}
@property(nonatomic,getter=isClick)BOOL click;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)NSArray *BtnArray;
@property(nonatomic,strong)UILabel  *navLabel;;
@end


@implementation ListThirdCollectionHeaderView
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


-(void)setTopColArray:(NSArray *)topColArray{
    _topColArray = topColArray;
    _IDArray = [NSMutableArray array];
    _nameArray = [NSMutableArray array];
    _picArray = [NSMutableArray array];
    
    for (LDetailedCollectionModel *model in topColArray) {
        [_IDArray addObject:model.catsId];
        [_nameArray addObject:model.catsName];
        [_picArray addObject:model.catsPic];
    }
    
    
    
    
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
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:rect(0, 0, 0, 0) collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.tag = 1008611;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[LDetailedCollectionViewCell class] forCellWithReuseIdentifier:@"LDetailedCollectionViewCell"];
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.height.mas_equalTo(@50);
    }];
    
    
    
    
    self.sortView = [UIView new];
    self.sortView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.sortView];
    [self.sortView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).with.offset(1);
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
    self.btnCollectionView.tag = 10086;
    self.btnCollectionView.scrollEnabled = NO;
    self.btnCollectionView.showsHorizontalScrollIndicator = NO;
    self.btnCollectionView.backgroundColor = [UIColor whiteColor];
    [self.btnCollectionView registerClass:[BtnCollectionViewCell class] forCellWithReuseIdentifier:@"BtnCollectionViewCell"];
    [self.sortView addSubview:self.btnCollectionView];
    [self.btnCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    if (collectionView.tag == 10086) {
        return 4;
    }else{
        
        return self.topColArray.count;
    }
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (collectionView.tag == 10086) {
        BtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BtnCollectionViewCell" forIndexPath:indexPath];
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
        return cell;
        
    }else{
        
        
        LDetailedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDetailedCollectionViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell =[[LDetailedCollectionViewCell alloc]init];
        }
        
        //给Cell填充背景色
        //    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
        //    selectedBGView.backgroundColor = [UIColor grayColor];
        //    selectedBGView.alpha = 0.3;
        //    cell.selectedBackgroundView = selectedBGView;
        
        LDetailedCollectionModel *model = self.topColArray[indexPath.item];
        
        [cell setDataViewModel:model];
        if (_ConArray.count == 0) {
            if (indexPath.item == 0) {
                cell.title.textColor = [UIColor redColor];
                self.navLabel.text = cell.title.text;
                _ConArray = [NSMutableArray arrayWithObject:_IDArray[indexPath.item]];
            }else{
                cell.title.textColor = [UIColor blackColor];
            }
        }else{
            if([_ConArray containsObject:_IDArray[indexPath.item]]){
                cell.title.textColor = [UIColor redColor];
            }else{
                cell.title.textColor = [UIColor blackColor];
            }
        }
        
        
        return cell;
        
    }
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //        TENWORDINLINE(<#w1#>, <#w2#>, <#w3#>, <#w4#>, <#w5#>, <#w6#>, <#w7#>, <#w8#>, <#w9#>, <#w10#>)
    
    if (collectionView.tag == 10086) {
        _btnArr = [NSMutableArray arrayWithObject:self.BtnArray[indexPath.item]];
        [self.btnCollectionView reloadData];
        
        
        switch (indexPath.item) {
            case 0:{
                if ([_delegate respondsToSelector:@selector(listThirdHeaderView:Flag:)]) {
                    [_delegate listThirdHeaderView:self Flag:@{@"catsid":_ConArray[0]}];
                }
                break;
            }case 1:{
                if ([_delegate respondsToSelector:@selector(listThirdHeaderView:Flag:)]) {
                    [_delegate listThirdHeaderView:self Flag:@{@"catsid":_ConArray[0],@"flag":@"warnStock"}];
                }
                break;
            }case 2:{
                if ([_delegate respondsToSelector:@selector(listThirdHeaderView:Flag:)]) {
                    [_delegate listThirdHeaderView:self Flag:@{@"catsid":_ConArray[0],@"flag":@"time"}];
                }
                break;
            }case 3:{
                if (!self.click) {//高价 NO
                    if ([_delegate respondsToSelector:@selector(listThirdHeaderView:Flag:)]) {
                        [_delegate listThirdHeaderView:self Flag:@{@"catsid":_ConArray[0],@"flag":@"highPrice"}];
                    }
                    
                }else{// 低价 YES
                    if ([_delegate respondsToSelector:@selector(listThirdHeaderView:Flag:)]) {
                        [_delegate listThirdHeaderView:self Flag:@{@"catsid":_ConArray[0],@"flag":@"lowPrice"}];
                    }
                }
                
                self.click = !self.click;
                break;
            }
            default:
                break;
        }
        
        
    }else{
        
        _ConArray = [NSMutableArray arrayWithObject:_IDArray[indexPath.item]];
        LDetailedCollectionViewCell *cell = (LDetailedCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        self.navLabel.text = cell.title.text;
        [self.collectionView reloadData];
        
        if ([_delegate respondsToSelector:@selector(listThirdHeaderView:Dictionary:)]) {
            [_delegate listThirdHeaderView:self Dictionary:@{@"catsid":_IDArray[indexPath.item]}];
        }
    }
}



//// cell点击变色
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
//
//
//// cell点击变色
//- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if ([colView isEqual:self.collectionView]) {
//        LDetailedCollectionViewCell *cell = (LDetailedCollectionViewCell*)[colView cellForItemAtIndexPath:indexPath];
//        [cell setBackgroundColor:[UIColor whiteColor]];
//    } else {
//        LDetailedCollectionViewCell* cell = (LDetailedCollectionViewCell*)[colView cellForItemAtIndexPath:indexPath];
//        [cell setBackgroundColor:[UIColor whiteColor]];
//    }
//}




-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((screen_width)/4, 50);
}


-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
    
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
    self.navLabel = [UILabel new];
    self.navLabel.textAlignment = NSTextAlignmentCenter;
    self.navLabel.textColor = [UIColor whiteColor];
    //    navLabel.text = @"";
    [view addSubview:self.navLabel];
    [self.navLabel mas_makeConstraints:^(MASConstraintMaker *make) {
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





@end





























#import "HomeListModel.h"
#import "HomeCollectionViewCell.h"
@interface listDetailedColHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>


{
    
    
    NSMutableArray *_btnArr;
    
}
@property(nonatomic,getter=isClick)BOOL click;
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)NSArray *BtnArray;
@property(nonatomic,strong)UILabel  *titl;


@end

@implementation listDetailedColHeaderView

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
    [self.btnCollectionView registerClass:[BtnCollectionViewCell class] forCellWithReuseIdentifier:@"BtnCollectionViewCell"];
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
    
    BtnCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"BtnCollectionViewCell" forIndexPath:indexPath];
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
            if ([_delegate respondsToSelector:@selector(listHeaderView:Flag:)]) {
                [_delegate listHeaderView:self Flag:@{@"catsid":self.catsID}];
            }
            break;
        }case 1:{
            if ([_delegate respondsToSelector:@selector(listHeaderView:Flag:)]) {
                [_delegate listHeaderView:self Flag:@{@"catsid":self.catsID,@"flag":@"warnStock"}];
            }
            break;
        }case 2:{
            if ([_delegate respondsToSelector:@selector(listHeaderView:Flag:)]) {
                [_delegate listHeaderView:self Flag:@{@"catsid":self.catsID,@"flag":@"time"}];
            }
            break;
        }case 3:{
            if (!self.click) {//高价 NO
                if ([_delegate respondsToSelector:@selector(listHeaderView:Flag:)]) {
                    [_delegate listHeaderView:self Flag:@{@"catsid":self.catsID,@"flag":@"highPrice"}];
                }
                
            }else{// 低价 YES
                if ([_delegate respondsToSelector:@selector(listHeaderView:Flag:)]) {
                    [_delegate listHeaderView:self Flag:@{@"catsid":self.catsID,@"flag":@"lowPrice"}];
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


