//
//  EarnScoreController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/8/14.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "EarnScoreController.h"
#import "MemberRegualrController.h"

@interface EarnScoreController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UIImageView *adverView;

@property (nonatomic, weak) UITableView *earnWayView;

@end

@implementation EarnScoreController


- (UIImageView *)adverView {
    
    if (!_adverView) {
        
        UIImageView *adverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, 200)];
        _adverView = adverView;
        [self.view addSubview:adverView];
    }
    return _adverView;
}


- (UITableView *)earnWayView {
    
    if (!_earnWayView) {
        
        UITableView *earnWayView = [[UITableView alloc] initWithFrame:CGRectMake(0, 264, Main_Screen_Width, Main_Screen_Height - 264) style:UITableViewStylePlain];
        _earnWayView = earnWayView;
        [self.view addSubview:_earnWayView];
    }
    return _earnWayView;
}


- (void)drawNavigation {
    
    [self drawTitle:@"赚积分"];
    [self drawRightTextButton:@"积分规则" action:@selector(clickRegularButton)];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.earnWayView.delegate = self;
    self.earnWayView.dataSource = self;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return nil;
}





- (void)clickRegularButton{
    
    MemberRegualrController *regularController = [[MemberRegualrController alloc] init];
    
    [self.navigationController pushViewController:regularController animated:YES];
    
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
