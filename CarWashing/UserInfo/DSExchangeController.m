//
//  DSExchangeController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSExchangeController.h"
#import <Masonry.h>

@interface DSExchangeController ()

@end

@implementation DSExchangeController

- (void)drawNavigation {
    
    [self drawTitle:@"兑换"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    
    UITextField *exchangeTF = [[UITextField alloc] init];
    exchangeTF.placeholder = @"请输入兑换码";
    exchangeTF.textAlignment = NSTextAlignmentCenter;
    exchangeTF.layer.cornerRadius = 24;
    exchangeTF.keyboardType = UIKeyboardTypeNumberPad;
    exchangeTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exchangeTF];
    
    UIButton *exchangeBtn = [UIUtil drawDefaultButton:self.view title:@"兑换" target:self action:@selector(didClickExchangeScoreBtn:)];
    
    [exchangeTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(64 + 23);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(351);
        make.height.mas_equalTo(48);
    }];
    
    [exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(exchangeTF.mas_bottom).mas_offset(60);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(351);
        make.height.mas_equalTo(48);
    }];

 }
                             
- (void)didClickExchangeScoreBtn:(UIButton *)button {
    
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
