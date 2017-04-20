//
//  HomeViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//



#import "HomeViewController.h"
#import "HomeView.h"
#import "HomeWebViewController.h"
#import "HomeModel.h"
#import "HomeCollectionViewCell.h"
#import "HomeWebViewController.h"
#import "ListDetailedController.h"
#import "ReclassifyViewController.h"
#import "GoodsDetailsController.h"
#import "ListViewController.h"
/**
 
 bgCsrollView的ContentSize需要设置
 
 */

/*   测试用   */
#import "SearchViewController.h"

/*   测试用   */
@interface HomeViewController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate,MBProgressHUDDelegate>
{
    ///
    NSString *_hotStr;
    ///
    NSString *_PopularStr;
    ///
}
///
@property(nonatomic,strong)HomeView *homeView;



#pragma mark - topAds范围 -
///top图
@property(nonatomic,strong)NSMutableArray *topImgArray;
///top字幕
@property(nonatomic,strong)NSMutableArray *topTitleArray;
///top链接
@property(nonatomic,strong)NSMutableArray *topURLArray;
///
@property(nonatomic,strong)NSMutableArray *topIDArray;

#pragma mark -- List范围 --
///
@property(nonatomic,strong)NSMutableArray *listArray;




#pragma mark - bottomAds范围 -
///bottom图
@property(nonatomic,strong)NSMutableArray *botImgArray;
///bottom字幕
@property(nonatomic,strong)NSMutableArray *botTitleArray;
///bottom链接
@property(nonatomic,strong)NSMutableArray *botURLArray;
///
@property(nonatomic,strong)NSMutableArray *botIDArray;

///左1
@property(nonatomic,strong)UIImageView *leftImg;
///右上1
@property(nonatomic,strong)UIImageView *rightTopImg;
///中下1
@property(nonatomic,strong)UIImageView *bottomMiddleImg;
///右下1
@property(nonatomic,strong)UIImageView *rightBottomImg;

#pragma mark -- 横向滚动 --

///
@property(nonatomic,strong)NSMutableArray *horizontalArray;

#pragma mark -- collection --
@property(nonatomic,strong)NSMutableArray *collectionArray;





@end

@implementation HomeViewController




-(void)loadView{
    self.homeView = [[HomeView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = self.homeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self HUDShowWithView:self.view];

    [self CostomNav];

    
}

-(void)HUDShowWithView:(UIView*)view{
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.delegate = self;
    //    hud.dimBackground = YES;
    hud.labelText = @"努力加载中…";
    hud.color = RGBA(28, 88, 66, 0.1);
    UIImage *image = [[UIImage imageNamed:@"HUD"] imageWithRenderingMode:UIImageRenderingModeAutomatic];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:image];
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    anima.toValue = @(M_PI*2);
    anima.duration = 1.5f;
    anima.repeatCount = 10;
    [imgView.layer addAnimation:anima forKey:nil];
    hud.customView = imgView;
    
    //        hud.bezelView.color = [UIColor colorWithWhite:0.0 alpha:1];
    //文字颜色
    hud.labelColor = [UIColor blackColor];
    hud.mode = MBProgressHUDModeCustomView;
    hud.animationType = MBProgressHUDAnimationZoom;
}


#pragma mark -- 轮播图 --
/**
 1
 */
-(void)ShowScrollow{
    
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.contentSize = self.homeView.topAdsView.size;
    [self.homeView.topAdsView addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    
    
    
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:rect(0, 0, 0, 0) delegate:self placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    
    
    cycleScrollView.delegate = self;
    cycleScrollView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.titlesGroup =self.topTitleArray;
    cycleScrollView.imageURLStringsGroup = self.topImgArray;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    
    [scrollView addSubview:cycleScrollView];
    [cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.homeView.topAdsView);
    }];
    
}

/**
 2
 */
#pragma mark - List -

-(void)setList{

    self.homeView.listCollectionView.delegate = self;
    self.homeView.listCollectionView.dataSource = self;
    self.homeView.listCollectionView.backgroundColor = [UIColor whiteColor];
    [self.homeView.listCollectionView registerClass:[ListCVCell class] forCellWithReuseIdentifier:@"ListCVCell"];
}

/*----------------2017年02月23日12:46:56修改的代码-------------------------*/

/*----------------2017年02月23日12:46:56修改的代码-------------------------*/


/**
 3
 */
