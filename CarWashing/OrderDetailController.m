//
//  OrderDetailController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "OrderDetailController.h"
#import "OrderDetailView.h"

@interface OrderDetailController ()

@end

@implementation OrderDetailController

- (void)drawNavigation {
    
    [self drawTitle:@"订单详情"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    OrderDetailView *detailView = [OrderDetailView orderDetailView];
    detailView.frame = CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64);
    [self.view addSubview:detailView];
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
