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
@property(strong,nonatomic)NSArray *dataArray;
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
    _dataArray = @[@"0",@"1",@"2"];
}


#pragma mark - TableView
-(UITableView *)quesTableView{
    if(_quesTableView == nil){
        _quesTableView = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStylePlain)];
        _quesTableView.delegate = self;
        _quesTableView.dataSource = self;
        _quesTableView.backgroundColor = [UIColor orangeColor];
        [_quesTableView registerClass:[QuesTableViewCell class] forCellReuseIdentifier:@"question"];
    }
    return _quesTableView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_dataArray[indexPath.section] != nil){
        return 340;
    }
    return 200;
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
    return cell;
}



@end