#pragma mark - bottom广告 -
-(void)ShowAdsBottom{
    
    CGFloat height = self.homeView.bottomAdsView.height/2.0;
    CGFloat width = self.homeView.bottomAdsView.width/3.0;
    __weak typeof(self) weakself = self;
    self.homeView.bottomAdsView.backgroundColor = [UIColor whiteColor];
    /**
     1
     */
    UIImageView *img1 = [UIImageView new];
    img1.userInteractionEnabled = YES;
    self.leftImg = img1;
    img1.borderColor = [UIColor colorWithHexString:@"#d9d9d9"];
    img1.borderWidth = 0.3f;
//    [img1 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[0]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
     UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImg1:)];
    [img1 addGestureRecognizer:tap1];
    [self.homeView.bottomAdsView addSubview:img1];
    [img1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself.homeView.bottomAdsView.mas_left).with.offset(0);
        make.top.equalTo(weakself.homeView.bottomAdsView.mas_top).with.offset(0);
        make.height.mas_equalTo(height*2);
        make.width.mas_equalTo(width);
    }];
    /**
     2
     */
    UIImageView *img2 = [UIImageView new];
    img2.userInteractionEnabled = YES;
    self.rightTopImg = img2;
    img2.borderColor = [UIColor colorWithHexString:@"#d9d9d9"];
    img2.borderWidth = 0.3f;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImg2:)];
    [img2 addGestureRecognizer:tap2];
//    [img2 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[1]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    [self.homeView.bottomAdsView addSubview:img2];
    [img2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img1.mas_right).with.offset(0);
        make.top.equalTo(weakself.homeView.bottomAdsView.mas_top).with.offset(0);
        make.right.equalTo(weakself.homeView.bottomAdsView.mas_right).with.offset(0);
        make.height.mas_equalTo(height);
    }];
    /**
     3
     */
    UIImageView *img3 = [UIImageView new];
    self.bottomMiddleImg = img3;
    img3.userInteractionEnabled = YES;
    img3.borderColor = [UIColor colorWithHexString:@"#d9d9d9"];
    img3.borderWidth = 0.3f;
    UITapGestureRecognizer *tap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImg3:)];
    [img3 addGestureRecognizer:tap3];
    [img3 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[2]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    [self.homeView.bottomAdsView addSubview:img3];
    [img3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img1.mas_right).with.offset(0);
        make.top.equalTo(img2.mas_bottom).with.offset(0);
        make.width.mas_equalTo(width);
        make.bottom.equalTo(weakself.homeView.bottomAdsView.mas_bottom).with.offset(0);
    }];
   
    /**
     4
     */
     UIImageView *img4 = [UIImageView new];
    self.rightBottomImg = img4;
    img4.userInteractionEnabled = YES;

    img4.borderColor = [UIColor colorWithHexString:@"#d9d9d9"];
    img4.borderWidth = 0.3f;
    UITapGestureRecognizer *tap4 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapImg4:)];
    [img4 addGestureRecognizer:tap4];
