//
//  DSConsumerDetailController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/8/8.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSConsumerDetailController.h"

@interface DSConsumerDetailController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger showtype;
    NSString *nowtimeStr;
}
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation DSConsumerDetailController

- (void) drawNavigation {
    
    if ([self.titlename isEqualToString:@"活动赠送"]) {
        [self drawTitle:@"活动赠送"];
    }else{
        [self drawTitle:@"消费记录"];
    }
    if (self.showType==2) {
       [self drawBackButtonWithAction:@selector(backButtonClick:)];
    }
    
}
- (void) backButtonClick:(id)sender {
    
   
    self.tabBarController.selectedIndex = 0;
    
    NSArray     *array  = self.navigationController.viewControllers;
    NSArray *a = [NSArray arrayWithObject:array[0]];
    
    
    
    if(array.count == 4)
    {
        
        self.navigationController.viewControllers = a;
        
    }
    else
    {
        NSArray     *array1 = [NSArray arrayWithObject:array[0]];
        self.navigationController.viewControllers = array1;
    }
    
}

- (void) drawContent
{
    self.contentView.top                = self.statusView.bottom;
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#111112"];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.showType==2) {
        [self.view showInfo:@"扣卡成功" autoHidden:YES interval:1];
    }
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY/MM/dd HH:mm:ss"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    nowtimeStr = [formatter stringFromDate:datenow];
    
    NSLog(@"nowtimeStr =  %@",nowtimeStr);
    
    NSLog(@"---CYrecord%@",self.CYrecord);
    NSLog(@"---%@",self.record);
    
    // Do any additional setup after loading the view.
    [self createSubView];
}
- (void) createSubView {
    
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStyleGrouped];
//    self.tableView.top              = -Main_Screen_Height*10/667;
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
    if ([self.titlename isEqualToString:@"活动赠送"]) {
        return 1;
    }
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([self.titlename isEqualToString:@"活动赠送"]) {
        return 5;
    }else{
        switch (section) {
            case 0:
                return 1;
                break;
                
            default:
                break;
        }
        return 5;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     if(self.record.ConsumptionType == 2)
     {
         return 60*Main_Screen_Height/667;
     }
    return 50*Main_Screen_Height/667;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.titlename isEqualToString:@"活动赠送"]) {
        static NSString *cellStatic = @"cellStaticSport";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        }
        cell.backgroundColor    = [UIColor whiteColor];
        cell.textLabel.textColor    = [UIColor colorFromHex:@"#4a4a4a"];
        cell.detailTextLabel.textColor = [UIColor colorFromHex:@"#999999"];
        cell.detailTextLabel.font   = [UIFont systemFontOfSize:13];
        if (indexPath.row == 0) {
            
            cell.textLabel.text     = @"获得途径";
            cell.detailTextLabel.text   = self.record.ConsumerDescrip;
            
        }else if (indexPath.row == 1){
            cell.textLabel.text     = @"赠送时间";
            cell.detailTextLabel.text   = self.record.CreateDate;
            
        }else if (indexPath.row == 2){
            cell.textLabel.text     = @"卡类型";
            cell.detailTextLabel.text   = [NSString stringWithFormat:@"洗车%@",self.record.MiddleDes];
            
        }else if (indexPath.row == 3){
            cell.textLabel.text     = @"洗车次数";
            cell.detailTextLabel.text   =  [NSString stringWithFormat:@"免费洗车%@次",self.record.BottomDes];
            
        }else {
            cell.textLabel.text     = @"活动编号";
            cell.detailTextLabel.text   = self.record.UniqueNumber;
            
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.textLabel.textColor    = [UIColor colorFromHex:@"#4a4a4a"];
    if (indexPath.section == 0) {
        
        cell.textLabel.text     = @"付款金额";
        cell.detailTextLabel.textColor = [UIColor blackColor];
        
        if(self.record.ConsumptionType == 2)
        {
            cell.textLabel.text = @"付款方式";
            //            [cell.detailTextLabel setNumberOfLines:2];
            //            cell.detailTextLabel.text   = [NSString stringWithFormat:@"%@\n%@",self.record.MiddleDes,self.record.BottomDes];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 5*Main_Screen_Height/667, Main_Screen_Width - 15*Main_Screen_Width/375, 30*Main_Screen_Height/667)];
            [label setText:self.record.MiddleDes];
            label.font = [UIFont boldSystemFontOfSize:19*Main_Screen_Width/375];
            label.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:label];
            
            UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 35*Main_Screen_Height/667, Main_Screen_Width - 15*Main_Screen_Width/375, 20*Main_Screen_Height/667)];
            [label2 setText:[NSString stringWithFormat:@"剩余%@次",self.record.BottomDes]];
            label2.font = [UIFont boldSystemFontOfSize:12*Main_Screen_Width/375];
            label2.textAlignment = NSTextAlignmentRight;
            [cell.contentView addSubview:label2];
            
            
        }
        else if(self.record.ConsumptionType == 1)
        {
            cell.detailTextLabel.text   = [NSString stringWithFormat:@"￥%@",self.record.MiddleDes];
        }
        else        {
            cell.detailTextLabel.text   = [NSString stringWithFormat:@"￥%@",self.record.BottomDes];
        }
        
        
        
        
    }else {
        cell.detailTextLabel.textColor = [UIColor colorFromHex:@"#999999"];
        cell.detailTextLabel.font   = [UIFont systemFontOfSize:13];
        if (indexPath.row == 0) {
            
            cell.textLabel.text     = @"消费说明";
            cell.detailTextLabel.text   = self.record.ConsumerDescrip;
            
        }else if (indexPath.row == 1){
            cell.textLabel.text     = @"订单时间";
            cell.detailTextLabel.text   = self.record.CreateDate;
            
        }else if (indexPath.row == 2){
            NSArray *arr = @[@"",@"微信支付",@"支付宝支付",@"洗车卡抵扣",@"洗车卡抵扣"];
            cell.textLabel.text     = @"支付方式";
            NSLog(@"---%@",self.record);
            cell.detailTextLabel.text   = [arr objectAtIndex:self.record.PayMathod];
            
        }else if (indexPath.row == 3){
            cell.textLabel.text     = @"积分奖励";
            cell.detailTextLabel.text   = [NSString stringWithFormat:@"%ld积分",self.record.IntegralNumber];
            
        }else {
            cell.textLabel.text     = @"订单编号";
            cell.detailTextLabel.text   = self.record.UniqueNumber;
            
        }
        
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


@end
