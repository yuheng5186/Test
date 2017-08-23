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
#import <Masonry.h>
#import "DSMembershipController.h"

@interface ScoreDetailController ()<UITableViewDelegate, UITableViewDataSource, HQSliderViewDelegate>

@property (nonatomic, weak) UITableView *scoreListView;

@property (nonatomic, weak) HQSliderView *sliderView;

@property (nonatomic, weak) UIView *headView;
@property (nonatomic, weak) UIButton *earnButton;
@property (nonatomic, weak) UIButton *exchangeButton;
@property (nonatomic, weak) UILabel *scoreLabel;

/** 记录点击的是第几个Button */
@property (nonatomic, assign) NSInteger scoreTag;

@end

@implementation ScoreDetailController

- (UIView *)headView {
    
    if (!_headView) {
        UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 175*Main_Screen_Height/667)];
        headView.backgroundColor = [UIColor whiteColor];
        _headView = headView;
        [self.view addSubview:_headView];
    }
    
    return _headView;
}

- (UILabel *)scoreLabel {
    
    if (!_scoreLabel) {
        
        UILabel *scoreLabel = [[UILabel alloc] init];
        scoreLabel.textColor = [UIColor colorFromHex:@"#febb02"];
        scoreLabel.font = [UIFont systemFontOfSize:38*Main_Screen_Height/667];
        _scoreLabel = scoreLabel;
        [self.headView addSubview:_scoreLabel];
    }
    
    return _scoreLabel;
}


- (UIButton *)earnButton {
    
    if (!_earnButton) {
        
        UIButton *earnButton = [[UIButton alloc] init];
        [earnButton setTitle:@"赚积分" forState:UIControlStateNormal];
        [earnButton setTitleColor:[UIColor colorFromHex:@"#4a4a4a"] forState:UIControlStateNormal];
        earnButton.layer.cornerRadius = 20*Main_Screen_Height/667;
        earnButton.layer.borderWidth = 1;
        earnButton.layer.borderColor = [UIColor blackColor].CGColor;
        _earnButton = earnButton;
        [self.headView addSubview:_earnButton];
    }
    
    return _earnButton;
}

- (UIButton *)exchangeButton {
    
    if (!_exchangeButton) {
        
        UIButton *exchangeButton = [[UIButton alloc] init];
        [exchangeButton setTitle:@"积分兑换" forState:UIControlStateNormal];
        [exchangeButton setTitleColor:[UIColor colorFromHex:@"#4a4a4a"] forState:UIControlStateNormal];
        exchangeButton.layer.cornerRadius = 20*Main_Screen_Height/667;
        exchangeButton.layer.borderWidth = 1;
        exchangeButton.layer.borderColor = [UIColor blackColor].CGColor;
        _exchangeButton = exchangeButton;
        [self.headView addSubview:_exchangeButton];
    }
    
    return _exchangeButton;
}



- (UITableView *)scoreListView {
    
    if (_scoreListView == nil) {
        UITableView *scoreListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _scoreListView = scoreListView;
        [self.view addSubview:_scoreListView];
        
        if ([_scoreListView respondsToSelector:@selector(setSeparatorInset:)]) {
            [_scoreListView setSeparatorInset:UIEdgeInsetsZero];
        }
    }
    
    return _scoreListView;
}


- (void)drawNavigation{
    
    [self drawTitle:@"我的积分"];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    
    [self setupTopSliderView];
    
    self.scoreListView.delegate = self;
    self.scoreListView.dataSource = self;
    self.scoreListView.rowHeight = 60*Main_Screen_Height/667;
    
    self.scoreLabel.text = @"1680";
    
    [self.earnButton addTarget:self action:@selector(didClickEarnScoreBtn) forControlEvents:UIControlEventTouchUpInside];
    
    [self.exchangeButton addTarget:self action:@selector(didExchangeScoreBtn) forControlEvents:UIControlEventTouchUpInside];
    
    //约束
    [_scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView).mas_offset(33*Main_Screen_Height/667);
        make.centerX.equalTo(_headView);
    }];
    
    [_earnButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_scoreLabel.mas_bottom).mas_offset(25*Main_Screen_Height/667);
        make.left.equalTo(_headView).mas_offset(28*Main_Screen_Height/667);
        make.width.mas_equalTo(130*Main_Screen_Height/667);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
    }];
    
    [_exchangeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_earnButton);
        make.right.equalTo(_headView).mas_offset(-28*Main_Screen_Height/667);
        make.width.mas_equalTo(130*Main_Screen_Height/667);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
    }];
    
    [_scoreListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_sliderView.mas_bottom).mas_offset(1);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
    }];
    
    [_sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headView.mas_bottom).mas_offset(10);
        make.width.mas_equalTo(Main_Screen_Width);
        make.height.mas_equalTo(44*Main_Screen_Height/667);
    }];
    
}


