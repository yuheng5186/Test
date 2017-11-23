//
//  UsedCarViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "UsedCarViewController.h"
#import "CYUserCarTableViewCell.h"
#import "CYUserCarModel.h"
#import "DSCarClubDetailController.h"
@interface UsedCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *CYUserCarTableView;
@property(strong,nonatomic)NSMutableArray *UserArray;
@property(assign,nonatomic)NSInteger page;
@property(nonatomic,strong)UILabel *noneLabel;

@end

@implementation UsedCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _UserArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.CYUserCarTableView];
    self.page=0;
//    [self requestData];
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];
}


-(void)requestData{
    NSDictionary *mulDic = @{
                             
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"PageIndex":@(self.page),
                             @"PageSize":@10
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/SecondHandCarList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"--二手车数据%@",dict);
        if ([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]]) {
            //获取json数组
            self.UserArray = (NSMutableArray*)[CYUserCarModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"]];
            //没有数据的情况下显示
            if (self.UserArray.count == 0) {
                self.noneLabel.hidden = NO;
            }else{
                self.noneLabel.hidden = YES;
            }
            
        }
        [self.CYUserCarTableView.mj_header endRefreshing];
        [self.CYUserCarTableView reloadData];
    } fail:^(NSError *error) {
        [self.CYUserCarTableView.mj_header endRefreshing];
    }];
    
}
#pragma mark - TableView
-(UITableView *)CYUserCarTableView{
    if(_CYUserCarTableView == nil){
        _CYUserCarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-108) style:(UITableViewStylePlain)];
        _CYUserCarTableView.delegate = self;
        _CYUserCarTableView.dataSource = self;
        _CYUserCarTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _CYUserCarTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _CYUserCarTableView.rowHeight = 145*Main_Screen_Height/667;
        
        self.noneLabel = [[UILabel alloc]init];
        self.noneLabel.frame = CGRectMake(Main_Screen_Width/2-100, Main_Screen_Height/2-200, 200, 100);
        self.noneLabel.backgroundColor = [UIColor grayColor];
        self.noneLabel.text = @"目前无二手车";
        self.noneLabel.textColor = [UIColor whiteColor];
        self.noneLabel.textAlignment = NSTextAlignmentCenter;
        self.noneLabel.hidden = YES;
        [_CYUserCarTableView addSubview:self.noneLabel];
    }
    return _CYUserCarTableView;
}
//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.UserArray.count;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CYUserCarCellID = @"CYUserCarCellID";
    CYUserCarTableViewCell *cell = [_CYUserCarTableView dequeueReusableCellWithIdentifier:CYUserCarCellID];
    if(cell == nil){
        cell = [[CYUserCarTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CYUserCarCellID];
    }
    [cell configCell:self.UserArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    CYUserCarModel * model = self.UserArray[indexPath.row];
    [_CYUserCarTableView deselectRowAtIndexPath:indexPath animated:YES];
    DSCarClubDetailController  *detailController    = [[DSCarClubDetailController alloc]init];
    detailController.hidesBottomBarWhenPushed       = YES;
    detailController.ActivityCode                   = model.CarCode;
    detailController.CarCode = model.CarCode;
    detailController.showType = @"二手车";
    detailController.loopNum = model.Mileage;
    detailController.carBrithYear = model.Manufacture;
    [self.navigationController pushViewController:detailController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
