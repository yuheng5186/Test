//
//  DSMessagesController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSMessagesController.h"
#import "DSMessageDetailController.h"
@interface DSMessagesController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DSMessagesController

- (void)drawNavigation {
    
    [self drawTitle:@"消息" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    self.contentView.top                = Main_Screen_Height*44/667;
    self.contentView.height             = self.view.height;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubView];
}
- (void) createSubView {

    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height*180/667) style:UITableViewStylePlain];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    //    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor  = [UIColor whiteColor];
    self.tableView.scrollEnabled    = NO;
    //    self.tableView.tableFooterView  = [UIView new];
    self.tableView.contentInset     = UIEdgeInsetsMake(0, 0, 60, 0);
    [self.contentView addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 3;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.imageView.image    = [UIImage imageNamed:@"btnImage"];
    
    if (indexPath.row == 0) {
        cell.textLabel.text     = @"优惠活动";
        cell.detailTextLabel.text = @"五折洗车卡";
    }else if (indexPath.row == 1){
        cell.textLabel.text     = @"互动消息";
        cell.detailTextLabel.text = @"好评服务特别好";
    
    }else{
        
        cell.textLabel.text     = @"系统消息";
        cell.detailTextLabel.text = @"好评服务特别好";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DSMessageDetailController *messageDetailController = [[DSMessageDetailController alloc]init];
    messageDetailController.hidesBottomBarWhenPushed    = YES;
    [self.navigationController pushViewController:messageDetailController animated:YES];
    
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
