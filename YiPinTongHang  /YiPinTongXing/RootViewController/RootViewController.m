//
//  RootViewController.m
//  YiPinTongXing
//
//  Created by dhz on 2017/2/7.
//  Copyright © 2017年 pengjie_liu. All rights reserved.
//

#import "RootViewController.h"
#import "HomeViewController.h"
#import "ListViewController.h"
#import "ShoppingViewController.h"
#import "PersonalViewController.h"
@interface RootViewController ()

@property(nonatomic,strong)HomeViewController *homeVC;
@property(nonatomic,strong)ShoppingViewController *shopVC;
@property(nonatomic,strong)ListViewController *listVC;
@property(nonatomic,strong)PersonalViewController *perVC;



@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setControllers];
    
}


-(void)setControllers{
    
    
    
    self.homeVC = [[HomeViewController alloc]init];
    UINavigationController *homeNC = [[UINavigationController alloc]initWithRootViewController:self.homeVC];
    
    [self.homeVC getData];
    
    

    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithHexString:@"#cf292e"]];// #cf292e  #e11010
 
    
    
    homeNC.navigationBar.titleTextAttributes = [self setTextColor];
    
    
    
    self.listVC = [[ListViewController alloc]init];
    UINavigationController *listNC = [[UINavigationController alloc]initWithRootViewController:self.listVC];
    [self.listVC getData];
    
    
    
    self.shopVC = [[ShoppingViewController alloc]init];
    UINavigationController *shopNC = [[UINavigationController alloc]initWithRootViewController:self.shopVC];

    
    self.perVC = [[PersonalViewController alloc]init];
    UINavigationController *perNC = [[UINavigationController alloc]initWithRootViewController:self.perVC];

    [self.perVC requestDataForAboutOurs];
    [self.perVC requestDataForPhone];
    self.viewControllers = @[homeNC,listNC,shopNC,perNC];
    
    
    homeNC.tabBarItem.title = @"首页";
    homeNC.tabBarItem.image = [UIImage imageNamed:@"tab_bar_home_page_unchecked.png"];
    homeNC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_bar_home_page_selected.png"];
    
    listNC.tabBarItem.title = @"分类";
    listNC.tabBarItem.image = [UIImage imageNamed:@"tab_bar_classification_unchecked.png"];
    listNC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_bar_classification_selected.png"];
    
    
    shopNC.tabBarItem.title = @"购物车";
    shopNC.tabBarItem.image = [UIImage imageNamed:@"tab_bar_shopping_cart_unchecked.png"];
    shopNC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_bar_shopping_cart_selected.png"];
    
    
    perNC.tabBarItem.title = @"个人中心";
    perNC.tabBarItem.image = [UIImage imageNamed:@"tab_bar_personal_unchecked.png"];
    perNC.tabBarItem.selectedImage = [UIImage imageNamed:@"tab_bar_personal_selected.png"];
    
    
    
    self.tabBar.tintColor = [UIColor colorWithHexString:@"#cf292e"];//#cf292e
    

    
    
    
}

-(NSDictionary*)setTextColor{
    //        NSDictionary *dic = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:UITextAttributeTextColor];
    
    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
    
    
    return dict;
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
