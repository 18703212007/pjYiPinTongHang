//
//  ListViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ListViewController.h"
#import "ListView.h"
#import "ListTableViewCell.h"
#import "ListCollectionViewCell.h"
#import "ListCollectionViewHeaderView.h"
#import "ListModel.h"
#import "ListDetailedViewController.h"
@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    NSInteger _selectIndex;
    BOOL      _isScrollDown;
}
@property(nonatomic,strong)ListView *listView;
@property(nonatomic,strong)NSMutableArray *nameTabArray;
@property(nonatomic,strong)NSMutableArray *namecolArray;
@property(nonatomic,strong)NSMutableArray *listArray;

//@property(nonatomic,strong)NSMutableArray


@end

@implementation ListViewController



-(void)loadView{
    self.listView = [[ListView alloc]initWithFrame:rect(0, 74, screen_width, screen_height)];
    self.view = self.listView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _selectIndex = 0;
    _isScrollDown = YES;
    
    
    [self CostomNav];
    
    //    [self getData];
    [self delegateAndCell];
    
    
    // Do any additional setup after loading the view.
}
#pragma mark -  -
-(void)delegateAndCell{
    
    self.listView.leftTableView.delegate = self;
    self.listView.leftTableView.dataSource = self;
    self.listView.rightCollectionView.dataSource = self;
    self.listView.rightCollectionView.delegate = self;
    [self.listView.leftTableView registerClass:[ListTableViewCell class] forCellReuseIdentifier:@"ListTableViewCell"];
    [self.listView.rightCollectionView registerClass:[ListCollectionViewCell class] forCellWithReuseIdentifier:@"ListCollectionViewCell"];
    [self.listView.rightCollectionView registerClass:[ListCollectionViewHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"ListCollectionViewHeaderView"];
    
    
    
    //    if (self.listView.leftTableView.frame.size.height >=screen_height) {
    //
    //        self.listView.leftTableView.scrollEnabled = YES;
    //
    //    }else{
    //        self.listView.leftTableView.scrollEnabled = NO;
    //
    //    }
    
}

#pragma mark - tableViewDataSource  Delegate-

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.nameTabArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCollectionViewCell"];
    if (!cell) {
        cell = [[ListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ListCollectionViewCell"];
        
    }
    TableModel *model = self.nameTabArray[indexPath.row];
    [cell setDataWithModel:model];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return screen_height/10.0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    ListTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    NSDictionary *dic = @{
                          @"typeid":cell.catsID
                          };
    
    NSString *str = @"m=Customer&c=GoodsCats&a=typeListTwo";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,str] Method:HTTPRequestPost Paramenters:dic PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"];
        self.namecolArray = [NSMutableArray array];
        self.listArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            CollectionModel *model = [CollectionModel new];
            [model setValuesForKeysWithDictionary:dict];
            [self.namecolArray addObject:model];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in [dict objectForKey:@"cats2"]) {
                ListModel *mode = [ListModel new];
                [mode setValuesForKeysWithDictionary:dic];
                [arr addObject:mode];
                
            }
            [self.listArray addObject:arr];
        }
        
        
        [self.listView.rightCollectionView reloadData];
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
    
    
    
    //    [self.listView.rightCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:_selectIndex] atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    //    [self.listView.leftTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_selectIndex inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
}





