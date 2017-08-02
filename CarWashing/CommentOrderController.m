//
//  CommentOrderController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/2.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "CommentOrderController.h"
#import "CommentOrderViewCell.h"

@interface CommentOrderController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) UITableView *commentOrderView;

@end

static NSString *id_commentOrderCell = @"id_commentOrderCell";

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
    
    [self.commentOrderView registerNib:[UINib nibWithNibName:@"CommentOrderViewCell" bundle:nil] forCellReuseIdentifier:id_commentOrderCell];
    self.commentOrderView.rowHeight = 180;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentOrderViewCell *commentCell = [tableView dequeueReusableCellWithIdentifier:id_commentOrderCell forIndexPath:indexPath];
    
    
    return commentCell;
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
