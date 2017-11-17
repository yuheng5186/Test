//
//  QuestionsViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "QuestionsViewController.h"
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


@interface QuestionsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    SDWeiXinPhotoContainerView *_picContainerView;
    
}
@property(nonatomic)NSInteger page;
@property(nonatomic,copy)NSMutableArray *modelArray;
@end

@implementation QuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _modelArray = [NSMutableArray array];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.quesTableView];
    self.page = 0;
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];

}



-(void)requestData{
    
    NSDictionary *mulDic = @{
                             @"ActivityType":@(2),//咨询,2.车友提问,3.热门话题
                             @"Account_Id":[UdStorage getObjectforKey:@"Account_Id"],
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



#pragma mark - TableView
-(UITableView *)quesTableView{
    if(_quesTableView == nil){
        _quesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-110) style:(UITableViewStylePlain)];
        _quesTableView.delegate = self;
        _quesTableView.dataSource = self;
        _quesTableView.backgroundColor = [UIColor whiteColor];
        _quesTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        [_quesTableView registerClass:[QuesTableViewCell class] forCellReuseIdentifier:@"question"];

    }
    return _quesTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CYQuestionModel * model = self.modelArray[indexPath.row];
//    //计算label高度
//    NSDictionary *font123 = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
//    CGSize maxSize = CGSizeMake(Main_Screen_Width-70, MAXFLOAT);
//    CGSize labelSize = [model.ActivityName boundingRectWithSize:maxSize options:(NSStringDrawingUsesLineFragmentOrigin) attributes:font123 context:nil].size;
    
    if([model.IndexImg rangeOfString:@","].location !=NSNotFound)//_roaldSearchText
    {
        NSArray * arrImage = [model.IndexImg componentsSeparatedByString:@","];
       if(arrImage.count > 1 && arrImage.count < 3){
            return 180;
        }else if (arrImage.count <= 6 && arrImage.count >= 3){
            return 260;
        }
        return 340;
    }
    if ([model.IndexImg isEqualToString:@""]) {
        return 90;
    }else{
        return 250;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CYQuestionModel * model = self.modelArray[indexPath.row];
    DSCarClubDetailController  *detailController    = [[DSCarClubDetailController alloc]init];
    detailController.hidesBottomBarWhenPushed       = YES;
    detailController.ActivityCode                   = model.ActivityCode;
    [self.navigationController pushViewController:detailController animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