//    [img4 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[3]]
//     placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    [self.homeView.bottomAdsView addSubview:img4];
    [img4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(img3.mas_right).with.offset(0);
        make.top.equalTo(img2.mas_bottom).with.offset(0);
        make.right.equalTo(weakself.homeView.bottomAdsView.mas_right).with.offset(0);
        make.bottom.equalTo(weakself.homeView.bottomAdsView.mas_bottom).with.offset(0);
    }];
    

    
    
    if (self.botImgArray.count == 0) {
        img1.image =[UIImage imageNamed:@"Cellplaceholder"];
        img2.image =[UIImage imageNamed:@"Cellplaceholder"];
        img3.image =[UIImage imageNamed:@"Cellplaceholder"];
        img4.image =[UIImage imageNamed:@"Cellplaceholder"];
    }else if (self.botImgArray.count == 1){
        [img1 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[0]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
        img2.image =[UIImage imageNamed:@"Cellplaceholder"];
        img3.image =[UIImage imageNamed:@"Cellplaceholder"];
        img4.image =[UIImage imageNamed:@"Cellplaceholder"];

    }else if (self.botImgArray.count == 2){
        [img1 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[0]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
        [img2 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[1]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
        img3.image =[UIImage imageNamed:@"Cellplaceholder"];
        img4.image =[UIImage imageNamed:@"Cellplaceholder"];
    }else if (self.botImgArray.count == 3){
        [img1 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[0]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
        [img2 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[1]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
        [img3 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[2]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
        img4.image =[UIImage imageNamed:@"Cellplaceholder"];
    }else{
    [img1 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[0]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    [img2 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[1]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    [img3 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[2]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
    [img4 sd_setImageWithURL:[NSURL URLWithString:self.botImgArray[3]] placeholderImage:[UIImage imageNamed:@"Cellplaceholder"]];
        
    }
    
    
    
    
    
    
    
}
-(void)OnTapImg1:(UITapGestureRecognizer*)sender{
    
    [self jumpToWebViewWith:self.botURLArray[0]];
    
}
-(void)OnTapImg2:(UITapGestureRecognizer*)sender{
     [self jumpToWebViewWith:self.botURLArray[1]];

}
-(void)OnTapImg3:(UITapGestureRecognizer*)sender{
     [self jumpToWebViewWith:self.botURLArray[2]];

}

-(void)OnTapImg4:(UITapGestureRecognizer*)sender{
     [self jumpToWebViewWith:self.botURLArray[3]];

}


/**
 4
 */
#pragma mark - 横向滚动图 -
-(void)setHorizontalScroll{
    
    [self.homeView.hotImg sd_setImageWithURL:[NSURL URLWithString:_hotStr]];
    self.homeView.hotHeadView.backgroundColor = [UIColor whiteColor];
    self.homeView.hotCollectionView.delegate = self;
    self.homeView.hotCollectionView.dataSource = self;
    
    [self.homeView.hotCollectionView registerClass:[HorizontalCollectionViewCell class] forCellWithReuseIdentifier:@"HorizontalCollectionViewCell"];
    
    
    
/*************************************************************/

}


/**
 5
 */
#pragma mark - collectionView - 
-(void)setcollection{
  
     
    [self.homeView.popularImg sd_setImageWithURL:[NSURL URLWithString:_PopularStr]];
     self.homeView.popularCollectionView.delegate = self;
    self.homeView.popularCollectionView.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
    self.homeView.popularCollectionView.dataSource = self;
    [self.homeView.popularCollectionView registerClass:[PopularCollectionViewCell class] forCellWithReuseIdentifier:@"PopularCollectionViewCell"];
    


    

    
}

#pragma mark - 数据解析 -
-(void)getData{
     NSString *url = k_Yptx_URL;
    /**
     
     */
    NSString *adsstr = @"m=Customer&c=Index&a=adsList";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,adsstr] Method:HTTPRequestPost Paramenters:nil PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableLeaves error:nil];
        
        
        NSArray *topAdsArr = [[dictionary objectForKey:@"data"] objectForKey:@"topAds"];
        NSArray *typebottomArr = [[dictionary objectForKey:@"data"] objectForKey:@"typeBottomAds"];
#pragma mark -- 轮播图 --
        
            for (NSDictionary *dict in topAdsArr) {
            [self.topTitleArray addObject:[dict objectForKey:@"adsName"]];
            [self.topURLArray addObject:[dict objectForKey:@"adsUrl"]];
            [self.topImgArray addObject:[NSString stringWithFormat:@"%@%@",url,[dict objectForKey:@"adsFile"]]];
                [self.topIDArray addObject:[dict objectForKey:@"adsId"]];
        }
      /**
       轮播图
       */
        [self ShowScrollow];
#pragma mark -- 广告 --
               for (NSDictionary *dic in typebottomArr) {
            [self.botTitleArray addObject:[dic objectForKey:@"adsName"]];
            [self.botURLArray addObject:[dic objectForKey:@"adsUrl"]];
            [self.botImgArray addObject:[NSString stringWithFormat:@"%@%@",url,[dic objectForKey:@"adsFile"]]];
        }
        /**
         广告图
         */
        [self ShowAdsBottom];

    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
#pragma mark -- 列表 --
    /**
     
     */
    NSString *liststr = @"m=Customer&c=Index&a=typeList";    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,liststr] Method:HTTPRequestPost Paramenters:nil PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"];
//

        for (NSDictionary *dic in array) {
            ListCollectModel *model = [ListCollectModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.listArray addObject:model];

        }

        
        [self setList];

        
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
#pragma mark -- 热门 --
    /**
     Hot
     */
    NSString *hotstr = @"m=Customer&c=Index&a=recomGoodsList";
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,hotstr] Method:HTTPRequestPost Paramenters:nil PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"];
        NSString *str = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]objectForKey:@"message"];
        _hotStr = [NSString stringWithFormat:@"%@%@",url,str];
        
        for (NSDictionary *dic in array) {
            HorCollectModel *model = [HorCollectModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.horizontalArray addObject:model];

        }
        [self setHorizontalScroll];
        
        
        
    } Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];
#pragma mark -- 人气 --
    /**
     Popular
     */
    NSString *popularStr = @"m=Customer&c=Index&a=bestGoodsList";
    
    [[AFHTTPClient shareInstance] requestWithPath:[NSString stringWithFormat:@"%@%@",URLSTRING,popularStr]  Method:HTTPRequestPost Paramenters:nil PrepareExecute:^{
        
    } Success:^(NSURLSessionDataTask *task, id responseObject) {
        NSArray *array = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil] objectForKey:@"data"];
        NSString *str = [[NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil]objectForKey:@"message"];
        _PopularStr = [NSString stringWithFormat:@"%@%@",url,str];

        for (NSDictionary *dic in array) {
           
            HomeModel *model = [HomeModel new];
            [model setValuesForKeysWithDictionary:dic];
            [self.collectionArray addObject:model];
        }
        [self setcollection];
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
    }
    Failure:^(NSURLSessionDataTask *task, NSError *error) {
        
    }];

}
#pragma mark - 自定义NVa -
-(void)CostomNav{
    
//        __weak typeof(self) weakself = self;
    self.navigationController.navigationBar.hidden = YES;
    //
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor colorWithHexString:@"cf292e"];
    [self.homeView.navView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.edges.mas_offset(UIEdgeInsetsMake(0, 0, 0, 0));
    }];
    UIImageView *navImg = [UIImageView new];
    navImg.image = IMAGE(@"home_page_words.png");
    CGFloat width1 = navImg.image.size.width;
    CGFloat height1 = navImg.image.size.height;
    
    [view addSubview:navImg];
    [navImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(width1);
        make.height.mas_equalTo(height1);
    }];
     UIButton *navRightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [navRightBtn setImage:[UIImage imageNamed:(@"personal_message.png")] forState:UIControlStateNormal];
    [navRightBtn addTarget:self action:@selector(messageClicked:) forControlEvents:UIControlEventTouchUpInside];
    ;
    [view addSubview:navRightBtn];
    [navRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(view.mas_right).with.offset(-10);
        make.top.equalTo(view.mas_top).with.offset(37);
        make.width.mas_equalTo(@22);
        make.height.mas_equalTo(@22);
    }];
    
    
    
    
}
#pragma mark - CollectionDelegate -
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{

   
    
    if (collectionView.tag == 99999) {
        return 1;
    }else if(collectionView.tag == 88888){
        return 1;
    
    }else{
        return 1;
    }
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (collectionView.tag == 99999) {
        return  self.collectionArray.count;

    }else if(collectionView.tag == 88888){
        return self.horizontalArray.count;
    }else{
        return self.listArray.count;
    }
    
   
}




