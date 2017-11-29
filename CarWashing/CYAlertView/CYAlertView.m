//
//  CYAlertView.m
//  CarWashing
//
//  Created by apple on 2017/10/30.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYAlertView.h"

@implementation CYAlertView

-(void)showView
{
    self.backView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    self.backView.backgroundColor=[UIColor blackColor];
    self.backView.alpha = 0.5;
    [self addSubview:self.backView];
    self.whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 230*Main_Screen_Height/667, 314*Main_Screen_Height/667)];
    self.whiteView.centerX = self.centerX;
    self.whiteView.centerY = self.centerY;
    [self addSubview:self.whiteView];
    UIImageView * imageVIew=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.whiteView.frame.size.width, self.whiteView.frame.size.height)];
    imageVIew.image = [UIImage imageNamed:@"shouye_tankuang"];
    [self.whiteView addSubview:imageVIew];
    UIImageView * imageVIew1=[[UIImageView alloc]initWithFrame:CGRectMake(65*Main_Screen_Height/667, 20*Main_Screen_Height/667, 90*Main_Screen_Height/667, 90*Main_Screen_Height/667)];
    imageVIew1.image = [UIImage imageNamed:@"shouye_tankuang_tu"];
    [self.whiteView addSubview:imageVIew1];
    
    UILabel * titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 120*Main_Screen_Height/667, self.whiteView.frame.size.width, 30*Main_Screen_Height/667)];
    titlelabel.text = @"欢迎登录蔷薇爱车";
    titlelabel.textColor=[UIColor colorFromHex:@"#ff221d"];
    titlelabel.textAlignment = NSTextAlignmentCenter;
    titlelabel.font=[UIFont systemFontOfSize:15.0*Main_Screen_Height/667];
    [self.whiteView addSubview:titlelabel];
    UILabel * detaillabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 150*Main_Screen_Height/667, self.whiteView.frame.size.width-20, 50*Main_Screen_Height/667)];
    detaillabel.text = @"新用户注册可以领取免费洗车卡,邀请好友加入可以享受更多！";
    detaillabel.numberOfLines=2;
    detaillabel.textColor=[UIColor colorFromHex:@"#3f3f3f"];
    detaillabel.textAlignment = NSTextAlignmentCenter;
    detaillabel.font=[UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [self.whiteView addSubview:detaillabel];
    
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.cancelButton.frame=CGRectMake(20*Main_Screen_Height/667, self.whiteView.frame.size.height-(62*Main_Screen_Height/667), self.whiteView.frame.size.width-(40*Main_Screen_Height/667), 40*Main_Screen_Height/667);
    self.cancelButton.titleLabel.font=[UIFont systemFontOfSize:18.0*Main_Screen_Height/667];
    [self.cancelButton setBackgroundColor:RGBAA(251, 44, 55, 1.0)];
//    [self.cancelButton setBackgroundImage:[UIImage imageNamed:@"shouye_tankuang_anniu"] forState:UIControlStateNormal];
    [self.cancelButton setTitle:@"我知道了" forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:[UIColor colorFromHex:@"#ffffff"] forState:UIControlStateNormal];
    self.cancelButton.layer.cornerRadius = 20*Main_Screen_Height/667;
    self.cancelButton.layer.masksToBounds = YES;
    [self.whiteView addSubview:self.cancelButton];
   
    
    
}

@end