#pragma mark - collectionViewDataSources Delegate -

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return self.namecolArray.count;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.listArray[section] count];
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ListCollectionViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ListCollectionViewCell alloc]init];
    }
    ListModel *model = self.listArray[indexPath.section][indexPath.row];
    
    [cell setDataWithModel:model];
    
    
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((0.75*screen_width-60)/3 , (0.75*screen_height-120)/3);
}
#pragma mark - headerView的文字
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    //    NSString *reuseIdentifier;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        //        reuseIdentifier= @"ListCollectionViewHeaderView";
    }
    ListCollectionViewHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ListCollectionViewHeaderView" forIndexPath:indexPath];
    
    if ([kind isEqualToString: UICollectionElementKindSectionHeader]) {
        
        CollectionModel *model = self.namecolArray[indexPath.section];
        view.title.text = model.catsName;
        
    }
    return view;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(screen_width, 30);
}
#pragma mark - collectionView分区标题即将展示 -
-(void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    //    if (!_isScrollDown &&collectionView.dragging) {
    //        [self selectRowAtIndex:indexPath.section];
    //    }
}
#pragma mark - collectionView分区标题展示结束 -
-(void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    //    if ((_isScrollDown && collectionView.dragging)) {
    //        [self selectRowAtIndex:indexPath.section + 1];
    //
    //    }else{
    //
    //    }
}




-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ListCollectionViewCell *cell =(ListCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    
    //        [self alertWithMassage:cell.nameCollection.text];
    ListDetailedViewController *detailVC = [ListDetailedViewController new];
    detailVC.titleStr = cell.nameCollection.text;
    detailVC.catsID = cell.catsID;
    
    [self presentViewController:detailVC animated:YES completion:^{
        
    }];
    
    
}




#pragma mark - 当拖动tableView的时候 处理tableView -
//-(void)selectRowAtIndex:(NSInteger)index{
//    [self.listView.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
//}

#pragma mark - UIScrollView delegate -

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    static float lastOffSetY = 0;
    
    if (self.listView.rightCollectionView == scrollView) {
        _isScrollDown = lastOffSetY < scrollView.contentOffset.y;
        lastOffSetY = scrollView.contentOffset.y;
    }
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



-(void)getData{
    
    NSString *str = @"m=Customer&c=GoodsCats&a=typeListNoe";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,str] Method:HTTPRequestPost Paramenters:nil PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray  *array = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]objectForKey:@"data"];
        self.nameTabArray = [NSMutableArray array];
        for (NSDictionary *dictionary in array) {
            TableModel *model = [TableModel new];
            [model setValuesForKeysWithDictionary:dictionary];
            [self.nameTabArray addObject:model];
        }
        [self.listView.leftTableView reloadData];
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    [self load];
    
    
}

-(void)load{
    
    NSDictionary *dic = @{
                          @"typeid":@"334"
                          
                          };
    NSString *str = @"m=Customer&c=GoodsCats&a=typeListTwo";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,str] Method:HTTPRequestPost Paramenters:dic PrepareExecute:nil Success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *array = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"];
        self.namecolArray = [NSMutableArray array];
        self.listArray = [NSMutableArray array];
        for (NSDictionary *dict in array) {
            CollectionModel *model = [CollectionModel new];
            [model setValuesForKeysWithDictionary:dict];
            [self.namecolArray addObject:model];
            NSMutableArray *arr = [NSMutableArray array];
            for (NSDictionary *dic in [dict objectForKey:@"cats2"]) {
                ListModel *mode = [ListModel new];
                [mode setValuesForKeysWithDictionary:dic];
                [arr addObject:mode];
                
            }
            [self.listArray addObject:arr];
        }
        [self.listView.rightCollectionView reloadData];
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
    
    
}








#pragma mark - 自定义NV -
-(void)CostomNav{
    
    __weak typeof(self) weakself = self;
    self.navigationController.navigationBar.hidden = YES;
    
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.listView.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakself.listView.mas_top).with.offset(0);
        make.left.equalTo(weakself.listView.mas_left).with.offset(0);
        make.right.equalTo(weakself.listView.mas_right).with.offset(0);
        make.height.mas_equalTo(@74);
    }];
    
    UILabel *title = [UILabel new];
    title.textAlignment = NSTextAlignmentCenter;
    title.textColor = [UIColor whiteColor];
    title.text = @"分类";
    [view addSubview:title];
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(view);
        make.height.mas_equalTo(@26);
    }];
    
    
}




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

@end
