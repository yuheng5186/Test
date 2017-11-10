//
//  QuestionsViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "QuestionsViewController.h"
#import "QuesTableViewCell.h"
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

@interface QuestionsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic)NSInteger page;
@property(nonatomic,copy)NSMutableArray *modelArray;
@end

@implementation QuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
//    [self getData];
    [self requestData];
    [self.view addSubview:self.quesTableView];
    self.page = 0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestData{
    _modelArray = [NSMutableArray new];
    NSDictionary *mulDic = @{
                             @"ActivityType":@(2),//咨询,2.车友提问,3.热门话题
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
        NSLog(@"--数据%@",dict);
        if ([[dict objectForKey:@"ResultCode"] isEqualToString:[NSString stringWithFormat:@"%@",@"F000000"]]) {
            //获取json数组

            self.modelArray = (NSMutableArray*)[CYQuestionModel mj_objectArrayWithKeyValuesArray:dict[@"JsonData"]];
  
        }
        [self.quesTableView reloadData];
    } fail:^(NSError *error) {
        
    }];
    
}

#pragma mark - TableView
-(void)getData{
    //获取数据
    NSString *URLStringJpg = @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1509604874541&di=5cfaf6d8a3ddb781ea369e1bd2e3e948&imgtype=0&src=http%3A%2F%2Fi1.ymfile.com%2Fuploads%2Fllc%2Fphb%2F06%2F27%2Fx2_1.1403838708_2048_1536_264311.jpg";
    NSArray *oneData = [NSArray new];
    NSArray *twoData = @[URLStringJpg,URLStringJpg];
    NSArray *threeData = @[URLStringJpg,URLStringJpg,URLStringJpg,URLStringJpg,URLStringJpg,URLStringJpg,URLStringJpg];
    NSArray *fourArray = @[URLStringJpg,URLStringJpg,URLStringJpg,URLStringJpg];
    NSArray *fiveArray = @[URLStringJpg];
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray addObject:threeData];
    [_dataArray addObject:oneData];
    [_dataArray addObject:twoData];
    [_dataArray addObject:fiveArray];
    [_dataArray addObject:fourArray];

    
    _mainImfoArray = @[@"项目中我们有时会需要根据字符串来确定UILabel的宽度或高度，如我们经常遇到的单元格自适应问题。如果是要动态知道UILabel的高度，那么我们直接利用单元格自适应高度就可以",@"项目中我们有时会需要根据字符串来确定UILabel的宽度或高度，如果是要动态知道UILabel的高度，那么我们直接利用单元格自适应高度就可以",@"如我们经常遇到的单元格自适应问题。如果是要动态知道UILabel的高度，那么我们直接利用单元格自适应高度就可以",@"项目中我们有时以",@"项目中我们有时会需要根据字符串来确定UILabel的宽度或高度，如我们经常遇到的单元格自适应问题。如果是要动态知道UILabel的高。"];

    

}


#pragma mark - TableView
-(UITableView *)quesTableView{
    if(_quesTableView == nil){
        _quesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-106) style:(UITableViewStylePlain)];
        _quesTableView.delegate = self;
        _quesTableView.dataSource = self;
        _quesTableView.backgroundColor = [UIColor whiteColor];
        _quesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_quesTableView registerClass:[QuesTableViewCell class] forCellReuseIdentifier:@"question"];

    }
    return _quesTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _modelArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYQuestionModel * model = self.modelArray[indexPath.section];
//    //计算label高度
//    NSDictionary *font123 = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
//    CGSize maxSize = CGSizeMake(Main_Screen_Width-70, MAXFLOAT);
//    CGSize labelSize = [model.ActivityName boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:font123 context:nil].size;
    
    if([model.IndexImg rangeOfString:@","].location !=NSNotFound)//_roaldSearchText
    {
        NSArray * arrImage = [model.IndexImg componentsSeparatedByString:@","];
       if(arrImage.count > 1 && arrImage.count <= 3){
            return 260;
        }else if (arrImage.count <= 6 && arrImage.count > 3){
            return 260;
        }
        return 340;
    }
    if ([model.IndexImg isEqualToString:@""]) {
        return 100;
    }
    return 250;
    
}

//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //取回数据
    //重用cell
    static NSString *quesCellID = @"question";
    QuesTableViewCell *cell = [_quesTableView dequeueReusableCellWithIdentifier:quesCellID forIndexPath:indexPath];
    [cell configModel:self.modelArray[indexPath.section]];

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DSCarClubDetailController *new = [[DSCarClubDetailController alloc]init];
    [self.navigationController pushViewController:new animated:YES];
}



@end
