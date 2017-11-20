//
//  InfoViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "InfoViewController.h"
#import "DSCarClubDetailController.h"
#import "ActivityListCell.h"

#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "CarClubNews.h"
#import "UdStorage.h"
#import "MBProgressHUD.h"
@interface InfoViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *CYUserCarTableView;

@property (nonatomic,strong) NSMutableArray *NewsArray;

@property (nonatomic,strong) NSMutableArray *otherArray;
@property (nonatomic)NSInteger page;

@end

@implementation InfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _NewsArray = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.CYUserCarTableView];
    [self.CYUserCarTableView registerNib:[UINib nibWithNibName:@"ActivityListCell" bundle:nil] forCellReuseIdentifier:@"ActivityListCell"];
    self.page = 0 ;
    [self requesetCarClubNews];
    NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(noticeupdate:) name:@"update" object:nil];
}
-(void)requesetCarClubNews
{
    NSDictionary *mulDic = @{
                             @"ActivityType":@(1),//咨询,2.车友提问,3.热门话题
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
//                             @"Area":[UdStorage getObjectforKey:@"City"],
                             @"PageIndex":[NSString stringWithFormat:@"%ld",self.page],
                             @"PageSize":@10
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/GetActivityList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            //            [self.view showInfo:@"获取数据成功" autoHidden:YES interval:2];
            NSArray *arr = [NSArray array];
            arr = [dict objectForKey:@"JsonData"];
            for(NSDictionary *dic in arr)
            {
                CarClubNews *news = [[CarClubNews alloc]init];
                [news setValuesForKeysWithDictionary:dic];
                [_NewsArray addObject:news];
            }
//            [self.tableView.mj_header endRefreshing];
            [_CYUserCarTableView reloadData];
            
        }
        else
        {
            [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
            
        }
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"获取数据失败" autoHidden:YES interval:2];
        
    }];
    
}
#pragma mark - TableView
-(UITableView *)CYUserCarTableView{
    if(_CYUserCarTableView == nil){
        _CYUserCarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-108) style:(UITableViewStylePlain)];
        _CYUserCarTableView.delegate   = self;
        _CYUserCarTableView.dataSource = self;
        _CYUserCarTableView.rowHeight        = 205*Main_Screen_Height/667;
        _CYUserCarTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        
    }
    return _CYUserCarTableView;
}
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
    return 10.00f*Main_Screen_Height/667;
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
    
    if(news.IsGive == 1)
    {
        cell.goodButton.selected = YES;
        [cell.goodButton setImage:[UIImage imageNamed:@"xiaohongshou"] forState:UIControlStateNormal];
    }else
    {
        cell.goodButton.selected = NO;
        [cell.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
        
    }
    cell.goodButton.tag = indexPath.section;
//    [cell.goodButton addTarget:self action:@selector(addSupport:) forControlEvents:UIControlEventTouchUpInside];
    
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
#pragma mark----当前页面点赞
-(void)addSupport:(UIButton *)button
{
    CarClubNews *model=(CarClubNews *)_NewsArray[button.tag];
    //    UIButton *button = (UIButton *)sender;
    if (button.selected == NO) {
        [button setImage:[UIImage imageNamed:@"xiaohongshou"] forState:UIControlStateNormal];
        //        self.goodNumberLabel.text                     = @"1289";
        //        [self.view showInfo:@"点赞成功!" autoHidden:YES];
        [self addNewsSupportTypeid:[NSString stringWithFormat:@"%ld",model.ActivityCode] andSupType:@"1"];
    }else {
        [button setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
        //        self.goodNumberLabel.text                     = @"1288";
        //        [self.view showInfo:@"取消点赞!" autoHidden:YES];
        [self addNewsSupportTypeid:[NSString stringWithFormat:@"%ld",model.ActivityCode] andSupType:@"1"];
        
    }
    button.selected = !button.selected;
}

-(void)addNewsSupportTypeid:(NSString *)SupTypeCodestr andSupType:(NSString *)SupTypestr{
    
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"SupTypeCode":SupTypeCodestr,
                             @"SupType":SupTypestr
                             };
    
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/AddActivitySupporInfo",Khttp] success:^(NSDictionary *dict, BOOL success) {
        
        
        if([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]])
        {
            //            [self.view showInfo:[dict objectForKey:@"ResultMessage"] autoHidden:YES interval:2];
            //            self.dic = [dict objectForKey:@"JsonData"];
            //        [self.MerchantDetailData addObjectsFromArray:arr];
            
            [self requesetCarClubNews];
        }
        else
        {
            [self.view showInfo:@"点赞失败" autoHidden:YES interval:2];
            //            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        
        
    } fail:^(NSError *error) {
        [self.view showInfo:@"点赞失败" autoHidden:YES interval:2];
    }];
    
    
}
#pragma mark----详情点赞后的处理
-(void)noticeupdate:(NSNotification *)sender{
    _NewsArray = [[NSMutableArray alloc]init];
    _otherArray = [[NSMutableArray alloc]init];
    self.page = 0 ;
    [self requesetCarClubNews];
}
@end
