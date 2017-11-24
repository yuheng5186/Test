//
//  MyPublishUserCarViewController.m
//  CarWashing
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MyPublishUserCarViewController.h"
#import "CYUserCarTableViewCell.h"
#import "CYUserCarModel.h"
#import "DSCarClubDetailController.h"
@interface MyPublishUserCarViewController()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *CYUserCarTableView;
@property(strong,nonatomic)NSMutableArray *UserArray;
@property(assign,nonatomic)NSInteger page;
@property(nonatomic,strong)UILabel *noneLabel;

@end

@implementation MyPublishUserCarViewController
- (void) drawNavigation {
    [self drawTitle:@"发现"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _UserArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.CYUserCarTableView];
    self.page=0;
}
-(void)getData
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"PageIndex":@(0),
                             @"PageSize":@(10),
                             @"AcquisitionType":@(1)
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/SecondHandCarList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"我的二手车发布%@",dict);
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
        [self.CYUserCarTableView reloadData];
        
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - TableView
-(UITableView *)CYUserCarTableView{
    if(_CYUserCarTableView == nil){
        _CYUserCarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64) style:(UITableViewStylePlain)];
        _CYUserCarTableView.delegate = self;
        _CYUserCarTableView.dataSource = self;
        _CYUserCarTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _CYUserCarTableView.rowHeight = 145*Main_Screen_Height/667;
        _CYUserCarTableView.estimatedRowHeight = 0;
        _CYUserCarTableView.estimatedSectionFooterHeight = 0;
        _CYUserCarTableView.estimatedSectionHeaderHeight = 0;
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
    detailController.deleteStr = @"是";
    detailController.DeleteType = 3;
    [self.navigationController pushViewController:detailController animated:YES];
}

@end
