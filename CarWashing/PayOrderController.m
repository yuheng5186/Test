//
//  PayOrderController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "PayOrderController.h"
#import "PayOrderViewCell.h"

@interface PayOrderController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *payOrderView;

@end

static NSString *id_payoOrderCell = @"id_payoOrderCell";

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
    
    [self.payOrderView registerNib:[UINib nibWithNibName:@"PayOrderViewCell" bundle:nil] forCellReuseIdentifier:id_payoOrderCell];
    self.payOrderView.rowHeight = 180;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PayOrderViewCell *payCell = [tableView dequeueReusableCellWithIdentifier:id_payoOrderCell forIndexPath:indexPath];
    
    return payCell;
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
