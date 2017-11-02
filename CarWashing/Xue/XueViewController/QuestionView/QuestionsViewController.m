//
//  QuestionsViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "QuestionsViewController.h"
#import "QuesTableViewCell.h"

@interface QuestionsViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(strong,nonatomic)UITableView *quesTableView;
@property(strong,nonatomic)NSMutableArray *dataArray;
@end

@implementation QuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self getData];
    [self.view addSubview:self.quesTableView];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TableView
-(void)getData{
    //获取数据
    NSArray *oneData = [NSArray new];
    NSArray *twoData = @[@"ershouchetu",@"ershouchetu"];
    NSArray *threeData = @[@"ershouchetu"];
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray addObject:oneData];
    [_dataArray addObject:twoData];
    [_dataArray addObject:threeData];

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
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *tempArray = [[NSArray alloc]initWithArray:_dataArray[indexPath.section]];
    if(tempArray.count > 0){
        return 310;
    }
    //没有图片
    return 150;
}

//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *quesCellID = @"question";
//    QuesTableViewCell *cell = [_quesTableView dequeueReusableCellWithIdentifier:quesCellID];
//    if(cell == nil){
//        cell = [[QuesTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:quesCellID];
//    }
    QuesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:quesCellID forIndexPath:indexPath];
    NSArray *tempArray = [[NSArray alloc]initWithArray:_dataArray[indexPath.section]];
    if(tempArray.count == 0){
        cell.largeImageView.hidden = YES;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
