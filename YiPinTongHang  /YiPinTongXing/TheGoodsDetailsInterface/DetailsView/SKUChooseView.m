//
//  SKUChooseView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/4/13.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "SKUChooseView.h"
#import "UICollectionViewLeftAlignedLayout.h"
#import "SpecLabelCell.h"
#import "SpecHeadView.h"
#import "BuyCountView.h"
#define kSpecHeadView   @"SpecHeadView"
#define kSpecLabelCell  @"SpecLabelCell"

@interface SKUChooseView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>

@property(nonatomic,strong)UILabel *lb_line;

@end


@implementation SKUChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        ///遮罩
        self.alphaView = [UIView new];
        self.alphaView.backgroundColor = [UIColor blackColor];
        self.alphaView.alpha = 0.5;
        [self addSubview:self.alphaView];
        [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(screen_width, screen_height));
            
        }];
        ///视图View
        self.whiteView = [UIView new];
        self.whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteView];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(screen_height*0.25);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(screen_width, screen_height*0.75));
        }];
        ///确定按钮的View
        self.sureView = [UIView new];
        self.sureView.backgroundColor = [UIColor whiteColor];
        [self.whiteView addSubview:self.sureView];
        [self.sureView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.mas_bottom).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(screen_width, 50));
        }];
        

        [self setUI];
    }
    return self;
}


-(void)setDictionary:(NSDictionary *)dictionary{
    _dictionary = dictionary;
    
    
    NSDictionary * SkuDate = dictionary[@"attrIosList"][@"attrValList_sku"];
    NSMutableArray * array = [[NSMutableArray alloc]init];
    NSArray * allKeys = [SkuDate allKeys];
    for (int i = 0;i < allKeys.count;i++) {
        NSString * key = allKeys[i];
        NSDictionary * dic = [SkuDate objectForKey:key];
        NSDictionary * skuDic = @{key:dic};
        [array addObject:skuDic];
    }
    
    [self createDataSource:array];
    [self reloadWindow:dictionary];
}






-(void)setUI{
    [self setTop];
    [self setSure];
    [self setMid];
}

-(void)setTop{
#pragma mark -上面部分的View -

    self.topView = [UIView new];
    self.topView.backgroundColor = [UIColor whiteColor];
    [self.whiteView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_top).with.offset(0);
        make.left.equalTo(self.mas_left).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(screen_width, 100));
    }];
    
    self.goodsImage = [UIImageView new];
    //        self.goodsImage.image = [UIImage imageNamed:@"star_gray.png"];
    self.goodsImage.backgroundColor = [UIColor yellowColor];
    self.goodsImage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.goodsImage.layer.cornerRadius = 4;
    self.goodsImage.layer.borderWidth = 5;
    [self.goodsImage.layer setMasksToBounds:YES];
    [self.whiteView addSubview:self.goodsImage];
    [self.goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_top).with.offset(-20);
        make.left.equalTo(self.whiteView.mas_left).with.offset(10);
        make.size.mas_equalTo(CGSizeMake(100 , 100));
    }];
    
    self.bt_cancle = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.whiteView addSubview:self.bt_cancle];
    [self.bt_cancle setBackgroundImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];
    [self.bt_cancle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_top).with.offset(10);
        make.right.equalTo(self.whiteView.mas_right).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(30 , 30));
    }];
    
    self.goodsPrice = [UILabel new];
    self.goodsPrice.font = [UIFont systemFontOfSize:14.0];
    self.goodsPrice.textColor = [UIColor redColor];
    [self.whiteView addSubview:self.goodsPrice];
    self.goodsPrice.adjustsFontSizeToFitWidth = YES;
    

    [self.goodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.whiteView.mas_top).with.offset(10);
        make.left.equalTo(self.goodsImage.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(200 , 20));
    }];
    
    self.lb_stock = [UILabel new];
    self.lb_stock.font = [UIFont systemFontOfSize:14.0];
    [self.whiteView addSubview:self.lb_stock];
    [self.lb_stock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.goodsPrice.mas_bottom).with.offset(10);
        make.left.equalTo(self.goodsImage.mas_right).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(120 , 20));
    }];
    self.lb_detail = [UILabel new];
    self.lb_detail.font = [UIFont systemFontOfSize:14.0];
    self.lb_detail.numberOfLines = 2;
    self.lb_detail.textColor = [UIColor blackColor];
    [self.whiteView addSubview:self.lb_detail];
    [self.lb_detail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lb_stock.mas_bottom).with.offset(0);
        make.left.equalTo(self.goodsImage.mas_right).with.offset(20);
        make.right.equalTo(self.whiteView.mas_right).with.offset(-10);
        make.height.mas_equalTo(40);
    }];

    [self setLineWith:_topView];

}
-(void)setSure
{
    
    self.bt_sure =[UIButton buttonWithType:UIButtonTypeCustom];
    [self.bt_sure setBackgroundColor:[UIColor redColor]];
    [self.bt_sure setTitle:@"确定" forState:UIControlStateNormal];
    self.bt_sure.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.sureView addSubview:self.bt_sure];
    [self.bt_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
}

