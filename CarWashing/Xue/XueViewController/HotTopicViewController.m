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

@interface HotTopicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *hotTable;
@property(strong,nonatomic)NSMutableArray *dataArray;
@end

@implementation HotTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [self getData];
    [self.view addSubview:self.hotTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - getData
-(void)getData{
    NSArray *oneData = [NSArray new];
    NSArray *twoData = @[@"ershouchetu"];
    NSArray *threeData = @[@"ershouchetu",@"ershouchetu"];
    _dataArray = [[NSMutableArray alloc]init];
    [_dataArray addObject:oneData];
    [_dataArray addObject:twoData];
    [_dataArray addObject:threeData];
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
    NSArray *tempArray = [[NSArray alloc]initWithArray:_dataArray[indexPath.section]];
    if(tempArray.count == 1){
        return 280;
    }
    return 210;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//动态格子数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *tempArray = [[NSArray alloc]initWithArray:_dataArray[indexPath.section]];
    if(tempArray.count == 1){
        HotTableViewCell *oneImageCell = [tableView dequeueReusableCellWithIdentifier:@"OneImage" forIndexPath:indexPath];
        return oneImageCell;
    }   //@end if
    AnotherHotTableViewCell *collectionCell = [tableView dequeueReusableCellWithIdentifier:@"collect" forIndexPath:indexPath];

    return collectionCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
