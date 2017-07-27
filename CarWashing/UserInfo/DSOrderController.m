//
//  DSOrderController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSOrderController.h"
#import "HQSliderView.h"
#import "HQTableViewCell.h"

@interface DSOrderController ()<UITableViewDelegate, UITableViewDataSource, HQSliderViewDelegate>

@property (nonatomic, weak) UITableView *orderListView;

/** 记录点击的是第几个Button */
@property (nonatomic, assign) NSInteger menuTag;

@end

@implementation DSOrderController

- (void)drawNavigation {
    
    [self drawTitle:@"全部订单" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    
    [self setupTopSliderView];
    
    UITableView *orderListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, Main_Screen_Width, Main_Screen_Height - 64)];
    orderListView.delegate = self;
    orderListView.dataSource = self;
    [self.view addSubview:orderListView];
    self.orderListView = orderListView;
}

#pragma mark - 创建上部的SliderView
- (void)setupTopSliderView {
    
    HQSliderView *sliderView = [[HQSliderView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    sliderView.titleArr = @[@"全部订单",@"待付款",@"待发货",@"待安装",@"待评价"];
    sliderView.delegate = self;
    [self.view addSubview:sliderView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.menuTag == 0) {
        return 3;
    }else if (self.menuTag == 1){
        return 6;
    }else if (self.menuTag == 2){
        return 9;
    }else if (self.menuTag == 3){
        return 12;
    }else{
        return 5;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HQTableViewCell *listCell = [HQTableViewCell tableViewCellWithTableView:tableView];
    
    if (self.menuTag == 0) {
        listCell.textLabel.text = [NSString stringWithFormat:@"全部 --- 第%ld行", indexPath.row];
    } else if (self.menuTag == 1) {
        listCell.textLabel.text = [NSString stringWithFormat:@"待付款 --- 第%ld行", indexPath.row];
    } else if (self.menuTag == 2) {
        listCell.textLabel.text = [NSString stringWithFormat:@"待发货 --- 第%ld行", indexPath.row];
    } else if (self.menuTag == 3) {
        listCell.textLabel.text = [NSString stringWithFormat:@"待安装 --- 第%ld行", indexPath.row];
    } else{
        listCell.textLabel.text = [NSString stringWithFormat:@"待评价 --- 第%ld行", indexPath.row];
    }
    
    
    return listCell;
}



#pragma mark - HQlisderView的代理
- (void)sliderView:(HQSliderView *)sliderView didClickMenuButton:(UIButton *)button{
    
    self.menuTag = button.tag;
    [self.orderListView reloadData];
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