-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (collectionView.tag == 99999) {
        
        PopularCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PopularCollectionViewCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        HomeModel *model = self.collectionArray[indexPath.item];
        [cell setDataViewModel:model];
        
        return cell;
   
    }else if(collectionView.tag == 88888){
        HorizontalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HorizontalCollectionViewCell" forIndexPath:indexPath];
        HorCollectModel *model = self.horizontalArray[indexPath.item];
        [cell setDataViewModel:model];
        return cell;
    }else{
        ListCVCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"ListCVCell" forIndexPath:indexPath];
        ListCollectModel *model = self.listArray[indexPath.item];
        [cell setDataViewModel:model];
        return cell; 
        
    }
    

}
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //cell的大小
    
    if (collectionView.tag == 99999) {
        return CGSizeMake((screen_width-6)/2, (screen_width-6)/2+50);

    }else if(collectionView.tag == 88888){
        return CGSizeMake((screen_width-30)/2, (screen_width-30)/2);
        return CGSizeMake(170, 170);//(screen_width-6)/2

    }else{
        return CGSizeMake((screen_width-6)/4, (180-2)/2);

//        return CGSizeMake((screen_width-6)/2, (180-2)/2);
    }
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    if (collectionView.tag == 99999) {
        PopularCollectionViewCell *cell = (PopularCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];

        GoodsDetailsController *goods = [GoodsDetailsController new];
        goods.goodsID = cell.goodsID;
        ///翻页
        goods.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        goods.modalPresentationStyle = UIModalPresentationFullScreen;
        
    
        [self presentViewController:goods animated:YES completion:^{
            
        }];
        
    }else if (collectionView.tag == 88888){
        HorizontalCollectionViewCell *cell = (HorizontalCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        
        GoodsDetailsController *goods = [GoodsDetailsController new];
        goods.goodsID = cell.goodsID;
        
        goods.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
        
        goods.modalPresentationStyle = UIModalPresentationFullScreen;
        

        
        [self presentViewController:goods animated:YES completion:^{
            
        }];
        
    }else{
        
        
        
        if (indexPath.item == 7) {
            
            UITabBarController *tabbar = (UITabBarController*)[UIApplication sharedApplication].keyWindow.rootViewController;
            tabbar.selectedIndex = 1;
            
            
        }else{
            
            ListCVCell *cell = (ListCVCell*)[collectionView cellForItemAtIndexPath:indexPath];
            ReclassifyViewController *detailVC = [ReclassifyViewController new];
            detailVC.catsID = cell.catsID;
            
            detailVC.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
            
            detailVC.modalPresentationStyle = UIModalPresentationFullScreen;
            
            [self presentViewController:detailVC animated:YES completion:^{
                
            }];
        }
        
        
        
    }
    
    
    
    
}



