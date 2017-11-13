//
//  CareRemindViewController.h
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/10.
//  Copyright © 2017年 DS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CareRemindViewController : UIViewController
@property(strong,nonatomic)UIView *fakeNavigation;
@property(strong,nonatomic)UIView *addView;
@property(strong,nonatomic)UIView *afterView;
//afterView中的属性
@property(strong,nonatomic)UILabel *carNoLabel;
@property(strong,nonatomic)UILabel *carCareTimeLabel;
@end
