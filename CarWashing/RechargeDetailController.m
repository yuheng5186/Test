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
@property (nonatomic, weak) UILabel *noticeLabelThree;
@property (nonatomic, weak) UILabel *noticeLabelFour;
@property (nonatomic, weak) UILabel *noticeLabelFive;


@property (nonatomic, weak) UIView  *titleView;

@end

@implementation RechargeDetailController


- (void)drawNavigation {
    
    [self drawTitle:@"充值卡详情"];
}


- (void) drawContent
{
//    self.statusView.backgroundColor     = [UIColor grayColor];
//    self.navigationView.backgroundColor = [UIColor grayColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}


- (void)setupUI {
    
    
    self.washCarLabel.text = self.card.CardName;
    self.validityLabel.text = [NSString stringWithFormat:@"有效期至%@",self.card.ExpEndDates];
    self.timesLabel.text = [NSString stringWithFormat:@"免费洗车次数%ld次",self.card.CardCount];
    
    
    [self.washCarLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.containView).mas_offset(20*Main_Screen_Height/667);
        make.left.equalTo(self.containView).mas_offset(10*Main_Screen_Height/667);
    }];
    
    [self.validityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.washCarLabel.mas_bottom).mas_offset(15*Main_Screen_Height/667);
    }];
    
    [self.timesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.validityLabel.mas_bottom).mas_offset(15*Main_Screen_Height/667);
    }];
    
    [self.noticeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.timesLabel.mas_bottom).mas_offset(35*Main_Screen_Height/667);
    }];
    
    [self.noticeLabelOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.noticeLabel.mas_bottom).mas_offset(15*Main_Screen_Height/667);
        make.right.equalTo(self.containView).mas_offset(-10*Main_Screen_Height/667);
    }];
    
    [self.noticeLabeTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.noticeLabelOne.mas_bottom).mas_offset(15*Main_Screen_Height/667);
        make.right.equalTo(self.containView).mas_offset(-10*Main_Screen_Height/667);
    }];
    
    [self.noticeLabelThree mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.noticeLabeTwo.mas_bottom).mas_offset(15*Main_Screen_Height/667);
        make.right.equalTo(self.containView).mas_offset(-10*Main_Screen_Height/667);
    }];
    
    [self.noticeLabelFour mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.noticeLabelThree.mas_bottom).mas_offset(15*Main_Screen_Height/667);
        make.right.equalTo(self.containView).mas_offset(-10*Main_Screen_Height/667);
    }];
    
    [self.noticeLabelFive mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.washCarLabel);
        make.top.equalTo(self.noticeLabelFour.mas_bottom).mas_offset(15*Main_Screen_Height/667);
        make.right.equalTo(self.containView).mas_offset(-10*Main_Screen_Height/667);
    }];
    
}

- (UIView *)containView {
    
    if (!_containView) {
        UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height)];
        containView.backgroundColor = [UIColor whiteColor];
        _containView = containView;
        [self.view addSubview:_containView];
    }
    return _containView;
}

- (UILabel *)washCarLabel {
    
    if (!_washCarLabel) {
        UILabel *washCarLabel = [[UILabel alloc] init];
        washCarLabel.text = self.card.CardName;
        washCarLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        washCarLabel.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
        _washCarLabel = washCarLabel;
        [self.containView addSubview:_washCarLabel];
    }
    return _washCarLabel;
}

- (UILabel *)validityLabel {
    
    if (!_validityLabel) {
        
        UILabel *validityLabel = [[UILabel alloc] init];
        validityLabel.text = [NSString stringWithFormat:@"有效期至%@",self.card.ExpEndDates];
        validityLabel.textColor = [UIColor colorFromHex:@"#999999"];
        validityLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        _validityLabel = validityLabel;
        [self.containView addSubview:_validityLabel];
    }
    return _validityLabel;
}


