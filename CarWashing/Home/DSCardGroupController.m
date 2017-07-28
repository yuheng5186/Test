//
//  DSCardGroupController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCardGroupController.h"
#import "HQSliderView.h"
#import "HQTableViewCell.h"

@interface DSCardGroupController ()<UITableViewDelegate, UITableViewDataSource, HQSliderViewDelegate>


@property (nonatomic, weak) UITableView *cardListView;

/** 记录点击的是第几个Button */
@property (nonatomic, assign) NSInteger myCardTag;

@end

@implementation DSCardGroupController

- (void)drawNavigation {
    
    [self drawTitle:@"我的卡券" Color:[UIColor blackColor]];
    
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
    
    UITableView *cardListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, Main_Screen_Width, Main_Screen_Height - 64)];
    cardListView.delegate = self;
    cardListView.dataSource = self;
    [self.view addSubview:cardListView];
    self.cardListView = cardListView;
    
}


#pragma mark - 创建上部的SliderView
- (void)setupTopSliderView {
    
    HQSliderView *cardSliderView = [[HQSliderView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    cardSliderView.titleArr = @[@"优惠券",@"充值卡"];
    cardSliderView.delegate = self;
    [self.view addSubview:cardSliderView];
}



#pragma mark - tableview代理
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.myCardTag == 0) {
        return 3;
    } else {
        return 2;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HQTableViewCell *cardListCell = [HQTableViewCell tableViewCellWithTableView:tableView];
    cardListCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (self.myCardTag == 0) {
        cardListCell.textLabel.text = [NSString stringWithFormat:@"全部 --- 第%ld行", indexPath.row];
    } else {
        cardListCell.textLabel.text = [NSString stringWithFormat:@"待付款 --- 第%ld行", indexPath.row];
    }
    
    return cardListCell;
}



#pragma mark - HQlisderView的代理
- (void)sliderView:(HQSliderView *)sliderView didClickMenuButton:(UIButton *)button{
    
    self.myCardTag = button.tag;
    [self.cardListView reloadData];
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
