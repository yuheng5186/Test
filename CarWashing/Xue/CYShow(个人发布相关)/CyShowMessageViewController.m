//
//  CyShowMessageViewController.m
//  CarWashing
//
//  Created by apple on 2017/11/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CyShowMessageViewController.h"
#import "CyShowTableViewCell.h"
#import "HTTPDefine.h"
#import "AppDelegate.h"
#import "HYActivityView.h"
#import "UdStorage.h"
#import "AFNetworkingTool.h"
#import "LCMD5Tool.h"
#import "MyExploitViewController.h"
//四个模块
#import "MyQuestionViewController.h"
#import "MyDynamicViewController.h"
#import "MyPublishUserCarViewController.h"
#import "MyInteractMessageViewController.h"
@interface CyShowMessageViewController () <UITableViewDelegate,UITableViewDataSource>
{
    UILabel * experienceLabel;
}
@property (nonatomic,strong) UITableView * tableView;
@property (nonatomic,strong) NSDictionary * dicData;
@end

@implementation CyShowMessageViewController
-(void)getData
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/MyBicycleCircle",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"我的车友圈%@",dict);
        self.dicData = dict;
        if ([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]]) {
            experienceLabel.text = [NSString stringWithFormat:@"经验值:%@",dict[@"JsonData"][@"EmpiricalValueCount"]];
        }
        [self.tableView reloadData];
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor redColor];
    [self.view addSubview:self.tableView];
    UIImageView * leftimage=[[UIImageView alloc]initWithFrame:CGRectMake(15, 30, 13, 20)];
    leftimage.image= [UIImage imageNamed:@"icon_titlebar_arrow"];
    [self.view addSubview:leftimage];
    UIButton * leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftButton.frame = CGRectMake(0, 0, 100, 80);
    [leftButton addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:leftButton];
    UIView * headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 200*Main_Screen_Height/667)];
    headerView.backgroundColor = [UIColor colorFromHex:@"#0161a1"];
    headerView.userInteractionEnabled  = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureClick)];
    [headerView addGestureRecognizer:tapGesture];
    self.tableView.tableHeaderView = headerView;
    //头像
    UIImageView * headerImageView = [[UIImageView alloc]init];
    headerImageView.backgroundColor=[UIColor redColor];
    headerImageView.layer.cornerRadius = 35*Main_Screen_Height/667;
    headerImageView.layer.masksToBounds = YES;
    NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,APPDELEGATE.currentUser.userImagePath];
    [headerImageView sd_setImageWithURL:[NSURL URLWithString:ImageURL] placeholderImage:[UIImage imageNamed:@"huiyuantou"]];
    [headerView addSubview:headerImageView];
    [headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerView.mas_centerX);
        make.top.mas_equalTo(headerView.mas_top).mas_offset(49*Main_Screen_Height/667);
        make.size.mas_equalTo(CGSizeMake(70*Main_Screen_Height/667, 70*Main_Screen_Height/667));
    }];
    //名字
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.text = @"13071076158";
    nameLabel.text=[NSString stringWithFormat:@"%@",APPDELEGATE.currentUser.userName];
    nameLabel.textAlignment = NSTextAlignmentCenter;
    nameLabel.font=[UIFont systemFontOfSize:18.0*Main_Screen_Height/667];
    [headerView addSubview:nameLabel];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerImageView.mas_centerX);
        make.top.mas_equalTo(headerImageView.mas_bottom).mas_offset(15*Main_Screen_Height/667);
        make.size.mas_equalTo(CGSizeMake(200*Main_Screen_Height/667, 20*Main_Screen_Height/667));
    }];
    //经验值
    experienceLabel = [[UILabel alloc]init];
    experienceLabel.textColor=[UIColor whiteColor];
    
    experienceLabel.textAlignment = NSTextAlignmentCenter;
    experienceLabel.font=[UIFont systemFontOfSize:13.0*Main_Screen_Height/667];
    [headerView addSubview:experienceLabel];
    [experienceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headerImageView.mas_centerX).mas_offset(-5);
        make.top.mas_equalTo(nameLabel.mas_bottom).mas_offset(10*Main_Screen_Height/667);
        make.size.mas_equalTo(CGSizeMake(80*Main_Screen_Height/667, 20*Main_Screen_Height/667));
    }];
    //箭头
    UIImageView * rightImageView = [[UIImageView alloc]init];
    rightImageView.image=[UIImage imageNamed:@"dianjitiaozhuanMy"];
    [headerView addSubview:rightImageView];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(experienceLabel.mas_centerY);
        make.left.mas_equalTo(experienceLabel.mas_right);
        make.size.mas_equalTo(CGSizeMake(10*Main_Screen_Height/667, 13*Main_Screen_Height/667));
    }];
    [self getData];
}
-(void)leftBtnClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section==0) {
        return 3;
    }
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray * imageArr =@[@"wodetiwenMy",@"wodedongtaiMy",@"wodeaiche"];
    NSArray * LabelArr =@[@"我的提问",@"我的动态",@"发布二手车"];
    static NSString * cellID = @"cellID";
    CyShowTableViewCell * cell = [_tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"CyShowTableViewCell" owner:self options:nil]lastObject];
    }
    if (indexPath.section==1) {
        cell.leftShowImage.image=[UIImage imageNamed:@"hudongxiaoxiMy"];
        cell.typeLabel.text= @"互动消息";
        cell.widthCons.constant = 16;
        cell.heightCons.constant =16;
        cell.numLabel.text = [NSString stringWithFormat:@"%@",self.dicData[@"JsonData"][@"InteractMessageCount"]];
    }else if (indexPath.section==0){
        cell.leftShowImage.image=[UIImage imageNamed:[NSString stringWithFormat:@"%@",imageArr[indexPath.row]]];
        cell.typeLabel.text=[NSString stringWithFormat:@"%@",LabelArr[indexPath.row]];
        if (indexPath.row==0) {
            cell.widthCons.constant = 16;
            cell.heightCons.constant = 16;
            cell.numLabel.text = [NSString stringWithFormat:@"%@",self.dicData[@"JsonData"][@"MyQuestionCount"]];
        }else if (indexPath.row==1){
            cell.widthCons.constant = 16;
            cell.heightCons.constant = 16;
            cell.numLabel.text = [NSString stringWithFormat:@"%@",self.dicData[@"JsonData"][@"MyDynamicCount"]];
        }else if (indexPath.row==2){
            cell.widthCons.constant = 18;
            cell.heightCons.constant = 15;
             cell.numLabel.text = [NSString stringWithFormat:@"%@",self.dicData[@"JsonData"][@"MyUsedCarCount"]];
        }
    }
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView * lineView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 10)];
    lineView.backgroundColor=RGBAA(242, 242, 242, 1.0);
    return lineView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [_tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section==0) {
        if (indexPath.row==0){//我的提问
            MyQuestionViewController *myCarController                  = [[MyQuestionViewController alloc]init];
            myCarController.hidesBottomBarWhenPushed            = YES;
            [self.navigationController pushViewController:myCarController animated:YES];
        }else if (indexPath.row==1){//我的动态
            MyDynamicViewController *cardGroupController      = [[MyDynamicViewController alloc]init];
            cardGroupController.hidesBottomBarWhenPushed    = YES;
            [self.navigationController pushViewController:cardGroupController animated:YES];
        }else if (indexPath.row==2){//发布二手车
            MyPublishUserCarViewController *serviceVC          = [[MyPublishUserCarViewController alloc]init];
            serviceVC.hidesBottomBarWhenPushed      = YES;
            [self.navigationController pushViewController:serviceVC animated:YES];
        }
    }else{
        MyInteractMessageViewController * vc = [[MyInteractMessageViewController alloc]init];
        vc.hidesBottomBarWhenPushed      = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}
-(void)tapGestureClick
{
    MyExploitViewController * ExploitVc =[[MyExploitViewController alloc]init];
    ExploitVc.hidesBottomBarWhenPushed = YES;
    ExploitVc.num =[NSString stringWithFormat:@"%@",self.dicData[@"JsonData"][@"EmpiricalValueCount"]];
    [self.navigationController pushViewController:ExploitVc animated:YES];
}
-(UITableView *)tableView
{
    if (_tableView ==nil) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -20, Main_Screen_Width, Main_Screen_Height+20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 50;
        _tableView.backgroundColor=RGBAA(242, 242, 242, 1.0);
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _tableView;
}


@end
