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
#import "HowToUpGradeController.h"


@interface DSMembershipController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) UITableView *exchangListView;

@end

static NSString *id_exchangeCell = @"id_exchangeCell";

@implementation DSMembershipController

- (UITableView *)exchangListView {
    
    if (!_exchangListView) {
        
        UITableView *exchangeListView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
}


- (void)setupUI {
    
    MemberView *memberShipView = [MemberView memberView];
    memberShipView.frame = CGRectMake(0, 64*Main_Screen_Height/667, Main_Screen_Width, 113*Main_Screen_Height/667);
    [self.view addSubview:memberShipView];
    
    UIView *exchangeView = [[UIView alloc] init];
    
    [self.view addSubview:exchangeView];
    
    UILabel *exchangeLabel = [[UILabel alloc] init];
    exchangeLabel.text = @"精品兑换";
    exchangeLabel.font = [UIFont systemFontOfSize:14*Main_Screen_Height/667];
    exchangeLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    [exchangeView addSubview:exchangeLabel];
    
    //    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    //    UICollectionView *goodsView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    //    goodsView.backgroundColor = [UIColor whiteColor];
    //    [self.view addSubview:goodsView];
    //
    self.exchangListView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.exchangListView.delegate = self;
    self.exchangListView.dataSource = self;
    self.exchangListView.rowHeight = 90*Main_Screen_Height/667;
    self.exchangListView.backgroundColor = [UIColor whiteColor];
    
    [self.exchangListView registerClass:[GoodsExchangeCell class] forCellReuseIdentifier:id_exchangeCell];
    
    //约束
    [exchangeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(memberShipView.mas_bottom).mas_offset(10*Main_Screen_Height/667);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(40*Main_Screen_Height/667);
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
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view).mas_equalTo(10*Main_Screen_Height/667);
        make.right.equalTo(self.view).mas_equalTo(-10*Main_Screen_Height/667);
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
    
    HowToUpGradeController *upGradeVC = [[HowToUpGradeController alloc] init];
    upGradeVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:upGradeVC animated:YES];
    
}


#pragma mark - 点击会员按钮
- (IBAction)clickMemberButton:(UIButton *)sender {
    
    DSMemberRightsController *rightsController = [[DSMemberRightsController alloc] init];
    rightsController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:rightsController animated:YES];
    
}

#pragma mark - 点击积分数值按钮
- (IBAction)clickMemberScoreBtn:(UIButton *)sender {
    
    ScoreDetailController *scoreVC = [[ScoreDetailController alloc] init];
    scoreVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:scoreVC animated:YES];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    GoodsExchangeCell *changeCell = [tableView dequeueReusableCellWithIdentifier:id_exchangeCell forIndexPath:indexPath];
    
    
    
    
    return changeCell;
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    WashCarTicketController *ticketVC = [[WashCarTicketController alloc] init];
    ticketVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:ticketVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 10*Main_Screen_Height/667;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *v = [[UIView alloc] init];
    v.backgroundColor = [UIColor whiteColor];
    
    return v;
}


//- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // 圆角弧度半径
//    CGFloat cornerRadius = 6.f;
//    // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
//    cell.backgroundColor = UIColor.clearColor;
//
//    // 创建一个shapeLayer
//    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
//    CAShapeLayer *backgroundLayer = [[CAShapeLayer alloc] init]; //显示选中
//    // 创建一个可变的图像Path句柄，该路径用于保存绘图信息
//    CGMutablePathRef pathRef = CGPathCreateMutable();
//    // 获取cell的size
//    // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
//    CGRect bounds = CGRectInset(cell.bounds, 10, 0);
//
//    // CGRectGetMinY：返回对象顶点坐标
//    // CGRectGetMaxY：返回对象底点坐标
//    // CGRectGetMinX：返回对象左边缘坐标
//    // CGRectGetMaxX：返回对象右边缘坐标
//    // CGRectGetMidX: 返回对象中心点的X坐标
//    // CGRectGetMidY: 返回对象中心点的Y坐标
//
//    // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
//
//    // CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
//    if (indexPath.row == 0) {
//        // 初始起点为cell的左下角坐标
//        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
//        // 起始坐标为左下角，设为p，（CGRectGetMinX(bounds), CGRectGetMinY(bounds)）为左上角的点，设为p1(x1,y1)，(CGRectGetMidX(bounds), CGRectGetMinY(bounds))为顶部中点的点，设为p2(x2,y2)。然后连接p1和p2为一条直线l1，连接初始点p到p1成一条直线l，则在两条直线相交处绘制弧度为r的圆角。
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//        // 终点坐标为右下角坐标点，把绘图信息都放到路径中去,根据这些路径就构成了一块区域了
//        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
//
//    } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
//        // 初始起点为cell的左上角坐标
//        CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
//        CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
//        // 添加一条直线，终点坐标为右下角坐标点并放到路径中去
//        CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
//    } else {
//        // 添加cell的rectangle信息到path中（不包括圆角）
//        CGPathAddRect(pathRef, nil, bounds);
//    }
//    // 把已经绘制好的可变图像路径赋值给图层，然后图层根据这图像path进行图像渲染render
//    layer.path = pathRef;
//    backgroundLayer.path = pathRef;
//    // 注意：但凡通过Quartz2D中带有creat/copy/retain方法创建出来的值都必须要释放
//    CFRelease(pathRef);
//    // 按照shape layer的path填充颜色，类似于渲染render
//    // layer.fillColor = [UIColor colorWithWhite:1.f alpha:0.8f].CGColor;
//    layer.fillColor = [UIColor whiteColor].CGColor;
//
//    // view大小与cell一致
//    UIView *roundView = [[UIView alloc] initWithFrame:bounds];
//    // 添加自定义圆角后的图层到roundView中
//    [roundView.layer insertSublayer:layer atIndex:0];
//    roundView.backgroundColor = UIColor.clearColor;
//    // cell的背景view
//    cell.backgroundView = roundView;
//
//    // 以上方法存在缺陷当点击cell时还是出现cell方形效果，因此还需要添加以下方法
//    // 如果你 cell 已经取消选中状态的话,那以下方法是不需要的.
//    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:bounds];
//    backgroundLayer.fillColor = [UIColor cyanColor].CGColor;
//    [selectedBackgroundView.layer insertSublayer:backgroundLayer atIndex:0];
//    selectedBackgroundView.backgroundColor = UIColor.clearColor;
//    cell.selectedBackgroundView = selectedBackgroundView;
//
//}
//
//
//
//
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
