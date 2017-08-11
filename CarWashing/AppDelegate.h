//
//  AppDelegate.h
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/18.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXApi.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,WXApiDelegate>

@property (strong, nonatomic) UIWindow *window;


+ (AppDelegate *) sharedInstance;


@end

