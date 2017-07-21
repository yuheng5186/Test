//
//  DSSaleActivityController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSSaleActivityController.h"

@interface DSSaleActivityController ()

@end

@implementation DSSaleActivityController

- (void)drawNavigation {
    
    [self drawTitle:@"优惠活动" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
