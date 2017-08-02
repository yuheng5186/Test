//
//  WashCarTicketController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "WashCarTicketController.h"
#import "CarTicketView.h"

@interface WashCarTicketController ()

@end

@implementation WashCarTicketController


- (void)drawNavigation {
    
    [self drawTitle:@"洗车劵" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CarTicketView *ticketView = [CarTicketView carTicketView];
    ticketView.frame = CGRectMake(0, 64, Main_Screen_Width, 250);
    [self.view addSubview:ticketView];
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
