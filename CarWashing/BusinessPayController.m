//
//  BusinessPayController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/28.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BusinessPayController.h"
#import <Masonry.h>
#import "CashViewController.h"

@interface BusinessPayController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *payTableView;


@end

static NSString *payViewCell = @"payTableViewCell";

@implementation BusinessPayController

- (void)drawNavigation {
    
    [self drawTitle:@"支付"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.title = @"支付";
    
    [self setupUI];
}


- (void)setupUI {
    
    UITableView *payTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
    
    self.payTableView = payTableView;
    payTableView.delegate = self;
    payTableView.dataSource = self;
    payTableView.rowHeight = 50;
    
    [self.view addSubview:payTableView];
    
    //[payTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:payViewCell];
//    
//    //选择支付方式
//    UILabel *payLab = [[UILabel alloc] init];
//    payLab.text = @"选择支付方式";
//    [self.view addSubview:payLab];
//    
//    //支付宝
//    UIView *zhifubaoView = [[UIView alloc] init];
//    zhifubaoView.backgroundColor = [UIColor whiteColor];
//    
//    [self.view addSubview:zhifubaoView];
//    
//    
//    //微信
//    UIView *weixinView = [[UIView alloc] init];
//    weixinView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:weixinView];
//    
//    //约束
//    [payLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(payTableView.mas_bottom).mas_offset(20);
//        make.left.equalTo(self.view).mas_offset(20);
//    }];
//    
//    [zhifubaoView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.mas_equalTo(payLab.mas_bottom).mas_offset(10);
//        make.height.mas_equalTo(60);
//    }];
//    
//    [weixinView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self.view);
//        make.top.mas_equalTo(zhifubaoView.mas_bottom).mas_offset(1);
//        make.height.mas_equalTo(60);
//    }];
//    
//    
//    UIImageView *aliImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 30)];
//    aliImageView.image = [UIImage imageNamed:@"messageA"];
//    
//    UILabel *aliLable = [[UILabel alloc] init];
//    aliLable.text = @"支付宝支付";
//    
//    UIButton *aliBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width - 40, 15, 30, 30)];
//    
//    [aliBtn setBackgroundImage:[UIImage imageNamed:@"搜索-更多-未选中"] forState:UIControlStateNormal];
//    [aliBtn setBackgroundImage:[UIImage imageNamed:@"搜索-更多-已选中"] forState:UIControlStateHighlighted];
//    
//    [zhifubaoView addSubview:aliImageView];
//    [zhifubaoView addSubview:aliLable];
//    [zhifubaoView addSubview:aliBtn];
//    
//    [aliLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(aliImageView);
//        make.leading.mas_equalTo(aliImageView.mas_trailing).mas_offset(10);
//    }];
//    
//    
//    UIImageView *weixinImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 30)];
//    
//    weixinImageView.image = [UIImage imageNamed:@"messageA"];
//    
//    UILabel *weixinLable = [[UILabel alloc] init];
//    weixinLable.text = @"微信支付";
//    
//    UIButton *weixinBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width - 40, 15, 30, 30)];
//    
//    [weixinBtn setBackgroundImage:[UIImage imageNamed:@"搜索-更多-未选中"] forState:UIControlStateNormal];
//    [weixinBtn setBackgroundImage:[UIImage imageNamed:@"搜索-更多-已选中"] forState:UIControlStateHighlighted];
//    
//    [weixinView addSubview:weixinImageView];
//    [weixinView addSubview:weixinLable];
//    [weixinView addSubview:weixinBtn];
//    
//    [weixinLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_equalTo(weixinView);
//        make.leading.mas_equalTo(weixinImageView.mas_trailing).mas_offset(10);
//    }];
    
    
    //底部支付栏
    UIView *payBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 60, Main_Screen_Width, 60)];
    payBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:payBottomView];
    
    UILabel *bottomPriceLab = [[UILabel alloc] init];
    bottomPriceLab.text = @"¥54.00";
    bottomPriceLab.font = [UIFont systemFontOfSize:18];
    bottomPriceLab.textColor = [UIColor colorFromHex:@"#ff525a"];
    [payBottomView addSubview:bottomPriceLab];
    
    [bottomPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(payBottomView).mas_offset(30);
        make.top.equalTo(payBottomView).mas_offset(20);
        
    }];
    
    UIButton *bottomPayButton = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width - 136, 0, 136, 60)];
    bottomPayButton.backgroundColor = [UIColor colorFromHex:@"#febb02"];
    [bottomPayButton setTitle:@"立即付款" forState:UIControlStateNormal];
    [bottomPayButton setTintColor:[UIColor whiteColor]];
    bottomPayButton.titleLabel.font = [UIFont systemFontOfSize:18];

    //方法子
    [bottomPayButton addTarget:self action:@selector(showAlertWithTitle:message:) forControlEvents:UIControlEventTouchUpInside];
    
    [payBottomView addSubview:bottomPayButton];
    
    
}


//方法子
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"金顶洗车想要打开支付宝" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (section == 0) {
        return 3;
    }
    
    return 2;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *payCell = [tableView dequeueReusableCellWithIdentifier:payViewCell];
    
    payCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    
    if (indexPath.section == 0 || indexPath.section == 1) {
        payCell.textLabel.text = @"服务商家";
        payCell.detailTextLabel.text = @"上海金雷洗车";
    }else {
        
        payCell.imageView.image = [UIImage imageNamed:@"weixin"];
        payCell.textLabel.text = @"微信支付";
        payCell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"xaunzhong"]];
    }
    
    
    
    return payCell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 2 ) {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 0 || section == 1) {
        return nil;
    }
    
    UILabel *wayLabel = [[UILabel alloc] init];
    wayLabel.text = @"  请选择支付方式";
    wayLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    wayLabel.font = [UIFont systemFontOfSize:14];
    
    
    return wayLabel;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 2) {
        return 30;
    }
    
    return 10;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 10;
}


#pragma mark - 点击cell
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0 && indexPath.row == 3) {
        
        CashViewController *cashVC = [[CashViewController alloc] init];
        //cashVC.providesPresentationContextTransitionStyle = YES;
        //cashVC.definesPresentationContext = YES;
        cashVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        [self presentViewController:cashVC animated:NO completion:nil];
    }
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
