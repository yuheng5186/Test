//
//  DSMemberRightsController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSMemberRightsController.h"
#import "DSUpdateRuleController.h"
#import <Masonry.h>
#import "HowToUpGradeController.h"
#import "MemberRightsDetailController.h"
@interface DSMemberRightsController ()<UITableViewDelegate, UITableViewDataSource>

@end

static NSString *id_rightsCell = @"id_rightsCell";

@implementation DSMemberRightsController

- (void)drawNavigation {
    
    [self drawTitle:@"等级特权"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubView];
    
}
- (void) createSubView {
    UIView *upView                  = [UIUtil drawLineInView:self.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*130/667) color:[UIColor colorFromHex:@"#293754"]];
    upView.top                      = 0;
    
    
    UIImage *membershipImage              = [UIImage imageNamed:@"huiyuantou"];
    UIImageView *membershipImageView      = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, membershipImage.size.width, membershipImage.size.height) imageName:@"huiyuantou"];
    
    membershipImageView.top               = Main_Screen_Height*15/667;
    membershipImageView.centerX           = upView.centerX;
    
    NSString *membershipName              = @"白银会员";
    UIFont *membershipNameFont            = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    UILabel *membershipNameLabel          = [UIUtil drawLabelInView:upView frame:[UIUtil textRect:membershipName font:membershipNameFont] font:membershipNameFont text:membershipName isCenter:NO];
    membershipNameLabel.textColor         = [UIColor colorFromHex:@"#ffffff"];
    membershipNameLabel.top               = membershipImageView.bottom +Main_Screen_Height*10/667;
    membershipNameLabel.centerX           = membershipImageView.centerX;
    
    upView.height       = membershipNameLabel.bottom+Main_Screen_Height*10/667;
    

    UITableView *memberRightsView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [self.view addSubview:memberRightsView];
    
    
    
    memberRightsView.delegate = self;
    memberRightsView.dataSource = self;
    memberRightsView.rowHeight = 60*Main_Screen_Height/667;
    
    //底部
    UIView *containView = [[UIView alloc] init];
    containView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:containView];
    
    UIButton *gradeBtn = [[UIButton alloc] init];
    [gradeBtn setTitle:@"如何升级到黄金会员" forState:UIControlStateNormal];
    [gradeBtn setTitleColor:[UIColor colorFromHex:@"#4a4a4a"] forState:UIControlStateNormal];
    gradeBtn.titleLabel.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    [gradeBtn setImage:[UIImage imageNamed:@"xiaohuojian"] forState:UIControlStateNormal];
    [containView addSubview:gradeBtn];
    
    
    [memberRightsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(upView.mas_bottom);
        make.left.right.equalTo(self.view);
        
    }];
    
    [containView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(memberRightsView.mas_bottom);
        make.bottom.left.right.equalTo(self.view);
        make.height.mas_equalTo(49*Main_Screen_Height/667);
    }];
    
    [gradeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(containView);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
        make.width.mas_equalTo(250*Main_Screen_Height/667);
    }];
    
    gradeBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [gradeBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 10, 0, 0)];
    
    
    [gradeBtn addTarget:self action:@selector(clickHowToIncreaseGradeBtn) forControlEvents:UIControlEventTouchUpInside];
    
    
}

- (void)clickHowToIncreaseGradeBtn {
    
    HowToUpGradeController *upGradeVC = [[HowToUpGradeController alloc] init];
    
    [self.navigationController pushViewController:upGradeVC animated:YES];
    
}

#pragma mark - tableview
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id_rightsCell];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:id_rightsCell];
    
    cell.imageView.image = [UIImage imageNamed:@"shengjihoukaquan"];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.textColor = [UIColor colorFromHex:@"#3a3a3a"];
    
    
    cell.detailTextLabel.text = @"门店吸尘是可抵扣相应金额,每月领取一次";
    cell.detailTextLabel.font = [UIFont systemFontOfSize:12];
    cell.detailTextLabel.textColor = [UIColor colorFromHex:@"#999999"];
    
    
    if (indexPath.section == 0) {
        cell.textLabel.text = @"10元洗车券";
    }else {
        cell.textLabel.text = @"15元洗车券";
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 10*Main_Screen_Height/667;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *hederview=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 40)];
    hederview.backgroundColor=[UIColor colorFromHex:@"0xf0f0f0"];
    UIView *hederviews=[[UIView alloc]initWithFrame:CGRectMake(0, 10, Main_Screen_Width, 29)];
    hederviews.backgroundColor=[UIColor whiteColor];
    
    
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, Main_Screen_Width, 29)];
    
    infoLabel.textColor = [UIColor colorFromHex:@"#3a3a3a"];
    infoLabel.font = [UIFont systemFontOfSize:15];
    
    if (section == 0) {
        
        infoLabel.text = @"  等级特权";
        
    }else{
        
        infoLabel.text = @"  升级后可获得特权";
    }
    
    [hederviews addSubview:infoLabel];
    [hederview addSubview:hederviews];
    
    return hederview;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    
//    if (section == 0) {
//        return @"我的特权";
//    }else {
//        
//        return @"升级后可获得特权";
//    }
//}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MemberRightsDetailController *VC = [[MemberRightsDetailController alloc] init];
    VC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:VC animated:YES];
}



#pragma mark -------button click------

- (void) updateMemberClick:(id)sender {
    
    
}
- (void) updateRuleClick:(id)sender {
    
    DSUpdateRuleController *updateRuleController  = [[DSUpdateRuleController alloc]init];
    updateRuleController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:updateRuleController animated:YES];
    
}

//#pragma mark -------tapGesture click------
//- (void) tapSymbolButtonClick:(id)sender {
//    
//    
//}
//
//- (void) tapDiscountButtonClick:(id)sender {
//    
//    
//}
//- (void) tapMaintainButtonClick:(id)sender {
//    
//    
//}
//
//- (void) tapGoodsButtonClick:(id)sender {
//    
//    
//}

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
