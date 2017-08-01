//
//  DiscountController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/1.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DiscountController.h"
#import "DiscountCell.h"

@interface DiscountController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *discountView;

@end

static NSString *id_discountCell = @"id_discountCell";

@implementation DiscountController


- (UITableView *)discountView {
    
    if (_discountView == nil) {
        
        UITableView *discountView = [[UITableView alloc] initWithFrame:CGRectInset(self.view.bounds, 10, 10) style:UITableViewStyleGrouped];
        _discountView = discountView;
        [self.view addSubview:_discountView];
    }
    return _discountView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.discountView.delegate = self;
    self.discountView.dataSource = self;
    
    [self.discountView registerNib:[UINib nibWithNibName:@"DiscountCell" bundle:nil] forCellReuseIdentifier:id_discountCell];
    
    self.discountView.backgroundColor = [UIColor lightGrayColor];
    self.discountView.rowHeight = 130;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DiscountCell *cell = [tableView dequeueReusableCellWithIdentifier:id_discountCell forIndexPath:indexPath];

    return cell;
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
