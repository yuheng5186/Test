//
//  BusinessDetailViewController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/27.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BusinessDetailViewController.h"
#import "BusinessDetailHeaderView.h"
#import <Masonry.h>
#import "BusinessDetailCell.h"
#import "BusinessEstimateCell.h"
#import "BusinessPayController.h"
#import "ShopViewController.h"
#import "BusinessMapController.h"


@interface BusinessDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) BusinessDetailHeaderView *headerView;

@property (nonatomic, weak) UITableView *detailTableView;

@property (nonatomic, strong) NSIndexPath *lastPath;

@property (nonatomic, weak) BusinessDetailCell *detailCell;

@end

static NSString *detailTableViewCell = @"detailTableViewCell";
static NSString *businessCommentCell = @"businessCommentCell";

@implementation BusinessDetailViewController

- (void)drawNavigation {
    
    [self drawTitle:@"商家详情"];
    
    [self drawRightImageButton:@"fenxiang" action:@selector(didClickShareButton:)];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationController setNavigationBarHidden:YES];
    //self.title = @"商家详情";
    
    //self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self setupUI];
}


- (void)setupUI {
    
    UIView *containHeadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 375/2 + 196)];
    [self.view addSubview:containHeadView];
    
    UIImageView *detaiImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 375/2)];
    
    detaiImgView.image = [UIImage imageNamed:@"hangdiantu"];
    
    [containHeadView addSubview:detaiImgView];
    
    
    BusinessDetailHeaderView *headerView = [BusinessDetailHeaderView businessDetailHeaderView];
    
    headerView.frame = CGRectMake(0, 375/2, Main_Screen_Width, 196);
    
    self.headerView = headerView;
    [containHeadView addSubview:headerView];
    //detaiImgView.bottom  = headerView.top;

    [headerView addTarget:self action:@selector(clickDetailView) forControlEvents:UIControlEventTouchUpInside];
    
    
    UITableView *detailTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 124) style:UITableViewStyleGrouped];
    self.detailTableView = detailTableView;
    
    detailTableView.delegate = self;
    detailTableView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"BusinessDetailCell" bundle:nil];
    [detailTableView registerNib:nib forCellReuseIdentifier:detailTableViewCell];
    
    [detailTableView registerNib:[UINib nibWithNibName:@"BusinessEstimateCell" bundle:nil] forCellReuseIdentifier:businessCommentCell];
    
    //detailTableView.rowHeight = 100;
    
    detailTableView.tableHeaderView = containHeadView;
    
    [self.view addSubview:detailTableView];
    
    //表尾
    UIButton *commentBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 50)];
    [commentBtn setTitle:@"查看全部评价" forState:UIControlStateNormal];
    [commentBtn setTitleColor:[UIColor colorFromHex:@"#3a3a3a"] forState:UIControlStateNormal];
    commentBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    commentBtn.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:commentBtn];
    
    //添加点击事件
    [commentBtn addTarget:self action:@selector(clickCommentButton) forControlEvents:UIControlEventTouchUpInside];
    
    detailTableView.tableFooterView = commentBtn;
    
    //底部支付栏
    UIView *payToolBar = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 60, Main_Screen_Width, 60)];
    payToolBar.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:payToolBar];
    
    UILabel *lblPrice = [[UILabel alloc] init];
    lblPrice.text = @"¥24.00";
    lblPrice.font = [UIFont systemFontOfSize:18];
    lblPrice.textColor = [UIColor colorFromHex:@"#ff525a"];
    [payToolBar addSubview:lblPrice];
    
    UILabel *formerPriceLab = [[UILabel alloc] init];
    formerPriceLab.text = @"¥38.00";
    formerPriceLab.textColor = [UIColor colorFromHex:@"#999999"];
    formerPriceLab.font = [UIFont systemFontOfSize:13];
    [payToolBar addSubview:formerPriceLab];
    
    UILabel *lblCarType = [[UILabel alloc] init];
    lblCarType.text = @"标准洗车-五座轿车";
    lblCarType.font = [UIFont systemFontOfSize:13];
    lblCarType.textColor = [UIColor colorFromHex:@"#999999"];
    [payToolBar addSubview:lblCarType];
    
    UIButton *payBtn = [[UIButton alloc] init];
    payBtn.frame     = CGRectMake(Main_Screen_Width - 92, 0, 92, 60);
    [payBtn setTitle:@"去结算" forState:UIControlStateNormal];
    [payBtn setTintColor:[UIColor colorFromHex:@"#ffffff"]];
    payBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    //payBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    payBtn.backgroundColor = [UIColor colorFromHex:@"#febb02"];
    [payToolBar addSubview:payBtn];
    
    //跳转支付页面
    [payBtn addTarget:self action:@selector(clickPayButton) forControlEvents:UIControlEventTouchUpInside];
    
    //约束
    [lblPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(payToolBar).mas_offset(12);
        make.left.equalTo(payToolBar).mas_offset(20);
    }];
    
    [formerPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(lblPrice.mas_trailing).mas_offset(10);
        make.bottom.equalTo(lblPrice);
    }];
    
    [lblCarType mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.mas_equalTo(lblPrice);
        make.top.mas_equalTo(lblPrice.mas_bottom).mas_offset(6);
    }];
    
    /*[payBtn mas_makeConstraints:^(MASConstraintMaker *make) {
     make.width.mas_equalTo(120);
     make.height.mas_equalTo(80);
     make.right.top.equalTo(payToolBar);
     }];
     */
    
    UIButton *serviceBtn = [[UIButton alloc] init];
    [serviceBtn setImage:[UIImage imageNamed:@"kefuzixun"] forState:UIControlStateNormal];
    [serviceBtn addTarget:self action:@selector(didClickServiceBtn:) forControlEvents:UIControlEventTouchUpInside];
    [payToolBar addSubview:serviceBtn];
    
    UILabel *serviceLabel = [[UILabel alloc] init];
    serviceLabel.text = @"客服咨询";
    serviceLabel.font = [UIFont systemFontOfSize:13];
    serviceLabel.textColor = [UIColor colorFromHex:@"#999999"];
    [payToolBar addSubview:serviceLabel];
    
    
    [serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(payToolBar).mas_offset(12);
        make.trailing.equalTo(payBtn.mas_leading).mas_equalTo(-37);
        make.width.height.mas_equalTo(20);
    }];
    
    [serviceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(serviceBtn);
        make.top.equalTo(serviceBtn.mas_bottom).mas_offset(7);
    }];
    
}

