//
//  HotTopicViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "HotTopicViewController.h"
#import "HotTableViewCell.h"

@interface HotTopicViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *hotTable;
@end

@implementation HotTopicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:self.hotTable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - Navigation
-(UITableView *)hotTable{
    if(_hotTable == nil){
        _hotTable = [[UITableView alloc]initWithFrame:self.view.frame style:(UITableViewStylePlain)];
        _hotTable.delegate = self;
        _hotTable.dataSource = self;
        
        [_hotTable registerClass:[HotTableViewCell class] forCellReuseIdentifier:@"OneImage"];
    }
    return _hotTable;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 250;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

//动态格子数量
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HotTableViewCell *oneImageCell = [tableView dequeueReusableCellWithIdentifier:@"OneImage" forIndexPath:indexPath];
    return oneImageCell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}



@end
