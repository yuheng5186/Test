//
//  DSExchangeController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSExchangeController.h"

@interface DSExchangeController ()

@end

@implementation DSExchangeController

- (void)drawNavigation {
    
    [self drawTitle:@"兑换" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    
    UITextField *exchangeTF = [[UITextField alloc] initWithFrame:CGRectMake(50, 64 + 60, Main_Screen_Width - 100, 60)];
    exchangeTF.placeholder = @"请输入兑换码";
    exchangeTF.keyboardType = UIKeyboardTypeNumberPad;
    exchangeTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:exchangeTF];
    
    UIButton *exchangeBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, 64 + 180, Main_Screen_Width - 100, 40)];
    [exchangeBtn setTitle:@"兑换" forState:UIControlStateNormal];
    exchangeBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:exchangeBtn];
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
