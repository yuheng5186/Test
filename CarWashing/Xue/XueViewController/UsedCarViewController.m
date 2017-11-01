//
//  UsedCarViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/11/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "UsedCarViewController.h"
#import "CYUserCarTableViewCell.h"

@interface UsedCarViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(strong,nonatomic)UITableView *CYUserCarTableView;
@end

@implementation UsedCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.CYUserCarTableView];
}

#pragma mark - TableView
-(UITableView *)CYUserCarTableView{
    if(_CYUserCarTableView == nil){
        _CYUserCarTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height-108) style:(UITableViewStylePlain)];
        _CYUserCarTableView.delegate = self;
        _CYUserCarTableView.dataSource = self;
        _CYUserCarTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        _CYUserCarTableView.rowHeight = 145*Main_Screen_Height/667;
        
    }
    return _CYUserCarTableView;
}
//每组行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

//cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CYUserCarCellID = @"CYUserCarCellID";
    CYUserCarTableViewCell *cell = [_CYUserCarTableView dequeueReusableCellWithIdentifier:CYUserCarCellID];
    if(cell == nil){
        cell = [[CYUserCarTableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:CYUserCarCellID];
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_CYUserCarTableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
