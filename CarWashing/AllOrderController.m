//
//  AllOrderController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "AllOrderController.h"
#import "SuccessPayCell.h"
#import "DelayPayCell.h"
#import "CancelPayCell.h"
#import "OrderDetailController.h"


@interface AllOrderController ()<UITableViewDelegate, UITableViewDataSource, PushVCDelegate,DelayPayCellPushVCDelegate>

@property (nonatomic, weak) UITableView *allOrderListView;

@end

static NSString *id_successPayCell = @"id_successPayCell";
static NSString *id_delayPayCell = @"id_delayPayCell";
static NSString *id_cancelCell = @"id_cancelCell";

@implementation AllOrderController

- (UITableView *)allOrderListView {
    
    if (!_allOrderListView) {
        UITableView *allOrderListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height) style:UITableViewStyleGrouped];
        _allOrderListView = allOrderListView;
        [self.view addSubview:_allOrderListView];
    }
    return _allOrderListView;
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
    
    self.allOrderListView.delegate = self;
    self.allOrderListView.dataSource = self;
    
    [self.allOrderListView registerNib:[UINib nibWithNibName:@"SuccessPayCell" bundle:nil] forCellReuseIdentifier:id_successPayCell];
    [self.allOrderListView registerNib:[UINib nibWithNibName:@"DelayPayCell" bundle:nil] forCellReuseIdentifier:id_delayPayCell];
    [self.allOrderListView registerNib:[UINib nibWithNibName:@"CancelPayCell" bundle:nil] forCellReuseIdentifier:id_cancelCell];
     
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        SuccessPayCell *successCell = [tableView dequeueReusableCellWithIdentifier:id_successPayCell forIndexPath:indexPath];
        successCell.delegate = self;
        return successCell;
    }else if (indexPath.section == 1){
        
        DelayPayCell *delayCell = [tableView dequeueReusableCellWithIdentifier:id_delayPayCell forIndexPath:indexPath];
        delayCell.delegate = self;
        return delayCell;
    }
    
    CancelPayCell *cancelCell = [tableView dequeueReusableCellWithIdentifier:id_cancelCell forIndexPath:indexPath];
    
    return cancelCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 2) {
        
        OrderDetailController *orderDetailVC = [[OrderDetailController alloc] init];
        orderDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:orderDetailVC animated:YES];
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 2) {
        return 100;
    }
    
    return 150;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}



#pragma mark - 实现success的代理方法
- (void)pushController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController pushViewController:viewController animated:animated];
}


- (void)pushVC:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController pushViewController:viewController animated:animated];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
