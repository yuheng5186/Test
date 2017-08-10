//
//  PayOrderController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "PayOrderController.h"
#import "DelayPayCell.h"


@interface PayOrderController ()<UITableViewDelegate, UITableViewDataSource, DelayPayCellPushVCDelegate>

@property (nonatomic, weak) UITableView *payOrderView;

@end

static NSString *id_delayPayCell = @"id_delayPayCell";

@implementation PayOrderController


- (UITableView *)payOrderView {
    if (!_payOrderView) {
        UITableView *payOrderView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        _payOrderView = payOrderView;
        [self.view addSubview:_payOrderView];
    }
    return _payOrderView;
}


- (void) drawContent
{
    self.statusView.hidden      = YES;
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    self.contentView.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.payOrderView.delegate = self;
    self.payOrderView.dataSource = self;
    
    [self.payOrderView registerNib:[UINib nibWithNibName:@"DelayPayCell" bundle:nil] forCellReuseIdentifier:id_delayPayCell];
    self.payOrderView.rowHeight = 150;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DelayPayCell *delayCell = [tableView dequeueReusableCellWithIdentifier:id_delayPayCell forIndexPath:indexPath];
    delayCell.delegate = self;
    
    return delayCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}




#pragma mark - DelayPay的代理
- (void)pushVC:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController pushViewController:viewController animated:animated];
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
