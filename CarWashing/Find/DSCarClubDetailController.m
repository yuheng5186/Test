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


@interface DSCarClubDetailController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

@property (nonatomic,strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray    *modelsArray;
@property (nonatomic, strong) UIImageView       *userImageView;
@property (nonatomic, strong) UIImageView       *seeImageView;
@property (nonatomic, strong) UILabel           *seeNumber;
@property (nonatomic, strong) UILabel           *textTitleLabel;
@property (nonatomic, strong) UILabel           *textContentLabel;
@property (nonatomic, strong) UIImageView       *textImageView;
@property (nonatomic, strong) UIButton          *goodButton;
@property (nonatomic, strong) UILabel           *goodNumberLabel;

@property (nonatomic, strong) UILabel           *userName;
@property (nonatomic, strong) UILabel           *sayTime;
@property (nonatomic, strong) UILabel           *titleLab;
@property (nonatomic, strong) UILabel           *contentLab;
@property (nonatomic, strong) UILabel           *sayNumberLab;

@property (nonatomic, strong) UITextField       *userSayTextField;
@property (nonatomic, strong) UIButton          *sayButton;
@property (nonatomic, strong) UIButton          *downGoodButton;
@property (nonatomic, strong) UILabel           *sayShowLabel;
@property (nonatomic, strong) UILabel           *goodShowLabel;

@end

@implementation DSCarClubDetailController

- (void)drawNavigation {
    
    [self drawTitle:@"活动详情"];
    
}

- (void) drawContent
{
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
    self.tableView.contentInset     = UIEdgeInsetsMake(0, 0, 180, 0);
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
    userName.font                       = [UIFont systemFontOfSize:14];
    userName.textColor                  = [UIColor colorFromHex:@"#3a3a3a"];
    userName.text                       = @"15800781856";
    self.userName                       = userName;
    [header addSubview:userName];
    
    userName.sd_layout
    .leftSpaceToView(userImageView, 10)
    .topSpaceToView(header, 10)
    .heightIs(20)
    .widthIs(150);
    
    
    UILabel *seeNumberLabel                   = [UILabel new];
    seeNumberLabel.textColor                  = [UIColor blackColor];
    seeNumberLabel.font                       = [UIFont systemFontOfSize:12];
    seeNumberLabel.textColor                  = [UIColor colorFromHex:@"#868686"];
    seeNumberLabel.text                       = @"369";
    self.userName                            = seeNumberLabel;
    [header addSubview:seeNumberLabel];
    
    seeNumberLabel.sd_layout
    .rightSpaceToView(header, 10)
    .topSpaceToView(header, 10)
    .heightIs(20)
    .widthIs(40);
    
    
    UIImageView *seeImageView  = [UIImageView new];
    seeImageView.image         = [UIImage imageNamed:@"yanjing.jpg"];
    self.seeImageView          = seeImageView;
    [header addSubview:seeImageView];
    
    
    seeImageView.sd_layout
    .rightSpaceToView(seeNumberLabel, 5)
    .topSpaceToView(header, 12)
    .heightIs(15)
    .widthIs(15);
    
    
    
    
    UILabel *sayTimeLab                 = [UILabel new];
    sayTimeLab.textColor                = [UIColor colorFromHex:@"#999999"];
    sayTimeLab.text                     = @"2017-7-31 15:30:56";
    sayTimeLab.font                     = [UIFont systemFontOfSize:11];
    self.sayTime                        = sayTimeLab;
    [header addSubview:sayTimeLab];
    
    
    sayTimeLab.sd_layout
    .leftEqualToView(userName)
    .topSpaceToView(userName, 5)
    .widthIs(150)
    .heightIs(20);
    
    
    
    
    
    UIView *backgroudView               = [UIView new];
    backgroudView.width                 = [UIScreen mainScreen].bounds.size.width;
    backgroudView.backgroundColor       = [UIColor colorFromHex:@"#f6f6f6"];
    [header addSubview:backgroudView];
    
    backgroudView.sd_layout
    .topSpaceToView(sayTimeLab, 10)
    .leftEqualToView(header)
    .heightIs(300);
    
    UILabel *textTitleLabel                 = [UILabel new];
    textTitleLabel.textColor                = [UIColor colorFromHex:@"#4a4a4a"];
    textTitleLabel.text                     = @"夏天如何防止高温？";
    textTitleLabel.font                     = [UIFont systemFontOfSize:14];
    self.textTitleLabel                     = textTitleLabel;
    [backgroudView addSubview:textTitleLabel];
    
    
    textTitleLabel.sd_layout
    .leftSpaceToView(backgroudView, 10)
    .topSpaceToView(backgroudView, 10)
    .widthIs(250)
    .heightIs(40);
    
    UILabel *textContentLabel                 = [UILabel new];
    textContentLabel.textColor                = [UIColor colorFromHex:@"#999999"];
    textContentLabel.text                     = @"夏天到来,随着温度越来越高,很多抵抗力差的人在高温环境下很容易中暑.今天太阳城管理网分享几条经验,教亲们如何采取措施,防止中暑.每天要喝7-8杯水,夏天是个严重缺水的季节,所以要增加水量,做到水分充足.补充水分也可以选择喝茶,因为茶味略苦性寒，具有消暑、解毒、去火等功能,但饮茶不能过量，茶水以清淡适中为宜哦.还有水果跟蔬菜也可补充水分.记住不要等到口渴了才喝水, 因为口渴表示身体已经缺水了.吃的东西越多，为了消化这些食物，身体产生的代谢热量就越多.一定要注意少吃高蛋白的食物，因为它们产生的代谢热量特别多.高蛋白质的食物如:牛奶,肉,鸡蛋,豆类等.还要吃得清淡,像黄瓜,西红柿等,这些蔬菜含水量多.夏天的衣服一定要尽量穿透气、浅色的.散热的棉质衣服而且要宽松的.浅色的衣服不会吸热.所以尽量不要穿暗色的衣服易吸热,像黑色,灰色等.";
    textContentLabel.font                     = [UIFont systemFontOfSize:14];
    textContentLabel.numberOfLines            = 0;
    self.textContentLabel                     = textContentLabel;
    [backgroudView addSubview:textContentLabel];
    
    
    textContentLabel.sd_layout
    .leftEqualToView(textTitleLabel)
    .rightSpaceToView(backgroudView, 10)
    .topSpaceToView(textTitleLabel, 10)
    .autoHeightRatio(0);
    
    UIImageView *textImageView  = [UIImageView new];
    textImageView.image         = [UIImage imageNamed:@"hangdiantu"];
    self.textImageView          = textImageView;
    [backgroudView addSubview:textImageView];
    
    textImageView.sd_layout
    .topSpaceToView(textContentLabel, 10)
    .leftEqualToView(textContentLabel)
    .widthRatioToView(textContentLabel, 1)
    .heightIs(200);
    
    
    UIButton    *goodButton = [UIButton new];
    [goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
    goodButton.backgroundColor  = [UIColor whiteColor];
    [goodButton addTarget:self action:@selector(goodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.goodButton         = goodButton;
    [backgroudView addSubview:goodButton];
    
    goodButton.sd_layout
    .topSpaceToView(textImageView, 10)
    .centerXEqualToView(textImageView)
    .heightIs(50)
    .widthIs(50);
    goodButton.layer.cornerRadius = goodButton.size.width/2;
    
    
    
    UILabel  *goodNumberLabel                = [UILabel new];
    goodNumberLabel.textColor                = [UIColor colorFromHex:@"#999999"];
    goodNumberLabel.text                     = @"共有168人点赞过";
    goodNumberLabel.font                     = [UIFont systemFontOfSize:14];
    self.goodNumberLabel                     = goodNumberLabel;
    goodNumberLabel.textAlignment            = NSTextAlignmentCenter;
    [backgroudView addSubview:goodNumberLabel];
    
    goodNumberLabel.sd_layout
    .topSpaceToView(goodButton, 10)
    .centerXEqualToView(goodButton)
    .widthIs(150)
    .heightIs(20);
    
    
    [backgroudView setupAutoHeightWithBottomView:goodNumberLabel bottomMargin:10];
    
    
    
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
    
    UIView *downView = [UIView new];
    downView.frame = CGRectMake(0, Main_Screen_Height -Main_Screen_Height*100/667, Main_Screen_Width, Main_Screen_Height*60/667);
    downView.backgroundColor  = [UIColor whiteColor];
    
    
    self.userSayTextField                = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width-150, Main_Screen_Height*40/667)];
    self.userSayTextField.placeholder    = @"    我来说两句...";
    self.userSayTextField.delegate       = self;
    self.userSayTextField.returnKeyType  = UIReturnKeyDone;
    self.userSayTextField.textAlignment  = NSTextAlignmentLeft;
    self.userSayTextField.font           = [UIFont systemFontOfSize:12];
    self.userSayTextField.backgroundColor= [UIColor whiteColor];
    self.userSayTextField.layer.cornerRadius    = 20;
    self.userSayTextField.layer.borderWidth     = 1;
    self.userSayTextField.layer.borderColor     = [UIColor colorFromHex:@"#b4b4b4"].CGColor;
    self.userSayTextField.left           = Main_Screen_Width*10/375 ;
    self.userSayTextField.top            = Main_Screen_Height*10/667;
    [self.userSayTextField addTarget:self action:@selector(userSayTextFieldChanged:) forControlEvents:UIControlEventEditingChanged];
    [downView addSubview:self.userSayTextField];
    
    
    UIButton    *sayButton = [UIButton new];
    [sayButton setImage:[UIImage imageNamed:@"huodongxiangqingxiaoxi"] forState:UIControlStateNormal];
    sayButton.backgroundColor  = [UIColor whiteColor];
    [sayButton addTarget:self action:@selector(sayButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.sayButton         = sayButton;
    [downView addSubview:sayButton];
    
    sayButton.sd_layout
    .leftSpaceToView(self.userSayTextField, 10)
    .centerYEqualToView(self.userSayTextField)
    .heightIs(20)
    .widthIs(20);
    
    
    UILabel *sayShowLabel                   = [UILabel new];
    sayShowLabel.textColor                  = [UIColor colorFromHex:@"#999999"];
    sayShowLabel.font                       = [UIFont systemFontOfSize:12];
    sayShowLabel.text                       = @"369";
    self.sayShowLabel                       = sayShowLabel;
    [downView addSubview:sayShowLabel];
    
    sayShowLabel.sd_layout
    .leftSpaceToView(sayButton, 5)
    .topSpaceToView(downView, 12)
    .widthIs(40)
    .heightIs(20);
    
    UIButton    *downGoodButton = [UIButton new];
    [downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
    downGoodButton.backgroundColor  = [UIColor whiteColor];
    [downGoodButton addTarget:self action:@selector(downGoodButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.downGoodButton         = downGoodButton;
    [downView addSubview:downGoodButton];
    
    downGoodButton.sd_layout
    .leftSpaceToView(self.sayShowLabel, 5)
    .centerYEqualToView(self.userSayTextField)
    .heightIs(20)
    .widthIs(20);
    
    
    UILabel *goodShowLabel                   = [UILabel new];
    goodShowLabel.textColor                  = [UIColor colorFromHex:@"#999999"];
    goodShowLabel.font                       = [UIFont systemFontOfSize:12];
    goodShowLabel.text                       = @"369";
    self.sayShowLabel                       = goodShowLabel;
    [downView addSubview:goodShowLabel];
    
    goodShowLabel.sd_layout
    .leftSpaceToView(downGoodButton, 0)
    .topSpaceToView(downView, 12)
    .widthIs(40)
    .heightIs(20);
    
    
    [downView layoutSubviews];

    [self.contentView addSubview:downView];
    
    

}
- (void) userSayTextFieldChanged:(UITextField *)sender {


    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (void) sayButtonClick:(id)sender {


    
}
- (void) downGoodButtonClick:(UIButton *)sender {

    if (sender.selected == NO) {
        [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
        self.sayShowLabel.text                     = @"170";
        [self.view showInfo:@"点赞成功!" autoHidden:YES];
    }else {
        [self.downGoodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan"] forState:UIControlStateNormal];
        self.sayShowLabel.text                     = @"169";
        [self.view showInfo:@"取消点赞!" autoHidden:YES];
        
    }
    
    sender.selected = !sender.selected;
}
- (void) goodButtonClick:(UIButton *)sender {

    if (sender.selected == NO) {
        [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan2"] forState:UIControlStateNormal];
        self.goodNumberLabel.text                     = @"共有169人点赞过";
        [self.view showInfo:@"点赞成功!" autoHidden:YES];
    }else {
        [self.goodButton setImage:[UIImage imageNamed:@"huodongxiangqingzan1"] forState:UIControlStateNormal];
        self.goodNumberLabel.text                     = @"共有168人点赞过";
        [self.view showInfo:@"取消点赞!" autoHidden:YES];

    }

    sender.selected = !sender.selected;
    
    
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