#pragma mark - 点击拨打客服
- (void)didClickServiceBtn:(UIButton *)button {
    
    NSString *title = @"";
    
    NSString *message = @"是否拨打客服电话";
    
    [self showAlertWithTitle:title message:message];
}

#pragma mark - 点击查看全部评价
- (void)clickCommentButton {
    
    ShopViewController *commentVC = [[ShopViewController alloc] init];
    
    [self.navigationController pushViewController:commentVC animated:YES];
}

#pragma mark - 点击商家详情
- (void)clickDetailView{
    
    ShopViewController *shopController = [[ShopViewController alloc] init];
    
    [self.navigationController pushViewController:shopController animated:YES];
}

#pragma mark - 支付界面
- (void)clickPayButton {
    
    BusinessPayController *payController = [[BusinessPayController alloc] init];
    
    [self.navigationController pushViewController:payController animated:YES];
}


#pragma mark - tableView代理数据源
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

//    if (businessDetailCell == nil) {
//        businessDetailCell = [BusinessDetailCell businessDetailCell];
//    }
    if (indexPath.section == 0) {
        BusinessDetailCell *businessDetailCell = [tableView dequeueReusableCellWithIdentifier:detailTableViewCell forIndexPath:indexPath];
        businessDetailCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _detailCell = businessDetailCell;
        
        businessDetailCell.carLabel.text = @"标准洗车-五座轿车";
        businessDetailCell.clearLabel.text = @"整车泡沫冲洗擦干、轮胎轮轴冲洗清洁、车内吸尘、内饰脚垫等简单除尘";
        businessDetailCell.priceLabel.text = @"¥24.00";
        
        //单选状态
        NSInteger row = [indexPath row];
        NSInteger oldRow = [self.lastPath row];
        
        if (row == oldRow && self.lastPath != nil) {
            [businessDetailCell.stateButton setBackgroundImage:[UIImage imageNamed:@"xaunzhong"] forState:UIControlStateNormal];
        }else{
            
            [businessDetailCell.stateButton setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
        }
        
        return businessDetailCell;
    }
    
    BusinessEstimateCell *estimateCell = [tableView dequeueReusableCellWithIdentifier:businessCommentCell forIndexPath:indexPath];
    estimateCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return estimateCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 100;
    }
    
    return 110;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        NSInteger newRow = [indexPath row];
        NSInteger oldRow = (self.lastPath != nil)?[self.lastPath row]:-1;
        
        if (newRow != oldRow) {
            self.detailCell = [tableView cellForRowAtIndexPath:indexPath];
            
            [self.detailCell.stateButton setBackgroundImage:[UIImage imageNamed:@"xaunzhong"] forState:UIControlStateNormal];
            
            self.detailCell = [tableView cellForRowAtIndexPath:self.lastPath];
            
            [self.detailCell.stateButton setBackgroundImage:[UIImage imageNamed:@"weixuanzhong"] forState:UIControlStateNormal];
            
            self.lastPath = indexPath;
            
        }
    }
}


#pragma mark - 设置组头视图
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    UILabel *textLab = [[UILabel alloc] init];
    
    //textLab.backgroundColor = [UIColor colorFromHex:@"#dfdfdf"];
    textLab.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    textLab.font = [UIFont systemFontOfSize:14];
    
    if (section == 0) {
        textLab.text = @"服务活动";
    }else{
        textLab.text = @"评论 (58)";
    }
    
    return textLab.text;
}

//- (NSString *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    
//    
//}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}


#pragma mark - 点击分享按钮
- (void)didClickShareButton:(UIButton *)button {
    
    
}


#pragma mark - 地图导航
- (IBAction)didClickSmallBtn:(UIButton *)sender {
    
    BusinessMapController *mapVC = [[BusinessMapController alloc] init];
    mapVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:mapVC animated:YES];
    
}

//方法子
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        [PhoneHelper dial: @"1008611"];
        

        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}


- (IBAction)didClickShopPhoneBtn:(UIButton *)sender {
    
    NSString *message = @"是否拨打商家电话";
    NSString *title = @"";
    [self showAlertWithTitle:title message:message];
}

- (void)viewWillAppear:(BOOL)animated {
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.detailTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
    if ([_detailTableView.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [_detailTableView.delegate tableView:_detailTableView didSelectRowAtIndexPath:indexPath];
    }
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
