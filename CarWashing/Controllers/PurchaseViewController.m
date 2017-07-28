//
//  PurchaseViewController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/19.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "PurchaseViewController.h"
#import "PurchaseCardViewCell.h"
#import "PayPurchaseCardController.h"

@interface PurchaseViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *purchaseCardView;

@property (nonatomic, strong) NSArray *titles;

@end

static NSString *id_puchaseCard = @"purchaseCardCell";

@implementation PurchaseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title  = @"购卡";
    
    [self setupUI];
}


- (UITableView *)purchaseCardView {
    if (!_purchaseCardView) {
        
        UITableView *purchaseCardView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, Main_Screen_Width, Main_Screen_Height - 108) style:UITableViewStylePlain];
        
        self.purchaseCardView = purchaseCardView;
        [self.view addSubview:purchaseCardView];
    }
    
    return _purchaseCardView;
}


- (void)setupUI {
    
    
    self.purchaseCardView.delegate = self;
    self.purchaseCardView.dataSource = self;
    
    [self.purchaseCardView registerClass:[PurchaseCardViewCell class] forCellReuseIdentifier:id_puchaseCard];
    
    self.purchaseCardView.rowHeight = 200;
    self.purchaseCardView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PurchaseCardViewCell *purchaseCardCell = [tableView dequeueReusableCellWithIdentifier:id_puchaseCard forIndexPath:indexPath];
    //purchaseCardCell.layer.backgroundColor = (__bridge CGColorRef _Nullable)([UIColor lightGrayColor]);
    purchaseCardCell.backgroundColor = [UIColor lightGrayColor];
    purchaseCardCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return purchaseCardCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PayPurchaseCardController *payCardController = [[PayPurchaseCardController alloc] init];
    
    payCardController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:payCardController animated:YES];
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
