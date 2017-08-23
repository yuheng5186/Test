//
//  DSCarTravellingController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/21.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCarTravellingController.h"
#import "ActivityListCell.h"
#import "DSCarClubDetailController.h"

#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "CarClubNews.h"
#import "UdStorage.h"

@interface DSCarTravellingController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *NewsArray;

@end

@implementation DSCarTravellingController

- (void) drawContent
{
    self.statusView.hidden      = YES;
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _NewsArray = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view.
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.top              = 0;
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ActivityListCell" bundle:nil] forCellReuseIdentifier:@"ActivityListCell"];
    
    self.tableView.rowHeight        = Main_Screen_Height*205/667;
    self.tableView.contentInset     = UIEdgeInsetsMake(0, 0, 180, 0);
    [self.contentView addSubview:self.tableView];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    [self requesetCarClubNews];
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [_NewsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 10.00f;
}

#pragma mark --

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ActivityListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ActivityListCell" forIndexPath:indexPath];
    CarClubNews *news = [[CarClubNews alloc]init];
    news = [_NewsArray objectAtIndex:indexPath.section];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSString *ImageURL=[NSString stringWithFormat:@"%@%@",kHTTPImg,news.IndexImg];
        NSURL *url=[NSURL URLWithString:ImageURL];
        NSData *data=[NSData dataWithContentsOfURL:url];
        UIImage *img=[UIImage imageWithData:data];
        dispatch_sync(dispatch_get_main_queue(), ^{
            [cell.activityImageView setImage:img];
        });
    });
    cell.activityTitleLabel.text    = news.ActivityName;
    cell.activityTimeLabel.text     = news.ActDate;
    cell.sayNumberLabel.text        = [NSString stringWithFormat:@"%ld",news.CommentCount];
    cell.goodNumberLabel.text       = [NSString stringWithFormat:@"%ld",news.GiveCount];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CarClubNews *news = [[CarClubNews alloc]init];
    news = [_NewsArray objectAtIndex:indexPath.section];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DSCarClubDetailController  *detailController    = [[DSCarClubDetailController alloc]init];
    detailController.hidesBottomBarWhenPushed       = YES;
    detailController.ActivityCode                   = news.ActivityCode;
    [self.navigationController pushViewController:detailController animated:YES];
    
}

-(void)requesetCarClubNews
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"Area":@"上海市",
                             @"PageIndex":@0,
                             @"PageSize":@10
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/GetActivityList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            [self.view showInfo:@"获取数据成功" autoHidden:YES interval:2];
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                CarClubNews *news = [[CarClubNews alloc]init];
                [news setValuesForKeysWithDictionary:dic];
                [_NewsArray addObject:news];
            }
            [_tableView reloadData];
            
        }
        else
        {
            [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
    }];
    
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
