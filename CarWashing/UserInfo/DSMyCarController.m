//
//  DSMyCarController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSMyCarController.h"
#import "MyCarPortController.h"

@interface DSMyCarController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIImageView *carImageView;

@property (nonatomic, weak) UITableView *carInfoView;

@end

@implementation DSMyCarController

- (UIImageView *)carImageView {
    
    if (_carImageView == nil) {
        UIImageView *carImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 200)];
        _carImageView = carImageView;
        [self.view addSubview:_carImageView];
    }
    return _carImageView;
}

- (UITableView *)carInfoView {
    
    if (_carInfoView == nil) {
        
        UITableView *carInfoView = [[UITableView alloc] initWithFrame:CGRectMake(0, 264, Main_Screen_Width, Main_Screen_Height - 264) style:UITableViewStyleGrouped];
        _carInfoView = carInfoView;
        [self.view addSubview:_carInfoView];
    }
    return _carInfoView;
}


- (void)drawNavigation {
    
    [self drawTitle:@"我的爱车" Color:[UIColor blackColor]];
    [self drawRightTextButton:@"我的车库" action:@selector(clickMycarPort)];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.carImageView.image = [UIImage imageNamed:@"02"];
    
    self.carInfoView.delegate = self;
    self.carInfoView.dataSource = self;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *id_carCell = @"id_carCell";
    UITableViewCell *carCell = [tableView dequeueReusableCellWithIdentifier:id_carCell];
    
    carCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:id_carCell];
    
    
    carCell.textLabel.text = @"发动机";
    carCell.detailTextLabel.text = @"2.0T";
    carCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return carCell;
}



#pragma mark -点击我的车库
- (void)clickMycarPort {
    
    MyCarPortController *carPortVC = [[MyCarPortController alloc] init];
    
    carPortVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:carPortVC animated:YES];
    
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
