//
//  DSCarClubDetailController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/28.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCarClubDetailController.h"

@interface DSCarClubDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation DSCarClubDetailController

- (void)drawNavigation {
    
    [self drawTitle:@"活动详情" Color:[UIColor blackColor]];
    
}

- (void) drawContent
{
    self.statusView.backgroundColor     = [UIColor grayColor];
    self.navigationView.backgroundColor = [UIColor grayColor];
    self.contentView.top                = Main_Screen_Height*44/667;
    self.contentView.height             = self.view.height;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self createSubView];
}
- (void) createSubView {

    self.tableView                  = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, Main_Screen_Width,Main_Screen_Height) style:UITableViewStylePlain];
    self.tableView.top              = 0;
    self.tableView.delegate         = self;
    self.tableView.dataSource       = self;
    //    self.tableView.separatorStyle   = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor  = [UIColor whiteColor];
    //    self.tableView.scrollEnabled    = NO;
    //    self.tableView.tableFooterView  = [UIView new];
    
    [self.contentView addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 340;
    }
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:nil];
    }
    cell.backgroundColor    = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    

    

    
    if (indexPath.row == 0) {
        cell.backgroundColor    = [UIColor lightGrayColor];
        UIView  *upView     = [UIUtil drawLineInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*80/667) color:[UIColor whiteColor]];
        upView.top          = 0;
        
        UIImageView  *userImageView       = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, 50, 50) imageName:@"icon_defaultavatar"];
        userImageView.left                = Main_Screen_Width*10/375;
        userImageView.top                 = Main_Screen_Height*10/667;
        
        NSString *userString              = @"15800781856";
        UIFont *userStringFont            = [UIFont systemFontOfSize:14];
        UILabel *uesrStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:userString font:userStringFont] font:userStringFont text:userString isCenter:NO];
        uesrStringLabel.textColor         = [UIColor blackColor];
        uesrStringLabel.left              = userImageView.right +Main_Screen_Width*10/375;
        uesrStringLabel.top               = Main_Screen_Height*15/667;
        
        NSString *timeString              = @"2017-7-27 15:30";
        UIFont *timeStringFont            = [UIFont systemFontOfSize:14];
        UILabel *timeStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:timeString font:timeStringFont] font:timeStringFont text:timeString isCenter:NO];
        timeStringLabel.textColor         = [UIColor blackColor];
        timeStringLabel.left              = userImageView.right +Main_Screen_Width*10/375;
        timeStringLabel.top               = uesrStringLabel.bottom +Main_Screen_Height*5/667;
    }if (indexPath.row == 1) {

        UIView  *upView     = [UIUtil drawLineInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*80/667) color:[UIColor whiteColor]];
        upView.top          = 0;
        
        UIImageView  *userImageView       = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, 50, 50) imageName:@"icon_defaultavatar"];
        userImageView.left                = Main_Screen_Width*10/375;
        userImageView.top                 = Main_Screen_Height*10/667;
        
        NSString *userString              = @"15800781856";
        UIFont *userStringFont            = [UIFont systemFontOfSize:14];
        UILabel *uesrStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:userString font:userStringFont] font:userStringFont text:userString isCenter:NO];
        uesrStringLabel.textColor         = [UIColor blackColor];
        uesrStringLabel.left              = userImageView.right +Main_Screen_Width*10/375;
        uesrStringLabel.top               = Main_Screen_Height*15/667;
        
        NSString *timeString              = @"2017-7-27 15:30";
        UIFont *timeStringFont            = [UIFont systemFontOfSize:14];
        UILabel *timeStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:timeString font:timeStringFont] font:timeStringFont text:timeString isCenter:NO];
        timeStringLabel.textColor         = [UIColor blackColor];
        timeStringLabel.left              = uesrStringLabel.right +Main_Screen_Width*80/375;
        timeStringLabel.centerY           = uesrStringLabel.centerY;
        
        NSString *userSayString              = @"我也要去看看";
        UIFont *userSayStringFont            = [UIFont systemFontOfSize:14];
        UILabel *uesrSayStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:userSayString font:userSayStringFont] font:userSayStringFont text:userSayString isCenter:NO];
        uesrSayStringLabel.textColor         = [UIColor blackColor];
        uesrSayStringLabel.left              = userImageView.right +Main_Screen_Width*10/375;
        uesrSayStringLabel.top               = uesrStringLabel.bottom +Main_Screen_Height*15/667;
        
        NSString *numberString              = @"68";
        UIFont *numberStringFont            = [UIFont systemFontOfSize:14];
        UILabel *numberSayStringLabel       = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:numberString font:numberStringFont] font:numberStringFont text:numberString isCenter:NO];
        numberSayStringLabel.textColor         = [UIColor blackColor];
        numberSayStringLabel.right             = timeStringLabel.right;
        numberSayStringLabel.top               = timeStringLabel.bottom +Main_Screen_Height*15/667;
    }
    
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