- (UILabel *)timesLabel {
    
    if (!_timesLabel) {
        UILabel *timesLabel = [[UILabel alloc] init];
        timesLabel.text = [NSString stringWithFormat:@"免费洗车次数%ld次",self.card.CardCount];
        timesLabel.textColor = [UIColor colorFromHex:@"#999999"];
        timesLabel.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        _timesLabel = timesLabel;
        [self.containView addSubview:_timesLabel];
    }
    return _timesLabel;
}

- (UILabel *)noticeLabel {
    
    if (!_noticeLabel) {
        UILabel *noticeLabel = [[UILabel alloc] init];
        noticeLabel.text = @"使用须知";
        noticeLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
        noticeLabel.font = [UIFont systemFontOfSize:16*Main_Screen_Height/667];
        _noticeLabel = noticeLabel;
        [self.containView addSubview:_noticeLabel];
    }
    return _noticeLabel;
}


- (UILabel *)noticeLabelOne {
    
    if (!_noticeLabelOne) {
        UILabel *noticeLabelOne = [[UILabel alloc] init];
        noticeLabelOne.text = @"1、此卡仅限清洗汽车外观，不得购买其它服务项目";
        noticeLabelOne.numberOfLines = 0;
        noticeLabelOne.textColor = [UIColor colorFromHex:@"#999999"];
        noticeLabelOne.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        _noticeLabelOne = noticeLabelOne;
        [self.containView addSubview:_noticeLabelOne];
    }
    return _noticeLabelOne;
}

- (UILabel *)noticeLabeTwo {
    
    if (!_noticeLabeTwo) {
        UILabel *noticeLabelTwo = [[UILabel alloc] init];
        noticeLabelTwo.text = @"2、洗车卡不能兑换现金和转赠与其他人使用";
        noticeLabelTwo.textColor = [UIColor colorFromHex:@"#999999"];
        noticeLabelTwo.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        _noticeLabeTwo = noticeLabelTwo;
        [self.containView addSubview:_noticeLabeTwo];
    }
    return _noticeLabeTwo;
}


- (UILabel *)noticeLabelThree {
    
    if (!_noticeLabelThree) {
        
        UILabel *noticeLabelThree = [[UILabel alloc] init];
        noticeLabelThree.text = @"3、此卡一经售出，概不兑现。不记名，不挂失，不退卡，不补办";
        noticeLabelThree.textColor = [UIColor colorFromHex:@"#999999"];
        noticeLabelThree.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        noticeLabelThree.numberOfLines = 0;
        _noticeLabelThree = noticeLabelThree;
        [self.containView addSubview:_noticeLabelThree];
    }
    
    return _noticeLabelThree;
}


- (UILabel *)noticeLabelFour {
    
    if (!_noticeLabelFour) {
        
        UILabel *noticeLabelFour = [[UILabel alloc] init];
        noticeLabelFour.text = @"4、此卡可在蔷薇服务点享受会员优惠待遇，不得与其它优惠同时使用";
        noticeLabelFour.textColor = [UIColor colorFromHex:@"#999999"];
        noticeLabelFour.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        noticeLabelFour.numberOfLines = 0;
        _noticeLabelFour = noticeLabelFour;
        [self.containView addSubview:_noticeLabelFour];
    }
    
    return _noticeLabelFour;
}


- (UILabel *)noticeLabelFive {
    
    if (!_noticeLabelFive) {
        
        UILabel *noticeLabelFive = [[UILabel alloc] init];
        noticeLabelFive.text = @"5、由青岛蔷薇汽车服务有限公司保留此卡法律范围内的最终解释权。VIP热线：4006979558";
        noticeLabelFive.textColor = [UIColor colorFromHex:@"#999999"];
        noticeLabelFive.font = [UIFont systemFontOfSize:13*Main_Screen_Height/667];
        noticeLabelFive.numberOfLines = 0;
        _noticeLabelFive = noticeLabelFive;
        [self.containView addSubview:_noticeLabelFive];
    }
    
    return _noticeLabelFive;
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
