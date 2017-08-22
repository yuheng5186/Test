//
//  DSConsumerDetailController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/8.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSConsumerDetailController.h"

@interface DSConsumerDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;


@end

@implementation DSConsumerDetailController

- (void) drawNavigation {
    
    [self drawTitle:@"消费记录"];
}
- (void) drawContent
{
    self.contentView.top                = self.statusView.bottom;
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#111112"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubView];
}
- (void) createSubView {
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.top              = -Main_Screen_Height*10/667;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
    self.tableView.tableHeaderView  = [UIView new];
    [self.contentView addSubview:self.tableView];
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
}
#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 10.0f*Main_Screen_Height/667;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 1;
            break;
            
        default:
            break;
    }
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50*Main_Screen_Height/667;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.textLabel.textColor    = [UIColor colorFromHex:@"#4a4a4a"];
    if (indexPath.section == 0) {
        cell.textLabel.text     = @"付款金额";
        cell.detailTextLabel.text   = @"¥18.00";
        cell.detailTextLabel.textColor = [UIColor blackColor];

    }else {
        cell.detailTextLabel.textColor = [UIColor colorFromHex:@"#999999"];
        cell.detailTextLabel.font   = [UIFont systemFontOfSize:13];
        if (indexPath.row == 0) {
            
            cell.textLabel.text     = @"消费说明";
            cell.detailTextLabel.text   = @"金雷快修车店-25元五座标准洗车";
            
        }else if (indexPath.row == 1){
            cell.textLabel.text     = @"订单时间";
            cell.detailTextLabel.text   = @"2017-7-31 14:30:20";
            
        }else if (indexPath.row == 2){
            cell.textLabel.text     = @"支付方式";
            cell.detailTextLabel.text   = @"支付宝支付";
            
        }else if (indexPath.row == 3){
            cell.textLabel.text     = @"积分奖励";
            cell.detailTextLabel.text   = @"10积分";
            
        }else {
            cell.textLabel.text     = @"订单编号";
            cell.detailTextLabel.text   = @"3687461972390000";
            
        }

    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
