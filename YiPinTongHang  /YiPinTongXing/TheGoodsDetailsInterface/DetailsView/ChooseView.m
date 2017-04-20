//
//  ChooseView.m
//  YiPinTongXing
//
//  Created by dhz on 2017/3/16.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "ChooseView.h"

@interface ChooseView ()<UIScrollViewDelegate,UIAlertViewDelegate,UITextFieldDelegate,typeSelectedDelegate>

@end

@implementation ChooseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor colorWithHexString:@"#f0f0f0"];
        self.alphaView = [UIView new];
        self.alphaView.backgroundColor = [UIColor blackColor];
        self.alphaView.alpha = 0.8;
        [self addSubview:self.alphaView];
        [self.alphaView mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.top.equalTo(self.mas_top).with.offset(0);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(screen_width, screen_height));
           
        }];
        
        self.whiteView = [UIView new];
        
        self.whiteView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.whiteView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
        [self.whiteView addGestureRecognizer:tap];
        [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_top).with.offset(screen_height*0.35);
            make.left.equalTo(self.mas_left).with.offset(0);
            make.size.mas_equalTo(CGSizeMake(screen_width, screen_height*0.65));
        }];
        
        self.img = [UIImageView new];
//        self.img.image = [UIImage imageNamed:@"star_gray.png"];
        self.img.backgroundColor = [UIColor yellowColor];
        self.img.layer.borderColor = [UIColor whiteColor].CGColor;
        self.img.layer.cornerRadius = 4;
        self.img.layer.borderWidth = 5;
        [self.img.layer setMasksToBounds:YES];
        [self.whiteView addSubview:self.img];
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
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
        
        self.lb_price = [UILabel new];
        self.lb_price.font = [UIFont systemFontOfSize:14.0];
        self.lb_price.textColor = [UIColor redColor];
        [self.whiteView addSubview:self.lb_price];
        [self.lb_price mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.whiteView.mas_top).with.offset(10);
            make.left.equalTo(self.img.mas_right).with.offset(20);
            make.size.mas_equalTo(CGSizeMake(100 , 20));
        }];
        
        self.lb_stock = [UILabel new];
        self.lb_stock.font = [UIFont systemFontOfSize:14.0];
        [self.whiteView addSubview:self.lb_stock];
        [self.lb_stock mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lb_price.mas_bottom).with.offset(10);
            make.left.equalTo(self.img.mas_right).with.offset(20);
            make.size.mas_equalTo(CGSizeMake(120 , 20));
        }];
        self.lb_detail = [UILabel new];
        self.lb_detail.font = [UIFont systemFontOfSize:14.0];
        self.lb_detail.numberOfLines = 2;
        self.lb_detail.textColor = [UIColor blackColor];
        [self.whiteView addSubview:self.lb_detail];
        [self.lb_detail mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lb_stock.mas_bottom).with.offset(0);
            make.left.equalTo(self.img.mas_right).with.offset(20);
            make.right.equalTo(self.whiteView.mas_right).with.offset(-10);
            make.height.mas_equalTo(40);
        }];
        self.lb_line = [UILabel new];
        self.lb_line.backgroundColor = [UIColor lightGrayColor];
        [self.whiteView addSubview:self.lb_line];
        [self.lb_line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.img.mas_bottom).with.offset(20);
            make.left.equalTo(self.whiteView.mas_left).with.offset(0);
            make.right.equalTo(self.whiteView.mas_right).with.offset(0);
            make.height.mas_equalTo(@0.5);
        }];
        
        
        self.bt_sure =[UIButton buttonWithType:UIButtonTypeCustom];
        [self.bt_sure setBackgroundColor:[UIColor redColor]];
        [self.bt_sure setTitle:@"确定" forState:UIControlStateNormal];
        self.bt_sure.titleLabel.font = [UIFont systemFontOfSize:20];
        [self.whiteView addSubview:self.bt_sure];
        [self.bt_sure mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.whiteView.mas_bottom).with.offset(0);
            make.left.equalTo(self.whiteView.mas_left).with.offset(0);
            make.right.equalTo(self.whiteView.mas_right).with.offset(0);
            make.height.mas_equalTo(@50);
        }];
        
        self.mainscrollView = [[UIScrollView alloc]init];
        self.mainscrollView.showsVerticalScrollIndicator = NO;
        self.mainscrollView.showsHorizontalScrollIndicator = NO;
        [self.whiteView addSubview:self.mainscrollView];
        [self.mainscrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.lb_line.mas_bottom).with.offset(0);
            make.left.equalTo(self.whiteView.mas_left).with.offset(0);
            make.right.equalTo(self.whiteView.mas_right).with.offset(0);
            make.bottom.equalTo(self.bt_sure.mas_top).with.offset(0);
        }];
        
        self.countView = [BuyCountView new];
        [self.mainscrollView addSubview:self.countView];
        self.countView.frame = rect(0, 0, screen_width, 50);
        [self.countView.bt_add addTarget:self action:@selector(bt_add) forControlEvents:UIControlEventTouchUpInside];
        self.countView.tf_count.delegate = self;
        [self.countView.bt_reduce addTarget:self action:@selector(bt_reduce) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}


