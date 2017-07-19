//
//  MenuTabBarController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MenuTabBarController.h"

#import "HomeViewController.h"
#import "BusinessViewController.h"
#import "FindViewController.h"
#import "PurchaseViewController.h"
#import "MySettingViewController.h"

@interface MenuTabBarController ()

@end

@implementation MenuTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavigationControllers];
}


- (void) createNavigationControllers
{
    HomeViewController *homeVC      = [[HomeViewController alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
//    homeNav.navigationController.navigationBarHidden = YES;
    UITabBarItem *homeTabItem       = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"homeA"] selectedImage:[UIImage imageNamed:@"homeL"]];
    homeTabItem.tag     = 1;
    homeVC.tabBarItem   = homeTabItem;
    
    BusinessViewController *businessVC      = [[BusinessViewController alloc]init];
    UINavigationController *businessNav = [[UINavigationController alloc]initWithRootViewController:businessVC];
//    businessNav.navigationController.navigationBarHidden = YES;
    UITabBarItem *businessTabItem       = [[UITabBarItem alloc]initWithTitle:@"商家" image:[UIImage imageNamed:@"shopA"] selectedImage:[UIImage imageNamed:@"shopL"]];
    businessTabItem.tag     = 2;
    businessVC.tabBarItem   = businessTabItem;
    
    FindViewController *activityVC      = [[FindViewController alloc]init];
    UINavigationController *activityNav = [[UINavigationController alloc]initWithRootViewController:activityVC];
//    activityNav.navigationController.navigationBarHidden = YES;
    UITabBarItem *activityTabItem       = [[UITabBarItem alloc]initWithTitle:@"发现" image:[UIImage imageNamed:@"reportA"] selectedImage:[UIImage imageNamed:@"reportL"]];
    activityTabItem.tag     = 3;
    activityVC.tabBarItem   = activityTabItem;
    
    PurchaseViewController *purchaseVC      = [[PurchaseViewController alloc]init];
    UINavigationController *purchaseNav = [[UINavigationController alloc]initWithRootViewController:purchaseVC];
    purchaseNav.navigationController.navigationBarHidden = YES;
    UITabBarItem *purchaseTabItem       = [[UITabBarItem alloc]initWithTitle:@"社区" image:[UIImage imageNamed:@"messageA"] selectedImage:[UIImage imageNamed:@"messageL"]];
    purchaseTabItem.tag     = 4;
    purchaseVC.tabBarItem   = purchaseTabItem;
    
    MySettingViewController *mySettingVC      = [[MySettingViewController alloc]init];
    UINavigationController *mySettingNav = [[UINavigationController alloc]initWithRootViewController:mySettingVC];
//    mySettingNav.navigationController.navigationBarHidden = YES;
//    mySettingNav.navigationBar.hidden    = YES;
    UITabBarItem *mySettingTabItem       = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"BarItemNormal1"] selectedImage:[UIImage imageNamed:@"BarItemSelected1"]];
    mySettingTabItem.tag     = 5;
    mySettingVC.tabBarItem   = mySettingTabItem;
    
    
    self.viewControllers     = @[homeNav,businessNav,activityNav,purchaseNav,mySettingNav];
    
    //    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake (0, 0, Main_Screen_Width, 49)];
    //    backView.backgroundColor = [UIColor colorWithHex:0x111112 alpha:1.0];
    //    [self.tabBar insertSubview:backView atIndex:0];
    //    self.tabBar.opaque = YES;
    
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
