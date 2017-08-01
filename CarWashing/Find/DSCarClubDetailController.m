//
//  DSCarClubDetailController.m
//  CarWashing
//
//  Created by Wuxinglin on 2017/7/28.
//  Copyright © 2017年 DS. All rights reserved.
//

#import "DSCarClubDetailController.h"

#import "DSActivityDetailCell.h"
#import "UITableView+SDAutoTableViewCellHeight.h"


@interface DSCarClubDetailController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray    *modelsArray;
@property (nonatomic, strong) UIImageView       *userImageView;
@property (nonatomic, strong) UILabel           *userName;
@property (nonatomic, strong) UILabel           *sayTime;
@property (nonatomic, strong) UILabel           *titleLab;
@property (nonatomic, strong) UILabel           *contentLab;
@property (nonatomic, strong) UILabel           *sayNumberLab;


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
    
    [self createHeaderView];
    [self creatModelsWithCount:10];
}

- (void) createHeaderView {
    UIView *header = [UIView new];
    header.width = [UIScreen mainScreen].bounds.size.width;
    header.backgroundColor  = [UIColor whiteColor];
    
    
    
    UIImageView *userImageView  = [UIImageView new];
    userImageView.image         = [UIImage imageNamed:@"icon0.jpg"];
    self.userImageView          = userImageView;
    [header addSubview:userImageView];
    
    
    userImageView.sd_layout
    .leftSpaceToView(header, 10)
    .topSpaceToView(header, 10)
    .heightIs(40)
    .widthIs(40);
    userImageView.sd_cornerRadiusFromWidthRatio     = @(0.5);
    
    UILabel *userName                   = [UILabel new];
    userName.textColor                  = [UIColor blackColor];
    userName.font                       = [UIFont systemFontOfSize:16];
    userName.text                       = @"15800781856";
    self.userName                       = userName;
    [header addSubview:userName];
    
    userName.sd_layout
    .leftSpaceToView(userImageView, 10)
    .topSpaceToView(header, 10)
    .heightIs(20)
    .widthIs(150);
    
    
    UILabel *sayTimeLab                 = [UILabel new];
    sayTimeLab.textColor                = [UIColor lightGrayColor];
    sayTimeLab.text                     = @"2017-7-31";
    sayTimeLab.font                     = [UIFont systemFontOfSize:16];
    self.sayTime                        = sayTimeLab;
    [header addSubview:sayTimeLab];
    
    
    sayTimeLab.sd_layout
    .leftEqualToView(userName)
    .topSpaceToView(userName, 10)
    .widthIs(150)
    .heightIs(20);
    
    
    
    
    
    UIView *backgroudView               = [UIView new];
    backgroudView.width                 = [UIScreen mainScreen].bounds.size.width;
    backgroudView.backgroundColor       = [UIColor grayColor];
    [header addSubview:backgroudView];
    
    backgroudView.sd_layout
    .topSpaceToView(sayTimeLab, 10)
    .leftEqualToView(header)
    .heightIs(300);
    
    
    UILabel *sayNumberLab                   = [UILabel new];
    sayNumberLab.textColor                  = [UIColor blackColor];
    sayNumberLab.font                       = [UIFont systemFontOfSize:16];
    sayNumberLab.text                       = @"评论（28）";
    self.sayNumberLab                       = sayNumberLab;
    [header addSubview:sayNumberLab];
    
    sayNumberLab.sd_layout
    .leftSpaceToView(header, 10)
    .topSpaceToView(backgroudView, 10)
    .widthIs(100)
    .heightIs(20);
    
    
    UIView *bottomLine = [UIView new];
    bottomLine.backgroundColor = [[UIColor lightGrayColor] colorWithAlphaComponent:0.3];
    [header addSubview:bottomLine];
    
    bottomLine.sd_layout
    .topSpaceToView(sayNumberLab, 10)
    .leftSpaceToView(header, 0)
    .rightSpaceToView(header, 0)
    .heightIs(1);
    
    
    [header setupAutoHeightWithBottomView:bottomLine bottomMargin:10];
    [header layoutSubviews];
    self.tableView.tableHeaderView  = header;
    
    
}
- (void) creatModelsWithCount:(NSInteger)count {
    
    if (!_modelsArray) {
        _modelsArray = [NSMutableArray new];
    }
    
    NSArray *iconImageNamesArray = @[@"icon0.jpg",
                                     @"icon1.jpg",
                                     @"icon2.jpg",
                                     @"icon3.jpg",
                                     @"icon4.jpg",
                                     ];
    
    NSArray *namesArray = @[@"1.GSD_iOS",
                            @"2.风口上的猪",
                            @"3.当今世界网名都不好起了",
                            @"4.我叫郭德纲",
                            @"5.Hello Kitty"];
    
    NSArray *textArray = @[@"1.当你的 app 没有提供 3x 的 LaunchImage 时，系统默认进入兼容模式，大屏幕一切按照 320 宽度渲染，屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"2.然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。",
                           @"3.当你的 app 没有提供 3x 的 LaunchImage 时",
                           @"4.但是建议不要长期处于这种模式下，否则在大屏上会显得字大，内容少，容易遭到用户投诉。",
                           @"5.屏幕宽度返回 320；然后等比例拉伸到大屏。这种情况下对界面不会产生任何影响，等于把小屏完全拉伸。但是建议不要长期处于这种模式下。"
                           ];
    
    
    
    for (int i = 0; i < iconImageNamesArray.count; i++) {
        //        int iconRandomIndex = arc4random_uniform(5);
        //        int nameRandomIndex = arc4random_uniform(5);
        //        int contentRandomIndex = arc4random_uniform(5);
        
        DSUserModel *model = [DSUserModel new];
        model.iconName = iconImageNamesArray[i];
        model.name = namesArray[i];
        model.content = textArray[i];
        model.sayTime   = @"2017-7-31";
        
        
        //        DSUserModel *model = [DSUserModel new];
        //        model.iconName = iconImageNamesArray[i];
        //        model.name = namesArray[i];
        //        model.content = textArray[i];
        
        // 模拟“有或者无图片”
        
        [self.modelsArray addObject:model];
    }
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return self.modelsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellStatic = @"cellStatic";
    DSActivityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:cellStatic];
    if (!cell) {
        cell = [[DSActivityDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellStatic];
    }
    cell.model  = self.modelsArray[indexPath.row];
    

    

    
//    if (indexPath.row == 0) {
//        cell.backgroundColor    = [UIColor lightGrayColor];
//        UIView  *upView     = [UIUtil drawLineInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*80/667) color:[UIColor whiteColor]];
//        upView.top          = 0;
//        
//        UIImageView  *userImageView       = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, 50, 50) imageName:@"icon_defaultavatar"];
//        userImageView.left                = Main_Screen_Width*10/375;
//        userImageView.top                 = Main_Screen_Height*10/667;
//        
//        NSString *userString              = @"15800781856";
//        UIFont *userStringFont            = [UIFont systemFontOfSize:14];
//        UILabel *uesrStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:userString font:userStringFont] font:userStringFont text:userString isCenter:NO];
//        uesrStringLabel.textColor         = [UIColor blackColor];
//        uesrStringLabel.left              = userImageView.right +Main_Screen_Width*10/375;
//        uesrStringLabel.top               = Main_Screen_Height*15/667;
//        
//        NSString *timeString              = @"2017-7-27 15:30";
//        UIFont *timeStringFont            = [UIFont systemFontOfSize:14];
//        UILabel *timeStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:timeString font:timeStringFont] font:timeStringFont text:timeString isCenter:NO];
//        timeStringLabel.textColor         = [UIColor blackColor];
//        timeStringLabel.left              = userImageView.right +Main_Screen_Width*10/375;
//        timeStringLabel.top               = uesrStringLabel.bottom +Main_Screen_Height*5/667;
//    }if (indexPath.row == 1) {
//
//        UIView  *upView     = [UIUtil drawLineInView:cell.contentView frame:CGRectMake(0, 0, Main_Screen_Width, Main_Screen_Height*80/667) color:[UIColor whiteColor]];
//        upView.top          = 0;
//        
//        UIImageView  *userImageView       = [UIUtil drawCustomImgViewInView:upView frame:CGRectMake(0, 0, 50, 50) imageName:@"icon_defaultavatar"];
//        userImageView.left                = Main_Screen_Width*10/375;
//        userImageView.top                 = Main_Screen_Height*10/667;
//        
//        NSString *userString              = @"15800781856";
//        UIFont *userStringFont            = [UIFont systemFontOfSize:14];
//        UILabel *uesrStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:userString font:userStringFont] font:userStringFont text:userString isCenter:NO];
//        uesrStringLabel.textColor         = [UIColor blackColor];
//        uesrStringLabel.left              = userImageView.right +Main_Screen_Width*10/375;
//        uesrStringLabel.top               = Main_Screen_Height*15/667;
//        
//        NSString *timeString              = @"2017-7-27 15:30";
//        UIFont *timeStringFont            = [UIFont systemFontOfSize:14];
//        UILabel *timeStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:timeString font:timeStringFont] font:timeStringFont text:timeString isCenter:NO];
//        timeStringLabel.textColor         = [UIColor blackColor];
//        timeStringLabel.left              = uesrStringLabel.right +Main_Screen_Width*80/375;
//        timeStringLabel.centerY           = uesrStringLabel.centerY;
//        
//        NSString *userSayString              = @"我也要去看看";
//        UIFont *userSayStringFont            = [UIFont systemFontOfSize:14];
//        UILabel *uesrSayStringLabel          = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:userSayString font:userSayStringFont] font:userSayStringFont text:userSayString isCenter:NO];
//        uesrSayStringLabel.textColor         = [UIColor blackColor];
//        uesrSayStringLabel.left              = userImageView.right +Main_Screen_Width*10/375;
//        uesrSayStringLabel.top               = uesrStringLabel.bottom +Main_Screen_Height*15/667;
//        
//        NSString *numberString              = @"68";
//        UIFont *numberStringFont            = [UIFont systemFontOfSize:14];
//        UILabel *numberSayStringLabel       = [UIUtil drawLabelInView:cell.contentView frame:[UIUtil textRect:numberString font:numberStringFont] font:numberStringFont text:numberString isCenter:NO];
//        numberSayStringLabel.textColor         = [UIColor blackColor];
//        numberSayStringLabel.right             = timeStringLabel.right;
//        numberSayStringLabel.top               = timeStringLabel.bottom +Main_Screen_Height*15/667;
//    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    
    return [self.tableView cellHeightForIndexPath:indexPath model:self.modelsArray[indexPath.row] keyPath:@"model" cellClass:[DSActivityDetailCell class] contentViewWidth:[self cellContentViewWith]];
}

- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
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
