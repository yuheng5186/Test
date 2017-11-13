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

@interface AddDriverLicenseViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *careTableView;
@property(strong,nonatomic)NSArray *mainTitleArray;
@property(copy,nonatomic)NSString *dateMuSting;
@end

@implementation AddDriverLicenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _mainTitleArray = @[@"准驾类型",@"证件号",@"到期时间"];
    self.dateMuSting = @"请选择";
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.fakeNavigation];
    [self.view addSubview:self.careTableView];
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
        cell.accessoryType = UITableViewCellAccessoryDetailButton;
        cell.subTitleLabel.text = @"请选择";
    }else if(indexPath.row == 0){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
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



//保存按钮动作,在这里开始上传数据
-(void)addButtonAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//取消按钮动作
-(void)cancleAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
