//
//  DSMembershipController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSMembershipController.h"
#import "MemberView.h"
#import "MemberRegualrController.h"
#import "DSMemberRightsController.h"
#import "ScoreDetailController.h"
#import <Masonry.h>
#import "GoodsViewLayout.h"
#import "GoodsViewCell.h"
#import "WashCarTicketController.h"

@interface DSMembershipController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

static NSString *id_goodsCell = @"id_goodsCell";

@implementation DSMembershipController

- (void)drawNavigation {
    
    [self drawTitle:@"金顶会员"];
    [self drawRightTextButton:@"积分规则" action:@selector(clickRegularButton)];
    
    
    
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
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *goodsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    goodsView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:goodsView];
    
    
    //约束
    [exchangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(memberShipView.mas_bottom).mas_offset(10);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    [exchangeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(exchangeView);
    }];
    
    [goodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(exchangeView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
    }];
    
    goodsView.delegate = self;
    goodsView.dataSource = self;
    
    [goodsView registerClass:[GoodsViewCell class] forCellWithReuseIdentifier:id_goodsCell];
    
}

- (void)clickRegularButton{
    
    MemberRegualrController *regularController = [[MemberRegualrController alloc] init];
    
    [self.navigationController pushViewController:regularController animated:YES];
    
}


#pragma mark - 点击赚积分
- (IBAction)clickEarnScoreBtn:(UIButton *)sender {
    
    ScoreDetailController *scoreDetailVC    = [[ScoreDetailController alloc] init];
    scoreDetailVC.hidesBottomBarWhenPushed  = YES;
    [self.navigationController pushViewController:scoreDetailVC animated:YES];
}

#pragma mark - 点击升级
- (IBAction)clickUpgradeBtn:(UIButton *)sender {
    
    DSMemberRightsController *rightsController = [[DSMemberRightsController alloc] init];
    rightsController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:rightsController animated:YES];
    
}


#pragma mark - UICollectionView的数据源和代理
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    GoodsViewCell *goodsCell = [collectionView dequeueReusableCellWithReuseIdentifier:id_goodsCell forIndexPath:indexPath];
    goodsCell.backgroundColor = [UIColor whiteColor];
    
    return goodsCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WashCarTicketController *ticketVC = [[WashCarTicketController alloc] init];
    ticketVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ticketVC animated:YES];
}

#pragma mark - item布局设置
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(140, 80);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 15;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 36;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    return UIEdgeInsetsMake(7.5, 29.5, 7.5, 29.5);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
