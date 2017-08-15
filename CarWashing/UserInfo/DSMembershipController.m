//
//  DSMembershipController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSMembershipController.h"
#import "MemberView.h"
#import "DSMemberRightsController.h"
#import "ScoreDetailController.h"
#import <Masonry.h>
#import "WashCarTicketController.h"
#import "GoodsExchangeCell.h"
#import "EarnScoreController.h"

@interface DSMembershipController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *exchangListView;

@end

static NSString *id_exchangeCell = @"id_exchangeCell";

@implementation DSMembershipController

- (UITableView *)exchangListView {
    
    if (!_exchangListView) {
        
        UITableView *exchangeListView = [[UITableView alloc] init];
        _exchangListView = exchangeListView;
        [self.view addSubview:_exchangListView];
    }
    
    return _exchangListView;
}



- (void)drawNavigation {
    
    [self drawTitle:@"金顶会员"];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupUI];
}


- (void)setupUI {
    
    MemberView *memberShipView = [MemberView memberView];
    memberShipView.frame = CGRectMake(0, 64, Main_Screen_Width, 113);
    [self.view addSubview:memberShipView];
    
    UIView *exchangeView = [[UIView alloc] init];
    [self.view addSubview:exchangeView];
    
    UILabel *exchangeLabel = [[UILabel alloc] init];
    exchangeLabel.text = @"精品兑换";
    exchangeLabel.font = [UIFont systemFontOfSize:14];
    exchangeLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [exchangeView addSubview:exchangeLabel];
    
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
//    UICollectionView *goodsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
//    goodsView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:goodsView];
//
    
    self.exchangListView.delegate = self;
    self.exchangListView.dataSource = self;
    [self.exchangListView registerClass:[GoodsExchangeCell class] forCellReuseIdentifier:id_exchangeCell];
    
    //约束
    [exchangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(memberShipView.mas_bottom).mas_offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [exchangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(exchangeView);
    }];
    
//    [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(exchangeView.mas_bottom);
//        make.left.right.bottom.equalTo(self.view);
//    }];
//    
//    goodsView.delegate = self;
//    goodsView.dataSource = self;
//    
//    [goodsView registerClass:[GoodsViewCell class] forCellWithReuseIdentifier:id_goodsCell];
    
    [_exchangListView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(exchangeView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
}




#pragma mark - 点击赚积分
- (IBAction)clickEarnScoreBtn:(UIButton *)sender {
    
    EarnScoreController *earnScoreVC    = [[EarnScoreController alloc] init];
    earnScoreVC.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:earnScoreVC animated:YES];
}

#pragma mark - 点击升级
- (IBAction)clickUpgradeBtn:(UIButton *)sender {
    
    DSMemberRightsController *rightsController = [[DSMemberRightsController alloc] init];
    rightsController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:rightsController animated:YES];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsExchangeCell *changeCell = [tableView dequeueReusableCellWithIdentifier:id_exchangeCell forIndexPath:indexPath];
    
    return changeCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

//#pragma mark - UICollectionView的数据源和代理
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    return 1;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    return 4;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    GoodsViewCell *goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:id_goodsCell forIndexPath:indexPath];
//    goodsCell.backgroundColor = [UIColor whiteColor];
//    
//    return goodsCell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    
//    WashCarTicketController *ticketVC = [[WashCarTicketController alloc] init];
//    ticketVC.hidesBottomBarWhenPushed = YES;
//    [self.navigationController pushViewController:ticketVC animated:YES];
//}
//
//#pragma mark - item布局设置
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
//    
//    return CGSizeMake(140, 80);
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    
//    return 36;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    return 36;
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    
//    return UIEdgeInsetsMake(18, 23.75, 18, 23.75);
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