-(void)initTypeViewSizeArray:(NSArray *)sizeArray ColorArray:(NSArray *)colorArray dictionary :(NSDictionary *)stockDic sizeName:(NSString*)sizeName colorName:(NSString*)colorName Stock:(NSString*)stock
{
    
    self.sizeArray = sizeArray;
    self.colorArray = colorArray;
    self.stockDic = stockDic;
    
    self.sizeView = [[TypeView alloc] initWithFrame:rect(0, 0, screen_width, 50) andDataSources:self.sizeArray String:sizeName];
    
    self.sizeView.delegate  = self;
    [self.mainscrollView addSubview:self.sizeView];
    self.sizeView.frame = rect(0, 0, screen_width, self.sizeView.height);

    self.colorView = [[TypeView alloc]initWithFrame:rect(0, self.sizeView.height, screen_width, 50) andDataSources:self.colorArray String:colorName];
    self.colorView.delegate = self;
    [self.mainscrollView addSubview:self.colorView];
    self.colorView.frame = rect(0, self.sizeView.height, screen_width, self.colorView.height);
    
    self.countView.frame = rect(0, self.colorView.height + self.colorView.y, screen_width, 50);
    self.mainscrollView.contentSize = CGSizeMake(screen_width, self.countView.height+self.countView.y);
    
    
    
//    self.lb_price.text = @"¥100";
    self.lb_stock.text = [NSString stringWithFormat:@"库存量%@件",stock];
    self.stock = [stock intValue];
    self.lb_detail.text = @"请选择 尺码 颜色分类";
    
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showBigImage:)];
    self.img.userInteractionEnabled = YES;
    [self.img addGestureRecognizer:tap1];
    
    
}


-(void)showBigImage:(UITapGestureRecognizer*)sender{
    
    UIImageView *img = (UIImageView*)sender.view;
    
    [PJImgaeBrowser showImage:img];
}


