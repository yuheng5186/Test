//
//  IcreaseCarController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "IcreaseCarController.h"
#import <Masonry.h>
#import "QFDatePickerView.h"

#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "MyCar.h"
#import "UdStorage.h"

@interface IcreaseCarController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>

@property (nonatomic, weak) UITableView *carInfoView;

@property (nonatomic, weak) UILabel *lbl;
@property (nonatomic, weak) UILabel *lbl2;
@property (nonatomic, weak) UITextField *numTF;
@property (nonatomic, weak) UITextField *brandTF;
@property (nonatomic, weak) UITextField *text1;
@property (nonatomic, weak) UITextField *text2;

@end

static NSString *id_carInfoCell = @"id_carInfoCell";

@implementation IcreaseCarController




- (void)drawNavigation {
    
    [self drawTitle:self.titlename];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *carInfoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 400*Main_Screen_Height/667) style:UITableViewStyleGrouped];
    _carInfoView = carInfoView;
    [self.view addSubview:carInfoView];
    
    carInfoView.delegate = self;
    carInfoView.dataSource = self;
    
    UIButton *saveButton = [UIUtil drawDefaultButton:self.view title:@"保存" target:self action:@selector(didClickSaveButton)];
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-25*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(351*Main_Screen_Height/667);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
    }];
    
    
    //手势
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(endEditing)];
    tap.delegate = self;
    [self.view addGestureRecognizer:tap];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {//判断如果点击的是tableView的cell，就把手势给关闭了
        return NO;//关闭手势
    }//否则手势存在
    return YES;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *carCell = [tableView dequeueReusableCellWithIdentifier:id_carInfoCell];
    
    carCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id_carInfoCell];
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            
            carCell.textLabel.text = @"车牌号";
            carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
            carCell.textLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
            UILabel *provinceLabel = [[UILabel alloc] init];
            provinceLabel.text = @"沪";
            provinceLabel.textColor = [UIColor colorFromHex:@"#868686"];
            provinceLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
            [carCell.contentView addSubview:provinceLabel];
            
            UITextField *numTF1 = [[UITextField alloc] init];
            _numTF = numTF1;
            
            if(self.mycar == nil)
            {
                numTF1.placeholder = @"请输入车牌号";
            }
            else
            {
                numTF1.text = self.mycar.PlateNumber;
            }
            
            numTF1.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            numTF1.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
            [carCell.contentView addSubview:numTF1];

            
            [provinceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(carCell.textLabel);
                make.left.equalTo(carCell.contentView).mas_offset(110*Main_Screen_Height/667);
            }];
            
            [numTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(provinceLabel);
                make.leading.equalTo(provinceLabel.mas_trailing).mas_offset(16*Main_Screen_Height/667);
                make.width.mas_equalTo(200*Main_Screen_Height/667);
            }];
        }else{
            carCell.textLabel.text = @"品牌车系";
            carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
            carCell.textLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
            
            UITextField *brandTF1 = [[UITextField alloc] init];
            _brandTF = brandTF1;
            
            if(self.mycar == nil)
            {
                brandTF1.placeholder = @"请填写";
            }
            else
            {
                brandTF1.text = self.mycar.CarBrand;
            }
            
            
            brandTF1.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            brandTF1.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
            [carCell.contentView addSubview:brandTF1];
            
            [brandTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(carCell.contentView).mas_offset(110*Main_Screen_Height/667);

                make.centerY.equalTo(carCell);
                make.right.equalTo(carCell.contentView).mas_offset(-12*Main_Screen_Height/667);
            }];
        }
    }
    
    if (indexPath.section == 1) {
        
        NSArray *arr = @[@"车架号码",@"生产年份",@"上路时间",@"行驶里程"];
        carCell.textLabel.text = arr[indexPath.row];
        carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
        carCell.textLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
        
        if (indexPath.row == 0) {
            UITextField *textTF1 = [[UITextField alloc] init];
            _text1 = textTF1;
            
            
            if(self.mycar == nil)
            {
                textTF1.placeholder = @"请填写";
            }
            else
            {
                textTF1.text = self.mycar.ChassisNum;
            }
            
            textTF1.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            textTF1.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
            [carCell.contentView addSubview:textTF1];
            
            [textTF1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(carCell.contentView).mas_offset(110*Main_Screen_Height/667);
                make.centerY.equalTo(carCell);
                make.right.equalTo(carCell.contentView).mas_offset(-12*Main_Screen_Height/667);
            }];
        }
        else if (indexPath.row == 3) {
                UITextField *textTF2 = [[UITextField alloc] init];
                _text2 = textTF2;
                textTF2.placeholder = @"请填写";
            
                if(self.mycar == nil)
                {
                    textTF2.placeholder = @"请填写";
                }
                else
                {
                    textTF2.text = [NSString stringWithFormat:@"%ld",self.mycar.Mileage];
                }
            
                textTF2.textColor = [UIColor colorFromHex:@"#b4b4b4"];
                textTF2.font = [UIFont systemFontOfSize:12];
                [carCell.contentView addSubview:textTF2];
                
                [textTF2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(carCell.contentView).mas_offset(110*Main_Screen_Height/667);
                    make.centerY.equalTo(carCell);
                    make.right.equalTo(carCell.contentView).mas_offset(-12);
                }];
        }else {
            
            
            carCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            if (indexPath.row == 1) {
                UILabel *lbl = [[UILabel alloc] init];
                _lbl = lbl;
                
                
                if(self.mycar == nil)
                {
                    lbl.text = @"请选择";
                }
                else
                {
                    lbl.text = [NSString stringWithFormat:@"%ld",self.mycar.Manufacture];
                }
                
                lbl.textColor = [UIColor colorFromHex:@"#868686"];
                lbl.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
                [carCell.contentView addSubview:lbl];
                
                [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(carCell.contentView).mas_offset(110*Main_Screen_Height/667);
                    make.centerY.equalTo(carCell);
                }];
            }else {
                UILabel *lbl2 = [[UILabel alloc] init];
                _lbl2 = lbl2;
                
                if(self.mycar == nil)
                {
                    lbl2.text = @"请选择";
                }
                else
                {
                    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
                    [inputFormatter setDateFormat:@"yyyyMM"];
                    NSDate* inputDate = [inputFormatter dateFromString:self.mycar.DepartureTime];
                    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                    [outputFormatter setLocale:[NSLocale currentLocale]];
                    [outputFormatter setDateFormat:@"yyyy-MM"];
                    NSString *targetTime = [outputFormatter stringFromDate:inputDate];
                    lbl2.text  = targetTime;
                    
                    if(targetTime == 0)
                    {
                        NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
                        [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
                        [inputFormatter setDateFormat:@"yyyyM"];
                        NSDate* inputDate = [inputFormatter dateFromString:self.mycar.DepartureTime];
                        NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
                        [outputFormatter setLocale:[NSLocale currentLocale]];
                        [outputFormatter setDateFormat:@"yyyy-M"];
                        NSString *targetTime = [outputFormatter stringFromDate:inputDate];
                        lbl2.text  = targetTime;
                    }

                }
                
                
                
                lbl2.textColor = [UIColor colorFromHex:@"#868686"];
                lbl2.font = [UIFont systemFontOfSize:12*Main_Screen_Height/667];
                [carCell.contentView addSubview:lbl2];
                
                [lbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.left.equalTo(carCell.contentView).mas_offset(110*Main_Screen_Height/667);
                    make.centerY.equalTo(carCell);
                }];
            }        }
        
        
    }
    
    return carCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40*Main_Screen_Height/667;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.textColor = [UIColor colorFromHex:@"#868686"];
    infoLabel.font = [UIFont systemFontOfSize:15*Main_Screen_Height/667];
    
    if (section == 0) {
        
        infoLabel.text = @"  基本信息";
        
    }else{
        
        infoLabel.text = @"  其他信息";
    }
    
    
    return infoLabel;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1)
    {
        
        if (indexPath.row == 1) {
            QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
                
                self.lbl.text = str;
            }];
            [datePickerView show];
        }
        
        if (indexPath.row == 2) {
            QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithResponse:^(NSString *str) {
                
                self.lbl2.text = str;
            }];
            [datePickerView show];
        }
    }
    
}