-(void)setMid{
    
    self.midView = [UIView new];
    
    [self.whiteView addSubview: self.midView];
    [self.midView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.topView.mas_bottom).with.offset(0);
        make.left.equalTo(self.whiteView.mas_left).with.offset(0);
        make.right.equalTo(self.whiteView.mas_right).with.offset(0);
        make.bottom.equalTo(self.sureView.mas_top).with.offset(0);
        
    }];
    
    self.botView = [UIView new];
    [self.midView addSubview: self.botView];
    [self.botView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(self.midView.mas_left).with.offset(0);
        make.right.equalTo(self.midView.mas_right).with.offset(0);
        make.bottom.equalTo(self.midView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(@50);
        
    }];
    self.countView = [BuyCountView new];
    [self.botView addSubview:self.countView];
    self.countView.frame = rect(0, 0, screen_width, 50);
    [self.countView.bt_add addTarget:self action:@selector(bt_add) forControlEvents:UIControlEventTouchUpInside];
    self.countView.tf_count.delegate = self;
    [self.countView.bt_reduce addTarget:self action:@selector(bt_reduce) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self setCollection];
    
    
}

-(void)setCollection{

    UICollectionViewLeftAlignedLayout * flowLayout = [[UICollectionViewLeftAlignedLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 15;
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionView = [[UICollectionView alloc]initWithFrame:rect(0, 50, screen_width, screen_height*0.65 - 150) collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;

    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.currentTitle = @"(null)";
    [self.whiteView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.midView.mas_top).with.offset(0);
        make.left.equalTo(self.midView.mas_left).with.offset(0);
        make.right.equalTo(self.midView.mas_right).with.offset(0);
        make.bottom.equalTo(self.botView.mas_top).with.offset(0);
    }];
//    [self setLineWith:self.collectionView];
    
    
    [self.collectionView registerClass:[SpecLabelCell class] forCellWithReuseIdentifier:kSpecLabelCell];
    [self.collectionView registerClass:[SpecHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kSpecHeadView];
    
    
}







#pragma mark - -----------------------我是分割线------------------------------

#pragma mark - UICollectionViewDataSource - UICollectionViewDelegate - UICollectionViewDelegateFlowLayout
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return self.dataSource.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSDictionary * dic = self.dataSource[section];
    NSArray * array = dic[@"sku_list"];
    return array.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpecLabelCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:kSpecLabelCell forIndexPath:indexPath];
    NSDictionary * dic = self.dataSource[indexPath.section];
    NSArray * array = dic[@"sku_list"];
    NSDictionary * dict = array[indexPath.item];
    cell.nameLabel.text = NSString(@"%@", dict[@"attrVal"]);
    cell.layer.cornerRadius = 5;
    cell.layer.masksToBounds = YES;
    
    
    ///不可选
    if ([self.seletedEnable containsObject:indexPath]) {
        cell.nameLabel.textColor = [UIColor lightGrayColor];
        cell.backImage.image = [[UIImage imageNamed:@"btn_isdeable_n"] imageWithAlignmentRectInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
        cell.userInteractionEnabled = NO;
    }
    //可选
    else
    {
        cell.nameLabel.textColor = [UIColor darkGrayColor];
        cell.backImage.image = [[UIImage imageNamed:@"btn_selected_n"] imageWithAlignmentRectInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
        cell.userInteractionEnabled = YES;
    }
    
    //选中
    if ([self.seletedIndexPaths containsObject:indexPath]) {
        cell.nameLabel.textColor = [UIColor whiteColor];
        cell.backImage.image = [[UIImage imageNamed:@"btn_selected_s"] imageWithAlignmentRectInsets:UIEdgeInsetsMake(4, 4, 4, 4)];
        cell.userInteractionEnabled = YES;
    }
    
    
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * dic = self.dataSource[indexPath.section];
    NSArray * array = dic[@"sku_list"];
    NSDictionary * dict = array[indexPath.item];
    NSString * string = NSString(@"%@", dict[@"attrVal"]);
    CGFloat width = (string.length + 2) * 14;
    return CGSizeMake(width, 25);
    
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    SpecHeadView * headView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kSpecHeadView forIndexPath:indexPath];
    NSDictionary * dic = self.dataSource[indexPath.section];
    headView.nameLabel.text = NSString(@"%@", dic[@"attrName"]);
    
    if ([self.noSelectedHead containsObject:indexPath]) {
        headView.alertLabel.hidden = NO;
    }
    else
    {
        headView.alertLabel.hidden = YES;
    }
    
    if ([NSString(@"%@", dic[@"attrName"]) isEqualToString:@"颜色"]) {
        if (![self.currentTitle isEqualToString:@"(null)"]) {
            headView.specInfo.text = NSString(@"%@", self.currentTitle);
            headView.specInfo.hidden = NO;
            headView.alertLabel.hidden = YES;
        }
        else
        {
            headView.specInfo.hidden = YES;
        }
    }
    else
    {
        headView.specInfo.hidden = YES;
    }
    
    
    return headView;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return CGSizeMake(screen_width, 30);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ///取出SKUResult中所有可能的排列组合方式(keysArray)
    NSMutableArray * keysArray = [[NSMutableArray alloc]init];
    for (NSDictionary * dict in self.skuResult) {
        NSString * key = [[dict allKeys] firstObject];
        [keysArray addObject:key];
    }
    
    NSDictionary * dic = self.dataSource[indexPath.section];
    
    
    NSArray * array = dic[@"sku_list"];
    NSDictionary * dict = array[indexPath.item];
    NSString * AttrValueId = NSString(@"%@", dict[@"id"]);
    
    //取出所有选中状态的按钮标题
    //如果已经被选中则取消选中
    if ([self.seletedIndexPaths containsObject:indexPath]) {
        [self.seletedIndexPaths removeObjectAtIndex:indexPath.section];
        [self.seletedIndexPaths insertObject:@"0" atIndex:indexPath.section];
        [self.seletedIdArray removeObjectAtIndex:indexPath.section];
        [self.seletedIdArray insertObject:@"" atIndex:indexPath.section];
    }
    else
    {
        [self.seletedIndexPaths removeObjectAtIndex:indexPath.section];
        [self.seletedIndexPaths insertObject:indexPath atIndex:indexPath.section];
        [self.seletedIdArray removeObjectAtIndex:indexPath.section];
        [self.seletedIdArray insertObject:AttrValueId atIndex:indexPath.section];
    }
    
    [self.seletedEnable removeAllObjects];
    
    for (int i = 0; i < self.dataSource.count; i++) {
        NSDictionary * subDic = self.dataSource[i];
        NSArray *subArray = subDic[@"sku_list"];
        for (int j = 0; j < subArray.count; j++) {
            NSDictionary * reSubDic = subArray[j];
            NSIndexPath * currentIndexPath = [NSIndexPath indexPathForItem:j inSection:i];
            NSString * currentId = NSString(@"%@", reSubDic[@"id"]);
            NSMutableArray * tempArray = [[NSMutableArray alloc]initWithArray:self.seletedIdArray];
            
            [tempArray removeObjectAtIndex:i];
            [tempArray insertObject:currentId atIndex:i];
            NSMutableArray * resultArray = [[NSMutableArray alloc]init];
            for (NSString * str in tempArray) {
                if (![str isEqualToString:@""]) {
                    [resultArray addObject:str];
                }
            }
            NSArray * changeArray = [self change:resultArray];
            NSString * resultKey = [changeArray componentsJoinedByString:@";"];
            if (![keysArray containsObject:resultKey]) {
                [self.seletedEnable addObject:currentIndexPath];
            }
            
            
        }
        
    }
    
    
    [self price];
    
    NSString * StandardListName = dic[@"attrName"];
    
#pragma mark - 图片赋值 - 
    NSString *picStr = [NSString stringWithFormat:@"%@",[dic[@"sku_list"][indexPath.item] objectForKey:@"picurl"]];
    
    
    if ([picStr  isEqual: @"<null>"]) {
       
    }else{
        [self.goodsImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",k_Yptx_URL,picStr]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
        
    }
    
    
    
    
    if ([StandardListName isEqualToString:@"颜色"]) {
        id obj = self.seletedIndexPaths[indexPath.section];
        if ([obj isKindOfClass:[NSIndexPath class]]) {
            self.currentTitle = self.alertInfo[indexPath.item];
        }
        else
        {
            self.currentTitle = @"(null)";
        }
    }
    NSString *detailsStr;
    if (indexPath.section == 0) {
        detailsStr = [NSString stringWithFormat:@"%@",[dic[@"sku_list"][indexPath.item] objectForKey:@"attrVal"]];
    }else{
       
    }
#warning !!!!!!!
#pragma mark ---  写到这了  回传所选中的属性   ----
    [self.collectionView reloadData];
    
}



- (void)price
{
    NSMutableArray * resultArray = [[NSMutableArray alloc]init];
    for (NSString * str in self.seletedIdArray) {
        if (![str isEqualToString:@""]) {
            [resultArray addObject:str];
        }
    }
    NSArray * skeyArray =  [self change:resultArray];
    
    NSString * key = [skeyArray componentsJoinedByString:@";"];
    NSString * price = self.goodsprice;
    NSArray * skuIDAr;
    NSString * count =[NSString stringWithFormat:@"%@",self.dictionary[@"attrIosList"][@"zstock"]];
    for (NSDictionary * dic in self.skuResult) {
        NSString * skey = [[dic allKeys] firstObject];
        if ([key isEqualToString:skey]) {
            NSDictionary * dict = dic[key];
            count = [NSString stringWithFormat:@"%@",dict[@"stock"]];
            skuIDAr = dict[@"skuID"];
            NSArray * prices = dict[@"prices"];
            NSMutableArray * rPrices = [[NSMutableArray alloc]initWithArray:prices];
            NSArray * rePrices = [self change:rPrices];
            NSString * minPrice = [rePrices firstObject];
            NSString * maxPrice = [rePrices lastObject];
            if ([maxPrice isEqualToString:minPrice]) {
                price = [NSString stringWithFormat:@"￥%@",minPrice];
            }
            else
            {
                price = [NSString stringWithFormat:@"￥%@~￥%@",minPrice,maxPrice];
            }
        }
    }
    self.goodsPrice.text = price;
    self.lb_stock.text = [NSString stringWithFormat:@"%@",count];
    self.stock = [count intValue];
    self.skuID = [skuIDAr firstObject];
    
}


///接收通知处理数据
- (void)reloadWindow:(NSDictionary *)object
{
    NSDictionary * result = object;
    NSArray * skuResult = self.SKUResult;
    [self.skuResult removeAllObjects];
    [self.seletedEnable removeAllObjects];
    [self.noSelectedHead removeAllObjects];
    [self.seletedIdArray removeAllObjects];
    [self.seletedIndexPaths removeAllObjects];
    [self.skuResult addObjectsFromArray:skuResult];
    
    ///取出SKUResult中所有可能的排列组合方式(keysArray)
    NSMutableArray * keysArray = [[NSMutableArray alloc]init];
    for (NSDictionary * dict in self.skuResult) {
        NSString * key = [[dict allKeys] firstObject];
        [keysArray addObject:key];
    }
    
    NSDictionary * dic = result[@"attrIosList"];
    self.goodsName.text = NSString(@"%@", dic[@"name"]);
    self.goodsId = NSString(@"%@", dic[@"goodsID"]);
    [self.dataSource removeAllObjects];
    NSArray * array = dic[@"attrValList"];
    
    if ([array isKindOfClass:[NSNull class]]) {
        return;
    }
    
    
    NSString * price;
    NSMutableArray * allPrice = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in self.skuResult) {
        NSString * skey = [[dic allKeys] firstObject];
        NSDictionary * dict = dic[skey];
        NSArray * prices = dict[@"prices"];
        [allPrice addObjectsFromArray:prices];
    }
    NSArray * rePrices = [self change:allPrice];
    NSString * minPrice = [rePrices firstObject];
    NSString * maxPrice = [rePrices lastObject];
    if ([maxPrice isEqualToString:minPrice]) {
        price = [NSString stringWithFormat:@"￥%@",minPrice];
    }
    else
    {
        price = [NSString stringWithFormat:@"￥%@~￥%@",minPrice,maxPrice];
    }
    
    self.goodsPrice.text = price;
    self.goodsprice = price;
    
    
    int i = 0;
    for (NSDictionary * dic in array) {
        NSArray *  StandardInfoList = dic[@"sku_list"];
        NSString * StandardListName = NSString(@"%@", dic[@"attrName"]);
        int x = -1;
        NSString * attrValueId = @"";
        for (int j = 0; j < StandardInfoList.count; j++) {
            NSDictionary * dict = StandardInfoList[j];
            NSString * isSelected = NSString(@"%@", dict[@"IsSelect"]);
            NSString * AttrValueId = NSString(@"%@", dict[@"id"]);
            if ([StandardListName isEqualToString:@"颜色"]) {
                NSString * AttrvalueTitle = NSString(@"%@", dict[@"AttrTitle"]);
                [self.alertInfo addObject:AttrvalueTitle];
            }
            
            //不可选
            //            if (![keysArray containsObject:AttrValueId]) {
            //                NSIndexPath * indexpath = [NSIndexPath indexPathForItem:j inSection:i];
            //                [self.seletedEnable addObject:indexpath];
            //            }
            
            
            if ([isSelected isEqualToString:@"1"]) {
                x = j;
                attrValueId = AttrValueId;
                break;
            }
        }
        //如果没有选中的
        if (x == -1) {
            [self.seletedIndexPaths addObject:@"0"];
            [self.seletedIdArray addObject:@""];
        }
        else
        {
            NSIndexPath * indexPath = [NSIndexPath indexPathForItem:x inSection:i];
            [self.seletedIndexPaths addObject:indexPath];
            [self.seletedIdArray addObject:attrValueId];
        }
        
        [self.dataSource addObject:dic];
        i++;
    }
    
    [self.seletedEnable removeAllObjects];
    
    for (int i = 0; i < self.dataSource.count; i++) {
        NSDictionary * subDic = self.dataSource[i];
        NSArray *subArray = subDic[@"sku_list"];
        for (int j = 0; j < subArray.count; j++) {
            NSDictionary * reSubDic = subArray[j];
            NSIndexPath * currentIndexPath = [NSIndexPath indexPathForItem:j inSection:i];
            NSString * currentId = NSString(@"%@", reSubDic[@"id"]);
            NSMutableArray * tempArray = [[NSMutableArray alloc]initWithArray:self.seletedIdArray];
            
            [tempArray removeObjectAtIndex:i];
            [tempArray insertObject:currentId atIndex:i];
            NSMutableArray * resultArray = [[NSMutableArray alloc]init];
            for (NSString * str in tempArray) {
                if (![str isEqualToString:@""]) {
                    [resultArray addObject:str];
                }
            }
            NSArray * changeArray = [self change:resultArray];
            NSString * resultKey = [changeArray componentsJoinedByString:@";"];
            if (![keysArray containsObject:resultKey]) {
                [self.seletedEnable addObject:currentIndexPath];
            }
            
            
        }
        
    }
    
    
    [self.collectionView reloadData];
}





#pragma mark - SKU算法
- (void)createDataSource:(NSArray *)array
{
    NSMutableArray * keysArray = [[NSMutableArray alloc]init];
    NSMutableArray * valuesArray = [[NSMutableArray alloc]init];
    for (int i = 0; i < array.count; i++) {
        NSDictionary * dic = array[i];
        NSArray * keys = [dic allKeys];
        NSString * key = [keys firstObject];
        NSDictionary * value = [dic objectForKey:key];
        [keysArray addObject:key];
        [valuesArray addObject:value];
    }
    for (int j = 0; j < keysArray.count; j++) {
        NSString * key = keysArray[j];
        NSArray * subKeyAttrs = [key componentsSeparatedByString:@";"];
        NSMutableArray * muArray = [[NSMutableArray alloc]initWithArray:subKeyAttrs];
        NSArray * resultArray = [self change:muArray];
        
        NSArray * combArr = [self combInArray:resultArray];
        
        NSDictionary * sku = valuesArray[j];
        
        for (int k = 0; k < combArr.count; k++) {
            [self add2SKUResult:combArr[k] sku:sku];
        }
        NSString *keys = [resultArray componentsJoinedByString:@";"];
        NSString * price = [NSString stringWithFormat:@"%@",sku[@"price"]];
//        NSString * goodsID = NSString(@"%@", sku[@"goodsID"]);
        NSString * skuID = [NSString stringWithFormat:@"%@",sku[@"skuID"]];
        
        NSString * count = [NSString stringWithFormat:@"%@",sku[@"stock"]];
        NSMutableArray * prices = [[NSMutableArray alloc]init];
        NSMutableArray * skuIDArray = [[NSMutableArray alloc]init];
        [prices addObject:price];
        [skuIDArray addObject:skuID];
        NSDictionary * dic = @{@"stock":count,@"prices":prices,@"skuID":skuIDArray};
        NSDictionary * dict = @{keys:dic};
        [self.SKUResult addObject:dict];
    }
}



- (NSArray *)combInArray:(NSArray *)array
{
    if ([array isKindOfClass:[NSNull class]] || array.count == 0) {
        return @[];
    }
    
    int len = (int)array.count;
    NSMutableArray * aResult = [[NSMutableArray alloc]init];
    
    for (int n = 1; n < len; n++) {
        NSMutableArray * aaFlags = [[NSMutableArray alloc]initWithArray:[self getComFlags:len n:n]];
        
        while (aaFlags.count != 0) {
            NSMutableArray * aFlag = [[NSMutableArray alloc]initWithArray:[aaFlags firstObject]];
            [aaFlags removeObjectAtIndex:0];
            NSMutableArray * aComb = [[NSMutableArray alloc]init];
            for (int i = 0; i < len; i++) {
                if ([aFlag[i] intValue] == 1) {
                    [aComb addObject:array[i]];
                }
            }
            [aResult addObject:aComb];
            
        }
        
    }
    
    return aResult;
}

- (NSArray *)getComFlags:(int)m n:(int)n
{
    if (!n || n < 1) {
        return @[];
    }
    
    NSMutableArray * aFlag = [[NSMutableArray alloc]init];
    BOOL bNext = YES;
    
    for (int i = 0; i < m; i++) {
        int q = i < n ? 1 : 0;
        [aFlag addObject:[NSNumber numberWithInt:q]];
    }
    
    NSMutableArray * aResult = [[NSMutableArray alloc]init];
    [aResult addObject:[aFlag copy]];
    
    int iCnt1 = 0;
    while (bNext) {
        iCnt1 = 0;
        for (int i = 0; i < m - 1; i++) {
            if ([aFlag[i] intValue] == 1 && [aFlag[i+1] intValue] == 0) {
                for (int  j = 0; j < i; j++) {
                    int w = j < iCnt1 ? 1 : 0;
                    [aFlag removeObjectAtIndex:j];
                    [aFlag insertObject:[NSNumber numberWithInt:w] atIndex:j];
                }
                [aFlag removeObjectAtIndex:i];
                [aFlag insertObject:@(0) atIndex:i];
                [aFlag removeObjectAtIndex:i+1];
                [aFlag insertObject:@(1) atIndex:i+1];
                
                NSArray * aTmp = [aFlag copy];
                [aResult addObject:aTmp];
                
                int e = (int)aTmp.count;
                NSString * tempString;
                for (int r = e - n; r < e; r ++) {
                    tempString = [NSString stringWithFormat:@"%@%@",tempString,aTmp[r]];
                }
                if ([tempString rangeOfString:@"0"].location == NSNotFound) {
                    bNext = false;
                }
                
                break;
            }
            if ([aFlag[i] intValue] == 1) {
                iCnt1++;
            }
        }
    }
    return aResult;
}
- (void)add2SKUResult:(NSArray *)combArrItem sku:(NSDictionary *)sku
{
    NSString * key = [combArrItem componentsJoinedByString:@";"];
    NSMutableArray * keysArray = [[NSMutableArray alloc]init];
    for (NSDictionary * dic in self.SKUResult) {
        NSString * keys = [[dic allKeys] firstObject];
        [keysArray addObject:keys];
    }
    
    
    if ([keysArray containsObject:key]) {
        NSString * price = [NSString stringWithFormat:@"%@",sku[@"price"]];
        NSString * skuID = [NSString stringWithFormat:@"%@",sku[@"skuID"]];
        NSString * count = [NSString stringWithFormat:@"%@",sku[@"stock"]];
        NSMutableDictionary * newDic = [[NSMutableDictionary alloc]init];
        int i = 0;
        for (NSDictionary * dict in self.SKUResult) {
            NSString * keys = [[dict allKeys] firstObject];
            if ([keys isEqualToString:key]) {
                NSMutableDictionary * tempDic = [[NSMutableDictionary alloc]init];
                NSDictionary * diction = dict[keys];
                NSString * scount = [NSString stringWithFormat:@"%@",diction[@"stock"]];
                int newCount = [scount intValue] + [count intValue];
                [tempDic setValue:[NSString stringWithFormat:@"%d",newCount] forKey:@"stock"];
                NSMutableArray * tempArray = [[NSMutableArray alloc]initWithArray:diction[@"prices"]];
                [tempArray addObject:price];
                NSMutableArray * skuIDArray = [[NSMutableArray alloc]initWithArray:diction[@"skuID"]];
                [skuIDArray addObject:skuID];
                [tempDic setValue:tempArray forKey:@"prices"];
                [tempDic setValue:skuIDArray forKey:@"skuID"];
                [newDic setValue:tempDic forKey:keys];
                [self.SKUResult removeObjectAtIndex:i];
                [self.SKUResult insertObject:newDic atIndex:i];
                break;
            }
            i++;
        }
        
    }
    else
    {
        NSString * price = [NSString stringWithFormat:@"%@",sku[@"price"]];
        NSString * skuID = [NSString stringWithFormat:@"%@",sku[@"skuID"]];
        NSString * count = [NSString stringWithFormat:@"%@",sku[@"stock"]];
        NSMutableArray * skuIDArray = [[NSMutableArray alloc]init];
        NSMutableArray * prices = [[NSMutableArray alloc]init];
        [skuIDArray addObject:skuID];
        [prices addObject:price];
        NSDictionary * dic = @{@"stock":count,@"prices":prices,@"skuID":skuIDArray};
        NSDictionary * dict = @{key:dic};
        [self.SKUResult addObject:dict];
    }
}
///冒泡排序
- (NSArray *)change:(NSMutableArray *)array
{
    if (array.count > 1) {
        for (int  i =0; i<[array count]-1; i++) {
            
            for (int j = i+1; j<[array count]; j++) {
                
                if ([array[i] intValue]>[array[j] intValue]) {
                    
                    //交换
                    
                    [array exchangeObjectAtIndex:i withObjectAtIndex:j];
                    
                }
                
            }
            
        }
    }
    NSArray * resultArray = [[NSArray alloc]initWithArray:array];
    
    return resultArray;
}






-(void)setLineWith:(UIView*)view{
   
    self.lb_line = [UILabel new];
    self.lb_line.backgroundColor = [UIColor lightGrayColor];
    [view addSubview:self.lb_line];
    [self.lb_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).with.offset(-1);
        make.left.equalTo(view.mas_left).with.offset(20);
        make.right.equalTo(view.mas_right).with.offset(20);
        make.height.mas_equalTo(@1);
    }];
    
}






