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
#import "DSGuideViewController.h"
#import "UdStorage.h"
#import "HTTPDefine.h"

#import "WXApi.h"
//地图
#import <AMapFoundationKit/AMapFoundationKit.h>
#import "APIKey.h"
//支付
#import <AlipaySDK/AlipaySDK.h>
@interface AppDelegate ()<UITabBarDelegate>
{
    AppDelegate *myDelegate;
}
@property (nonatomic, strong) MenuTabBarController *menuTabBarController;
@end
//2017082308341476支付宝appid
//支付宝公钥 MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2dYOFRhBEb+XSAQq17rAKI3WebLIgmMZ352/nFTF2f5e8xkeVfmRm0qehNRRAtKMHJXEyjE27RMXhy53y+jSd4ZLaYVrm1RYYB0PbIH+0kC+NZqlhiZ+s8KQr6UZh37OCB+RcuNnsoybcTzhcuMkQbf2OkNzdBGGHv90XpW0YNXiSv/KblD/DsFoaR9Qb9olwYl5lGNfdKoNbhyfhTwD0vTTQB3Ojm2PSJcmjOzsmet5gps7E7DSWqIE5ApE5XgTkPHLzdT37B4I18Ed/Pip0Ye9sCXlVQ/Ok2gBGYcXWHg8Hv8D1DLvDM1F90NgQ9Q9vCWq+4pvASJFJe3sLVak9QIDAQAB
@implementation AppDelegate
#pragma mark ----地图相关
- (void)configureAPIKey
{
    if ([APIKey length] == 0)
    {
        NSString *reason = [NSString stringWithFormat:@"apiKey为空，请检查key是否正确设置。"];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:reason delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        
        [alert show];
    }
    
    [AMapServices sharedServices].apiKey = (NSString *)APIKey;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    myDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    
    
    if(Main_Screen_Height > 568)
    {
        myDelegate.autoSizeScaleX = Main_Screen_Width/375;
        myDelegate.autoSizeScaleY = Main_Screen_Height/667;
    }
    else
    {
        myDelegate.autoSizeScaleX = Main_Screen_Width/375;
        myDelegate.autoSizeScaleY = Main_Screen_Height/667;
    }
    
    [IQKeyboardManager sharedManager].enable = YES;
    [AMapServices sharedServices].apiKey = @"f6d2c4b2f6bbe466b2d1b1889783445e";
    
//    application.statusBarHidden                     = NO;
    [[UITabBar appearance] setBarTintColor: [UIColor whiteColor]];
    [[UITabBar appearance] setTintColor: [UIColor colorFromHex:@"#0161a1"]];
    
//    application.statusBarStyle                      = UIStatusBarStyleLightContent;
    application.applicationIconBadgeNumber          = 0;
    
    self.window									= [[UIWindow alloc] initWithFrame: UIScreen.mainScreen.bounds];
    
    

    
    
    
    
    
    if([UdStorage getObjectforKey:Userid])
    {
        
        
        APPDELEGATE.currentUser = [[User alloc]init];
        
        APPDELEGATE.currentUser.Account_Id = [[UdStorage getObjectforKey:Userid] integerValue];
        APPDELEGATE.currentUser.Level_id = [[UdStorage getObjectforKey:@"Level_id"] integerValue];
        APPDELEGATE.currentUser.UserScore = [[UdStorage getObjectforKey:@"UserScore"] integerValue];
        APPDELEGATE.currentUser.ModifyType = [[UdStorage getObjectforKey:@"ModifyType"] integerValue];
        APPDELEGATE.currentUser.VerCode = [[UdStorage getObjectforKey:@"VerCode"] integerValue];
        APPDELEGATE.currentUser.userName = [UdStorage getObjectforKey:@"Name"];
        APPDELEGATE.currentUser.Accountname = [UdStorage getObjectforKey:@"UserName"];
        APPDELEGATE.currentUser.userImagePath = [UdStorage getObjectforKey:@"Headimg"];
        APPDELEGATE.currentUser.userPhone = [UdStorage getObjectforKey:@"Mobile"];
        APPDELEGATE.currentUser.userSex = [UdStorage getObjectforKey:@"Sex"];
        APPDELEGATE.currentUser.userAge = [UdStorage getObjectforKey:@"Age"];
        APPDELEGATE.currentUser.userhobby = [UdStorage getObjectforKey:@"Hobby"];
        APPDELEGATE.currentUser.usermemo = [UdStorage getObjectforKey:@"Memo"];
        APPDELEGATE.currentUser.useroccupation = [UdStorage getObjectforKey:@"Occupation"];
        
        
        MenuTabBarController *menuTabBarController              = [[MenuTabBarController alloc] init];
       
        self.window.rootViewController  = menuTabBarController;
        
    }
    
    else{
        LoginViewController *loginControl = [[LoginViewController alloc]init];
        UINavigationController *nav         = [[UINavigationController alloc]initWithRootViewController:loginControl];
        self.window.rootViewController      = nav;
        nav.navigationBar.hidden      = YES;
    }
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        // 这里判断是否第一次
        DSGuideViewController *guideControl = [[DSGuideViewController alloc]init];
        UINavigationController *nav         = [[UINavigationController alloc]initWithRootViewController:guideControl];//为假表示没有文件，没有进入过主页
        self.window.rootViewController      = nav;
        nav.navigationBar.hidden      = YES;
    }

    
    
    NSUserDefaults *defaults    = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"" forKey:@"setTime"];
    [defaults synchronize];
    
