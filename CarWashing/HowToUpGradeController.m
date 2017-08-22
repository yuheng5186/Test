//
//  HowToUpGradeController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/16.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "HowToUpGradeController.h"
#import <Masonry.h>
#import "HYSlider.h"
#import "WayToUpGradeCell.h"
#import "EarnScoreController.h"
#import "DSUpdateRuleController.h"


@interface HowToUpGradeController ()<UITableViewDelegate, UITableViewDataSource,HYSliderDelegate>

@property (nonatomic, weak) UITableView *wayToEarnScoreView;

@end

static NSString *id_wayToUpCell = @"id_wayToUpCell";

@implementation HowToUpGradeController

- (UITableView *)wayToEarnScoreView {
    
    if (!_wayToEarnScoreView) {
        
        UITableView *wayToEarnScoreView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _wayToEarnScoreView = wayToEarnScoreView;
        [self.view addSubview:_wayToEarnScoreView];
    }
    
    return _wayToEarnScoreView;
}


- (void)drawContent {
    
    [self drawTitle:@"升等级"];
    
    [self drawRightTextButton:@"等级规则" action:@selector(didClickRightBarButton)];
}

- (void)didClickRightBarButton {
    
    DSUpdateRuleController *ruleVC = [[DSUpdateRuleController alloc] init];
    ruleVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ruleVC animated:YES];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
//    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)setupUI {
    
    UIView *headContainView = [[UIView alloc] init];
    headContainView.backgroundColor = [UIColor colorFromHex:@"#293754"];
    [self.view addSubview:headContainView];
    
    UILabel *gradeLab = [[UILabel alloc] init];
    gradeLab.text = @"白银会员";
    gradeLab.textColor = [UIColor colorFromHex:@"#ffffff"];
    gradeLab.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    [self.view addSubview:gradeLab];
    
    //滑块
//    HYSlider *slider = [[HYSlider alloc] initWithFrame:CGRectMake(23*Main_Screen_Height/667, 64 + 68*Main_Screen_Height/667, Main_Screen_Width - 46, 4*Main_Screen_Height/667)];
//    slider.currentValueColor = [UIColor redColor];
//    slider.maxValue = 1000;
//    slider.currentSliderValue = 600;
//    slider.showTextColor = [UIColor redColor];
//    slider.showTouchView = YES;
//    slider.showScrollTextView = YES;
//    slider.touchViewColor = [UIColor redColor];
//    [self.view addSubview:slider];
    
    HYSlider *slider = [[HYSlider alloc]initWithFrame:CGRectMake(35, gradeLab.frame.origin.y+gradeLab.frame.size.height+5, Main_Screen_Width-46, 9)];
    slider.backgroundColor=[UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1];
    
    slider.currentValueColor = [UIColor colorFromHex:@"#febb02"];
    slider.maxValue = 1000;
    slider.currentSliderValue = 600;
    slider.showTextColor = [UIColor colorFromHex:@"#febb02"];
    slider.showTouchView = YES;
    slider.showScrollTextView = YES;
    slider.touchViewColor = [UIColor colorFromHex:@"#febb02"];
    slider.delegate = self;
    [self.view addSubview:slider];
    UILabel *maxLab = [[UILabel alloc] init];
    
    maxLab.textColor =[UIColor colorFromHex:@"#ffffff"];
    maxLab.textAlignment=NSTextAlignmentRight;
    maxLab.font = [UIFont systemFontOfSize:10];
    maxLab.text =[NSString stringWithFormat:@"%d",1000];
    [self.view addSubview:maxLab];
    
    UIButton *displayBtn = [[UIButton alloc] init];
    displayBtn.userInteractionEnabled = NO;
    [displayBtn setTitle:@"再获得400积分升级为黄金会员" forState:UIControlStateNormal];
    [displayBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    displayBtn.titleLabel.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
    [displayBtn setImage:[UIImage imageNamed:@"xiaohuojian"] forState:UIControlStateNormal];
    displayBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [displayBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10*Main_Screen_Height/667, 0, 0)];
    [headContainView addSubview:displayBtn];
    
    //底部
    UIView *containView = [[UIView alloc] init];
    containView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containView];
    
    UIButton *getMoreBtn = [[UIButton alloc] init];
    [getMoreBtn setTitle:@"如何获得更多积分" forState:UIControlStateNormal];
    [getMoreBtn setTitleColor:[UIColor colorFromHex:@"#4a4a4a"] forState:UIControlStateNormal];
    getMoreBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [getMoreBtn setImage:[UIImage imageNamed:@"gengduojifen"] forState:UIControlStateNormal];
    [getMoreBtn addTarget:self action:@selector(didClickGetMoreBtn) forControlEvents:UIControlEventTouchUpInside];
    [containView addSubview:getMoreBtn];
    
    
    
    
    //约束
    [headContainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(64);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(130*Main_Screen_Height/667);
    }];
    
    [gradeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headContainView).mas_offset(9*Main_Screen_Height/667);
        make.centerX.equalTo(headContainView);
    }];
    
