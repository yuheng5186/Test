//
//  EarnScoreController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/14.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "EarnScoreController.h"
//#import "MemberRegualrController.h"
#import "WayToUpGradeCell.h"
#import "ScoreDetailController.h"

@interface EarnScoreController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIImageView *adverView;

@property (nonatomic, weak) UITableView *earnWayView;

@end

static NSString *id_earnViewCell = @"id_earnViewCell";

@implementation EarnScoreController


- (UIImageView *)adverView {
    
    if (!_adverView) {
        
        UIImageView *adverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 100*Main_Screen_Height/667)];
        _adverView = adverView;
        [self.view addSubview:adverView];
    }
    return _adverView;
}


- (UITableView *)earnWayView {
    
    if (!_earnWayView) {
        
        UITableView *earnWayView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64 + 100*Main_Screen_Height/667, Main_Screen_Width, Main_Screen_Height - 64 - 100*Main_Screen_Height/667) style:UITableViewStyleGrouped];
        _earnWayView = earnWayView;
        [self.view addSubview:_earnWayView];
    }
    return _earnWayView;
}


- (void)drawNavigation {
    
    [self drawTitle:@"赚积分"];
    [self drawRightTextButton:@"我的积分" action:@selector(clickMyScoreButton)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.adverView.image = [UIImage imageNamed:@"mendiantese"];
    
    self.earnWayView.delegate = self;
    self.earnWayView.dataSource = self;
    self.earnWayView.rowHeight = 90*Main_Screen_Height/667;
    [self.earnWayView registerClass:[WayToUpGradeCell class] forCellReuseIdentifier:id_earnViewCell];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WayToUpGradeCell *earnScoreCell = [tableView dequeueReusableCellWithIdentifier:id_earnViewCell forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"xinyonghuzhuce"];
        earnScoreCell.waysLab.text = @"新用户注册";
        earnScoreCell.wayToLab.text = @"完成手机号绑定注册";
        earnScoreCell.valuesLab.text = @"+20积分";
    }else if (indexPath.row == 1) {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"yaoqinghaoyou"];
        earnScoreCell.waysLab.text = @"邀请好友";
        earnScoreCell.wayToLab.text = @"邀请好友并完成注册";
        earnScoreCell.valuesLab.text = @"+200积分";
    }else if (indexPath.row == 2) {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"wanshancheliangxinxi"];
        earnScoreCell.waysLab.text = @"完善车辆信息";
        earnScoreCell.wayToLab.text = @"完成车辆绑定,填写车辆信息";
        earnScoreCell.valuesLab.text = @"+50积分";
    }else {
        
        earnScoreCell.iconV.image = [UIImage imageNamed:@"wanshangerenxinxi"];
        earnScoreCell.waysLab.text = @"完善隔个人信息";
        earnScoreCell.wayToLab.text = @"填写个人姓名完善个人信息";
        earnScoreCell.valuesLab.text = @"+20积分";
    }
    
    return earnScoreCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10*Main_Screen_Height/667;
}



- (void)clickMyScoreButton{
    
    ScoreDetailController *scoreController = [[ScoreDetailController alloc] init];
    scoreController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scoreController animated:YES];
    
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
