//
//  RechargeDetailController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "RechargeDetailController.h"
#import <Masonry.h>

@interface RechargeDetailController ()

@property (nonatomic,weak) UIView *containView;
@property (nonatomic, weak) UILabel *washCarLabel;
@property (nonatomic, weak) UILabel *validityLabel;
@property (nonatomic, weak) UILabel *timesLabel;
@property (nonatomic, weak) UILabel *noticeLabel;
@property (nonatomic, weak) UILabel *noticeLabelOne;
@property (nonatomic, weak) UILabel *noticeLabeTwo;

@end

@implementation RechargeDetailController


- (void)drawNavigation {
    
    [self drawTitle:@"充值卡详情" Color:[UIColor blackColor]];
}


- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    self.contentView.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    
//    UILabel *washCarLabel = [[UILabel alloc] init];
//    washCarLabel.text = @"洗车月卡";
//    [self.view addSubview:washCarLabel];
//    
//    UILabel *validityLabel = [[UILabel alloc] init];
//    validityLabel.text = @"有效期至: 2017-8-1";
//    [self.view addSubview:validityLabel];
//    
//    UILabel *timesLabel = [[UILabel alloc] init];
//    timesLabel.text = @"免费洗车次数6次";
//    [self.view addSubview:timesLabel];
//    
//    UILabel *noticeLabel = [[UILabel alloc] init];
//    noticeLabel.text = @"使用须知";
//    [self.view addSubview:noticeLabel];
//    
//    UILabel *noticeLabelOne = [[UILabel alloc] init];
//    noticeLabelOne.text = @"1、本洗车卡由金顶洗车APP发放,仅限金顶洗车店和与金顶合作商家使用";
//    [self.view addSubview:noticeLabelOne];
//    
//    UILabel *noticeLabelTwo = [[UILabel alloc] init];
//    noticeLabelTwo.text = @"2、有任何问题,可咨询金顶客服";
//    [self.view addSubview:noticeLabelTwo];
    
    [self.washCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self.containView).mas_offset(10);
    }];
    
    [self.validityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.washCarLabel.mas_bottom).mas_offset(20);
    }];
    
    [self.timesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.validityLabel.mas_bottom).mas_offset(10);
    }];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.timesLabel.mas_bottom).mas_offset(30);
    }];
    
    [self.noticeLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.noticeLabel.mas_bottom).mas_offset(10);
        make.right.equalTo(self.containView).mas_offset(-10);
    }];
    
    [self.noticeLabeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.noticeLabelOne.mas_bottom).mas_offset(10);
    }];
    
}

- (UIView *)containView {
    
    if (!_containView) {
        UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 300)];
        containView.backgroundColor = [UIColor whiteColor];
        _containView = containView;
        [self.view addSubview:_containView];
    }
    return _containView;
}

- (UILabel *)washCarLabel {
    
    if (!_washCarLabel) {
        UILabel *washCarLabel = [[UILabel alloc] init];
        washCarLabel.text = @"洗车月卡";
        _washCarLabel = washCarLabel;
        [self.containView addSubview:_washCarLabel];
    }
    return _washCarLabel;
}

- (UILabel *)validityLabel {
    
    if (!_validityLabel) {
        
        UILabel *validityLabel = [[UILabel alloc] init];
        validityLabel.text = @"有效期至: 2017-8-1";
        _validityLabel = validityLabel;
        [self.containView addSubview:_validityLabel];
    }
    return _validityLabel;
}


- (UILabel *)timesLabel {
    
    if (!_timesLabel) {
        UILabel *timesLabel = [[UILabel alloc] init];
        timesLabel.text = @"免费洗车次数6次";
        _timesLabel = timesLabel;
        [self.containView addSubview:_timesLabel];
    }
    return _timesLabel;
}

- (UILabel *)noticeLabel {
    
    if (!_noticeLabel) {
        UILabel *noticeLabel = [[UILabel alloc] init];
        noticeLabel.text = @"使用须知";
        _noticeLabel = noticeLabel;
        [self.containView addSubview:_noticeLabel];
    }
    return _noticeLabel;
}


- (UILabel *)noticeLabelOne {
    
    if (!_noticeLabelOne) {
        UILabel *noticeLabelOne = [[UILabel alloc] init];
        noticeLabelOne.text = @"1、本洗车卡由金顶洗车APP发放,仅限金顶洗车店和与金顶合作商家使用";
        noticeLabelOne.numberOfLines = 0;
        _noticeLabelOne = noticeLabelOne;
        [self.containView addSubview:_noticeLabelOne];
    }
    return _noticeLabelOne;
}

- (UILabel *)noticeLabeTwo {
    
    if (!_noticeLabeTwo) {
        UILabel *noticeLabelTwo = [[UILabel alloc] init];
        noticeLabelTwo.text = @"2、有任何问题,可咨询金顶客服";
        _noticeLabeTwo = noticeLabelTwo;
        [self.containView addSubview:_noticeLabeTwo];
    }
    return _noticeLabeTwo;
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
