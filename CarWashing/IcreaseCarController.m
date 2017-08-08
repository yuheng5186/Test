//
//  IcreaseCarController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "IcreaseCarController.h"
#import <Masonry.h>

@interface IcreaseCarController ()<UITableViewDelegate, UITableViewDataSource>


@end

static NSString *id_carInfoCell = @"id_carInfoCell";

@implementation IcreaseCarController




- (void)drawNavigation {
    
    [self drawTitle:@"新增车辆"];

}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *carInfoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 400) style:UITableViewStyleGrouped];
    
    [self.view addSubview:carInfoView];
    
    carInfoView.delegate = self;
    carInfoView.dataSource = self;
    
    UIButton *saveButton = [UIUtil drawDefaultButton:self.view title:@"保存" target:self action:@selector(didClickSaveButton)];
    
    [saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).mas_offset(-25);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(351);
        make.height.mas_equalTo(48);
    }];
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
            carCell.textLabel.font = [UIFont systemFontOfSize:14];
            UILabel *provinceLabel = [[UILabel alloc] init];
            provinceLabel.text = @"沪";
            provinceLabel.textColor = [UIColor colorFromHex:@"#868686"];
            provinceLabel.font = [UIFont systemFontOfSize:14];
            [carCell.contentView addSubview:provinceLabel];
            
            UITextField *numTF = [[UITextField alloc] init];
            numTF.placeholder = @"请输入车牌号";
            numTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            numTF.font = [UIFont systemFontOfSize:12];
            [carCell.contentView addSubview:numTF];
            
            [provinceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(carCell.textLabel);
                make.left.equalTo(carCell.contentView).mas_offset(110);
            }];
            
            [numTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(provinceLabel);
                make.leading.equalTo(provinceLabel.mas_trailing).mas_offset(16);
            }];
        }else{
            carCell.textLabel.text = @"品牌车系";
            carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
            carCell.textLabel.font = [UIFont systemFontOfSize:14];
            
            UITextField *brandTF = [[UITextField alloc] init];
            brandTF.placeholder = @"请填写";
            brandTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            brandTF.font = [UIFont systemFontOfSize:12];
            [carCell.contentView addSubview:brandTF];
            
            [brandTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(carCell.contentView).mas_offset(110);
                make.centerY.equalTo(carCell);
            }];
        }
    }
    
    if (indexPath.section == 1) {
        
        NSArray *arr = @[@"车架号码",@"生产年份",@"上路时间",@"行驶里程"];
        carCell.textLabel.text = arr[indexPath.row];
        carCell.textLabel.textColor = [UIColor colorFromHex:@"#868686"];
        carCell.textLabel.font = [UIFont systemFontOfSize:14];
        
        if (indexPath.row == 0 || indexPath.row == 3) {
            UITextField *textTF = [[UITextField alloc] init];
            textTF.placeholder = @"请填写";
            textTF.textColor = [UIColor colorFromHex:@"#b4b4b4"];
            textTF.font = [UIFont systemFontOfSize:12];
            [carCell.contentView addSubview:textTF];
            
            [textTF mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(carCell.contentView).mas_offset(110);
                make.centerY.equalTo(carCell);
            }];
        }else {
            
            carCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UILabel *lbl = [[UILabel alloc] init];
            lbl.text = @"请选择";
            lbl.textColor = [UIColor colorFromHex:@"#868686"];
            lbl.font = [UIFont systemFontOfSize:12];
            [carCell.contentView addSubview:lbl];
            
            [lbl mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(carCell.contentView).mas_offset(110);
                make.centerY.equalTo(carCell);
            }];
        }
        
        
    }
    
    return carCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.textColor = [UIColor colorFromHex:@"#868686"];
    infoLabel.font = [UIFont systemFontOfSize:15];
    
    if (section == 0) {
        
        infoLabel.text = @"  基本信息";
        
    }else{
        
        infoLabel.text = @"  其他信息";
    }
    
    
    return infoLabel;
}



- (void)didClickSaveButton {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