-(void)btnIndex:(int)tag
{
    
    if (self.sizeView.selectIndex >=0&&self.colorView.selectIndex >=0) {
        //尺码和颜色都选择的时候
        NSString *size =[self.sizeArray objectAtIndex:self.sizeView.selectIndex];
        NSString *color =[self.colorArray objectAtIndex:self.colorView.selectIndex];
        self.lb_stock.text = [NSString stringWithFormat:@"库存%@件",[[self.stockDic objectForKey: size] objectForKey:color]];
        self.lb_detail.text = [NSString stringWithFormat:@"已选 \"%@\" \"%@\"",size,color];
        self.stock =[[[self.stockDic objectForKey: size] objectForKey:color] intValue];
        
        [self reloadTypeBtn:[self.stockDic objectForKey:size] :self.colorArray :self.colorView];
        [self reloadTypeBtn:[self.stockDic objectForKey:color] :self.sizeArray :self.sizeView];
        
        
        self.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",self.colorView.selectIndex+1]];
    }else if (self.sizeView.selectIndex ==-1&&self.colorView.selectIndex == -1)
    {
        //尺码和颜色都没选的时候
//        self.lb_price.text = @"¥100";
        self.lb_stock.text = @"库存100000件";
        self.lb_detail.text = @"请选择 尺码 颜色分类";
        self.stock = 100000;
        //全部恢复可点击状态
        [self resumeBtn:self.colorArray :self.colorView];
        [self resumeBtn:self.sizeArray :self.sizeView];
        
    }else if (self.sizeView.selectIndex ==-1&&self.colorView.selectIndex >= 0)
    {
        //只选了颜色
        NSString *color =[self.colorArray objectAtIndex:self.colorView.selectIndex];
        //根据所选颜色 取出该颜色对应所有尺码的库存字典
        NSDictionary *dic = [self.stockDic objectForKey:color];
        [self reloadTypeBtn:dic :self.sizeArray :self.sizeView];
        [self resumeBtn:self.colorArray :self.colorView];
        self.lb_stock.text = @"库存100000件";
        self.lb_detail.text = @"请选择 尺码";
        self.stock = 100000;
        
        self.img.image = [UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",self.colorView.selectIndex+1]];
    }else if (self.sizeView.selectIndex >= 0&&self.colorView.selectIndex == -1)
    {
        //只选了尺码
        NSString *size =[self.sizeArray objectAtIndex:self.sizeView.selectIndex];
        //根据所选尺码 取出该尺码对应所有颜色的库存字典
        NSDictionary *dic = [self.stockDic objectForKey:size];
        [self resumeBtn:self.sizeArray :self.sizeView];
        [self reloadTypeBtn:dic :self.colorArray :self.colorView];
        self.lb_stock.text = @"库存100000件";
        self.lb_detail.text = @"请选择 颜色分类";
        self.stock = 100000;
        
    }
    
}


//恢复按钮的原始状态
-(void)resumeBtn:(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i< arr.count; i++) {
        UIButton *btn =(UIButton *) [view viewWithTag:100+i];
        btn.enabled = YES;
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        [btn setTitleColor:[UIColor blackColor] forState:0];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        if (view.selectIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
}
//根据所选的尺码或者颜色对应库存量 确定哪些按钮不可选
-(void)reloadTypeBtn:(NSDictionary *)dic :(NSArray *)arr :(TypeView *)view
{
    for (int i = 0; i<arr.count; i++) {
        int count = [[dic objectForKey:[arr objectAtIndex:i]] intValue];
        UIButton *btn =(UIButton *)[view viewWithTag:100+i];
        btn.selected = NO;
        [btn setBackgroundColor:[UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]];
        //库存为零 不可点击
        if (count == 0) {
            btn.enabled = NO;
            [btn setTitleColor:[UIColor lightGrayColor] forState:0];
        }else
        {
            btn.enabled = YES;
            [btn setTitleColor:[UIColor blackColor] forState:0];
        }
        //根据seletIndex 确定用户当前点了那个按钮
        if (view.selectIndex == i) {
            btn.selected = YES;
            [btn setBackgroundColor:[UIColor redColor]];
        }
    }
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
        [self tap];
    }
    
}


-(void)bt_reduce{
    int count = [self.countView.tf_count.text intValue];
    if (count > 1) {
        self.countView.tf_count.text = [NSString stringWithFormat:@"%d",count - 1];
    }else{
        
    }
}



-(void)tap{
   
    self.mainscrollView.contentOffset = CGPointMake(0, 0);
    [self.countView.tf_count resignFirstResponder];
}

@end
