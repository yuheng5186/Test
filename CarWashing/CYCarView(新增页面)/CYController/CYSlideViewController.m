//
//  CYSlideViewController.m
//  CarWashing
//
//  Created by apple on 2017/10/12.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CYSlideViewController.h"

@interface CYSlideViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString* a;
}
@property (nonatomic,strong) UITableView * choosetableView;
@end

@implementation CYSlideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hh:) name:@"gb" object:nil];
    self.view.backgroundColor=[UIColor whiteColor];
    //   初始化tableview
    _choosetableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, 250, Main_Screen_Height-64) style:UITableViewStylePlain];
    _choosetableView.rowHeight=50;
    _choosetableView.delegate=self;
    _choosetableView.dataSource=self;
    [self.view addSubview:_choosetableView];
}
- (void)hh:(NSNotification *)notification{
    
    
    // 如果是传多个数据，那么需要哪个数据，就对应取出对应的数据即可
    
    a  = notification.userInfo[@"color"];
    
    [self.choosetableView reloadData];
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"test";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundView = nil;
    }
    if ([a isEqualToString:@"1"]) {
         cell.textLabel.text = [NSString stringWithFormat:@"------第%u奔驰------",(unsigned)indexPath.row + 3];
    }else{
        cell.textLabel.text = [NSString stringWithFormat:@"------第%u奔驰------",(unsigned)indexPath.row + 1];
    }
    
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
