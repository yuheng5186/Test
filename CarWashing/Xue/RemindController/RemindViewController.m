//
//  RemindViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/7.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "RemindViewController.h"
#import "RemindViewTableViewCell.h"
#import "CareRemindViewController.h"
#import "DriverLicenseViewController.h"
#import "YearTestViewController.h"
#import "InsurenceViewController.h"

//四个模块的入口

@interface RemindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UIView *fakeNavigation;
@property(strong,nonatomic)UITableView *jackTableView;
@property(strong,nonatomic)NSArray *titleArray;
@property(strong,nonatomic)NSArray *imageArray;
@end

@implementation RemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
    [self.view addSubview:self.fakeNavigation];
    [self.view addSubview:self.jackTableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestFromWeb];
}

#pragma mark - 懒加载
-(UIView *)fakeNavigation{
    if (!_fakeNavigation) {
        _fakeNavigation = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 66)];
        _fakeNavigation.backgroundColor = [UIColor colorWithRed:13/255.0 green:98/255.0 blue:159/255.0 alpha:1];
        
        UILabel *fakeTitle = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-100, 26, 200, 30)];
        fakeTitle.text = @"爱车提醒";
        fakeTitle.font = [UIFont systemFontOfSize:18 weight:18];
        fakeTitle.textColor = [UIColor whiteColor];
        fakeTitle.textAlignment = NSTextAlignmentCenter;
        [_fakeNavigation addSubview:fakeTitle];
        
        
        UIImageView *backImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 32, 19, 19)];
        backImageView.image = [UIImage imageNamed:@"icon_titlebar_arrow"];
        backImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_fakeNavigation addSubview:backImageView];
        
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 66, 66)];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_fakeNavigation addSubview:backButton];
        
        
    }
    return _fakeNavigation;
}

#pragma mark - tableView
-(UITableView *)jackTableView{
    if (!_jackTableView) {
        _jackTableView = [[UITableView alloc]initWithFrame:CGRectMake(12, 91, Main_Screen_Width-24, Main_Screen_Height-91) style:(UITableViewStylePlain)];
        _jackTableView.delegate = self;
        _jackTableView.dataSource = self;
        _jackTableView.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1];
        [_jackTableView registerClass:[RemindViewTableViewCell class] forCellReuseIdentifier:@"cell"];
        _jackTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _jackTableView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    RemindViewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    _titleArray = @[@"保养提醒",@"驾驶证更换提醒",@"车辆年检提醒",@"车险提醒"];
    _imageArray = @[@"baoyang",@"jiashizheng",@"nianjian",@"chexian"];
    cell.bigLabel.text = _titleArray[indexPath.row];
    cell.smallImageView.image = [UIImage imageNamed:_imageArray[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        //保养提醒
        CareRemindViewController *new = [[CareRemindViewController alloc]init];
        [self.navigationController pushViewController:new animated:YES];
    }else if (indexPath.row == 1){
        DriverLicenseViewController *new = [[DriverLicenseViewController alloc]init];
        [self.navigationController pushViewController:new animated:YES];
    }else if (indexPath.row == 2){
        YearTestViewController *new = [[YearTestViewController alloc]init];
        [self.navigationController pushViewController:new animated:YES];
    }else if (indexPath.row == 3){
        InsurenceViewController *new = [[InsurenceViewController alloc]init];
        [self.navigationController pushViewController:new animated:YES];
    }
}

#pragma mark - backAction
-(void)backAction{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)requestFromWeb{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:Userid]
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MyCar/VehicleReminderList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"总舵主%@",dict);
    } fail:^(NSError *error) {
        
    }];
}

@end
