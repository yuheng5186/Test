//
//  ShopCommentController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ShopCommentController.h"

@interface ShopCommentController ()

@property (nonatomic, weak) UITableView *commentListView;

@end

@implementation ShopCommentController

- (UITableView *)commentListView{
    if (_commentListView == nil) {
        UITableView *commenListView = [[UITableView alloc] initWithFrame:self.view.bounds];
        _commentListView = commenListView;
        [self.view addSubview:commenListView];
    }
    return _commentListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
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