//    LoginViewController *loginControl = [[LoginViewController alloc]init];
//    UINavigationController *nav         = [[UINavigationController alloc]initWithRootViewController:loginControl];
//    nav.navigationBar.hidden      = YES;
//
//    self.window.rootViewController      = nav;
   
    
//    MenuTabBarController *menuTabBarController	= [[MenuTabBarController alloc] init];
//    self.window.rootViewController				= menuTabBarController;
    [WXApi registerApp:@"wx36260a82ad0e51bb"];      //公司

     [self configureAPIKey];

//友盟统计
    [MobClick setLogEnabled:YES];
    UMConfigInstance.appKey = @"5a17af22f29d98598500034a";
    UMConfigInstance.channelId = @"AppStore";
    [MobClick startWithConfigure:UMConfigInstance];
    [MobClick event:@"addHomeClickID"];
    
    return YES;
}

+ (AppDelegate *)sharedInstance {
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    
    return [WXApi handleOpenURL:url delegate:self];
}

#pragma mark ----支付宝相关
- (BOOL) application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result == %@",resultDic);
            /**        * 状态码        * 9000 订单支付成功        * 8000 正在处理中        * 4000 订单支付失败        * 6001 用户中途取消        * 6002 网络连接出错        */
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                //                [self aliPayReslut];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayresultSuccess" object:nil];
            }else if ([resultDic[@"resultStatus"]isEqualToString:@"4000"]){
                [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayresultfail" object:nil];
                
            }else if ([resultDic[@"resultStatus"]isEqualToString:@"6001"]){
                [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayresultCancel" object:nil];
                //                [self.view showInfo:@"订单支付已取消" autoHidden:YES interval:2];
            }
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result === %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    [WXApi handleOpenURL:url delegate:self];
    return YES;
}
// NOTE: 9.0以后使用新API接口
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
//{
//    if ([url.host isEqualToString:@"safepay"]) {
//        // 支付跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//        }];
//
//        // 授权跳转支付宝钱包进行支付，处理支付结果
//        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
//            NSLog(@"result = %@",resultDic);
//            // 解析 auth code
//            NSString *result = resultDic[@"result"];
//            NSString *authCode = nil;
//            if (result.length>0) {
//                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
//                for (NSString *subResult in resultArr) {
//                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
//                        authCode = [subResult substringFromIndex:10];
//                        break;
//                    }
//                }
//            }
//            NSLog(@"授权结果 authCode = %@", authCode?:@"");
//        }];
//    }
//    [WXApi handleOpenURL:url delegate:self];
//    return YES;
//
//}
// NOTE: 9.0以后使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    
    if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"]){
        
        return [WXApi handleOpenURL:url delegate:self];
    }
    if ([url.host isEqualToString:@"safepay"]) {
        // 支付跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result == %@",resultDic);
             /**        * 状态码        * 9000 订单支付成功        * 8000 正在处理中        * 4000 订单支付失败        * 6001 用户中途取消        * 6002 网络连接出错        */
            if ([resultDic[@"resultStatus"] isEqualToString:@"9000"]) {
                //                [self aliPayReslut];
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayresultSuccess" object:nil];
            }else if ([resultDic[@"resultStatus"]isEqualToString:@"4000"]){
                [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayresultfail" object:nil];
                
            }else if ([resultDic[@"resultStatus"]isEqualToString:@"6001"]){
                 [[NSNotificationCenter defaultCenter]postNotificationName:@"alipayresultCancel" object:nil];
//                [self.view showInfo:@"订单支付已取消" autoHidden:YES interval:2];
            }
           
        }];
        
        // 授权跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processAuth_V2Result:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result ==== %@",resultDic);
            // 解析 auth code
            NSString *result = resultDic[@"result"];
            NSString *authCode = nil;
            if (result.length>0) {
                NSArray *resultArr = [result componentsSeparatedByString:@"&"];
                for (NSString *subResult in resultArr) {
                    if (subResult.length > 10 && [subResult hasPrefix:@"auth_code="]) {
                        authCode = [subResult substringFromIndex:10];
                        break;
                    }
                }
            }
            NSLog(@"授权结果 authCode = %@", authCode?:@"");
        }];
    }
    [WXApi handleOpenURL:url delegate:self];

    return YES;
    
    
    
}

#pragma mark ----微信支付回调
- (void)onResp:(BaseResp *)resp
{
    NSString *payResoult = [NSString stringWithFormat:@"%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        if([payResoult isEqualToString:@"0"])
        {
            NSNotification * notice = [NSNotification notificationWithName:@"paysuccess" object:nil userInfo:nil];
            [[NSNotificationCenter defaultCenter]postNotification:notice];
//            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"支付结果：成功！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
//            
//            [alertview show];
            
        }
        else if([payResoult isEqualToString:@"-1"])
        {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"支付失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertview show];
        }
        else if([payResoult isEqualToString:@"-2"])
        {
//            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"用户已经退出支付！" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
              UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"取消支付" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertview show];
        }
        else
        {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"支付失败" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertview show];
        }
        
    }
    
    else if([resp isKindOfClass:[SendMessageToWXResp class]]){
        
        
        
        if([payResoult isEqualToString:@"0"])
        {
            
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:@"分享成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertview show];
        }else if([payResoult isEqualToString:@"-2"])
        {
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:@"分享已取消" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertview show];
        }
        else
        {
            
            UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:@"" message:@"分享成功" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            [alertview show];
            
        }
        
    }
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
