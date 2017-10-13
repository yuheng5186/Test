//
//  CYSlideViewController.m
//  CarWashing
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYSlideViewController.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "HTTPDefine.h"
#import "MBProgressHUD.h"
#import "UdStorage.h"
#import "CYCarRMListModel.h"
@interface CYSlideViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString* a;
}
@property (nonatomic,strong) UITableView     * choosetableView;
@property (nonatomic,strong) NSMutableArray  * DetailArray;
@property (nonatomic, strong) NSMutableArray *RMListArrayRow;
@property (nonatomic, strong) NSDictionary   *dicData;
@end

@implementation CYSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _DetailArray = [NSMutableArray array];
    _RMListArrayRow = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hh:) name:@"gb" object:nil];
    self.view.backgroundColor=[UIColor whiteColor];
    //   初始化tableview
    _choosetableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, 250, Main_Screen_Height-64) style:0];
    _choosetableView.rowHeight=50;
    _choosetableView.delegate=self;
    _choosetableView.dataSource=self;
    [self.view addSubview:_choosetableView];
}
- (void)hh:(NSNotification *)notification{
    
    
    // 如果是传多个数据，那么需要哪个数据，就对应取出对应的数据即可
    
    a  = notification.userInfo[@"color"];
        NSDictionary *mulDic = @{
                                 @"Title":a
                                 };
        NSDictionary *params = @{
                                 @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                                 @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                                 };
    //    NSLog(@"%@",params);
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@MyCar/GetCarTypeDropTList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"车辆信息---%@",dict);
        self.DetailArray = (NSMutableArray*)[CYCarRMListModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"]];
        self.dicData = dict;
//        self.RMListArray = (NSMutableArray*)[CYCarRMListModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"][@"RMList"][0][@"List"]];
//        self.RMListArraySection = (NSMutableArray*)[CYCarRMListModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"][@"ZMList"]];
        [self.choosetableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"---%@",error);
    }];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.self.DetailArray.count;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    CYCarRMListModel * model = self.DetailArray[section];
    return [NSString stringWithFormat:@"%@",model.Title];
}





-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    self.RMListArrayRow = [CYCarRMListModel mj_objectArrayWithKeyValuesArray:self.dicData[@"JsonData"][section][@"List"]];
    NSLog(@"---%@",self.RMListArrayRow);
    return self.RMListArrayRow.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundView = nil;
    }
//    if ([a isEqualToString:@"1"]) {
//         cell.textLabel.text = [NSString stringWithFormat:@"------第%u奔驰------",(unsigned)indexPath.row + 3];
//    }else{
//        cell.textLabel.text = [NSString stringWithFormat:@"------第%u奔驰------",(unsigned)indexPath.row + 1];
//    }
    self.RMListArrayRow = [CYCarRMListModel mj_objectArrayWithKeyValuesArray:self.dicData[@"JsonData"][indexPath.section][@"List"]];
    CYCarRMListModel * model = self.RMListArrayRow[indexPath.row];
    cell.textLabel.font=[UIFont systemFontOfSize:15.0];
    cell.textLabel.textColor=RGBAA(153, 153, 153, 1.0);
    cell.textLabel.text = [NSString stringWithFormat:@"%@",model.Title];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"pop" object:nil];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
