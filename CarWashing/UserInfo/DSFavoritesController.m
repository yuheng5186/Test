//
//  DSFavoritesController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSFavoritesController.h"

#import "SalerListViewCell.h"

@interface DSFavoritesController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *favoriteListView;

@end

static NSString *id_favoriteCell = @"id_favoriteCell";

@implementation DSFavoritesController

- (UITableView *)favoriteListView{
    if (nil == _favoriteListView) {
        UITableView *favoriteListView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 64)];
        [self.view addSubview:favoriteListView];
        _favoriteListView = favoriteListView;
    }
    
    return _favoriteListView;
}

- (void)drawNavigation {
    
    [self drawTitle:@"收藏"];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    self.favoriteListView.delegate = self;
    self.favoriteListView.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"SalerListViewCell" bundle:nil];
    
    [self.favoriteListView registerNib:nib forCellReuseIdentifier:id_favoriteCell];
    
    self.favoriteListView.rowHeight = 96;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SalerListViewCell *favoriCell = [tableView dequeueReusableCellWithIdentifier:id_favoriteCell forIndexPath:indexPath];
    
    return favoriCell;
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