- (void)endEditing
{
    [self.view endEditing:YES];
}



- (void)didClickSaveButton {
    
    if(self.mycar == nil)
    {
        NSDictionary *mulDic = @{
                                 @"CarBrand":_brandTF.text,
                                 @"PlateNumber":_numTF.text,
                                 @"ChassisNum":_text1.text,
                                 @"EngineNum":@"",
                                 @"Manufacture":[_lbl.text substringWithRange:NSMakeRange(0,4)],
                                 @"DepartureTime":_lbl2.text,
                                 @"Mileage":_text2.text,
                                 @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"]
                                 };
        NSMutableArray *ad = [NSMutableArray array];
        
        for (NSString *key in mulDic.allKeys) {
            if ([[mulDic objectForKey:key] isEqual:[NSNull null]])
            {
                [ad addObject:[mulDic objectForKey:key]];
            }
        }
        
        if([ad count] == 0)
        {
            NSDictionary *params = @{
                                     @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                     @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                     };
            
            [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MyCar/AddCarInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
                
                
                if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                {
                    [self.view showInfo:@"新增成功" autoHidden:YES interval:2];
                    NSNotification * notice = [NSNotification notificationWithName:@"increasemycarsuccess" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter]postNotification:notice];
                    [self.navigationController popViewControllerAnimated:YES];
                }
                
                else
                {
                    [self.view showInfo:@"新增失败" autoHidden:YES interval:2];
                }
                
                
                
                
                
                
            } fail:^(NSError *error) {
                [self.view showInfo:@"新增失败" autoHidden:YES interval:2];
            }];
            
        }
        else
        {
            [self.view showInfo:@"请将信息填写完整" autoHidden:YES interval:2];
        }

    }
    else
    {
            NSDictionary *mulDic = @{
                                     @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                                     @"CarCode":[NSString stringWithFormat:@"%ld",self.mycar.CarCode],
                                     @"ModifyType":@1,
                                     @"CarBrand":_brandTF.text,
                                     @"PlateNumber":_numTF.text,
                                     @"ChassisNum":_text1.text,
                                     @"EngineNum":@"",
                                     @"Manufacture":[_lbl.text substringWithRange:NSMakeRange(0,4)],
                                     @"DepartureTime":_lbl2.text,
                                     @"Mileage":_text2.text
                                    };
            NSDictionary *params = @{
                                     @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                     @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                     };
            [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MyCar/ModifyCarInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
                if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
                {
                    [self.view showInfo:@"修改成功" autoHidden:YES interval:2];
                    NSNotification * notice = [NSNotification notificationWithName:@"updatemycarsuccess" object:nil userInfo:nil];
                    [[NSNotificationCenter defaultCenter]postNotification:notice];
                    [self.navigationController popViewControllerAnimated:YES];
                    
                }
                else
                {
                    [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
                }
                
            } fail:^(NSError *error) {
                [self.view showInfo:@"修改失败" autoHidden:YES interval:2];
            }];

    }
    
    
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
