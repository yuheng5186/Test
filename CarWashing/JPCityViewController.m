//
//  JPCityViewController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/31.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "JPCityViewController.h"

extern NSString * const YZUpdateMenuTitleNote;
static NSString * const ID_cell = @"cell";

@interface JPCityViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *titleArray;


@property (nonatomic, weak) UITableView *cityTableView;

@end

@implementation JPCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    _titleArray = @[@"上海市",@"浦东新区",@"黄浦区",@"杨浦区",@"松江区",@"虹口区"];
    
    UITableView *cityTableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    cityTableView.delegate = self;
    cityTableView.dataSource = self;
    self.cityTableView = cityTableView;
    [self.view addSubview:cityTableView];
    
    [cityTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID_cell];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.cityTableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionNone];
    //[self tableView:self.cityTableView didSelectRowAtIndexPath:indexPath];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID_cell];
    
    cell.textLabel.text = self.titleArray[indexPath.row];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    // 选中当前
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    // 更新菜单标题
    [[NSNotificationCenter defaultCenter] postNotificationName:YZUpdateMenuTitleNote object:self userInfo:@{@"title":cell.textLabel.text}];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
