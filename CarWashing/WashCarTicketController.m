//
//  WashCarTicketController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "WashCarTicketController.h"
#import "CarTicketView.h"
#import <Masonry.h>

@interface WashCarTicketController ()

@end

@implementation WashCarTicketController


- (void)drawNavigation {
    
    [self drawTitle:@"洗车劵"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CarTicketView *ticketView = [CarTicketView carTicketView];
    ticketView.frame = CGRectMake(10, 64 + 10, Main_Screen_Width - 20, 80);
    [self.view addSubview:ticketView];
    
    UIButton *exchangeButton = [UIUtil drawDefaultButton:self.view title:@"500积分兑换" target:self action:@selector(didClickExhangeButton:)];
    
    [exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ticketView.mas_bottom).mas_offset(60);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(350);
    }];
}
                                
- (void)didClickExhangeButton:(UIButton *)button {
                                    
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
