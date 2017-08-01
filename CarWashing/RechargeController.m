//
//  RechargeController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "RechargeController.h"
#import "RechargeCell.h"

@interface RechargeController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *rechargeView;

@end

static NSString *id_rechargeCell = @"id_rechargeCell";

@implementation RechargeController

- (UITableView *)rechargeView {
    
    if (_rechargeView == nil) {
        UITableView *rechargeView = [[UITableView alloc] initWithFrame:CGRectInset(self.view.bounds, 10, 10) style:UITableViewStyleGrouped];
        _rechargeView = rechargeView;
        [self.view addSubview:_rechargeView];
    }
    return _rechargeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.rechargeView.delegate = self;
    self.rechargeView.dataSource = self;
    
    [self.rechargeView registerNib:[UINib nibWithNibName:@"RechargeCell" bundle:nil] forCellReuseIdentifier:id_rechargeCell];
    self.rechargeView.rowHeight = 180;
    self.rechargeView.backgroundColor = [UIColor lightGrayColor];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RechargeCell *cell = [tableView dequeueReusableCellWithIdentifier:id_rechargeCell forIndexPath:indexPath];
    
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
