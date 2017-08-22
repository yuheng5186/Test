//
//  ShopIntroController.m
//  CarWashing
//
//  Created by 时建鹏 on 2017/7/26.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "ShopIntroController.h"
#import "ShopInfoHeadView.h"
#import "BusinessMapController.h"

@interface ShopIntroController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) ShopInfoHeadView *infoHeadView;

@property (nonatomic, weak) UITableView *infoTableView;

@end

static NSString *id_infoCell = @"id_infoCell";

@implementation ShopIntroController

- (ShopInfoHeadView *)infoHeadView {
    
    if (!_infoHeadView) {
        ShopInfoHeadView *infoHeadView = [ShopInfoHeadView shopInfoHeadView];
        _infoHeadView = infoHeadView;
        [self.view addSubview:_infoHeadView];
    }
    return _infoHeadView;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
}

- (void)setupUI {
    
    self.infoHeadView.frame = CGRectMake(0, 0, Main_Screen_Width, 280*Main_Screen_Height/667);
    self.infoHeadView.namelabel.text = self.dic[@"MerName"];
    self.infoHeadView.addresslabel.text = self.dic[@"MerAddress"];
    if([self.dic[@"ShopType"] intValue] == 1)
    {
        self.infoHeadView.typelabel.text = @"洗车服务";
    }
    UITableView *infoTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height - 64 - 44*Main_Screen_Height/667) style:UITableViewStylePlain];
    _infoTableView = infoTableView;
    [self.view addSubview:_infoTableView];
    
    infoTableView.delegate = self;
    infoTableView.dataSource = self;
    
    
    infoTableView.tableHeaderView = self.infoHeadView;
    infoTableView.rowHeight = 200*Main_Screen_Height/667;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    UITableViewCell *infoCell = [tableView dequeueReusableCellWithIdentifier:id_infoCell];
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    
    
    UIImageView *infoImageView = [[UIImageView alloc] init];
    infoImageView.image = [UIImage imageNamed:@"hangdiantu"];
    infoImageView.frame = CGRectMake(0, 0, Main_Screen_Width, 200*Main_Screen_Height/667);
    [cell.contentView addSubview:infoImageView];
    

    
    return cell;
}

- (IBAction)skipToMapView:(id)sender {
    
    BusinessMapController *mapVC = [[BusinessMapController alloc] init];
    mapVC.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:mapVC animated:YES];
    
}



- (IBAction)didClickShopPhone:(id)sender {
    
    NSString *message = @"是否拨打商家电话";
    NSString *title = @"";
    [self showAlertWithTitle:title message:message];
    
}


//方法子
- (void)showAlertWithTitle:(NSString *)title message:(NSString *)message {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancelAction];
    
    UIAlertAction *OKAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:OKAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
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
