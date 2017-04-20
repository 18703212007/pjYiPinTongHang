//
//  DiscussViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/16.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "DiscussViewController.h"
#import "HomeCollectionViewCell.h"
#import "GoodsDetailsModel.h"
#import "GoodsDetailsTableViewCell.h"
#import "TableViewPingLunCell.h"
@interface DiscussViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,FourthPingLunCelldelegate>

{
    NSArray *_array;
    NSMutableArray *_conArray;
    UIImageView *_img;
    
}


@property(nonatomic,strong)UIView *navView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray  *discussArray;

@property(nonatomic,strong)ALLPingLunModel *model;

@property(nonatomic,getter=isCountNum)BOOL countNum;

@property(nonatomic,strong)PingLunModel *pingLunmodel;


@end

@implementation DiscussViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    self.countNum = NO;
    [super viewDidLoad];
    
    [self getData];
    [self CostomNav];
    [self setCollection];
    [self setTable];
    
    
    
    
    
}


-(void)setCollection{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self.view addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.navView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(screen_height/8.0);
    }];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    
    
    [self.collectionView registerClass:[LDetailedCollectionViewCell class] forCellWithReuseIdentifier:@"LDetailedCollectionViewCellDiscuss"];
    
    
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _array.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    LDetailedCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LDetailedCollectionViewCellDiscuss" forIndexPath:indexPath];
    if (!cell) {
        cell = [[LDetailedCollectionViewCell alloc]init];
    }
    if ([self.model.num isEqualToString:@"0"]||self.model.num == 0) {
        
        CGFloat height = screen_height  - 74 - screen_height/8.0;
        [self loadImagewithHeight:height];
    }
    
    cell.title.text = _array[indexPath.item];
    
    
    //给Cell填充背景色
    UIView* selectedBGView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBGView.backgroundColor = [UIColor clearColor];
    selectedBGView.alpha = 0.3;
    cell.selectedBackgroundView = selectedBGView;
    //    selectedBGView.layer.borderColor = [UIColor whiteColor].CGColor;
    //    selectedBGView.layer.cornerRadius = 4;
    //    selectedBGView.layer.borderWidth = 5;
    //    [selectedBGView.layer setMasksToBounds:YES];
    
    if (_conArray.count == 0) {
        if (indexPath.item == 0) {// 207  41  46
            cell.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];
            cell.title.textColor = [UIColor whiteColor];
            
        }else{
            cell.backgroundColor = [UIColor whiteColor];
            cell.title.textColor = [UIColor blackColor];
            
        }
    }else{
        if([_conArray containsObject:_array[indexPath.item]]){
            
            cell.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];
            cell.title.textColor = [UIColor whiteColor];
            
        }else{
            
            cell.backgroundColor = [UIColor whiteColor];
            cell.title.textColor = [UIColor blackColor];
            
        }
    }
    
    
    
    
    return cell;
    
    
    
    
    
    
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(screen_width/3.0, screen_height/16.0);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 0;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
    
}




// cell点击变色
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


// cell点击变色
- (void)collectionView:(UICollectionView *)colView  didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([colView isEqual:self.collectionView]) {
        LDetailedCollectionViewCell *cell = (LDetailedCollectionViewCell*)[colView cellForItemAtIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor whiteColor]];
    } else {
        LDetailedCollectionViewCell* cell = (LDetailedCollectionViewCell*)[colView cellForItemAtIndexPath:indexPath];
        [cell setBackgroundColor:[UIColor whiteColor]];
    }
}



-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:{
            NSDictionary *dic = @{@"goodsid":
                                      self.goodsID
                                  };
            [self requestDataWithDictionary:dic];
            
            
            break;
        }case 1:{
            NSDictionary *dic = @{@"goodsid":
                                      self.goodsID,
                                  @"type":@"5"
                                  };
            [self requestDataWithDictionary:dic];
            
            break;
        }case 2:{
            NSDictionary *dic = @{@"goodsid":
                                      self.goodsID,
                                  @"type":@"3"
                                  };
            [self requestDataWithDictionary:dic];
            
            break;
        }case 3:{
            NSDictionary *dic = @{@"goodsid":
                                      self.goodsID,
                                  @"type":@"1"
                                  };
            [self requestDataWithDictionary:dic];
            
            break;
        }case 4:{
            NSDictionary *dic = @{@"goodsid":
                                      self.goodsID,
                                  @"type":@"9"
                                  };
            [self requestDataWithDictionary:dic];
            
            break;
        }
        default:
            break;
    }
    
    
    _conArray = [NSMutableArray arrayWithObject:_array[indexPath.row]];
    [self.collectionView reloadData];
    
    
}

