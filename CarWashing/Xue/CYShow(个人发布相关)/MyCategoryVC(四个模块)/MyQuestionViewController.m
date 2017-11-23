//
//  MyQuestionViewController.m
//  CarWashing
//
//  Created by apple on 2017/11/22.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "MyQuestionViewController.h"
#import "CYQuestionTableViewCell.h"
#import "UIView+SDAutoLayout.h"
#import "SDWeiXinPhotoContainerView.h"
#import "UIImageView+WebCache.h"

#import "HTTPDefine.h"
#import "LCMD5Tool.h"
#import "AFNetworkingTool.h"
#import "CarClubNews.h"
#import "UdStorage.h"
#import "MBProgressHUD.h"
#import "CYQuestionModel.h"
#import "DSCarClubDetailController.h"

#import "UIView+SDAutoLayout.h"
#import "SDWeiXinPhotoContainerView.h"
#import "CYQuestionTwoTableViewCell.h"
@interface MyQuestionViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    SDWeiXinPhotoContainerView *_picContainerView;
    
}
@property(nonatomic)NSInteger page;
@property(nonatomic,copy)NSMutableArray *modelArray;
@property(nonatomic,strong)UILabel *noneLabel;

@end

@implementation MyQuestionViewController
- (void) drawNavigation {
    [self drawTitle:@"我的提问"];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor whiteColor];
    _modelArray = [NSMutableArray array];
    
    [self.contentView addSubview:self.quesTableView];
    self.page = 0;
}
-(void)getData
{
    NSDictionary *mulDic = @{
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
                             @"ActivityType":@"2",
                             @"PageIndex":@(0),
                             @"PageSize":@(10),
                             @"AcquisitionType":@(1)
                             };
    NSDictionary *params = @{
                             @"JsonData" : [NSString stringWithFormat:@"%@",[AFNetworkingTool convertToJsonData:mulDic]],
                             @"Sign" : [NSString stringWithFormat:@"%@",[LCMD5Tool md5:[AFNetworkingTool convertToJsonData:mulDic]]]
                             };
    [AFNetworkingTool post:params andurl:[NSString stringWithFormat:@"%@Activity/GetActivityList",Khttp] success:^(NSDictionary *dict, BOOL success) {
        NSLog(@"%@",dict);
        if ([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]]) {
            //获取json数组
            
            self.modelArray = (NSMutableArray*)[CYQuestionModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"]];
            
            //没有数据的情况下显示
            if (self.modelArray.count == 0) {
                self.noneLabel.hidden = NO;
            }else{
                self.noneLabel.hidden = YES;
            }
            
            
        }
        [self.quesTableView reloadData];
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - TableView
-(UITableView *)quesTableView{
    if(_quesTableView == nil){
        _quesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-64) style:(UITableViewStylePlain)];
        _quesTableView.delegate = self;
        _quesTableView.dataSource = self;
        _quesTableView.backgroundColor = [UIColor whiteColor];
//        _quesTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestData)];
        _quesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        self.noneLabel = [[UILabel alloc]init];
        self.noneLabel.frame = CGRectMake(Main_Screen_Width/2-100, Main_Screen_Height/2-200, 200, 100);
        self.noneLabel.backgroundColor = [UIColor grayColor];
        self.noneLabel.text = @"目前无提问";
        self.noneLabel.textColor = [UIColor whiteColor];
        self.noneLabel.textAlignment = NSTextAlignmentCenter;
        self.noneLabel.hidden = YES;
        [_quesTableView addSubview:self.noneLabel];
    }
    return _quesTableView;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
}
        
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        CYQuestionModel * model = self.modelArray[indexPath.row];
            
         if([model.IndexImg rangeOfString:@","].location !=NSNotFound)//_roaldSearchText
          {
        NSArray * arrImage = [model.IndexImg componentsSeparatedByString:@","];
        if(arrImage.count > 1 && arrImage.count < 3){
            return 190;
        }else if (arrImage.count <= 6 && arrImage.count >= 3){
            return 270;
        }
        return 350;
    }
    if ([model.IndexImg isEqualToString:@""]) {
        return 90;
        }else{
            if ([model.IndexImg isEqualToString:@""]) {
                return 100;
            }else{
                return 250;
            }
        }
            
}
//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.modelArray.count;
}
//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
            
        //取回数据
            
    CYQuestionModel * model = self.modelArray[indexPath.row];
            
    if([model.IndexImg rangeOfString:@","].location !=NSNotFound)//_roaldSearchText
    {
      //重用cell
      static NSString *quesCellID = @"question";
      CYQuestionTableViewCell *cell = [_quesTableView dequeueReusableCellWithIdentifier:quesCellID];
      if (cell==nil) {
      cell = [[[NSBundle mainBundle]loadNibNamed:@"CYQuestionTableViewCell" owner:self options:nil]lastObject];
      _picContainerView = [SDWeiXinPhotoContainerView new];
       _picContainerView.frame=CGRectMake(0, 0, cell.backView.frame.size.width, cell.backView.frame.size.height);
        [cell.backView addSubview:_picContainerView];
        }
        [cell configCell:self.modelArray[indexPath.row]];
        NSArray * arrImage = [model.IndexImg componentsSeparatedByString:@","];
        if(arrImage.count > 1 && arrImage.count <= 3){
            NSMutableArray *containArr = [NSMutableArray array];
            for (int i=0; i<arrImage.count; i++) {
                NSString * str=[NSString stringWithFormat:@"%@%@",kHTTPImg,arrImage[i]];                [containArr addObject:str];
            }
                _picContainerView.picPathStringsArray = containArr;
            }else if (arrImage.count <= 6 && arrImage.count > 3){
                    
           NSMutableArray *containArr = [NSMutableArray array];
           for (int i=0; i<arrImage.count; i++) {
           NSString * str=[NSString stringWithFormat:@"%@%@",kHTTPImg,arrImage[i]];
           [containArr addObject:str];
           }
            _picContainerView.picPathStringsArray = containArr;
        }else{
                    
        NSMutableArray *containArr = [NSMutableArray array];
        for (int i=0; i<arrImage.count; i++) {
         NSString * str=[NSString stringWithFormat:@"%@%@",kHTTPImg,arrImage[i]];
          [containArr addObject:str];
          }
            _picContainerView.picPathStringsArray = containArr;
        }
            return cell;
        }
            //重用cell
            static NSString *quesCellTwoID = @"quesCellTwoID";
            CYQuestionTwoTableViewCell *quesCellTwocell = [_quesTableView dequeueReusableCellWithIdentifier:quesCellTwoID];
            if (quesCellTwocell==nil) {
                quesCellTwocell = [[[NSBundle mainBundle]loadNibNamed:@"CYQuestionTwoTableViewCell" owner:self options:nil]lastObject];
                
            }
            [quesCellTwocell configCell:self.modelArray[indexPath.row]];
            return quesCellTwocell;
       
}
//详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CYQuestionModel * model = self.modelArray[indexPath.row];
    DSCarClubDetailController  *detailController    = [[DSCarClubDetailController alloc]init];
    detailController.comeTypeString = @"1";
    detailController.showType = @"高兴";
    detailController.hidesBottomBarWhenPushed       = YES;
    detailController.ActivityCode                   = model.ActivityCode;
    NSLog(@"模型中文章号%ld",(long)model.ActivityCode);
    [self.navigationController pushViewController:detailController animated:YES];
}


@end
