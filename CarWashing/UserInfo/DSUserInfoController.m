//
//  DSUserInfoController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/20.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSUserInfoController.h"

@interface DSUserInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation DSUserInfoController

- (void)drawNavigation {
    
    [self drawTitle:@"个人信息" Color:[UIColor blackColor]];
    
}


- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    self.contentView.top                = self.statusView.bottom;
//    self.contentView.height             = self.view.height;
    self.contentView.backgroundColor    = [UIColor colorFromHex:@"#111112"];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createSubView];

}

- (void) createSubView {
    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStyleGrouped];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    self.tableView.scrollEnabled    = NO;
    self.tableView.tableFooterView  = [UIView new];
    self.tableView.tableHeaderView  = [UIView new];
    [self.contentView addSubview:self.tableView];
}
#pragma mark - UITableViewDataSource

-(CGFloat)tableView:(UITableView*)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}

-(CGFloat)tableView:(UITableView*)tableView heightForFooterInSection:(NSInteger)section

{
    return 0.01f;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    return 0;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 120;
    }else{
        return 60;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    
    if (indexPath.section == 0) {
        cell.textLabel.text     = @"头像";
        UIImageView *userImageView  = [UIUtil drawCustomImgViewInView:cell.contentView frame:CGRectMake(0, cell.contentView.centerY+Main_Screen_Height*10/667, 50, 50) imageName:@"icon_defaultavatar"];
        userImageView.left          = Main_Screen_Width*280/375;
        
        
    }else if (indexPath.section == 1){
        if (indexPath.row == 0) {
            cell.textLabel.text         = @"昵称";
            cell.detailTextLabel.text   = @"15800781856";
            
        }else if (indexPath.row == 1){
            cell.textLabel.text         = @"手机号";
            cell.detailTextLabel.text   = @"15800781856";
        }
        else {
            cell.textLabel.text         = @"性别";
            cell.detailTextLabel.text   = @"未填写";
        }
        
    }else if (indexPath.section == 2){
        if (indexPath.row == 0){
            cell.textLabel.text         = @"微信绑定";
            cell.detailTextLabel.text   = @"去绑定";
        }
        else {
            cell.textLabel.text         = @"QQ绑定";
            cell.detailTextLabel.text   = @"去绑定";
        }
    
    }
    else{
        cell.textLabel.text     = @"收货地址";
        
    }
    
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

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
