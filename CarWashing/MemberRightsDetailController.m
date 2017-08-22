//
//  MemberRightsDetailController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/22.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MemberRightsDetailController.h"
#import <Masonry.h>

@interface MemberRightsDetailController ()<UITableViewDelegate, UITableViewDataSource>



@end

@implementation MemberRightsDetailController

- (void)drawNavigation {
    
    [self drawTitle:@"特权详情"];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    
    UIImageView *cardImgV = [[UIImageView alloc] init];
    cardImgV.image = [UIImage imageNamed:@"tiyankaditu"];
    [self.view addSubview:cardImgV];
    
    UILabel *cardNameLab = [[UILabel alloc] init];
    cardNameLab.text = @"体验卡";
    cardNameLab.textColor = [UIColor colorFromHex:@"#ffffff"];
    cardNameLab.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
    [cardImgV addSubview:cardNameLab];
    
    UILabel *timesLab = [[UILabel alloc] init];
    timesLab.text = @"免费洗车2次";
    timesLab.textColor = [UIColor colorFromHex:@"#ffffff"];
    timesLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [cardImgV addSubview:timesLab];
    
    UILabel *invalidLab = [[UILabel alloc] init];
    invalidLab.text = @"截止日期：2017-8-10";
    invalidLab.textColor = [UIColor colorFromHex:@"#ffffff"];
    invalidLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [cardImgV addSubview:invalidLab];
    
    UIButton *getBtn = [UIUtil drawDefaultButton:self.view title:@"立即领取" target:self action:@selector(didClickGetBtn)];
    
    UIButton *checkCardBtn = [[UIButton alloc] init];
    [checkCardBtn setTitle:@"查看卡包" forState:UIControlStateNormal];
    [checkCardBtn setTitleColor:[UIColor colorFromHex:@"#999999"] forState:UIControlStateNormal];
    checkCardBtn.titleLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
    [checkCardBtn addTarget:self action:@selector(didClickCheckCardBtn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkCardBtn];
    
    
    //约束
    [cardImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).mas_offset(64 + 26*Main_Screen_Height/667);
        make.left.equalTo(self.view).mas_offset(12*Main_Screen_Height/667);
        make.right.equalTo(self.view).mas_offset(-12*Main_Screen_Height/667);
        make.height.mas_equalTo(90*Main_Screen_Height/667);
    }];
    
    [cardNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardImgV).mas_offset(12*Main_Screen_Height/667);
        make.left.equalTo(cardImgV).mas_offset(14*Main_Screen_Height/667);
    }];
    
    [timesLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardNameLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
        make.leading.equalTo(cardNameLab);
    }];
    
    [invalidLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(timesLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
        make.leading.equalTo(cardNameLab);
    }];
    
    [getBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(cardImgV.mas_bottom).mas_offset(19*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(351*Main_Screen_Height/667);
        make.height.mas_equalTo(48*Main_Screen_Height/667);
    }];
    
    [checkCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(getBtn.mas_bottom).mas_offset(18*Main_Screen_Height/667);
        make.centerX.equalTo(self.view);
    }];
    
    UITableView *noticeView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //noticeView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:noticeView];
    
    [noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(checkCardBtn.mas_bottom).mas_offset(18*Main_Screen_Height/667);
        make.bottom.equalTo(self.view);
        make.width.mas_equalTo(Main_Screen_Width);
    }];
    noticeView.delegate = self;
    noticeView.dataSource = self;
    noticeView.estimatedRowHeight = 80;
    noticeView.rowHeight = UITableViewAutomaticDimension;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *id_noticeCell = @"id_noticeCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:id_noticeCell];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id_noticeCell];
//    UILabel *titleLab = [[UILabel alloc] init];
//    titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
//    titleLab.font = [UIFont systemFontOfSize:14];
//    [cell.contentView addSubview:titleLab];
//    
//    UILabel *infosLab = [[UILabel alloc] init];
//    infosLab.textColor = [UIColor colorFromHex:@"#999999"];
//    infosLab.font = [UIFont systemFontOfSize:13];
//    infosLab.numberOfLines = 0;
//    [cell.contentView addSubview:infosLab];
//    
//    [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(cell.contentView).mas_offset(15);
//        make.left.equalTo(cell.contentView).mas_offset(12);
//    }];
    
    if (indexPath.section == 0) {
        
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        titleLab.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
        [cell.contentView addSubview:titleLab];
        
        UILabel *infosLab = [[UILabel alloc] init];
        infosLab.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        infosLab.numberOfLines = 0;
        titleLab.text = @"特权介绍";
        infosLab.text = @"白银会员每月可领取10元代金券，不可以和其他优惠活动叠加使用";
        [cell.contentView addSubview:infosLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).mas_offset(8*Main_Screen_Height/667);
            make.left.equalTo(cell.contentView).mas_offset(12*Main_Screen_Height/667);
        }];
        
        [infosLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(titleLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
            make.bottom.equalTo(cell.contentView).mas_offset(-8*Main_Screen_Height/667);
        }];
        
        
    }else if (indexPath.section == 1) {
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        titleLab.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
        [cell.contentView addSubview:titleLab];
        
        UILabel *infosLab = [[UILabel alloc] init];
        infosLab.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        infosLab.numberOfLines = 0;
        titleLab.text = @"领取对象";
        infosLab.text = @"白银会员";
        [cell.contentView addSubview:infosLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).mas_offset(8*Main_Screen_Height/667);
            make.left.equalTo(cell.contentView).mas_offset(12*Main_Screen_Height/667);
        }];
        
        [infosLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(titleLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
            make.bottom.equalTo(cell.contentView).mas_offset(-8*Main_Screen_Height/667);
        }];
        
        
    }else {
        UILabel *titleLab = [[UILabel alloc] init];
        titleLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        titleLab.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
        [cell.contentView addSubview:titleLab];
        
        UILabel *infosLab = [[UILabel alloc] init];
        infosLab.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        infosLab.numberOfLines = 0;
        [cell.contentView addSubview:infosLab];
        
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(cell.contentView).mas_offset(8*Main_Screen_Height/667);
            make.left.equalTo(cell.contentView).mas_offset(12*Main_Screen_Height/667);
        }];
        
        [infosLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(titleLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
        }];
        
        UILabel *infosLab2 = [[UILabel alloc] init];
        infosLab2.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab2.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        infosLab2.numberOfLines = 0;
        [cell.contentView addSubview:infosLab2];
        
        UILabel *infosLab3 = [[UILabel alloc] init];
        infosLab3.textColor = [UIColor colorFromHex:@"#999999"];
        infosLab3.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        infosLab3.numberOfLines = 0;
        [cell.contentView addSubview:infosLab3];
        
        titleLab.text = @"使用须知";
        infosLab.text = @"1、本代金券由金顶洗车APP开发，仅限金顶洗车店和与金顶合作商家使用";
        infosLab2.text = @"2、如果代金券购买服务时发生了退服务行为，代金券不予退还";
        infosLab3.text = @"3、有任何问题，可咨询金顶客服";
        
        [infosLab2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infosLab.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(infosLab);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
        }];
        
        [infosLab3 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(infosLab2.mas_bottom).mas_offset(8*Main_Screen_Height/667);
            make.leading.equalTo(infosLab2);
            make.right.equalTo(cell.contentView).mas_offset(-12*Main_Screen_Height/667);
            make.bottom.equalTo(cell.contentView).mas_offset(-8*Main_Screen_Height/667);
        }];
        
        
        
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}



#pragma mark -
- (void)didClickGetBtn {
    
}

- (void)didClickCheckCardBtn {
    
}

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
