//
//  ScoreDetailController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/27.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ScoreDetailController.h"
#import "HQSliderView.h"
#import "HQTableViewCell.h"

@interface ScoreDetailController ()<UITableViewDelegate, UITableViewDataSource, HQSliderViewDelegate>

@property (nonatomic, weak) UITableView *scoreListView;

/** 记录点击的是第几个Button */
@property (nonatomic, assign) NSInteger scoreTag;

@end

@implementation ScoreDetailController

- (UITableView *)scoreListView {
    
    if (_scoreListView == nil) {
        UITableView *scoreListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, Main_Screen_Width, Main_Screen_Height - 64)];
        _scoreListView = scoreListView;
        [self.view addSubview:_scoreListView];
    }
    
    return _scoreListView;
}


- (void)drawNavigation{
    
    [self drawTitle:@"积分详情"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    
    [self setupTopSliderView];
    
    self.scoreListView.delegate = self;
    self.scoreListView.dataSource = self;
    
}


#pragma mark - 创建上部的SliderView
- (void)setupTopSliderView {
    
    HQSliderView *sliderView = [[HQSliderView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 44)];
    sliderView.titleArr = @[@"全部",@"收入",@"支出"];
    sliderView.delegate = self;
    [self.view addSubview:sliderView];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.scoreTag == 0) {
        return 3;
    }else if (self.scoreTag == 1){
        return 6;
    }else{
        return 5;
    }
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    HQTableViewCell *scoreCell = [HQTableViewCell tableViewCellWithTableView:tableView];
    
    if (self.scoreTag == 0) {
        
        scoreCell.textLabel.text = [NSString stringWithFormat:@"全部 --- 第%ld行", indexPath.row];
        scoreCell.detailTextLabel.text = @"2010";
        UILabel *scoreLbl = [[UILabel alloc] init];
        scoreLbl.text = @"+4";
        scoreCell.accessoryView = scoreLbl;
    } else if (self.scoreTag == 1) {
        
        scoreCell.textLabel.text = [NSString stringWithFormat:@"待付款 --- 第%ld行", indexPath.row];
    } else{
        
        scoreCell.textLabel.text = [NSString stringWithFormat:@"待评价 --- 第%ld行", indexPath.row];
    }
    
    
    return scoreCell;
}


#pragma mark - HQlisderView的代理
- (void)sliderView:(HQSliderView *)sliderView didClickMenuButton:(UIButton *)button{
    
    self.scoreTag = button.tag;
    [self.scoreListView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