//    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(gradeLab.mas_bottom).mas_offset(44);
//        make.left.equalTo(headContainView).mas_offset(23);
//        make.right.equalTo(headContainView).mas_offset(-23);
//        make.height.mas_equalTo(4);
//    }];
    [slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(gradeLab.mas_bottom).mas_offset(35);
        make.left.equalTo(headContainView).mas_offset(23);
        make.right.equalTo(headContainView).mas_offset(-23);
        make.width.mas_equalTo(Main_Screen_Width-46);
        make.height.mas_equalTo(9);
    }];
    [maxLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slider.mas_bottom).mas_offset(5);
        //        make.left.equalTo(headContainView).mas_offset(23);
        make.right.equalTo(slider);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(9);
    }];
    
    [displayBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(slider.mas_bottom).mas_offset(10);
        make.centerX.equalTo(headContainView);
        make.width.mas_equalTo(250);
        make.bottom.equalTo(headContainView).mas_offset(10);
    }];

    
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(49*Main_Screen_Height/667);
    }];
    
    [getMoreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containView);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
        make.width.mas_equalTo(250*Main_Screen_Height/667);
    }];
    
    getMoreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [getMoreBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    
    
    self.wayToEarnScoreView.delegate = self;
    self.wayToEarnScoreView.dataSource = self;
    self.wayToEarnScoreView.rowHeight = 90*Main_Screen_Height/667;
    
    [_wayToEarnScoreView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(headContainView.mas_bottom);
        make.right.left.equalTo(headContainView);
        make.height.mas_equalTo(Main_Screen_Height - 64 - 130*Main_Screen_Height/667 - 49*Main_Screen_Height/667);
    }];
    
    [self.wayToEarnScoreView registerClass:[WayToUpGradeCell class] forCellReuseIdentifier:id_wayToUpCell];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WayToUpGradeCell *wayCell = [tableView dequeueReusableCellWithIdentifier:id_wayToUpCell forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        
        wayCell.iconV.image = [UIImage imageNamed:@"xinyonghuzhuce"];
        wayCell.waysLab.text = @"新用户注册";
        wayCell.wayToLab.text = @"完成手机号绑定注册";
        wayCell.valuesLab.text = @"+20积分";
    }else if (indexPath.row == 1) {
        
        wayCell.iconV.image = [UIImage imageNamed:@"yaoqinghaoyou"];
        wayCell.waysLab.text = @"邀请好友";
        wayCell.wayToLab.text = @"邀请好友并完成注册";
        wayCell.valuesLab.text = @"+200积分";
    }else if (indexPath.row == 2) {
        
        wayCell.iconV.image = [UIImage imageNamed:@"wanshancheliangxinxi"];
        wayCell.waysLab.text = @"完善车辆信息";
        wayCell.wayToLab.text = @"完成车辆绑定,填写车辆信息";
        wayCell.valuesLab.text = @"+50积分";
    }else {
        
        wayCell.iconV.image = [UIImage imageNamed:@"wanshangerenxinxi"];
        wayCell.waysLab.text = @"完善隔个人信息";
        wayCell.wayToLab.text = @"填写个人姓名完善个人信息";
        wayCell.valuesLab.text = @"+20积分";
    }
        
    
    
    
    return wayCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10*Main_Screen_Height/667;
}



#pragma mark - 点击底部按钮
- (void)didClickGetMoreBtn {
    
    EarnScoreController *earnScoreVC = [[EarnScoreController alloc] init];
    earnScoreVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:earnScoreVC animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
