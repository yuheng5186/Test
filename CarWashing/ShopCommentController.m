//
//  ShopCommentController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ShopCommentController.h"
#import "BusinessEstimateCell.h"

@interface ShopCommentController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *commentListView;

@end

static NSString *id_commentShopCell = @"id_commentShopCell";

@implementation ShopCommentController

- (UITableView *)commentListView{
    if (_commentListView == nil) {
        UITableView *commenListView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _commentListView = commenListView;
        [self.view addSubview:commenListView];
    }
    return _commentListView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentListView.delegate = self;
    self.commentListView.dataSource = self;
    
    [self.commentListView registerNib:[UINib nibWithNibName:@"BusinessEstimateCell" bundle:nil] forCellReuseIdentifier:id_commentShopCell];
    self.commentListView.rowHeight = 110;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BusinessEstimateCell *commentCell = [tableView dequeueReusableCellWithIdentifier:id_commentShopCell forIndexPath:indexPath];
    
    return commentCell;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel *commentTitleLabel = [[UILabel alloc] init];
    commentTitleLabel.text = @"  评价(58)";
    commentTitleLabel.backgroundColor = [UIColor colorFromHex:@"#dfdfdf"];
    commentTitleLabel.textColor = [UIColor colorFromHex:@"#4a4a4a"];
    commentTitleLabel.font = [UIFont systemFontOfSize:14];
    
    return commentTitleLabel;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
    
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