-(void)bt_add{
    
    //当前所需数量不可以大于库存数量;
    //    self.stock = 10000;
    int count = [self.countView.tf_count.text intValue];
    if (count < self.stock) {
        self.countView.tf_count.text = [NSString stringWithFormat:@"%d",count+1];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"数量超出范围" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        alert.tag = 10000000;
        [alert show];
        self.countView.tf_count.text = [NSString stringWithFormat:@"%d",self.stock];
    
    }
    
}


-(void)bt_reduce{
    int count = [self.countView.tf_count.text intValue];
    if (count > 1) {
        self.countView.tf_count.text = [NSString stringWithFormat:@"%d",count - 1];
    }else{
        
    }
}

#pragma mark - 懒加载
-(NSMutableArray *)dataSource
{
    if(_dataSource == nil)
    {
        _dataSource = [[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(NSMutableArray *)seletedIndexPaths
{
    if(_seletedIndexPaths == nil)
    {
        _seletedIndexPaths = [[NSMutableArray alloc]init];
    }
    return _seletedIndexPaths;
}


-(NSMutableArray *)seletedIdArray
{
    if(_seletedIdArray == nil)
    {
        _seletedIdArray = [[NSMutableArray alloc]init];
    }
    return _seletedIdArray;
}

-(NSMutableArray *)skuResult
{
    if(_skuResult == nil)
    {
        _skuResult = [[NSMutableArray alloc]init];
    }
    return _skuResult;
}


-(NSMutableArray *)noSelectedHead
{
    if(_noSelectedHead == nil)
    {
        _noSelectedHead = [[NSMutableArray alloc]init];
    }
    return _noSelectedHead;
}

-(NSMutableArray *)seletedEnable
{
    if(_seletedEnable == nil)
    {
        _seletedEnable = [[NSMutableArray alloc]init];
    }
    return _seletedEnable;
}

-(NSMutableArray *)alertInfo
{
    if(_alertInfo == nil)
    {
        _alertInfo = [[NSMutableArray alloc]init];
    }
    return _alertInfo;
}




-(NSMutableArray *)SKUResult
{
    if(_SKUResult == nil)
    {
        _SKUResult = [[NSMutableArray alloc]init];
    }
    return _SKUResult;
}





@end
