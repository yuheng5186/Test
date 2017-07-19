//
//  BusinessViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "BusinessViewController.h"
#import "SalerListViewCell.h"
#import "YZPullDownMenu.h"
#import "YZMenuButton.h"
#import "YZMoreMenuViewController.h"
#import "YZSortViewController.h"
#import "YZAllCourseViewController.h"

@interface BusinessViewController ()<UITableViewDelegate, UITableViewDataSource,YZPullDownMenuDataSource>

@property (nonatomic, weak) UITableView *salerListView;

@property (nonatomic, strong) NSArray *titles;

@end

static NSString *salerListCell = @"salerListViewCell";

@implementation BusinessViewController


- (UITableView *)salerListView {
    if (nil == _salerListView) {
        UITableView *salerListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _salerListView = salerListView;
        [self.view addSubview:salerListView];
        
    }
    return _salerListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"商家";
    
    [self setupUI];
    
    [self setSearchMenu];
}


- (void)setupUI {
    
    self.salerListView.delegate = self;
    self.salerListView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"SalerListViewCell" bundle:nil];
    
    [self.salerListView registerNib:nib forCellReuseIdentifier:salerListCell];
    
    self.salerListView.rowHeight = 96;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SalerListViewCell *salerListViewCell = [tableView dequeueReusableCellWithIdentifier:salerListCell forIndexPath:indexPath];
    
    
    return salerListViewCell;
}


#pragma mark - 搜索下拉
- (void)setSearchMenu {
    
    // 创建下拉菜单
    YZPullDownMenu *menu = [[YZPullDownMenu alloc] init];
    menu.frame = CGRectMake(0, 64, Main_Screen_Width, 44);
    [self.view addSubview:menu];
    
    // 设置下拉菜单代理
    menu.dataSource = self;
    
    // 初始化标题
    _titles = @[@"全部门店",@"默认排序",@"筛选"];
    
    // 添加子控制器
    [self setupAllChildViewController];
}


#pragma mark - 添加子控制器
- (void)setupAllChildViewController
{
    YZAllCourseViewController *allCourse = [[YZAllCourseViewController alloc] init];
    YZSortViewController *sort = [[YZSortViewController alloc] init];
    YZMoreMenuViewController *moreMenu = [[YZMoreMenuViewController alloc] init];
    [self addChildViewController:allCourse];
    [self addChildViewController:sort];
    [self addChildViewController:moreMenu];
}

#pragma mark - YZPullDownMenuDataSource
// 返回下拉菜单多少列
- (NSInteger)numberOfColsInMenu:(YZPullDownMenu *)pullDownMenu
{
    return 3;
}

// 返回下拉菜单每列按钮
- (UIButton *)pullDownMenu:(YZPullDownMenu *)pullDownMenu buttonForColAtIndex:(NSInteger)index
{
    YZMenuButton *button = [YZMenuButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:_titles[index] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithRed:25 /255.0 green:143/255.0 blue:238/255.0 alpha:1] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"标签-向下箭头"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"标签-向上箭头"] forState:UIControlStateSelected];
    
    return button;
}

// 返回下拉菜单每列对应的控制器
- (UIViewController *)pullDownMenu:(YZPullDownMenu *)pullDownMenu viewControllerForColAtIndex:(NSInteger)index
{
    return self.childViewControllers[index];
}

// 返回下拉菜单每列对应的高度
- (CGFloat)pullDownMenu:(YZPullDownMenu *)pullDownMenu heightForColAtIndex:(NSInteger)index
{
    // 第1列 高度
    if (index == 0) {
        return 400;
    }
    
    // 第2列 高度
    if (index == 1) {
        return 180;
    }
    
    // 第3列 高度
    return 240;
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
