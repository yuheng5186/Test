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

@property (nonatomic, weak) UIButton *increaseButton;

@end

static NSString *id_carInfoCell = @"id_carInfoCell";

@implementation IcreaseCarController

- (UIButton *)increaseButton {
    if (!_increaseButton) {
        UIButton *increaseButton = [[UIButton alloc] init];
        increaseButton.backgroundColor = [UIColor orangeColor];
        [increaseButton setTitle:@"保存" forState:UIControlStateNormal];
        _increaseButton = increaseButton;
        [self.view addSubview:_increaseButton];
    }
    return _increaseButton;
}



- (void)drawNavigation {
    
    [self drawTitle:@"新增车辆" Color:[UIColor blackColor]];
    
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *carInfoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 400) style:UITableViewStyleGrouped];
    carInfoView.bounces = NO;
    [self.view addSubview:carInfoView];
    
    carInfoView.delegate = self;
    carInfoView.dataSource = self;
    
    [self.increaseButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(carInfoView.mas_bottom).mas_offset(20);
        make.centerX.equalTo(self.view);
        make.width.mas_equalTo(Main_Screen_Width / 3 *2);
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
    UITableViewCell *carInfoCell = [tableView dequeueReusableCellWithIdentifier:id_carInfoCell];
    
    carInfoCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id_carInfoCell];
    
    return carInfoCell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}



@end
