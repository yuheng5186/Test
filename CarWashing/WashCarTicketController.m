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

#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "MBProgressHUD.h"
#import "UdStorage.h"
#import "HTTPDefine.h"

@interface WashCarTicketController ()

@end

@implementation WashCarTicketController


- (void)drawNavigation {
    
    [self drawTitle:@"体验卡"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    CarTicketView *ticketView = [CarTicketView carTicketView];
//    ticketView.frame = CGRectMake(37.5*Main_Screen_Height/667, 64 + 25*Main_Screen_Height/667, Main_Screen_Width - 75*Main_Screen_Height/667, 192*Main_Screen_Height/667);
    ticketView.backgroundColor = self.view.backgroundColor;
    
    ticketView.CardName.text = self.card.CardName;
    ticketView.ScoreLabel.text = [NSString stringWithFormat:@"%ld积分",self.card.Integralnum];
    
    [self.view addSubview:ticketView];
    
    UIButton *exchangeButton = [UIUtil drawDefaultButton:self.view title:[NSString stringWithFormat:@"%ld积分兑换",self.card.Integralnum] target:self action:@selector(didClickExhangeButton:)];
    
    [ticketView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(64 + 25*Main_Screen_Height/667);
        make.left.equalTo(self.view).mas_offset(37*Main_Screen_Height/667);
        make.right.equalTo(self.view).mas_offset(-37*Main_Screen_Height/667);
        make.height.mas_equalTo(192*Main_Screen_Height/667);
    }];
    
    [exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ticketView.mas_bottom).mas_offset(50*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
        make.width.mas_equalTo(350*Main_Screen_Height/667);
    }];
}
                                
- (void)didClickExhangeButton:(UIButton *)button {
    
    
    if(self.card.Integralnum > [self.CurrentScore integerValue])
    {
        [self.view showInfo:@"积分不足" autoHidden:YES interval:2];
    }
    else
    {
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *datenow = [NSDate date];
        NSDate *newDate = [datenow dateByAddingTimeInterval:60 * 60 * 24 * self.card.ExpiredDay];
        
        
        NSDictionary *mulDic = @{
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                 @"ConfigCode":[NSString stringWithFormat:@"%ld",self.card.ConfigCode],
                                 @"UseLevel":@1,
                                 @"GetCardType":[NSString stringWithFormat:@"%ld",self.card.GetCardType],
                                 @"Area":self.card.Area,
                                 @"CardCount":[NSString stringWithFormat:@"%ld",self.card.CardCount],
                                 @"CardName":self.card.CardName,
                                 @"CardPrice":[NSString stringWithFormat:@"%@",self.card.CardPrice],
                                 @"CardType":[NSString stringWithFormat:@"%ld",self.card.CardType],
                                 @"Description":self.card.Description,
                                 @"ExpStartDates":[NSString stringWithFormat:@"%@",[formatter stringFromDate:datenow]],
                                 @"ExpEndDates":[NSString stringWithFormat:@"%@",[formatter stringFromDate:newDate]],
                                 @"Integralnum": [NSString stringWithFormat:@"%ld",self.card.Integralnum],
                                 };
        
        
        NSLog(@"%@",mulDic);
        
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
        [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Card/ReceiveCardInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
            
            if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
            {
                
                [self.view showInfo:@"兑换成功" autoHidden:YES interval:2];
                
            }
            else
            {
                [self.view showInfo:@"兑换失败" autoHidden:YES interval:2];
            }
        } fail:^(NSError *error) {
            [self.view showInfo:@"兑换失败" autoHidden:YES interval:2];
            
        }];

    }
    
    
    
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
