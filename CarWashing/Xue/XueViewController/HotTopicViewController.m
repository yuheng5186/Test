//
//  HotTopicViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "HotTopicViewController.h"
#import "HotTableViewCell.h"
#import "AnotherHotTableViewCell.h"
#import "AFNetworkingTool.h"
#import "UdStorage.h"
#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "CYHotTopicModel.h"
#import "DSCarClubDetailController.h"


@interface HotTopicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *hotTable;
@property(strong,nonatomic)NSMutableArray *dataArray;
@property(nonatomic,assign)NSInteger *page;
@property(nonatomic,copy)NSMutableArray *modelArray;
@end

@implementation HotTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.hotTable];
    self.page = 0;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestWeb];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - getData
-(void)requestWeb{
    NSDictionary *mulDic = @{
                             @"ActivityType":@(3),//咨询,2.车友提问,3.热门话题
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"PageIndex":@(0),
                             @"PageSize":@10
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/GetActivityList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        if ([[dict objectForKey:@"ResultCode" ]isEqualToString:@"F000000" ] ) {
            NSLog(@"----------------%@----------------",dict);
            self.modelArray = (NSMutableArray *)[CYHotTopicModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"]];

            
        }
        [_hotTable reloadData];
    } fail:^(NSError *error) {
        NSLog(@"----------------热门话题获取数据失败--------------------");
    }];
    
}




#pragma mark - TableView
-(UITableView *)hotTable{
    if(_hotTable == nil){
        _hotTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-108) style:(UITableViewStylePlain)];
        _hotTable.delegate = self;
        _hotTable.dataSource = self;
        _hotTable.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_hotTable registerClass:[HotTableViewCell class] forCellReuseIdentifier:@"OneImage"];
        [_hotTable registerClass:[AnotherHotTableViewCell class] forCellReuseIdentifier:@"collect"];
    }
    return _hotTable;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYHotTopicModel *model = self.modelArray[indexPath.row];
    NSArray *imageArray = [model.IndexImg componentsSeparatedByString:@","];
    if (imageArray.count==0||imageArray.count==1) {
        return  270;
    }
    return 210;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CYHotTopicModel *singleModel = self.modelArray[indexPath.row];
    NSArray *imageArray = [singleModel.IndexImg componentsSeparatedByString:@","];
    if (imageArray.count==0||imageArray.count==1) {
        HotTableViewCell *oneImageCell = [tableView dequeueReusableCellWithIdentifier:@"OneImage" forIndexPath:indexPath];
        [oneImageCell configCell:singleModel];
        return oneImageCell;
    }
    AnotherHotTableViewCell *collectionCell = [tableView dequeueReusableCellWithIdentifier:@"collect" forIndexPath:indexPath];
    [collectionCell configCell:singleModel];
    return collectionCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CYHotTopicModel * model = self.modelArray[indexPath.row];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DSCarClubDetailController  *detailController    = [[DSCarClubDetailController alloc]init];
    detailController.hidesBottomBarWhenPushed       = YES;
    detailController.ActivityCode                   = model.ActivityCode;
    [self.navigationController pushViewController:detailController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
