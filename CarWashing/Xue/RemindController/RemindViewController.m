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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