-(void)getData{
    
    NSString *pjUrlString = @"m=Customer&c=GoodsAppraises&a=appraisesList";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,pjUrlString] Method:HTTPRequestPost Paramenters:@{@"goodsid":self.goodsID} PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.model  = [ALLPingLunModel mj_objectWithKeyValues:[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]];
        
        [self setAllPinglunContant];
        
        
        
        NSArray *arr = [[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"] objectForKey:@"appraisesList"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dic in arr) {
            PingLunModel *model = [PingLunModel new];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.discussArray = [NSArray arrayWithArray:array];;
        [self.tableView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
}

-(void)requestDataWithDictionary:(NSDictionary*)dic{
    
    NSString *goodsDetailsstr = @"m=Customer&c=GoodsAppraises&a=appraisesList";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,goodsDetailsstr] Method:HTTPRequestPost Paramenters:dic PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        self.model  = [ALLPingLunModel mj_objectWithKeyValues:[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"]];
        
        
        NSArray *arr = [[[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"] objectForKey:@"appraisesList"];
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in arr) {
            PingLunModel *model = [PingLunModel new];
            [model setValuesForKeysWithDictionary:dic];
            [array addObject:model];
        }
        self.discussArray = [NSArray arrayWithArray:array];
        [self.tableView reloadData];
        
        
        
        
        
        
        
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
}

-(void)setAllPinglunContant{
    _array = @[@"全部",@"好评",@"中评",@"差评",@"晒图"];
    _array = [NSArray arrayWithObjects:
              [NSString stringWithFormat:@"%@(%@)",_array[0],self.model .num],
              [NSString stringWithFormat:@"%@(%@)",_array[1],self.model.hnum],
              [NSString stringWithFormat:@"%@(%@)",_array[2],self.model.znum],
              [NSString stringWithFormat:@"%@(%@)",_array[3],self.model.cnum],
              [NSString stringWithFormat:@"%@(%@)",_array[4],self.model.stnum],
              nil];
    [self.collectionView reloadData];
    
}




-(void)setTable{
    
    self.tableView = [[UITableView alloc]initWithFrame:rect(0,0,0,0) style:UITableViewStylePlain];
    //    self.tableView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview: self.tableView];
    self.tableView.tableFooterView = [UIView new];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
    }];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[FourthPingLunCell class] forCellReuseIdentifier:@"FourthAllPingLunCell"];
    //    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewPingLunCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"TableViewPingLunCell"];
    //    self.cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableViewPingLunCell"];
    
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.discussArray.count;
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.pingLunmodel.picarr.count) {
        return 160;
    }else{
        return 115;
    }
    
    
    
    
    
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FourthPingLunCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FourthAllPingLunCell"];
    if (!cell) {
        cell = [[FourthPingLunCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FourthAllPingLunCell"];
    }

    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    if (self.discussArray.count == 0) {
   
    }else{
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.pingLunmodel = self.discussArray[indexPath.row];
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
}




#pragma mark - 自定义NV -
-(void)CostomNav{
    __weak typeof(self) weakself = self;
    
    self.navView = [UIView new];
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.view.mas_top).with.offset(0);
        make.left.equalTo(weakself.view.mas_left).with.offset(0);
        make.right.equalTo(weakself.view.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    
    
    
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"#cf292e"];
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
    //    UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [navRightBtn setImage:[UIImage imageNamed:(@"details_basket.png")] forState:UIControlStateNormal];
    //    [navRightBtn addTarget:self action:@selector(basket:) forControlEvents:UIControlEventTouchUpInside];
    //    ;
    //    [view addSubview:navRightBtn];
    //    [navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.equalTo(view.mas_right).with.offset(-10);
    //        make.top.equalTo(view.mas_top).with.offset(32);
    //        make.width.mas_equalTo(@33);
    //        make.height.mas_equalTo(@33);
    //    }];
    
    
}

-(void)backBtn:(UIButton*)sender{
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}


-(void)loadImagewithHeight:(CGFloat)height{
    
    _img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wushuju"]];
    [self.view addSubview:_img];
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.view.mas_top).with.offset(screen_height - height);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
        make.height.mas_equalTo(height);
        
    }];
    
    
}


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

@end
