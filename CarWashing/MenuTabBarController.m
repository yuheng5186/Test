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

#import "LoginViewController.h"
#import "DSScanController.h"
#import "UdStorage.h"
#import "DSStartWashingController.h"

#import "MyViewController.h"
@interface MenuTabBarController ()

@property (nonatomic, strong)     UIImageView *imageView;

@end

@implementation MenuTabBarController


- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear:animated];
    
    UIImage *centerImage = [UIImage imageNamed:@"xiche"];
    
    [self addCenterButtonWithImage:centerImage highlightImage: nil];
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createNavigationControllers];
    


    BOOL firstRun = [[[NSUserDefaults standardUserDefaults]valueForKey:@"firstRun"] boolValue];

    if (!firstRun) {
        [self addGuideView];

        [[NSUserDefaults standardUserDefaults]setValue:@YES forKey:@"firstRun"];
        [[NSUserDefaults standardUserDefaults]synchronize];
    }
}

- (void)addGuideView {
    NSString *imageName = @"qw";
    
    UIImage *image = [UIImage imageNamed:imageName];
    self.imageView = [[UIImageView alloc] initWithImage:image];
    self.imageView.frame = self.view.bounds;
    self.imageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissGuideView)];
    [self.imageView addGestureRecognizer:tap];
    
    [self.view addSubview:self.imageView];
}
- (void) dismissGuideView{
    
    [self.imageView removeFromSuperview];
}


//- (void) viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear: animated];
//    
//    LoginViewController *loginController    = [[LoginViewController alloc]init];
//    UINavigationController *navController   = [[UINavigationController alloc]initWithRootViewController:loginController];
//    navController.navigationBar.hidden      = YES;
//    
//    [self presentViewController:navController animated:YES completion:nil];
//    
//}
- (void) createNavigationControllers
{
    
    
    HomeViewController *homeVC      = [[HomeViewController alloc]init];
    UINavigationController *homeNav = [[UINavigationController alloc]initWithRootViewController:homeVC];
    homeNav.navigationController.navigationBarHidden = YES;
    UITabBarItem *homeTabItem       = [[UITabBarItem alloc]initWithTitle:@"首页" image:[UIImage imageNamed:@"shouye"] selectedImage:[UIImage imageNamed:@"shouye1"]];
    homeTabItem.tag     = 1;
    homeVC.tabBarItem   = homeTabItem;
    
    BusinessViewController *businessVC      = [[BusinessViewController alloc]init];
    UINavigationController *businessNav = [[UINavigationController alloc]initWithRootViewController:businessVC];
    businessNav.navigationController.navigationBarHidden = YES;
    UITabBarItem *businessTabItem       = [[UITabBarItem alloc]initWithTitle:@"商家" image:[UIImage imageNamed:@"shangjia"] selectedImage:[UIImage imageNamed:@"shangjia1"]];
    businessTabItem.tag     = 2;
    businessVC.tabBarItem   = businessTabItem;
    
    
    //洗车模块
    DSScanController *activityVC      = [[DSScanController alloc]init];
    UINavigationController *activityNav = [[UINavigationController alloc]initWithRootViewController:activityVC];
    activityNav.navigationController.navigationBarHidden = YES;
    UITabBarItem *activityTabItem       = [[UITabBarItem alloc]initWithTitle:@"洗车" image:[UIImage imageNamed:@"wode"] selectedImage:[UIImage imageNamed:@"wode"]];
    activityTabItem.tag     = 3;
    activityVC.tabBarItem   = activityTabItem;
    
    PurchaseViewController *purchaseVC      = [[PurchaseViewController alloc]init];
    UINavigationController *purchaseNav = [[UINavigationController alloc]initWithRootViewController:purchaseVC];
    purchaseNav.navigationController.navigationBarHidden = YES;
    UITabBarItem *purchaseTabItem       = [[UITabBarItem alloc]initWithTitle:@"购卡" image:[UIImage imageNamed:@"gouka"] selectedImage:[UIImage imageNamed:@"gouka1"]];
    purchaseTabItem.tag     = 4;
    purchaseVC.tabBarItem   = purchaseTabItem;
    
    MyViewController *mySettingVC      = [[MyViewController alloc]init];
    UINavigationController *mySettingNav = [[UINavigationController alloc]initWithRootViewController:mySettingVC];
    mySettingNav.navigationController.navigationBarHidden = YES;
//    mySettingNav.navigationBar.hidden    = YES;
    UITabBarItem *mySettingTabItem       = [[UITabBarItem alloc]initWithTitle:@"我的" image:[UIImage imageNamed:@"wode"] selectedImage:[UIImage imageNamed:@"wode1"]];
    mySettingTabItem.tag     = 5;
    mySettingVC.tabBarItem   = mySettingTabItem;
    
    
    self.viewControllers     = @[homeNav,businessNav,activityNav,purchaseNav,mySettingNav];
    
    //    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake (0, 0, Main_Screen_Width, 49)];
    //    backView.backgroundColor = [UIColor colorWithHex:0x111112 alpha:1.0];
    //    [self.tabBar insertSubview:backView atIndex:0];
    //    self.tabBar.opaque = YES;
    
}

