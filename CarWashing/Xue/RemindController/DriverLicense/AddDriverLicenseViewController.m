//
//  AddDriverLicenseViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/12.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "AddDriverLicenseViewController.h"
#import "AddCareTableViewCell.h"
#import "ChooseTableViewController.h"

//时间选择
#import "WSDatePickerView.h"

#import "UdStorage.h"
#import "HTTPDefine.h"
#import "AFNetworkingTool.h"
#import "AFNetworkingTool+GetToken.h"
#import "LCMD5Tool.h"

//菊花
#import "MBProgressHUD.h"

@interface AddDriverLicenseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *careTableView;
@property(strong,nonatomic)NSArray *mainTitleArray;

@property(strong,nonatomic)UITextField *licenseNumTextField;

@property(strong,nonatomic)UIView *jerkLicenseView;         //驾照示例

@end

@implementation AddDriverLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _mainTitleArray = @[@"准驾类型",@"证件号",@"到期时间"];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.fakeNavigation];
    [self.view addSubview:self.careTableView];
    
    self.licenseNumTextField = [[UITextField alloc]initWithFrame:CGRectMake(120, 126, 200, 35)];
    _licenseNumTextField.placeholder = self.placeHolderString;
    _licenseNumTextField.borderStyle = UITextBorderStyleNone;
    _licenseNumTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _licenseNumTextField.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:self.licenseNumTextField];
    
    [self setUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 懒加载fakeNavigation
-(UIView *)fakeNavigation{
    if (!_fakeNavigation) {
        _fakeNavigation = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 66)];
        _fakeNavigation.backgroundColor = [UIColor colorWithRed:13/255.0 green:98/255.0 blue:159/255.0 alpha:1];
        
        UILabel *fakeTitle = [[UILabel alloc]initWithFrame:CGRectMake(Main_Screen_Width/2-100, 26, 200, 30)];
        fakeTitle.text = @"添加驾照提醒";
        fakeTitle.font = [UIFont systemFontOfSize:18 weight:18];
        fakeTitle.textColor = [UIColor whiteColor];
        fakeTitle.textAlignment = NSTextAlignmentCenter;
        [_fakeNavigation addSubview:fakeTitle];
        
        //取消按钮
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 26, 66, 30)];
        backButton.backgroundColor = [UIColor clearColor];
        [backButton setTitle:@"取消" forState:(UIControlStateNormal)];
        [backButton addTarget:self action:@selector(cancleAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_fakeNavigation addSubview:backButton];
        
        
    }
    return _fakeNavigation;
}

-(void)setUI{
    
    //保存按钮
    UIButton *saveButton = [[UIButton alloc]initWithFrame:CGRectMake(12, 200+66, Main_Screen_Width-24, 50)];
    saveButton.backgroundColor = [UIColor colorWithRed:13/255.0 green:98/255.0 blue:159/255.0 alpha:1];
    [saveButton setTitle:@"保存" forState:(UIControlStateNormal)];
    saveButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:18];
    saveButton.clipsToBounds = YES;
    saveButton.layer.cornerRadius = 5;
    [saveButton addTarget:self action:@selector(addButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:saveButton];
    
    UIButton *jerkButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-50, 116, 50, 50)];
    [jerkButton setImage:[UIImage imageNamed:@"_"] forState:(UIControlStateNormal)];
    [jerkButton addTarget:self action:@selector(jerkButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:jerkButton];
    
}

-(UIView *)jerkLicenseView{
    if (!_jerkLicenseView) {
        _jerkLicenseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
        _jerkLicenseView.backgroundColor = [UIColor blackColor];
        _jerkLicenseView.alpha = 0;
        
        UIImageView *licenseImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, Main_Screen_Height/2-100, Main_Screen_Width, 200)];
//        NSString *imageString = [[NSBundle mainBundle] pathForResource:@"jiashizheng123" ofType:@"png"];
//        licenseImageView.image = [[UIImage alloc]initWithContentsOfFile:imageString];
        licenseImageView.image = [UIImage imageNamed:@"jiashizheng123"];
        [_jerkLicenseView addSubview:licenseImageView];
        
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jerkViewDismissAction)];
        _jerkLicenseView.userInteractionEnabled = YES;
        [_jerkLicenseView addGestureRecognizer:tap];
        
    }
    return _jerkLicenseView;
}

