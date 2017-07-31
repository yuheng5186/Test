//
//  DSMembershipController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSMembershipController.h"
#import "MemberView.h"
#import "MemberRegualrController.h"
#import "DSMemberRightsController.h"
#import "ScoreDetailController.h"

@interface DSMembershipController ()

@end

@implementation DSMembershipController

- (void)drawNavigation {
    
    [self drawTitle:@"金顶会员" Color:[UIColor blackColor]];
    [self drawRightTextButton:@"积分规则" action:@selector(clickRegularButton)];
    
    
    
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
    
    MemberView *memberShipView = [MemberView memberView];
    memberShipView.frame = CGRectMake(0, 64, Main_Screen_Width, 200);
    [self.view addSubview:memberShipView];
    
    
}

- (void)clickRegularButton{
    
    MemberRegualrController *regularController = [[MemberRegualrController alloc] init];
    
    [self.navigationController pushViewController:regularController animated:YES];
    
}


#pragma mark - 点击赚积分
- (IBAction)clickEarnScoreBtn:(UIButton *)sender {
    
    ScoreDetailController *scoreDetailVC = [[ScoreDetailController alloc] init];
    
    [self.navigationController pushViewController:scoreDetailVC animated:YES];
}

#pragma mark - 点击升级
- (IBAction)clickUpgradeBtn:(UIButton *)sender {
    
    DSMemberRightsController *rightsController = [[DSMemberRightsController alloc] init];
    rightsController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:rightsController animated:YES];
    
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