#pragma mark - 创建上部的SliderView
- (void)setupTopSliderView {
    
    HQSliderView *sliderView = [[HQSliderView alloc] initWithFrame:CGRectZero];
    _sliderView = sliderView;
    sliderView.backgroundColor  = [UIColor whiteColor];
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
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    cell.backgroundColor            = [UIColor whiteColor];
//    cell.textLabel.font             = [UIFont systemFontOfSize:14];
//    cell.detailTextLabel.font       = [UIFont systemFontOfSize:12];
//    cell.detailTextLabel.textColor  = [UIColor colorFromHex:@"#999999"];
    NSString *titleString ;
    if (indexPath.row == 0) {
        titleString     = @"每日签到";
    }
    if (indexPath.row == 1) {
        titleString     = @"评论商品";
    }
    if (indexPath.row == 2) {
        titleString     = @"分享好友";
    }
    
    if (indexPath.row == 3) {
        titleString     = @"兑换1元现金券";
    }
    
    UIFont *titleStringFont            = [UIFont systemFontOfSize:14];
    UILabel *titleStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:titleString font:titleStringFont] font:titleStringFont text:titleString isCenter:NO];
    titleStringLabel.textColor         = [UIColor colorFromHex:@"#4a4a4a"];
    titleStringLabel.left              = Main_Screen_Width*13/375;
    titleStringLabel.top               = Main_Screen_Height*10/667;
    
    NSString *timeString              = @"2017-7-27 15:30";
    UIFont *timeStringFont            = [UIFont systemFontOfSize:12];
    UILabel *timeStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:timeString font:timeStringFont] font:timeStringFont text:timeString isCenter:NO];
    timeStringLabel.textColor         = [UIColor colorFromHex:@"#999999"];
    timeStringLabel.left              = titleStringLabel.left;
    timeStringLabel.top               = titleStringLabel.bottom +Main_Screen_Height*5/667;
    
    NSString *contentString              = @"+20";
    UIFont *contentStringFont            = [UIFont systemFontOfSize:12];
    UILabel *contentStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:contentString font:contentStringFont] font:contentStringFont text:contentString isCenter:NO];
    contentStringLabel.textColor         = [UIColor redColor];
    contentStringLabel.right             = Main_Screen_Width -Main_Screen_Width*12/375;
    contentStringLabel.top               = Main_Screen_Height*9/667;
    
    
    
//    HQTableViewCell *scoreCell = [HQTableViewCell tableViewCellWithTableView:tableView];
//
//    if (self.scoreTag == 0) {
//        
//        scoreCell.textLabel.text = @"每日签到";
//        scoreCell.detailTextLabel.text = @"2017-07-20";
//        UILabel *scoreLbl = [[UILabel alloc] init];
//        scoreLbl.text = @"+4";
//        scoreCell.accessoryView = scoreLbl;
//    } else if (self.scoreTag == 1) {
//        
//        scoreCell.textLabel.text = [NSString stringWithFormat:@"待付款 --- 第%ld行", indexPath.row];
//    } else{
//        
//        scoreCell.textLabel.text = [NSString stringWithFormat:@"待评价 --- 第%ld行", indexPath.row];
//    }
//    
//    
    return cell;
}


#pragma mark - HQlisderView的代理
- (void)sliderView:(HQSliderView *)sliderView didClickMenuButton:(UIButton *)button{
    
    self.scoreTag = button.tag;
    [self.scoreListView reloadData];
}


#pragma mark - 点击赚积分按钮和兑换按钮
- (void)didClickEarnScoreBtn {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didExchangeScoreBtn {
    
    //DSMembershipController *memberVC = [[DSMembershipController alloc] init];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[DSMembershipController class]]) {
            DSMembershipController *memberVC =(DSMembershipController *)controller;
            [self.navigationController popToViewController:memberVC animated:YES];
        }
    }
    
    
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