#pragma mark - 懒加载careTableView
-(UITableView *)careTableView{
    if (!_careTableView) {
        _careTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 66, Main_Screen_Width, 150) style:(UITableViewStylePlain)];
        _careTableView.delegate = self;
        _careTableView.dataSource = self;
        _careTableView.scrollEnabled = NO;
        [_careTableView registerClass:[AddCareTableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _careTableView;
}

//设置行数，看row
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

//高度50
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

//设置cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AddCareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row == 1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.subTitleLabel.text = @"";
    }else if(indexPath.row == 0){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        //这里self.licenseTypeString没有值
        cell.subTitleLabel.text = self.licenseTypeString;
    }else if (indexPath.row == 2){
        //time
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.subTitleLabel.text = self.dateMuSting;
    }
    cell.mainTitleLabel.text = self.mainTitleArray[indexPath.row];
    return cell;
}

//点击cell
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //开始判断
    if (indexPath.row == 0) {
        //选择驾照类型
        ChooseTableViewController *new = [[ChooseTableViewController alloc]init];
        new.deliverBlock = ^(NSString *str){
            self.licenseTypeString = str;
            [tableView reloadData];
        };
        [self.navigationController pushViewController:new animated:YES];
    }else if (indexPath.row == 1){
        //输入驾照号码
        
    }else if (indexPath.row == 2){
        //选择时间
        WSDatePickerView *datePicker = [[WSDatePickerView alloc]initWithDateStyle:(DateStyleShowYearMonthDay) CompleteBlock:^(NSDate *selectDate) {
            //获得结果位date
            NSString *date = [selectDate stringWithFormat:@"yyyy-MM-dd"];
            self.dateMuSting = date;
            [tableView reloadData];
        }];
        datePicker.doneButtonColor = [UIColor colorFromHex:@"#0161a1"];
        [datePicker show];
    }
}

-(void)jerkButtonAction{
    [self.view addSubview:self.jerkLicenseView];
    [UIView animateWithDuration:0.3 animations:^{
        self.jerkLicenseView.alpha = 1;
    }];
}

-(void)jerkViewDismissAction{
    [UIView animateWithDuration:0.2 animations:^{
        self.jerkLicenseView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.jerkLicenseView removeFromSuperview];
    }];
}

//保存按钮动作,在这里开始上传数据
-(void)addButtonAction{
    
    //本地userDefault
    [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"License"];
    // 保存到本地
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if ([self.licenseNumTextField.text isEqualToString:@""]) {
        self.licenseNumTextField.text = self.placeHolderString;
    }
    
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode = MBProgressHUDModeDeterminate;
    hud.labelText = @"正在上传";
    //上传
    NSDictionary *mulDic = @{
                             @"Id":[NSString stringWithFormat:@"%@",self.getID],
                             @"Account_Id":[UdStorage getObjectforKey:Userid],
                             @"ReminderType":@(2),
                             @"QuasiDriveType":[NSString stringWithFormat:@"%@",self.licenseTypeString],
                             @"TimeDate":[NSString stringWithFormat:@"%@",self.dateMuSting],
                             @"IDNumber":[NSString stringWithFormat:@"%@",self.licenseNumTextField.text]
                             };
    NSLog(@"驾照类型------>%@",self.licenseTypeString);
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@%@",Khttp,self.webTypeString] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"驾照上传结果%@",dict);
        if ([dict[@"ResultCode"] isEqualToString:@"F000000"]) {
            NSLog(@"驾照上传成功！");
            hud.mode = MBProgressHUDModeText;
            hud.labelText = @"成功!";
            [hud hide:YES afterDelay:0.5];
             [self dismissViewControllerAnimated:YES completion:nil];
            
        }
    } fail:^(NSError *error) {
        hud.mode = MBProgressHUDModeText;
        hud.labelText = @"失败!";
        [hud hide:YES afterDelay:0.5];
        NSLog(@"AF失败%@",error);
    }];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//取消按钮动作
-(void)cancleAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
