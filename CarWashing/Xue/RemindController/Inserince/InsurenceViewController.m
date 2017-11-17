//
//  InsurenceViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/12.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "InsurenceViewController.h"
#import "RemindViewController.h"
#import "AddInSurenceViewController.h"
#import "InsureModel.h"

#import "MBProgressHUD.h"

@interface InsurenceViewController ()
@property(copy,nonatomic)NSString *timeString;
@property(copy,nonatomic)NSString *sendIDString;
@property(copy,nonatomic)NSString *mainPlateText;

@property(copy,nonatomic)NSString *sendComString;
@end

@implementation InsurenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.fakeNavigation];
    //需要判断是否已经添加保养提醒,目前直接写在这里,点击“添加”按钮时隐藏添加View
    [self.view addSubview:self.afterView];
//    [self.view addSubview:self.addView];
    
}

//需要判断是否已经添加保养提醒
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestFormWeb];
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *setAlready = [userDefaults objectForKey:@"Insure"];
//    if ([setAlready isEqualToString:@"1"]) {
//        self.addView.hidden = YES;
//        self.afterView.hidden = NO;
//    }
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
        fakeTitle.text = @"车险提醒";
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
        
        UIButton *editButton = [[UIButton alloc]initWithFrame:CGRectMake(Main_Screen_Width-31,30, 19, 19)];
        [editButton setImage:[UIImage imageNamed:@"bianji"] forState:(UIControlStateNormal)];
        [editButton addTarget:self action:@selector(editingAction) forControlEvents:(UIControlEventTouchUpInside)];
        [_fakeNavigation addSubview:editButton];
        
        
    }
    return _fakeNavigation;
}

//提示添加的View，添加按钮时隐藏
//-(UIView *)addView{
//    if (!_addView) {
//        _addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height)];
//        _addView.backgroundColor = [UIColor whiteColor];
//
//        //提示信息
//
//        UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Width)];
//        addButton.backgroundColor = [UIColor colorWithRed:13/255.0 green:98/255.0 blue:159/255.0 alpha:1];
//        [addButton setTitle:@"尚未添加车险信息，点击添加" forState:(UIControlStateNormal)];
//        addButton.titleLabel.font = [UIFont systemFontOfSize:18 weight:18];
//        [addButton addTarget:self action:@selector(callNewViewController) forControlEvents:(UIControlEventTouchUpInside)];
//        [_addView addSubview:addButton];
//    }
//    return _addView;
//}

//添加成功后的View
-(UIView *)afterView{
    if (!_afterView) {
        _afterView = [[UIView alloc]initWithFrame:CGRectMake(0, 66, Main_Screen_Width, Main_Screen_Height-66)];
        _afterView.backgroundColor = [UIColor whiteColor];
        
        UIView *blueBase = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 120)];
        blueBase.backgroundColor = [UIColor colorWithRed:13/255.0 green:98/255.0 blue:159/255.0 alpha:1];
        [_afterView addSubview:blueBase];
        
        //afterView中的属性
        _carNoLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, Main_Screen_Width, 35)];
        _carNoLabel.textColor = [UIColor whiteColor];
        _carNoLabel.font = [UIFont systemFontOfSize:15];
        _carNoLabel.text = self.mainPlateText;
        _carNoLabel.textAlignment = NSTextAlignmentCenter;
        [_afterView addSubview:_carNoLabel];
        
        _carCareTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, Main_Screen_Width, 40)];
        _carCareTimeLabel.textColor = [UIColor whiteColor];
        _carCareTimeLabel.font = [UIFont systemFontOfSize:20];
        _carCareTimeLabel.text = self.timeString;
        _carCareTimeLabel.textAlignment = NSTextAlignmentCenter;
        [_afterView addSubview:_carCareTimeLabel];
        
        UILabel *day60Label = [[UILabel alloc]initWithFrame:CGRectMake(0, 75, Main_Screen_Width, 35)];
        day60Label.textColor = [UIColor whiteColor];
        day60Label.font = [UIFont systemFontOfSize:15];
        day60Label.text = @"到期前60请重新购买";
        day60Label.textAlignment = NSTextAlignmentCenter;
        [_afterView addSubview:day60Label];
        
        UIImageView *imageViewHere = [[UIImageView alloc]initWithFrame:CGRectMake(0, 120, Main_Screen_Width, 432*Main_Screen_Height/667)];
        imageViewHere.image = [UIImage imageNamed:@"车险须知"];
        imageViewHere.contentMode = UIViewContentModeScaleAspectFit;
        [_afterView addSubview:imageViewHere];
    }
    return _afterView;
}
//返回按钮动作
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)editingAction{
    AddInSurenceViewController *new = [[AddInSurenceViewController alloc]init];
    new.webTypeString = @"MyCar/ModifyVehicleReminder";
    new.getID = self.sendIDString;
    new.companyNameMuString = self.sendComString;
    new.dateMuSting = self.timeString;
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:new];
    [self presentViewController:nav animated:YES completion:nil];
}

////addView上present新控制器
//-(void)callNewViewController{
//    AddInSurenceViewController *new = [[AddInSurenceViewController alloc]init];
//    new.webTypeString = @"MyCar/AddVehicleReminder";
//    new.companyNameMuString = @"请选择保险公司";
//    new.dateMuSting = @"请选择";
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:new];
//    [self presentViewController:nav animated:YES completion:^{
//        self.addView.hidden = YES;
//    }];
//}

-(void)requestFormWeb{
    
//    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//    hud.mode = MBProgressHUDModeDeterminate;
//    hud.labelText = @"正在加载";
    
    NSDictionary *mulDic = [NSDictionary new];
    if ([self.wayGetHere isEqualToString:@"1"]) {
        mulDic = @{
                   @"Account_Id":[UdStorage getObjectforKey:Userid],
                   @"ReminderType":[NSString stringWithFormat:@"%@",self.getRemindType],
                   @"Id":[NSString stringWithFormat:@"%@",self.getID]
                   };
    }else{
        mulDic = @{
                   @"Account_Id":[UdStorage getObjectforKey:Userid]
                   };
        
    }
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MyCar/VehicleReminderList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        if ([dict[@"ResultCode"] isEqualToString:@"F000000"]) {
            
//            [hud hide:YES afterDelay:0.5];
            NSArray *newArr = dict[@"JsonData"];
            NSLog(@"保险提醒%@",newArr[3]);
            
            NSMutableArray *modelArray = (NSMutableArray *)[InsureModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"]];
            InsureModel *modelJack = modelArray[3];
            
            self.timeString = modelJack.ExpirationDate;
//            _carCareTimeLabel.text = self.timeString;
            self.mainPlateText = [NSString stringWithFormat:@"%@-%@ 车险到期日",modelJack.Province,modelJack.PlateNumber];
            _carNoLabel.text = self.mainPlateText;
            self.sendIDString = modelJack.Id;
            self.sendComString = modelJack.InsuranceCompany;
            _carCareTimeLabel.text = self.timeString;
//            if ([modelJack.IsSetUp isEqualToString:@"1"]) {
//                self.addView.hidden = YES;
//                self.afterView.hidden = NO;
//            }else{
//                self.addView.hidden = NO;
//                self.afterView.hidden = YES;
//            }
            
            
        }
    } fail:^(NSError *error) {
//        [hud hide:YES afterDelay:0.5];
    }];
}

@end
