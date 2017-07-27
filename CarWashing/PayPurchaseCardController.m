//
//  PayPurchaseCardController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/24.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "PayPurchaseCardController.h"
#import "payCardDetailCell.h"
#import <Masonry.h>


@interface PayPurchaseCardController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *payCardView;

@end

static NSString *id_payCardViewCell = @"id_payCardViewCell";
static NSString *id_payDetailCell = @"id_payDetailCell";

@implementation PayPurchaseCardController

- (UITableView *)payCardView {
    if (!_payCardView) {
        UITableView *payCardView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 360) style:UITableViewStylePlain];
        self.payCardView = payCardView;
        [self.view addSubview:payCardView];
    }
    return _payCardView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购卡支付";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self setupUI];
    
}




- (void)setupUI {
    
//    UITableView *tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 300) style:UITableViewStylePlain];
//    
//    tableview.delegate = self;
//    tableview.dataSource = self;
    //[self.view addSubview:self];
    
    self.payCardView.delegate = self;
    self.payCardView.dataSource = self;
    
    //[tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:id_payCardViewCell];
    [self.payCardView registerClass:[payCardDetailCell class] forCellReuseIdentifier:id_payDetailCell];
    
    //选择支付方式
    UILabel *payLab = [[UILabel alloc] init];
    payLab.text = @"选择支付个方式";
    [self.view addSubview:payLab];
    
    //支付宝
    UIView *zhifubaoView = [[UIView alloc] init];
    zhifubaoView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:zhifubaoView];
    
    
    //微信
    UIView *weixinView = [[UIView alloc] init];
    weixinView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:weixinView];
    
    //约束
    [payLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.payCardView.mas_bottom).mas_offset(20);
        make.left.equalTo(self.view).mas_offset(20);
    }];
    
    [zhifubaoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(payLab.mas_bottom).mas_offset(10);
        make.height.mas_equalTo(60);
    }];
    
    [weixinView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.mas_equalTo(zhifubaoView.mas_bottom).mas_offset(1);
        make.height.mas_equalTo(60);
    }];
    
    
    UIImageView *aliImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 30)];
    aliImageView.image = [UIImage imageNamed:@"messageA"];
    
    UILabel *aliLable = [[UILabel alloc] init];
    aliLable.text = @"支付宝支付";
    
    UIButton *aliBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width - 40, 15, 30, 30)];
    
    [aliBtn setBackgroundImage:[UIImage imageNamed:@"搜索-更多-未选中"] forState:UIControlStateNormal];
    [aliBtn setBackgroundImage:[UIImage imageNamed:@"搜索-更多-已选中"] forState:UIControlStateHighlighted];
    
    [zhifubaoView addSubview:aliImageView];
    [zhifubaoView addSubview:aliLable];
    [zhifubaoView addSubview:aliBtn];
    
    [aliLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(aliImageView);
        make.leading.mas_equalTo(aliImageView.mas_trailing).mas_offset(10);
    }];
    
    
    UIImageView *weixinImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 15, 30, 30)];
    
    weixinImageView.image = [UIImage imageNamed:@"messageA"];
    
    UILabel *weixinLable = [[UILabel alloc] init];
    weixinLable.text = @"微信支付";
    
    UIButton *weixinBtn = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width - 40, 15, 30, 30)];
    
    [weixinBtn setBackgroundImage:[UIImage imageNamed:@"搜索-更多-未选中"] forState:UIControlStateNormal];
    [weixinBtn setBackgroundImage:[UIImage imageNamed:@"搜索-更多-已选中"] forState:UIControlStateHighlighted];
    
    [weixinView addSubview:weixinImageView];
    [weixinView addSubview:weixinLable];
    [weixinView addSubview:weixinBtn];
    
    [weixinLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(weixinView);
        make.leading.mas_equalTo(weixinImageView.mas_trailing).mas_offset(10);
    }];
    
    
    //底部支付栏
    UIView *payBottomView = [[UIView alloc] initWithFrame:CGRectMake(0, Main_Screen_Height - 80, Main_Screen_Width, 80)];
    payBottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:payBottomView];
    
    UILabel *bottomPriceLab = [[UILabel alloc] init];
    bottomPriceLab.text = @"¥54.00";
    bottomPriceLab.font = [UIFont systemFontOfSize:25];
    bottomPriceLab.font = [UIFont boldSystemFontOfSize:20];
    [payBottomView addSubview:bottomPriceLab];
    
    [bottomPriceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(payBottomView).mas_offset(30);
        
    }];
    
    UIButton *bottomPayButton = [[UIButton alloc] initWithFrame:CGRectMake(Main_Screen_Width - 200, 0, 200, 80)];
    bottomPayButton.backgroundColor = [UIColor orangeColor];
    [bottomPayButton setTitle:@"立即付款" forState:UIControlStateNormal];
    bottomPayButton.titleLabel.font = [UIFont systemFontOfSize:20];
    bottomPayButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
    
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
    


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 4;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 1) {
        return 120;
    }
    return 60;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellStatic = @"cellStatic";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    
    if (indexPath.row == 1) {
        
        payCardDetailCell *payCell = [tableView dequeueReusableCellWithIdentifier:id_payDetailCell];
        
        return payCell;
    }
    
    cell.textLabel.text  = @"eeeeee";
    cell.detailTextLabel.text = @"sdcdscwfr";

    
    return cell;
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
