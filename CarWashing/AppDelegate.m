//
//  AppDelegate.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/18.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "AppDelegate.h"
#import "MenuTabBarController.h"
#import "LoginViewController.h"
#import "IQKeyboardManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.

    [IQKeyboardManager sharedManager].enable = YES;
    [AMapServices sharedServices].apiKey = @"f6d2c4b2f6bbe466b2d1b1889783445e";
    
    application.statusBarHidden                     = NO;
    [[UITabBar appearance] setBarTintColor: [UIColor whiteColor]];
    [[UITabBar appearance] setTintColor: [UIColor colorFromHex:@"#293754"]];
    
    application.statusBarStyle                      = UIStatusBarStyleLightContent;
    application.applicationIconBadgeNumber          = 0;
    
    self.window									= [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];

    
    LoginViewController *loginControl = [[LoginViewController alloc]init];
    UINavigationController *nav         = [[UINavigationController alloc]initWithRootViewController:loginControl];
    nav.navigationBar.hidden      = YES;

    self.window.rootViewController      = nav;
   
    
//    MenuTabBarController *menuTabBarController	= [[MenuTabBarController alloc] init];
//    self.window.rootViewController				= menuTabBarController;
    [WXApi registerApp:@"wxcb207ec4f5991a99"];

    return YES;
}

+ (AppDelegate *)sharedInstance {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    
    return [WXApi handleOpenURL:url delegate:self];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