-(void) addCenterButtonWithImage:(UIImage*)buttonImage highlightImage:(UIImage*)highlightImage
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    //button.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    button.frame = CGRectMake(0.0, 0.0, 60, 60);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImage forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(didSelectRouterAction) forControlEvents:UIControlEventTouchUpInside];
    button.centerX = Main_Screen_Width/2;
    button.centerY = 5;
    [self.tabBar addSubview:button];
}
- (void)didSelectRouterAction {
    
    
    self.selectedViewController = self.viewControllers[2];
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    NSString    *stringTime     = [defaults objectForKey:@"setTime"];
    
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *overdate = [dateFormatter dateFromString:stringTime];
    NSTimeZone *zone1 = [NSTimeZone systemTimeZone];
    NSInteger interva1 = [zone1 secondsFromGMTForDate: overdate];
    NSDate*endDate = [overdate dateByAddingTimeInterval: interva1];
    
    //获取当前时间
    NSDate*date = [NSDate date];
    NSTimeZone*zone2 = [NSTimeZone systemTimeZone];
    NSInteger interva2 = [zone2 secondsFromGMTForDate: date];
    NSDate *currentDate = [date dateByAddingTimeInterval: interva2];
    
    NSInteger intString;
    NSTimeInterval interval =[endDate timeIntervalSinceDate:currentDate];
    NSInteger gotime = round(interval);
    NSString *str2 = [[NSString stringWithFormat:@"%ld",(long)gotime] stringByReplacingOccurrencesOfString:@"-" withString:@""];
    intString = [str2 intValue];
    
    if (intString > 0 && intString < 240) {
        
        DSStartWashingController *start = [[DSStartWashingController alloc]init];
        //        [UdStorage storageObject:dateString forKey:@"setTime"];
        
        start.paynum=[UdStorage getObjectforKey:@"Jprice"];
        start.RemainCount = [UdStorage getObjectforKey:@"RemainCount"];
        start.IntegralNum = [UdStorage getObjectforKey:@"IntegralNum"];
        start.CardType = [UdStorage getObjectforKey:@"CardType"];
        start.CardName =[UdStorage getObjectforKey:@"CardName"];
        //        start.second        = 240;
        start.hidesBottomBarWhenPushed            = YES;
        start.second                    = 240-intString;
        
        [self.navigationController pushViewController:start animated:YES];
        //        [_session stopRunning];
        
    }else {
        self.tabBarController.selectedIndex = 2;
//
       
        //
        //
        [self.navigationController popToRootViewControllerAnimated:YES];
        
        
    }
   
}

//- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{//每次点击都会执行的方法
//    if ([tabBarController.viewControllers indexOfObject:viewController] == 2) {
//        
//        
//    }
//    return YES;
//    
//}

@end
