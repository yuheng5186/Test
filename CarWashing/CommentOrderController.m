//
//  CommentOrderController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CommentOrderController.h"
#import "SuccessPayCell.h"

@interface CommentOrderController ()<UITableViewDataSource, UITableViewDelegate, PushVCDelegate>

@property (nonatomic, weak) UITableView *commentOrderView;

@end

static NSString *id_successPayCell = @"id_successPayCell";

@implementation CommentOrderController


- (UITableView *)commentOrderView {
    if (!_commentOrderView) {
        UITableView *commentOrderView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, self.view.bounds.size.height) style:UITableViewStyleGrouped];
        _commentOrderView = commentOrderView;
        [self.view addSubview:_commentOrderView];
    }
    return _commentOrderView;
}


- (void) drawContent
{
    self.statusView.hidden      = YES;
    self.navigationView.hidden  = YES;
    self.contentView.top        = 0;
    self.contentView.height     = self.view.height;
    self.contentView.backgroundColor = [UIColor lightGrayColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.commentOrderView.delegate = self;
    self.commentOrderView.dataSource = self;
    
    [self.commentOrderView registerNib:[UINib nibWithNibName:@"SuccessPayCell" bundle:nil] forCellReuseIdentifier:id_successPayCell];
    self.commentOrderView.rowHeight = 150;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    SuccessPayCell *commentCell = [tableView dequeueReusableCellWithIdentifier:id_successPayCell forIndexPath:indexPath];
    commentCell.delegate = self;
    
    return commentCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.1;
}



#pragma mark - successPaycell 的代理
- (void)pushController:(UIViewController *)viewController animated:(BOOL)animated {
    
    [self.navigationController pushViewController:viewController animated:animated];
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
