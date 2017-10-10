//
//  MapViewController.m
//  CarWashing
//
//  Created by apple on 2017/10/10.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
- (void) drawContent {
    
    self.statusView.hidden      = YES;
    
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
   
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.contentView.backgroundColor= [UIColor colorFromHex:@"f6f6f6"];
    UIView *titleView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, 64) color:[UIColor clearColor]];
    titleView.top                      = 0;
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 8, 70, 64);
    [rightBtn setImage:[UIImage imageNamed:@"ditu_fanhui"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:rightBtn];
}
-(void)rightBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}


@end