#pragma mark -- MemoryWarning
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - 消息按钮事件 -
-(void)messageClicked:(UIButton*)sender{
    [self alertWithMassage:@"你点击了消息按钮"];
    
}




#pragma mark -- SDCycleScrollViewDelegate --
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    /**
     需要接WebView
     */
//    [self alertWithMassage:[NSString stringWithFormat:@"点击了第%lu个图",index]];
    [self jumpToWebViewWith:self.topURLArray[index]];
    
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

#pragma mark - 跳转到WebView -
-(void)jumpToWebViewWith:(NSString*)string{
    
    NSURL *url = [NSURL URLWithString:string];
    
    HomeWebViewController *webViewVC = [HomeWebViewController new];
    webViewVC.urlString = url;
    [self presentViewController:webViewVC animated:YES completion:^{
        
    }];
}




-(NSMutableArray *)topIDArray{
    if (_topIDArray == nil) {
        _topIDArray = [NSMutableArray array];
    }
    return _topIDArray;
}
-(NSMutableArray *)topImgArray{
    if (_topImgArray == nil) {
        _topImgArray = [NSMutableArray array];
    }
    return _topImgArray;
}
-(NSMutableArray *)topURLArray{
    if (_topURLArray == nil) {
        _topURLArray = [NSMutableArray array];
    }
    return _topURLArray;
}


-(NSMutableArray *)topTitleArray{
    if (_topTitleArray == nil) {
        _topTitleArray = [NSMutableArray array];
    }
    return _topTitleArray;
}


-(NSMutableArray *)listArray{
    if (_listArray == nil) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

-(NSMutableArray *)botImgArray{
    if (_botImgArray == nil) {
        _botImgArray = [NSMutableArray array];
    }
    return _botImgArray;
}

-(NSMutableArray *)botTitleArray{
    if (_botTitleArray == nil) {
        _botTitleArray = [NSMutableArray array];
    }
    return _botTitleArray;
}


-(NSMutableArray *)botIDArray{
    if (_botIDArray == nil) {
        _botIDArray = [NSMutableArray array];
    }
    return _botIDArray;
}

-(NSMutableArray *)botURLArray{
    if (_botIDArray == nil) {
        _botIDArray = [NSMutableArray array];
    }
    return _botIDArray;
}


-(UIImageView *)leftImg{
    if (_leftImg == nil) {
        _leftImg =[UIImageView new];
    }
    return _leftImg;
}

-(UIImageView *)rightTopImg{
    if (_rightTopImg == nil) {
        _rightTopImg =[UIImageView new];
    }
    return _rightTopImg;
}

-(UIImageView *)bottomMiddleImg{
    if (_bottomMiddleImg == nil) {
        _bottomMiddleImg =[UIImageView new];
    }
    return _bottomMiddleImg;
}

-(UIImageView *)rightBottomImg{
    if (_rightBottomImg == nil) {
        _rightBottomImg =[UIImageView new];
    }
    return _rightBottomImg;
}


-(NSMutableArray *)horizontalArray
{
    if (_horizontalArray == nil) {
        _horizontalArray = [NSMutableArray array];
    }
    return _horizontalArray;
}



-(NSMutableArray *)collectionArray
{
    if (_collectionArray == nil) {
        _collectionArray = [NSMutableArray array];
    }
    return _collectionArray;
}



-(void)checkIMGCount{
    
    
    
    
    
    
}



@end
