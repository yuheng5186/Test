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
    
    [self drawTitle:@"体验卡"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    CarTicketView *ticketView = [CarTicketView carTicketView];
    ticketView.frame = CGRectMake(37.5*Main_Screen_Height/667, 64 + 25*Main_Screen_Height/667, Main_Screen_Width - 75*Main_Screen_Height/667, 192*Main_Screen_Height/667);
    ticketView.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:ticketView];
    
    UIButton *exchangeButton = [UIUtil drawDefaultButton:self.view title:@"500积分兑换" target:self action:@selector(didClickExhangeButton:)];
    
    [exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ticketView.mas_bottom).mas_offset(50*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
        make.width.mas_equalTo(350*Main_Screen_Height/667);
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
